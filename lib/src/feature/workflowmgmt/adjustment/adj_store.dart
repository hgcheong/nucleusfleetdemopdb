import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adj_models.dart';
import 'adj_seed.dart';
import 'adj_workflow.dart';

/// A rule was broken; [message] can be shown to the user as is.
class AdjError implements Exception {
  AdjError(this.message);
  final String message;

  @override
  String toString() => message;
}

class AdjState {
  const AdjState({
    required this.requests,
    required this.currentUserEmail,
    this.guarantees = const [],
    this.overdues = const [],
    this.creditProfiles = const [],
  });

  final List<AdjRequest> requests;
  final String currentUserEmail;

  /// Bank guarantee register (local sample data).
  final List<AdjGuarantee> guarantees;

  /// Statements past due (local sample data).
  final List<AdjOverdue> overdues;

  /// Customer credit register: limits and evaluation figures (local sample data).
  final List<AdjCreditProfile> creditProfiles;

  /// Fresh demo data. Reference codes and the adjustment samples' values are
  /// random, so they differ after each reset.
  static AdjState seeded(String userEmail) {
    adjNewSeedRun();
    return AdjState(
        requests: adjSeedRequests(),
        currentUserEmail: userEmail,
        guarantees: adjSeedGuarantees(),
        overdues: adjSeedOverdues(),
        creditProfiles: adjSeedCreditProfiles(),
      );
  }

  /// Open (not rejected or completed) task for a guarantee, if any.
  AdjRequest? openTaskForGuarantee(String bgNumber) {
    for (final r in requests) {
      if (r.isBankGuarantee &&
          r.guarantee?.bgNumber == bgNumber &&
          r.status != AdjStatus.rejected &&
          r.status != AdjStatus.completed) {
        return r;
      }
    }
    return null;
  }

  /// Open task for a statement's LPC, if any.
  AdjRequest? openTaskForStatement(String statementNo) {
    for (final r in requests) {
      if (r.isLpc &&
          r.overdue?.statementNo == statementNo &&
          r.status != AdjStatus.rejected &&
          r.status != AdjStatus.completed) {
        return r;
      }
    }
    return null;
  }

  /// Open task for a Data Entry transaction, if any.
  AdjRequest? openTaskForTransaction(String txnType, String txnId) {
    for (final r in requests) {
      final src = r.source;
      if (r.kind == AdjKind.dataEntry &&
          src != null &&
          src.txnType == txnType &&
          src.txnId == txnId &&
          r.status != AdjStatus.rejected &&
          r.status != AdjStatus.completed) {
        return r;
      }
    }
    return null;
  }

  /// Open credit adjustment for an account, if any.
  AdjRequest? openTaskForCreditAccount(String account) {
    for (final r in requests) {
      if (r.isCreditAdjustment &&
          r.accountNumber == account &&
          r.status != AdjStatus.rejected &&
          r.status != AdjStatus.completed) {
        return r;
      }
    }
    return null;
  }

  AdjCreditProfile? creditProfileOf(String? account) {
    for (final p in creditProfiles) {
      if (p.accountNumber == account) return p;
    }
    return null;
  }

  AdjGuarantee? guaranteeByNumber(String? bgNumber) {
    for (final g in guarantees) {
      if (g.bgNumber == bgNumber) return g;
    }
    return null;
  }

  AdjOverdue? statementByNumber(String? statementNo) {
    for (final o in overdues) {
      if (o.statementNo == statementNo) return o;
    }
    return null;
  }

  /// Guarantees that need a decision: expiring within the window or already
  /// expired, and not yet adjusted. Soonest first.
  List<AdjGuarantee> guaranteesNeedingAction(DateTime today) => guarantees
      .where((g) => g.adjustedBy == null && g.daysToExpiry(today) <= adjGuaranteeWindowDays)
      .toList()
    ..sort((a, b) => a.expiryDate.compareTo(b.expiryDate));

  /// Statements past due with no payment received and no LPC posted yet.
  /// Longest overdue first.
  List<AdjOverdue> statementsNeedingLpc(DateTime today) => overdues
      .where((o) => o.chargedBy == null && o.noPaymentReceived && o.daysOverdue(today) > 0)
      .toList()
    ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

  List<AdjUser> get users => adjDemoUsers;

  AdjUser get currentUser => userByEmail(currentUserEmail) ?? adjDemoUsers.first;

  AdjUser? userByEmail(String? email) {
    for (final u in adjDemoUsers) {
      if (u.email == email) return u;
    }
    return null;
  }

  /// Display name, falling back to the email for people outside the list.
  String nameOf(String? email) => userByEmail(email)?.name ?? (email ?? '-');

  AdjRole? roleOf(String email) => userByEmail(email)?.role;

  List<AdjUser> usersWithRole(AdjRole role) => adjDemoUsers.where((u) => u.role == role).toList();

  /// Newest first.
  List<AdjRequest> get sorted => [...requests]..sort((a, b) => b.requestDate.compareTo(a.requestDate));

  AdjRequest? find(String ref) {
    for (final r in requests) {
      if (r.referenceCode == ref) return r;
    }
    return null;
  }

  /// Requests of one kind, newest first.
  List<AdjRequest> sortedOf(AdjKind kind) => sorted.where((r) => r.kind == kind).toList();

  /// Requests waiting for [user]; pass [kind] to limit to one kind.
  List<AdjRequest> pendingFor(AdjUser user, [AdjKind? kind]) => sorted
      .where((r) => (kind == null || r.kind == kind) && AdjWorkflow.canAct(r, user))
      .toList();

  List<AdjLevelStatus> levelsOf(AdjRequest r) => AdjWorkflow.levels(r, roleOf);

  /// Suggested route for a new request: the usual person at each level,
  /// or the next one if the usual person is the requestor.
  Map<AdjRole, String> defaultRouteFor(String requestorEmail) {
    final route = <AdjRole, String>{};
    for (final role in AdjRole.levels) {
      final options = usersWithRole(role).where((u) => u.email != requestorEmail).toList();
      if (options.isEmpty) continue;
      final usual = adjDefaultRoute[role];
      route[role] = options.any((u) => u.email == usual) ? usual! : options.first.email;
    }
    return route;
  }

  AdjState copyWith({
    List<AdjRequest>? requests,
    String? currentUserEmail,
    List<AdjGuarantee>? guarantees,
    List<AdjOverdue>? overdues,
    List<AdjCreditProfile>? creditProfiles,
  }) =>
      AdjState(
        requests: requests ?? this.requests,
        currentUserEmail: currentUserEmail ?? this.currentUserEmail,
        guarantees: guarantees ?? this.guarantees,
        overdues: overdues ?? this.overdues,
        creditProfiles: creditProfiles ?? this.creditProfiles,
      );
}

/// Set before opening the New request page to start a bank guarantee or
/// LPC task from a register row: the guarantee or statement number.
final adjPrefillProvider = StateProvider<String?>((ref) => null);

/// What another screen (e.g. Customer Management) knows about the account
/// when it starts a credit adjustment.
class AdjCreditPrefill {
  const AdjCreditPrefill({
    required this.accountNumber,
    this.customerName,
    this.currentLimit,
    this.sourcePath,
  });

  final String accountNumber;
  final String? customerName;
  final double? currentLimit;

  /// Path back to the screen it came from.
  final String? sourcePath;
}

/// Set before opening New credit adjustment from another screen.
final adjCreditPrefillProvider = StateProvider<AdjCreditPrefill?>((ref) => null);

/// All workflow data, kept in this browser. No API calls.
final adjStoreProvider = NotifierProvider<AdjStore, AdjState>(AdjStore.new);

class AdjStore extends Notifier<AdjState> {
  // v3 adds bulk payments, bank guarantees and LPC; data saved by earlier
  // versions is ignored so the new samples appear.
  static const _storageKey = 'smartpay_adj_workflow_v5';

  /// Browser storage is small (about 5 MB per site, shared with the rest of
  /// the app), so only small files keep their content after a reload.
  static const _maxKeptFileBytes = 512 * 1024;
  static const _maxKeptTotalBytes = 2 * 1024 * 1024;

  static const maxFileBytes = 10 * 1024 * 1024;
  static const allowedExtensions = ['pdf', 'xlsx', 'xls', 'csv', 'docx', 'doc', 'png', 'jpg', 'jpeg'];

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final _accountPattern = RegExp(r'^\d{6,20}$');

  final _random = Random();
  bool _changedBeforeRestore = false;

  @override
  AdjState build() {
    Future.microtask(_restore);
    return AdjState.seeded(adjDefaultUserEmail);
  }

  // ---------------------------------------------------------------- session

  void switchUser(String email) {
    if (state.userByEmail(email) == null) return;
    _set(state.copyWith(currentUserEmail: email));
  }

  /// Puts the demo data back and clears what's stored in this browser.
  Future<void> resetDemo() async {
    state = AdjState.seeded(state.currentUserEmail);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
    } catch (_) {
      // Storage unavailable: the in-memory reset still applies.
    }
  }

  // ---------------------------------------------------------------- decisions

  void approve(String ref, {String remarks = ''}) {
    final r = _forAction(ref);
    _requireStatus(r, AdjStatus.inProgress);
    final next = AdjStage.values[r.stage.index + 1];
    final done = next == AdjStage.completed;
    _update(
      r.copyWith(
        stage: next,
        status: done ? AdjStatus.completed : AdjStatus.inProgress,
        history: [...r.history, _entry(AdjWorkflow.approveAction(r.stage), remarks)],
      ),
    );
    if (done) _applyOutcome(r);
  }

  void returnForAmendment(String ref, {required String remarks}) {
    final r = _forAction(ref);
    _requireStatus(r, AdjStatus.inProgress);
    if (remarks.trim().isEmpty) throw AdjError('Add remarks so the requestor knows what to change.');
    _update(r.copyWith(
      status: AdjStatus.returned,
      history: [...r.history, _entry(AdjAction.returned, remarks)],
    ));
  }

  void reject(String ref, {required String remarks}) {
    final r = _forAction(ref);
    _requireStatus(r, AdjStatus.inProgress);
    if (remarks.trim().isEmpty) throw AdjError('Add remarks explaining why this request is rejected.');
    _update(r.copyWith(
      status: AdjStatus.rejected,
      history: [...r.history, _entry(AdjAction.rejected, remarks)],
    ));
  }

  /// Requestor fixes a returned request; it restarts at business review.
  void resubmit(String ref, {required String reason, String remarks = ''}) {
    final r = _forAction(ref);
    _requireStatus(r, AdjStatus.returned);
    if (reason.trim().length < 20) throw AdjError('Describe the reason in at least 20 characters.');
    _update(r.copyWith(
      reason: reason.trim(),
      stage: AdjStage.submitted,
      status: AdjStatus.inProgress,
      history: [...r.history, _entry(AdjAction.resubmitted, remarks)],
    ));
  }

  /// What a completed task changes outside the request itself.
  void _applyOutcome(AdjRequest r) {
    if (r.isBankGuarantee && r.guarantee != null && r.newCreditLimit != null) {
      _set(state.copyWith(guarantees: [
        for (final g in state.guarantees)
          g.bgNumber == r.guarantee!.bgNumber
              ? g.copyWith(creditLimit: r.newCreditLimit, adjustedBy: r.referenceCode)
              : g,
      ]));
    } else if (r.isCreditAdjustment && r.creditEval != null && r.newCreditLimit != null) {
      final known = state.creditProfileOf(r.accountNumber) != null;
      final e = r.creditEval!;
      _set(state.copyWith(creditProfiles: [
        for (final p in state.creditProfiles)
          p.accountNumber == r.accountNumber
              ? p.copyWith(creditLimit: r.newCreditLimit, adjustedBy: r.referenceCode)
              : p,
        // Account raised from Customer Management and not in the register yet.
        if (!known)
          AdjCreditProfile(
            accountNumber: r.accountNumber,
            customerName: e.customerName,
            creditLimit: r.newCreditLimit!,
            monthsActive: e.monthsActive,
            avgMonthlySpend: e.avgMonthlySpend,
            balance: e.balance,
            latePayments12m: e.latePayments12m,
            maxDaysPastDue: e.maxDaysPastDue,
            securityAmount: e.securityAmount,
            adjustedBy: r.referenceCode,
          ),
      ]));
    } else if (r.isLpc && r.overdue != null) {
      _set(state.copyWith(overdues: [
        for (final o in state.overdues)
          o.statementNo == r.overdue!.statementNo ? o.copyWith(chargedBy: r.referenceCode) : o,
      ]));
    }
  }

  // ---------------------------------------------------------------- files

  /// Adds files to the step the request is at now.
  void addDocuments(String ref, List<AdjDocument> picked) {
    final r = _find(ref);
    if (!AdjWorkflow.canAttach(r, state.currentUser)) {
      throw AdjError('You can attach files only while the request is with you.');
    }
    if (picked.isEmpty) return;
    final step = AdjWorkflow.currentFileStep(r)!;
    final names = {for (final d in r.documents) d.fileName.toLowerCase()};
    for (final d in picked) {
      if (!names.add(d.fileName.toLowerCase())) throw AdjError('${d.fileName} is already attached.');
    }
    final now = DateTime.now();
    final added = [
      for (final d in picked)
        AdjDocument(
          id: _newDocId(),
          fileName: d.fileName,
          sizeBytes: d.sizeBytes,
          step: step,
          uploadedBy: state.currentUserEmail,
          uploadedAt: now,
          bytes: d.bytes,
        ),
    ];
    _update(r.copyWith(
      documents: [...r.documents, ...added],
      history: [...r.history, _entry(AdjAction.documentsAdded, added.map((d) => d.fileName).join(', '))],
    ));
  }

  void removeDocument(String ref, String documentId) {
    final r = _find(ref);
    AdjDocument? doc;
    for (final d in r.documents) {
      if (d.id == documentId) doc = d;
    }
    if (doc == null) throw AdjError('File not found.');
    if (!AdjWorkflow.canRemoveDocument(r, state.currentUser, doc)) {
      throw AdjError('You can only remove files you attached, while the request is with you.');
    }
    _update(r.copyWith(
      documents: r.documents.where((d) => d.id != documentId).toList(),
      history: [...r.history, _entry(AdjAction.documentRemoved, doc.fileName)],
    ));
  }

  // ---------------------------------------------------------------- create

  /// Creates a request and sends it to the first approver. For bulk
  /// payments the total is the sum of [paymentLines] and [totalAmount] is
  /// ignored.
  AdjRequest submit({
    AdjKind kind = AdjKind.adjustment,
    required String businessLine,
    required String adjustmentType,
    double totalAmount = 0,
    required String accountNumber,
    required String reason,
    required Map<AdjRole, String?> approvers,
    List<String> ccEmails = const [],
    List<AdjDocument> documents = const [],
    List<AdjPaymentLine> paymentLines = const [],
    DateTime? paymentDate,
    String? bgNumber,
    double? newCreditLimit,
    DateTime? effectiveDate,
    String? statementNo,
    double? lpcRatePct,
    AdjSourceRecord? source,
    AdjCreditEval? creditEval,
    DateTime? endDate,
    String? sourcePath,
  }) {
    final me = state.currentUserEmail;
    final bulk = kind == AdjKind.bulkPayment;
    final fromDataEntry = kind == AdjKind.dataEntry;
    var account = accountNumber.trim();
    final minReason = fromDataEntry ? 10 : 20;
    if (reason.trim().length < minReason) {
      throw AdjError('${kind.reasonLabel} needs at least $minReason characters.');
    }
    if (fromDataEntry) {
      if (source == null || source.txnId.isEmpty) throw AdjError('Save the transaction first, then request approval.');
      final open = state.openTaskForTransaction(source.txnType, source.txnId);
      if (open != null) throw AdjError('This transaction already has an open approval task: ${open.referenceCode}.');
      if (account.isEmpty) account = '-';
    }
    var total = totalAmount;
    if (bulk) {
      if (paymentLines.isEmpty) throw AdjError('Add at least one payee.');
      if (paymentLines.length > maxPaymentLines) {
        throw AdjError('A bulk payment can have at most $maxPaymentLines payees.');
      }
      for (var i = 0; i < paymentLines.length; i++) {
        final problem = paymentLineProblem(paymentLines[i]);
        if (problem != null) throw AdjError('Payee ${i + 1}: $problem');
      }
      if (paymentDate == null) throw AdjError('Choose the payment date.');
      total = paymentLines.fold<double>(0, (t, l) => t + l.amount);
    }
    AdjGuarantee? guarantee;
    if (kind == AdjKind.bankGuarantee) {
      guarantee = state.guaranteeByNumber(bgNumber);
      if (guarantee == null) throw AdjError('Choose the bank guarantee.');
      final open = state.openTaskForGuarantee(guarantee.bgNumber);
      if (open != null) throw AdjError('${guarantee.bgNumber} already has an open task: ${open.referenceCode}.');
      if (newCreditLimit == null || newCreditLimit < 0) throw AdjError('Enter the new credit limit.');
      if (newCreditLimit >= guarantee.creditLimit) {
        throw AdjError('The new credit limit must be lower than the current limit of '
            'RM ${guarantee.creditLimit.toStringAsFixed(2)}.');
      }
      if (effectiveDate == null) throw AdjError('Choose the effective date.');
      total = guarantee.creditLimit - newCreditLimit;
      account = guarantee.accountNumber;
    }
    AdjOverdue? statement;
    if (kind == AdjKind.lpc) {
      statement = state.statementByNumber(statementNo);
      if (statement == null) throw AdjError('Choose the statement.');
      if (!statement.noPaymentReceived) throw AdjError('LPC here is only for statements with no payment received.');
      final open = state.openTaskForStatement(statement.statementNo);
      if (open != null) throw AdjError('${statement.statementNo} already has an open task: ${open.referenceCode}.');
      if (lpcRatePct == null || lpcRatePct <= 0 || lpcRatePct > 36) {
        throw AdjError('Enter a rate between 0 and 36% a year.');
      }
      if (effectiveDate == null) throw AdjError('Choose the charge date.');
      total = statement.lpcFor(ratePct: lpcRatePct, on: effectiveDate);
      account = statement.accountNumber;
    }
    AdjCreditEval? eval;
    if (kind == AdjKind.creditAdjustment) {
      if (creditEval == null) throw AdjError('Complete the credit evaluation.');
      if (creditEval.customerName.trim().isEmpty) throw AdjError('Enter the customer name.');
      final open = state.openTaskForCreditAccount(account);
      if (open != null) throw AdjError('Account $account already has an open credit adjustment: ${open.referenceCode}.');
      if (newCreditLimit == null || newCreditLimit < 0) throw AdjError('Enter the new credit limit.');
      final current = creditEval.currentLimit;
      final increase = adjustmentType != adjCreditTypes.last; // last = Permanent decrease
      if (increase && newCreditLimit <= current) {
        throw AdjError('For an increase the new limit must be higher than the current limit of '
            'RM ${current.toStringAsFixed(2)}.');
      }
      if (!increase && newCreditLimit >= current) {
        throw AdjError('For a decrease the new limit must be lower than the current limit of '
            'RM ${current.toStringAsFixed(2)}.');
      }
      if (effectiveDate == null) throw AdjError('Choose the effective date.');
      if (adjustmentType == adjCreditTypes[1]) {
        if (endDate == null) throw AdjError('Choose the end date of the temporary increase.');
        if (!endDate.isAfter(effectiveDate)) throw AdjError('The end date must be after the effective date.');
        if (endDate.difference(effectiveDate).inDays > adjMaxTemporaryDays) {
          throw AdjError('A temporary increase can last at most $adjMaxTemporaryDays days.');
        }
      }
      eval = AdjCreditEval(
        customerName: creditEval.customerName.trim(),
        currentLimit: current,
        requestedLimit: newCreditLimit,
        monthsActive: creditEval.monthsActive,
        avgMonthlySpend: creditEval.avgMonthlySpend,
        balance: creditEval.balance,
        latePayments12m: creditEval.latePayments12m,
        maxDaysPastDue: creditEval.maxDaysPastDue,
        securityAmount: creditEval.securityAmount,
      );
      total = (newCreditLimit - current).abs();
    }
    if (total < 0 || (total == 0 && !fromDataEntry)) {
      throw AdjError(kind == AdjKind.lpc
          ? 'The charge is zero: the charge date must be after the due date.'
          : 'Total amount must be greater than zero.');
    }
    if (!fromDataEntry && !_accountPattern.hasMatch(account)) {
      throw AdjError('${kind.accountLabel} must be 6 to 20 digits.');
    }
    final routeProblem = AdjWorkflow.routeProblem(me, approvers);
    if (routeProblem != null) throw AdjError(routeProblem);
    for (final role in AdjRole.levels) {
      if (state.roleOf(approvers[role]!) != role) {
        throw AdjError('${approvers[role]} is not a ${role.label}.');
      }
    }
    final bad = ccEmails.where((e) => !_emailPattern.hasMatch(e)).toList();
    if (bad.isNotEmpty) throw AdjError('Check these CC addresses: ${bad.join(', ')}');

    final now = DateTime.now();
    final request = AdjRequest(
      kind: kind,
      referenceCode: _newReference(now, kind.refPrefix),
      requestorEmail: me,
      requestDate: now,
      businessLine: businessLine,
      adjustmentType: adjustmentType,
      totalAmount: (total * 100).roundToDouble() / 100,
      accountNumber: account,
      reason: reason.trim(),
      approvers: {for (final role in AdjRole.levels) role: approvers[role]!},
      ccEmails: ccEmails.toSet().toList(),
      paymentLines: bulk ? List.unmodifiable(paymentLines) : const [],
      paymentDate: bulk ? paymentDate : null,
      guarantee: guarantee,
      newCreditLimit: (guarantee != null || eval != null) ? newCreditLimit : null,
      overdue: statement,
      lpcRatePct: statement == null ? null : lpcRatePct,
      source: fromDataEntry ? source : null,
      effectiveDate: (guarantee != null || statement != null || eval != null) ? effectiveDate : null,
      creditEval: eval,
      endDate: eval != null && adjustmentType == adjCreditTypes[1] ? endDate : null,
      sourcePath: eval != null ? sourcePath : null,
      documents: [
        for (final d in documents)
          AdjDocument(
            id: _newDocId(),
            fileName: d.fileName,
            sizeBytes: d.sizeBytes,
            step: AdjRole.requestor,
            uploadedBy: me,
            uploadedAt: now,
            bytes: d.bytes,
          ),
      ],
      history: [AdjHistoryEntry(action: AdjAction.submitted, actorEmail: me, at: now)],
    );
    _set(state.copyWith(requests: [...state.requests, request]));
    return request;
  }

  static const maxPaymentLines = 500;

  /// Checks one payee line. Returns a message, or null if it's valid.
  static String? paymentLineProblem(AdjPaymentLine l) {
    if (l.payeeName.trim().isEmpty) return 'enter the payee name.';
    if (l.bankName.trim().isEmpty) return 'enter the bank.';
    if (!_accountPattern.hasMatch(l.accountNumber.trim())) return 'account number must be 6 to 20 digits.';
    if (l.amount <= 0) return 'amount must be greater than zero.';
    return null;
  }

  // ---------------------------------------------------------------- helpers

  AdjRequest _find(String ref) {
    final r = state.find(ref);
    if (r == null) throw AdjError('No request found with reference $ref.');
    return r;
  }

  AdjRequest _forAction(String ref) {
    final r = _find(ref);
    if (!AdjWorkflow.canAct(r, state.currentUser)) {
      throw AdjError("This request isn't waiting for you.");
    }
    return r;
  }

  void _requireStatus(AdjRequest r, AdjStatus expected) {
    if (r.status != expected) throw AdjError("This request isn't waiting for that action.");
  }

  AdjHistoryEntry _entry(AdjAction action, String remarks) => AdjHistoryEntry(
        action: action,
        actorEmail: state.currentUserEmail,
        at: DateTime.now(),
        remarks: remarks.trim(),
      );

  void _update(AdjRequest changed) {
    _set(state.copyWith(requests: [
      for (final r in state.requests) r.referenceCode == changed.referenceCode ? changed : r,
    ]));
  }

  void _set(AdjState next) {
    _changedBeforeRestore = true;
    state = next;
    _save();
  }

  String _two(int n) => n.toString().padLeft(2, '0');

  /// Prefix + yyMMddHHmm + 6 random digits, e.g. SA2611121530482913.
  String _newReference(DateTime t, String prefix) {
    final stamp = '${_two(t.year % 100)}${_two(t.month)}${_two(t.day)}${_two(t.hour)}${_two(t.minute)}';
    while (true) {
      final ref = '$prefix$stamp${List.generate(6, (_) => _random.nextInt(10)).join()}';
      if (state.find(ref) == null) return ref;
    }
  }

  String _newDocId() => 'd${DateTime.now().microsecondsSinceEpoch}${_random.nextInt(1 << 20)}';

  // ---------------------------------------------------------------- storage

  Future<void> _restore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      if (raw == null || _changedBeforeRestore) return;
      final j = jsonDecode(raw) as Map<String, dynamic>;
      final requests = [
        for (final r in j['requests'] as List) AdjRequest.fromJson(r as Map<String, dynamic>),
      ];
      final user = j['user'] as String?;
      state = AdjState(
        requests: requests,
        currentUserEmail: state.userByEmail(user) == null ? state.currentUserEmail : user!,
        guarantees: [
          for (final g in (j['guarantees'] as List? ?? const []))
            AdjGuarantee.fromJson(g as Map<String, dynamic>),
        ],
        overdues: [
          for (final o in (j['overdues'] as List? ?? const []))
            AdjOverdue.fromJson(o as Map<String, dynamic>),
        ],
        creditProfiles: [
          for (final p in (j['creditProfiles'] as List? ?? const []))
            AdjCreditProfile.fromJson(p as Map<String, dynamic>),
        ],
      );
    } catch (_) {
      // Missing or unreadable storage: keep the demo data.
    }
  }

  Future<void> _save() async {
    // Keep content for small files, newest requests first, within budget.
    var budget = _maxKeptTotalBytes;
    final keep = <String>{};
    for (final r in state.sorted) {
      for (final d in r.documents.reversed) {
        if (d.bytes != null && d.sizeBytes <= _maxKeptFileBytes && d.sizeBytes <= budget) {
          keep.add(d.id);
          budget -= d.sizeBytes;
        }
      }
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _storageKey,
        jsonEncode({
          'user': state.currentUserEmail,
          'requests': [for (final r in state.requests) r.toJson(keepContent: (d) => keep.contains(d.id))],
          'guarantees': [for (final g in state.guarantees) g.toJson()],
          'overdues': [for (final o in state.overdues) o.toJson()],
          'creditProfiles': [for (final p in state.creditProfiles) p.toJson()],
        }),
      );
    } catch (_) {
      // Storage full or blocked: changes stay in memory for this session.
    }
  }
}
