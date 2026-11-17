import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

import '../adj_csv.dart';
import '../adj_files.dart';
import '../adj_models.dart';
import '../adj_nav.dart';
import '../adj_samples.dart';
import '../adj_seed.dart';
import '../adj_store.dart';
import '../adj_workflow.dart';
import '../widgets/adj_common.dart';
import '../widgets/adj_credit_eval.dart';

const int _wid = 9303;

/// Create a request of one kind and send it for approval.
/// Path: /workflowmgmt/:kind/new
@RoutePage()
class AdjApprovalNewRequest extends BaseScreen {
  const AdjApprovalNewRequest({super.key});

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    if (isPageDeniedView(AcxAuthAccess.pageDeniedList, _wid)) return const NotAuthorised();
    final kind = AdjKind.fromPath(context.routeData.inheritedPathParams.optString('kind'));
    // Fill the area so the page sits at the top (see dashboard screen).
    return SizedBox.expand(child: _NewBody(key: ValueKey(kind), kind: kind));
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) => desktopBody(context, ref);

  @override
  Widget sideBar() => provideSideBar('workflowmgmt');

  @override
  PreferredSizeWidget breadCrumb() => provideBreadCrumb('workflowmgmt');
}

DateTime _today() {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day);
}

class _NewBody extends ConsumerStatefulWidget {
  const _NewBody({super.key, required this.kind});
  final AdjKind kind;

  @override
  ConsumerState<_NewBody> createState() => _NewBodyState();
}

class _NewBodyState extends ConsumerState<_NewBody> {
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _account = TextEditingController();
  final _reason = TextEditingController();
  final _cc = TextEditingController();
  final List<AdjDocument> _files = [];
  late Map<AdjRole, String?> _approvers;
  String? _businessLine;
  String? _type;

  // Bulk payment
  final List<_LineDraft> _lines = [];
  final _payDateText = TextEditingController();
  DateTime? _payDate;

  // Bank guarantee and LPC
  String? _bgNumber;
  String? _statementNo;
  final _newLimit = TextEditingController();
  final _rate = TextEditingController(text: adjDefaultLpcRate.toStringAsFixed(2));
  final _effDateText = TextEditingController();
  DateTime? _effDate;

  // Credit adjustment
  final _customerName = TextEditingController();
  final _currentLimit = TextEditingController();
  final _months = TextEditingController();
  final _spend = TextEditingController();
  final _balance = TextEditingController();
  final _late = TextEditingController();
  final _dpd = TextEditingController();
  final _security = TextEditingController();
  final _endDateText = TextEditingController();
  DateTime? _endDate;
  String? _sourcePath;

  AdjKind get _kind => widget.kind;
  bool get _credit => _kind == AdjKind.creditAdjustment;
  bool get _temporary => _credit && _type == adjCreditTypes[1];
  bool get _bulk => _kind == AdjKind.bulkPayment;
  bool get _bg => _kind == AdjKind.bankGuarantee;
  bool get _lpc => _kind == AdjKind.lpc;

  @override
  void initState() {
    super.initState();
    final store = ref.read(adjStoreProvider);
    _approvers = Map.of(store.defaultRouteFor(store.currentUserEmail));
    if (_bulk) _lines.add(_LineDraft());

    // Credit adjustment opened from the register or Customer Management.
    if (_credit) {
      _type ??= adjCreditTypes.first;
      final p = ref.read(adjCreditPrefillProvider);
      if (p != null) {
        _account.text = p.accountNumber;
        _sourcePath = p.sourcePath;
        _fillFromRegister(store, p.accountNumber);
        if ((p.customerName ?? '').trim().isNotEmpty && _customerName.text.isEmpty) {
          _customerName.text = p.customerName!.trim();
        }
        if (p.currentLimit != null) _currentLimit.text = p.currentLimit!.toStringAsFixed(2);
        Future.microtask(() {
          if (mounted) ref.read(adjCreditPrefillProvider.notifier).state = null;
        });
      }
    }

    // Opened from a register row in the queue: preselect that item.
    final prefill = ref.read(adjPrefillProvider);
    if (prefill != null) {
      if (_bg && store.guaranteeByNumber(prefill) != null) _selectGuarantee(prefill, store);
      if (_lpc && store.statementByNumber(prefill) != null) _selectStatement(prefill);
      Future.microtask(() {
        if (mounted) ref.read(adjPrefillProvider.notifier).state = null;
      });
    }
  }

  @override
  void dispose() {
    for (final c in [
      _amount, _account, _reason, _cc, _payDateText, _newLimit, _rate, _effDateText, //
      _customerName, _currentLimit, _months, _spend, _balance, _late, _dpd, _security, _endDateText,
    ]) {
      c.dispose();
    }
    for (final l in _lines) {
      l.dispose();
    }
    super.dispose();
  }

  // ---------------------------------------------------------------- helpers

  List<String> _ccList() =>
      _cc.text.split(RegExp(r'[,;\s]+')).map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

  double? _num(String text) => double.tryParse(text.replaceAll(',', '').trim());

  double get _linesTotal =>
      (_lines.fold<double>(0, (t, l) => t + l.amountValue) * 100).roundToDouble() / 100;

  void _setEffDate(DateTime? d) {
    _effDate = d;
    _effDateText.text = d == null ? '' : adjDate(d);
  }

  void _selectGuarantee(String? bgNumber, AdjState store) {
    final g = store.guaranteeByNumber(bgNumber);
    _bgNumber = bgNumber;
    if (g == null) return;
    _newLimit.text = math.max(0.0, g.creditLimit - g.amount).toStringAsFixed(2);
    _setEffDate(g.expiryDate);
    _type ??= adjGuaranteeOutcomes.first;
  }

  void _selectStatement(String? statementNo) {
    _statementNo = statementNo;
    if (statementNo == null) return;
    _setEffDate(_today());
    _type ??= adjLpcBases.first;
  }

  /// Demo helper: random amount, account and reason for the chosen type.
  void _fillSample() {
    final sample = adjRandomAdjustment(type: _type);
    setState(() {
      _type = sample.type;
      _businessLine ??= adjBusinessLines.first;
      _amount.text = sample.amount.toStringAsFixed(2);
      _account.text = sample.account;
      _reason.text = sample.reason;
    });
  }

  /// Fills the customer and evaluation figures from the credit register when
  /// the account is in it. Returns whether it was found.
  bool _fillFromRegister(AdjState store, String account) {
    final p = store.creditProfileOf(account.trim());
    if (p == null) return false;
    _customerName.text = p.customerName;
    _currentLimit.text = p.creditLimit.toStringAsFixed(2);
    _months.text = '${p.monthsActive}';
    _spend.text = p.avgMonthlySpend.toStringAsFixed(2);
    _balance.text = p.balance.toStringAsFixed(2);
    _late.text = '${p.latePayments12m}';
    _dpd.text = '${p.maxDaysPastDue}';
    _security.text = p.securityAmount.toStringAsFixed(2);
    return true;
  }

  int? _int(String text) => int.tryParse(text.trim());

  /// Evaluation from the form, or null while a figure is missing.
  AdjCreditEval? _evalDraft() {
    final current = _num(_currentLimit.text);
    final requested = _num(_newLimit.text);
    final months = _int(_months.text);
    final spend = _num(_spend.text);
    final balance = _num(_balance.text);
    final late = _int(_late.text);
    final dpd = _int(_dpd.text);
    final security = _security.text.trim().isEmpty ? 0.0 : _num(_security.text);
    if ([current, requested, months, spend, balance, late, dpd, security].contains(null)) return null;
    if (requested! <= 0) return null;
    return AdjCreditEval(
      customerName: _customerName.text.trim(),
      currentLimit: current!,
      requestedLimit: requested,
      monthsActive: months!,
      avgMonthlySpend: spend!,
      balance: balance!,
      latePayments12m: late!,
      maxDaysPastDue: dpd!,
      securityAmount: security!,
    );
  }

  Future<void> _pickEndDate() async {
    final start = _effDate ?? _today();
    final picked = await _pickDate(
      _endDate,
      start.add(const Duration(days: 1)),
      start.add(const Duration(days: adjMaxTemporaryDays)),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _endDate = picked;
      _endDateText.text = adjDate(picked);
    });
  }

  Future<DateTime?> _pickDate(DateTime? current, DateTime first, DateTime last) {
    final initial = current == null || current.isBefore(first) || current.isAfter(last) ? first : current;
    return showDatePicker(context: context, initialDate: initial, firstDate: first, lastDate: last);
  }

  Future<void> _pickPayDate() async {
    final today = _today();
    final picked = await _pickDate(_payDate, today, today.add(const Duration(days: 365)));
    if (picked == null || !mounted) return;
    setState(() {
      _payDate = picked;
      _payDateText.text = adjDate(picked);
    });
  }

  Future<void> _pickEffDate() async {
    final today = _today();
    final stmt = ref.read(adjStoreProvider).statementByNumber(_statementNo);
    final first = _lpc && stmt != null
        ? stmt.dueDate.add(const Duration(days: 1))
        : today.subtract(const Duration(days: 90));
    final last = _lpc ? today : today.add(const Duration(days: 365));
    final picked = await _pickDate(_effDate, first, last);
    if (picked == null || !mounted) return;
    setState(() => _setEffDate(picked));
  }

  Future<void> _pickFiles() async {
    final picked = await adjPickFiles(existingNames: _files.map((d) => d.fileName));
    if (picked.isNotEmpty && mounted) setState(() => _files.addAll(picked));
  }

  Future<void> _importCsv() async {
    final text = await adjPickCsvText();
    if (text == null || !mounted) return;
    final result = adjParseCsv(text);
    if (result.lines.isEmpty) {
      Toast.error(result.errors.isEmpty
          ? 'No payees found in that file.'
          : 'No payees imported. ${result.errors.take(5).join(' ')}');
      return;
    }
    final kept = _lines.where((l) => !l.isBlank).length;
    if (kept + result.lines.length > AdjStore.maxPaymentLines) {
      Toast.error('A bulk payment can have at most ${AdjStore.maxPaymentLines} payees.');
      return;
    }
    setState(() {
      for (final blank in _lines.where((l) => l.isBlank).toList()) {
        _lines.remove(blank);
        blank.dispose();
      }
      _lines.addAll(result.lines.map(_LineDraft.new));
    });
    final skipped = result.errors.length;
    if (skipped == 0) {
      Toast.success('Imported ${result.lines.length} payees');
    } else {
      Toast.message('Imported ${result.lines.length} payees. Skipped $skipped '
          '${skipped == 1 ? 'row' : 'rows'}: ${result.errors.take(5).join(' ')}');
    }
  }

  // ---------------------------------------------------------------- submit

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final store = ref.read(adjStoreProvider);
    final problem = AdjWorkflow.routeProblem(store.currentUserEmail, _approvers);
    if (problem != null) {
      Toast.error(problem);
      return;
    }
    if (_bulk && _lines.isEmpty) {
      Toast.error('Add at least one payee.');
      return;
    }
    final guarantee = store.guaranteeByNumber(_bgNumber);
    final stmt = store.statementByNumber(_statementNo);
    final effDate = _effDate;
    final lines = [for (final l in _lines) l.toLine()];
    final rate = _num(_rate.text) ?? 0;
    final newLimit = _num(_newLimit.text) ?? 0;
    final double amount = switch (_kind) {
      AdjKind.bulkPayment => _linesTotal,
      AdjKind.bankGuarantee => guarantee == null ? 0.0 : guarantee.creditLimit - newLimit,
      AdjKind.lpc => stmt == null || effDate == null ? 0.0 : stmt.lpcFor(ratePct: rate, on: effDate),
      AdjKind.adjustment || AdjKind.dataEntry => _num(_amount.text) ?? 0.0,
      AdjKind.creditAdjustment => (newLimit - (_num(_currentLimit.text) ?? 0)).abs(),
    };
    final eval = _credit ? _evalDraft() : null;
    if (_credit && eval == null) {
      Toast.error('Complete the credit evaluation figures.');
      return;
    }
    final cc = _ccList();
    final cs = Theme.of(context).colorScheme;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit for approval?'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ReviewLine('Type', _type!),
                if (guarantee != null) ...[
                  _ReviewLine('Customer', guarantee.customerName),
                  _ReviewLine('Guarantee', '${guarantee.bgNumber}, ${adjRM(guarantee.amount)}'),
                  _ReviewLine('Credit limit', '${adjRM(guarantee.creditLimit)} to ${adjRM(newLimit)}'),
                ],
                if (stmt != null) ...[
                  _ReviewLine('Customer', stmt.customerName),
                  _ReviewLine('Statement', '${stmt.statementNo}, ${adjRM(stmt.outstanding)} unpaid'),
                  _ReviewLine('Rate', '${rate.toStringAsFixed(2)}% a year'),
                ],
                if (eval != null) ...[
                  _ReviewLine('Customer', '${eval.customerName} (${_account.text.trim()})'),
                  _ReviewLine('Credit limit', '${adjRM(eval.currentLimit)} to ${adjRM(newLimit)}'),
                  _ReviewLine('Evaluation',
                      'Grade ${eval.grade} (${eval.score}/100), recommended ${adjRM(eval.recommendedLimit)}'),
                  if (_temporary && _endDate != null) _ReviewLine('Until', adjDate(_endDate!)),
                ],
                _ReviewLine(_kind.amountLabel, adjRM(amount)),
                if (_bulk) _ReviewLine('Payees', '${lines.length}'),
                if (_bulk && _payDate != null) _ReviewLine('Payment date', adjDate(_payDate!)),
                if ((_bg || _lpc || _credit) && effDate != null)
                  _ReviewLine(_lpc ? 'Charge date' : 'Effective date', adjDate(effDate)),
                if (!_bg && !_lpc && !_credit) _ReviewLine(_kind.accountLabel, _account.text.trim()),
                _ReviewLine('Business line', _businessLine!),
                _ReviewLine('Files', _files.isEmpty ? 'None attached' : '${_files.length} attached'),
                if (cc.isNotEmpty) _ReviewLine('CC', cc.join(', ')),
                const SizedBox(height: 14),
                Text('Approval route', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                const SizedBox(height: 6),
                for (var i = 0; i < AdjRole.levels.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      '${i + 1}. ${AdjRole.levels[i].levelTitle}: ${store.nameOf(_approvers[AdjRole.levels[i]])}',
                      style: TextStyle(color: cs.onSurface),
                    ),
                  ),
                const SizedBox(height: 12),
                Text(
                  "The request goes to the first person straight away. You can't edit it after "
                  'submitting unless an approver returns it to you.',
                  style: TextStyle(fontSize: 12, height: 1.4, color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Back to edit')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Submit for approval')),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    try {
      final r = ref.read(adjStoreProvider.notifier).submit(
            kind: _kind,
            businessLine: _businessLine!,
            adjustmentType: _type!,
            totalAmount: amount,
            accountNumber: _account.text,
            reason: _reason.text,
            approvers: _approvers,
            ccEmails: cc,
            documents: _files,
            paymentLines: _bulk ? lines : const [],
            paymentDate: _bulk ? _payDate : null,
            bgNumber: _bg ? _bgNumber : null,
            newCreditLimit: (_bg || _credit) ? newLimit : null,
            statementNo: _lpc ? _statementNo : null,
            lpcRatePct: _lpc ? rate : null,
            effectiveDate: (_bg || _lpc || _credit) ? effDate : null,
            creditEval: eval,
            endDate: _temporary ? _endDate : null,
            sourcePath: _sourcePath,
          );
      Toast.success('Request ${r.referenceCode} submitted. '
          'Waiting for ${store.nameOf(r.approvers[AdjRole.businessReviewer])} to review.');
      adjGoDetail(r);
    } on AdjError catch (e) {
      Toast.error('Not submitted: ${e.message}');
    }
  }

  // ---------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final store = ref.watch(adjStoreProvider);
    final me = store.currentUser;

    // Switching "acting as" changes the requestor, so reset the route.
    ref.listen<String>(adjStoreProvider.select((s) => s.currentUserEmail), (_, next) {
      setState(() => _approvers = Map.of(ref.read(adjStoreProvider).defaultRouteFor(next)));
    });

    final types = adjTypesFor(_kind);

    if (_kind == AdjKind.dataEntry) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.topLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: AdjCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.approval_outlined, size: 36, color: cs.primary),
                  const SizedBox(height: 12),
                  Text(
                    'Data Entry approvals start from the transaction',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: cs.onSurface),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Open a saved transaction in Data Entry and press Request for approval next to Save. '
                    'Its details are copied into the task.',
                    style: TextStyle(color: cs.onSurfaceVariant, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => singleton<AppRouter>().navigatePath('/dataentry/main'),
                    child: const Text('Go to Data Entry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
      // Left-aligned like the rest of the app; max width keeps lines readable.
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(children: [
                  IconButton.outlined(
                    tooltip: 'Back to approval queue',
                    onPressed: () => adjGoList(_kind),
                    icon: const Icon(Icons.arrow_back, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AdjPageHeader(
                      title: _kind.newTitle,
                      subtitle: switch (_kind) {
                        AdjKind.bulkPayment => 'Add the payees, choose the approvers, then submit.',
                        AdjKind.bankGuarantee =>
                          'Choose the expiring guarantee, set the new credit limit, then submit.',
                        AdjKind.lpc => 'Choose the unpaid statement, check the charge, then submit.',
                        AdjKind.dataEntry => 'Data Entry tasks start from the transaction screen.',
                        AdjKind.adjustment => 'Fill in the details, choose the approvers, then submit.',
                        AdjKind.creditAdjustment =>
                          'Enter the new limit and the credit evaluation figures, then submit.',
                      },
                      actions: const [AdjActingAs()],
                    ),
                  ),
                ]),
                const SizedBox(height: 18),
                if (_bg) ...[_guaranteeCard(store), const SizedBox(height: 20)],
                if (_lpc) ...[_lpcCard(store), const SizedBox(height: 20)],
                if (_credit) ...[_creditCard(store), const SizedBox(height: 20), _evalCard(), const SizedBox(height: 20)],
                AdjCard(
                  child: AdjSection(title: 'Request Details', children: [
                    const SizedBox(height: 14),
                    Text('Requestor: ${me.name} (${me.email})', style: TextStyle(color: cs.onSurfaceVariant)),
                    AdjField(child: DropdownButtonFormField<String>(
                      // ignore: deprecated_member_use
                      value: _businessLine,
                      decoration: const InputDecoration(labelText: 'Business line'),
                      items: [for (final b in adjBusinessLines) DropdownMenuItem(value: b, child: Text(b))],
                      onChanged: (v) => setState(() => _businessLine = v),
                      validator: (v) => v == null ? 'Choose a business line.' : null,
                    )),
                    AdjField(child: DropdownButtonFormField<String>(
                      key: ValueKey('type-$_type'),
                      // ignore: deprecated_member_use
                      value: types.contains(_type) ? _type : null,
                      decoration: InputDecoration(labelText: _kind.typeLabel),
                      items: [for (final t in types) DropdownMenuItem(value: t, child: Text(t))],
                      onChanged: (v) => setState(() => _type = v),
                      validator: (v) => v == null ? 'Choose the ${_kind.typeLabel.toLowerCase()}.' : null,
                    )),
                    if (_kind == AdjKind.adjustment) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Tooltip(
                          message: 'Fills the amount, account and reason with made-up values for the chosen '
                              'type (or a random type). Press again for different values.',
                          child: TextButton.icon(
                            onPressed: _fillSample,
                            icon: const Icon(Icons.auto_awesome_outlined, size: 18),
                            label: const Text('Fill with sample'),
                          ),
                        ),
                      ),
                      AdjField(child: TextFormField(
                        controller: _amount,
                        decoration: const InputDecoration(labelText: 'Total amount', prefixText: 'RM '),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                        validator: (v) {
                          final n = _num(v ?? '');
                          return (n == null || n <= 0) ? 'Enter an amount greater than zero.' : null;
                        },
                      )),
                    ],
                    if (!_bg && !_lpc && !_credit) ...[
                      AdjField(child: TextFormField(
                        controller: _account,
                        decoration: InputDecoration(labelText: _kind.accountLabel),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (v) {
                          final n = (v ?? '').trim().length;
                          return (n < 6 || n > 20) ? '${_kind.accountLabel} must be 6 to 20 digits.' : null;
                        },
                      )),
                    ],
                    if (_bulk) ...[
                      AdjField(child: TextFormField(
                        controller: _payDateText,
                        readOnly: true,
                        onTap: _pickPayDate,
                        decoration: const InputDecoration(
                          labelText: 'Payment date',
                          suffixIcon: Icon(Icons.calendar_today, size: 18),
                        ),
                        validator: (_) => _payDate == null ? 'Choose the payment date.' : null,
                      )),
                    ],
                    AdjField(child: TextFormField(
                      controller: _reason,
                      minLines: 4,
                      maxLines: 10,
                      decoration: InputDecoration(
                        labelText: _kind.reasonLabel,
                        alignLabelWithHint: true,
                        helperText: switch (_kind) {
                          AdjKind.bulkPayment => 'What the payments are for and how the amounts were confirmed.',
                          AdjKind.bankGuarantee =>
                            'Why the limit should change, e.g. the guarantee is not being renewed.',
                          AdjKind.lpc => 'Why the charge applies, e.g. reminders sent and no payment arrangement.',
                          AdjKind.dataEntry => 'Why this transaction needs approval.',
                          AdjKind.adjustment => 'Explain what went wrong and how the amount was confirmed.',
                          AdjKind.creditAdjustment =>
                            'Why the limit should change, e.g. fleet growth, seasonal peak or late payments.',
                        },
                      ),
                      validator: (v) => (v ?? '').trim().length < 20
                          ? '${_kind.reasonLabel} needs at least 20 characters.'
                          : null,
                    )),
                  ]),
                ),
                if (_bulk) ...[const SizedBox(height: 20), _linesCard()],
                const SizedBox(height: 20),
                AdjCard(
                  child: AdjSection(title: 'Supporting Documents', children: [
                    const SizedBox(height: 8),
                    for (var i = 0; i < _files.length; i++)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.description, color: cs.primary),
                        title: Text(_files[i].fileName),
                        subtitle: Text(adjSize(_files[i].sizeBytes)),
                        trailing: IconButton(
                          tooltip: 'Remove',
                          icon: const Icon(Icons.close),
                          onPressed: () => setState(() => _files.removeAt(i)),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton.icon(
                        onPressed: _pickFiles,
                        icon: const Icon(Icons.attach_file, size: 18),
                        label: const Text('Attach files'),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(adjFileRulesText, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                  ]),
                ),
                const SizedBox(height: 20),
                AdjCard(
                  child: AdjSection(title: 'Application Approval', children: [
                    const SizedBox(height: 10),
                    Text("Choose who handles each level, in order. You can't be an approver on your own request.",
                        style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant)),
                    for (final role in AdjRole.levels) ...[
                      _ApproverField(
                        key: ValueKey('${role.name}-${me.email}'),
                        role: role,
                        options: store.usersWithRole(role).where((u) => u.email != me.email).toList(),
                        value: _approvers[role],
                        onChanged: (v) => setState(() => _approvers[role] = v),
                      ),
                    ],
                    AdjField(child: TextFormField(
                      controller: _cc,
                      decoration: const InputDecoration(
                        labelText: 'CC email list',
                        helperText: 'Optional. Separate addresses with commas.',
                      ),
                      validator: (_) {
                        final bad = _ccList().where((e) => !_emailPattern.hasMatch(e)).toList();
                        return bad.isEmpty ? null : 'Check these addresses: ${bad.join(', ')}';
                      },
                    )),
                  ]),
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: DiboldTheme.actionSpacing,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(onPressed: () => adjGoList(_kind), child: const Text('Cancel')),
                    FilledButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.send, size: 18),
                      label: const Text('Review and submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------- bank guarantee

  Widget _numField(TextEditingController c, String label, {String? helper, bool money = false, bool whole = false,
      bool optional = false, double width = 220}) {
    return SizedBox(
      width: width,
      child: AdjField(child: TextFormField(
        controller: c,
        decoration: InputDecoration(labelText: label, helperText: helper, prefixText: money ? 'RM ' : null),
        keyboardType: TextInputType.numberWithOptions(decimal: !whole),
        inputFormatters: [FilteringTextInputFormatter.allow(whole ? RegExp(r'[0-9]') : RegExp(r'[0-9.,]'))],
        onChanged: (_) => setState(() {}),
        validator: (v) {
          if (optional && (v ?? '').trim().isEmpty) return null;
          final n = whole ? _int(v ?? '')?.toDouble() : _num(v ?? '');
          return (n == null || n < 0) ? (whole ? 'Enter a whole number.' : 'Enter an amount.') : null;
        },
      )),
    );
  }

  Widget _creditCard(AdjState store) {
    final cs = Theme.of(context).colorScheme;
    final current = _num(_currentLimit.text);
    final newLimit = _num(_newLimit.text);
    final open = store.openTaskForCreditAccount(_account.text.trim());
    return AdjCard(
      child: AdjSection(title: 'Customer and Credit Limit', children: [
        const SizedBox(height: 14),
        if (_sourcePath != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('Raised from Customer Management.', style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
          ),
        Wrap(spacing: DiboldTheme.fieldSpacing, runSpacing: 0, children: [
          SizedBox(
            width: 220,
            child: AdjField(child: TextFormField(
              controller: _account,
              decoration: const InputDecoration(
                labelText: 'Customer account',
                helperText: 'Figures load from the credit register.',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (v) => setState(() => _fillFromRegister(store, v)),
              validator: (v) {
                final n = (v ?? '').trim().length;
                return (n < 6 || n > 20) ? 'Account must be 6 to 20 digits.' : null;
              },
            )),
          ),
          SizedBox(
            width: 320,
            child: AdjField(child: TextFormField(
              controller: _customerName,
              decoration: const InputDecoration(labelText: 'Customer name'),
              onChanged: (_) => setState(() {}),
              validator: (v) => (v ?? '').trim().isEmpty ? 'Enter the customer name.' : null,
            )),
          ),
        ]),
        if (open != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(children: [
              Icon(Icons.info_outline, size: 16, color: context.dbStatus.warning),
              const SizedBox(width: 6),
              Flexible(
                child: Text('This account already has an open credit adjustment, ${open.referenceCode}.',
                    style: TextStyle(fontSize: 12, color: cs.onSurface)),
              ),
              TextButton(onPressed: () => adjGoDetail(open), child: const Text('View task')),
            ]),
          ),
        Wrap(spacing: DiboldTheme.fieldSpacing, runSpacing: 0, children: [
          _numField(_currentLimit, 'Current credit limit', money: true),
          SizedBox(
            width: 220,
            child: AdjField(child: TextFormField(
              controller: _newLimit,
              decoration: const InputDecoration(labelText: 'New credit limit', prefixText: 'RM '),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
              onChanged: (_) => setState(() {}),
              validator: (v) {
                final n = _num(v ?? '');
                if (n == null || n < 0) return 'Enter the new credit limit.';
                final cur = _num(_currentLimit.text);
                if (cur == null) return null;
                final decrease = _type == adjCreditTypes.last;
                if (!decrease && n <= cur) return 'Must be higher than ${adjRM(cur)}.';
                if (decrease && n >= cur) return 'Must be lower than ${adjRM(cur)}.';
                return null;
              },
            )),
          ),
          SizedBox(
            width: 200,
            child: AdjField(child: TextFormField(
              controller: _effDateText,
              readOnly: true,
              onTap: _pickEffDate,
              decoration: const InputDecoration(
                labelText: 'Effective date',
                suffixIcon: Icon(Icons.calendar_today, size: 18),
              ),
              validator: (_) => _effDate == null ? 'Choose the effective date.' : null,
            )),
          ),
          if (_temporary)
            SizedBox(
              width: 200,
              child: AdjField(child: TextFormField(
                controller: _endDateText,
                readOnly: true,
                onTap: _pickEndDate,
                decoration: const InputDecoration(
                  labelText: 'End date',
                  helperText: 'Up to $adjMaxTemporaryDays days.',
                  suffixIcon: Icon(Icons.calendar_today, size: 18),
                ),
                validator: (_) => _endDate == null ? 'Choose the end date.' : null,
              )),
            ),
        ]),
        if (current != null && newLimit != null && newLimit != current) ...[
          const SizedBox(height: 12),
          Text(
            '${newLimit > current ? 'Increase' : 'Decrease'} of ${adjRM((newLimit - current).abs())}'
            '${_temporary ? ', temporary' : ''}.',
            style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface),
          ),
        ],
      ]),
    );
  }

  Widget _evalCard() {
    final cs = Theme.of(context).colorScheme;
    final eval = _evalDraft();
    return AdjCard(
      child: AdjSection(title: 'Credit Evaluation', children: [
        const SizedBox(height: 6),
        Text(
          "The customer's figures for the last 12 months. They are scored when the request is submitted "
          'and approvers see the result.',
          style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
        ),
        Wrap(spacing: DiboldTheme.fieldSpacing, runSpacing: 0, children: [
          _numField(_months, 'Months as customer', whole: true, width: 180),
          _numField(_spend, 'Average monthly spend', helper: 'Last 6 months.', money: true),
          _numField(_balance, 'Current balance', money: true),
          _numField(_late, 'Late payments', helper: 'Last 12 months.', whole: true, width: 180),
          _numField(_dpd, 'Worst days past due', helper: 'Last 12 months.', whole: true, width: 180),
          _numField(_security, 'Security held', helper: 'Bank guarantee or deposit.', money: true, optional: true),
        ]),
        const SizedBox(height: 16),
        if (eval == null)
          Text('Fill in the new limit and the figures above to see the evaluation.',
              style: TextStyle(color: cs.onSurfaceVariant))
        else
          AdjCreditEvalView(eval: eval),
      ]),
    );
  }

  Widget _guaranteeCard(AdjState store) {
    final cs = Theme.of(context).colorScheme;
    final today = _today();
    final options = [
      for (final g in store.guarantees)
        if (g.adjustedBy == null &&
            (store.openTaskForGuarantee(g.bgNumber) == null || g.bgNumber == _bgNumber))
          g,
    ];
    final g = store.guaranteeByNumber(_bgNumber);
    final newLimit = _num(_newLimit.text);

    return AdjCard(
      child: AdjSection(title: 'Bank Guarantee and Credit Limit', children: [
        const SizedBox(height: 14),
        AdjField(child: DropdownButtonFormField<String>(
          key: ValueKey('bg-$_bgNumber'),
          // ignore: deprecated_member_use
          value: options.any((o) => o.bgNumber == _bgNumber) ? _bgNumber : null,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Bank guarantee'),
          items: [
            for (final o in options)
              DropdownMenuItem(
                value: o.bgNumber,
                child: Text('${o.bgNumber}, ${o.customerName} (${adjExpiryText(o, today)})',
                    overflow: TextOverflow.ellipsis),
              ),
          ],
          onChanged: (v) => setState(() => _selectGuarantee(v, store)),
          validator: (v) => v == null ? 'Choose the bank guarantee.' : null,
        )),
        if (options.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Every guarantee in the register already has a task or has been adjusted.',
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
          ),
        if (g != null) ...[
          const SizedBox(height: 10),
          AdjDetailRow(label: 'Customer', value: '${g.customerName} (${g.accountNumber})'),
          AdjDetailRow(label: 'Issuing bank', value: g.issuingBank),
          AdjDetailRow(label: 'Guarantee amount', value: adjRM(g.amount)),
          AdjDetailRow(label: 'Expiry date', value: '${adjDate(g.expiryDate)} (${adjExpiryText(g, today)})'),
          AdjDetailRow(label: 'Current credit limit', value: adjRM(g.creditLimit)),
          Wrap(spacing: DiboldTheme.fieldSpacing, runSpacing: 0, children: [
            SizedBox(
              width: 280,
              child: AdjField(child: TextFormField(
                controller: _newLimit,
                decoration: const InputDecoration(
                  labelText: 'New credit limit',
                  prefixText: 'RM ',
                  helperText: 'Suggested: current limit minus the guarantee.',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                onChanged: (_) => setState(() {}),
                validator: (v) {
                  final n = _num(v ?? '');
                  if (n == null || n < 0) return 'Enter the new credit limit.';
                  if (n >= g.creditLimit) return 'Must be lower than ${adjRM(g.creditLimit)}.';
                  return null;
                },
              )),
            ),
            SizedBox(
              width: 220,
              child: AdjField(child: TextFormField(
                controller: _effDateText,
                readOnly: true,
                onTap: _pickEffDate,
                decoration: const InputDecoration(
                  labelText: 'Effective date',
                  helperText: 'Usually the expiry date.',
                  suffixIcon: Icon(Icons.calendar_today, size: 18),
                ),
                validator: (_) => _effDate == null ? 'Choose the effective date.' : null,
              )),
            ),
          ]),
          if (newLimit != null && newLimit < g.creditLimit) ...[
            const SizedBox(height: 12),
            Text('Credit limit reduction: ${adjRM(g.creditLimit - newLimit)}',
                style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
          ],
        ],
      ]),
    );
  }

  // ---------------------------------------------------------------- LPC

  Widget _lpcCard(AdjState store) {
    final cs = Theme.of(context).colorScheme;
    final today = _today();
    final options = [
      for (final o in store.statementsNeedingLpc(today))
        if (store.openTaskForStatement(o.statementNo) == null || o.statementNo == _statementNo) o,
    ];
    final stmt = store.statementByNumber(_statementNo);
    final rate = _num(_rate.text);
    final effDate = _effDate;
    final charge = stmt != null && rate != null && effDate != null ? stmt.lpcFor(ratePct: rate, on: effDate) : null;

    return AdjCard(
      child: AdjSection(title: 'Unpaid Statement and Charge', children: [
        const SizedBox(height: 14),
        AdjField(child: DropdownButtonFormField<String>(
          key: ValueKey('stmt-$_statementNo'),
          // ignore: deprecated_member_use
          value: options.any((o) => o.statementNo == _statementNo) ? _statementNo : null,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Statement with no payment received'),
          items: [
            for (final o in options)
              DropdownMenuItem(
                value: o.statementNo,
                child: Text(
                  '${o.statementNo}, ${o.customerName} (${o.daysOverdue(today)} days overdue)',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
          onChanged: (v) => setState(() => _selectStatement(v)),
          validator: (v) => v == null ? 'Choose the statement.' : null,
        )),
        if (options.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('No unpaid statements are waiting for an LPC decision.',
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
          ),
        if (stmt != null) ...[
          const SizedBox(height: 10),
          AdjDetailRow(label: 'Customer', value: '${stmt.customerName} (${stmt.accountNumber})'),
          AdjDetailRow(label: 'Due date', value: adjDate(stmt.dueDate)),
          AdjDetailRow(label: 'Amount due', value: adjRM(stmt.amountDue)),
          const AdjDetailRow(label: 'Payment received', value: 'None'),
          Wrap(spacing: DiboldTheme.fieldSpacing, runSpacing: 0, children: [
            SizedBox(
              width: 220,
              child: AdjField(child: TextFormField(
                controller: _rate,
                decoration: const InputDecoration(labelText: 'Rate', suffixText: '% a year'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                onChanged: (_) => setState(() {}),
                validator: (v) {
                  final n = _num(v ?? '');
                  return (n == null || n <= 0 || n > 36) ? 'Enter a rate between 0 and 36.' : null;
                },
              )),
            ),
            SizedBox(
              width: 220,
              child: AdjField(child: TextFormField(
                controller: _effDateText,
                readOnly: true,
                onTap: _pickEffDate,
                decoration: const InputDecoration(
                  labelText: 'Charge date',
                  suffixIcon: Icon(Icons.calendar_today, size: 18),
                ),
                validator: (_) => _effDate == null ? 'Choose the charge date.' : null,
              )),
            ),
          ]),
          if (charge != null && rate != null && effDate != null) ...[
            const SizedBox(height: 12),
            Text(
              'LPC ${adjRM(charge)}: ${adjRM(stmt.outstanding)} × ${rate.toStringAsFixed(2)}% × '
              '${stmt.daysOverdue(effDate)} days ÷ 365',
              style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface),
            ),
          ],
        ],
      ]),
    );
  }

  // ---------------------------------------------------------------- bulk payment lines

  Widget _linesCard() {
    final cs = Theme.of(context).colorScheme;
    final total = _linesTotal;
    return AdjCard(
      child: AdjSection(
        title: 'Payment Lines',
        trailing: Text('${_lines.length} ${_lines.length == 1 ? 'payee' : 'payees'}, ${adjRM(total)}',
            style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
        children: [
          const SizedBox(height: 10),
          Text('Add each payee, or import a CSV with the columns: $adjCsvHeader.',
              style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant)),
          const SizedBox(height: 12),
          Wrap(spacing: DiboldTheme.actionSpacing, runSpacing: 8, children: [
            OutlinedButton.icon(
              onPressed:
                  _lines.length >= AdjStore.maxPaymentLines ? null : () => setState(() => _lines.add(_LineDraft())),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add payee'),
            ),
            OutlinedButton.icon(
              onPressed: _importCsv,
              icon: const Icon(Icons.upload_file, size: 18),
              label: const Text('Import CSV'),
            ),
            TextButton.icon(
              onPressed: () => adjSaveText('bulk-payment-template.csv', adjCsvTemplate),
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Download template'),
            ),
          ]),
          const SizedBox(height: 14),
          for (var i = 0; i < _lines.length; i++)
            _LineEditor(
              key: _lines[i].key,
              index: i,
              draft: _lines[i],
              onChanged: () => setState(() {}),
              onRemove: () => setState(() => _lines.removeAt(i).dispose()),
            ),
          if (_lines.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text('No payees yet.', style: TextStyle(color: cs.onSurfaceVariant)),
            ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text('Total ${adjRM(total)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: cs.onSurface)),
          ),
        ],
      ),
    );
  }
}

/// Editable bulk payment line.
class _LineDraft {
  _LineDraft([AdjPaymentLine? l])
      : payee = TextEditingController(text: l?.payeeName ?? ''),
        bank = TextEditingController(text: l?.bankName ?? ''),
        account = TextEditingController(text: l?.accountNumber ?? ''),
        amount = TextEditingController(text: l == null ? '' : l.amount.toStringAsFixed(2)),
        reference = TextEditingController(text: l?.reference ?? '');

  final TextEditingController payee;
  final TextEditingController bank;
  final TextEditingController account;
  final TextEditingController amount;
  final TextEditingController reference;
  final key = UniqueKey();

  List<TextEditingController> get _all => [payee, bank, account, amount, reference];

  double get amountValue => double.tryParse(amount.text.replaceAll(',', '').trim()) ?? 0;

  bool get isBlank => _all.every((c) => c.text.trim().isEmpty);

  AdjPaymentLine toLine() => AdjPaymentLine(
        payeeName: payee.text.trim(),
        bankName: bank.text.trim(),
        accountNumber: account.text.trim(),
        amount: (amountValue * 100).roundToDouble() / 100,
        reference: reference.text.trim(),
      );

  void dispose() {
    for (final c in _all) {
      c.dispose();
    }
  }
}

class _LineEditor extends StatelessWidget {
  const _LineEditor({
    super.key,
    required this.index,
    required this.draft,
    required this.onChanged,
    required this.onRemove,
  });

  final int index;
  final _LineDraft draft;
  final VoidCallback onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final payee = AdjField(child: TextFormField(
      controller: draft.payee,
      decoration: const InputDecoration(labelText: 'Payee', isDense: true),
      validator: (v) => (v ?? '').trim().isEmpty ? 'Enter the payee.' : null,
    ));
    final bank = AdjField(child: TextFormField(
      controller: draft.bank,
      decoration: InputDecoration(
        labelText: 'Bank',
        isDense: true,
        suffixIcon: PopupMenuButton<String>(
          tooltip: 'Choose a bank',
          icon: const Icon(Icons.arrow_drop_down),
          onSelected: (b) {
            draft.bank.text = b;
            onChanged();
          },
          itemBuilder: (context) => [for (final b in adjBanks) PopupMenuItem<String>(value: b, child: Text(b))],
        ),
      ),
      validator: (v) => (v ?? '').trim().isEmpty ? 'Enter the bank.' : null,
    ));
    final account = AdjField(child: TextFormField(
      controller: draft.account,
      decoration: const InputDecoration(labelText: 'Account number', isDense: true),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (v) {
        final n = (v ?? '').trim().length;
        return (n < 6 || n > 20) ? '6 to 20 digits.' : null;
      },
    ));
    final amount = AdjField(child: TextFormField(
      controller: draft.amount,
      decoration: const InputDecoration(labelText: 'Amount', prefixText: 'RM ', isDense: true),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
      onChanged: (_) => onChanged(),
      validator: (v) {
        final n = double.tryParse((v ?? '').replaceAll(',', '').trim());
        return (n == null || n <= 0) ? 'More than zero.' : null;
      },
    ));
    final reference = AdjField(child: TextFormField(
      controller: draft.reference,
      decoration: const InputDecoration(labelText: 'Reference (optional)', isDense: true),
    ));
    final remove = IconButton(
      tooltip: 'Remove payee ${index + 1}',
      color: context.dbStatus.danger,
      icon: const Icon(Icons.delete_outline),
      onPressed: onRemove,
    );
    final number = SizedBox(
      width: 28,
      child: Text('${index + 1}', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurfaceVariant)),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(DiboldTheme.radiusSm),
      ),
      child: LayoutBuilder(builder: (context, c) {
        if (c.maxWidth >= 820) {
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: const EdgeInsets.only(top: 12), child: number),
            Expanded(flex: 4, child: payee),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: bank),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: account),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: amount),
            const SizedBox(width: 10),
            Expanded(flex: 3, child: reference),
            remove,
          ]);
        }
        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [number, Expanded(child: payee), remove]),
          const SizedBox(height: 10),
          bank,
          const SizedBox(height: 10),
          account,
          const SizedBox(height: 10),
          amount,
          const SizedBox(height: 10),
          reference,
        ]);
      }),
    );
  }
}

class _ApproverField extends StatelessWidget {
  const _ApproverField({
    super.key,
    required this.role,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  final AdjRole role;
  final List<AdjUser> options;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final current = options.any((u) => u.email == value) ? value : null;
    return AdjField(child: DropdownButtonFormField<String>(
      // ignore: deprecated_member_use
      value: current,
      isExpanded: true,
      decoration: InputDecoration(labelText: '${role.levelTitle}: ${role.label}'),
      items: [
        for (final u in options) DropdownMenuItem(value: u.email, child: Text('${u.name} (${u.email})')),
      ],
      onChanged: onChanged,
      validator: (v) => v == null
          ? (options.isEmpty ? 'No one else can approve this level.' : 'Choose a ${role.label.toLowerCase()}.')
          : null,
    ));
  }
}

class _ReviewLine extends StatelessWidget {
  const _ReviewLine(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 110, child: Text(label, style: TextStyle(color: cs.onSurfaceVariant))),
        Expanded(child: Text(value, style: TextStyle(color: cs.onSurface))),
      ]),
    );
  }
}
