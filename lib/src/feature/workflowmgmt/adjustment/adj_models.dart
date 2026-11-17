import 'dart:convert';
import 'dart:typed_data';

/// Task approval — data types.
///
/// Plain Dart (no code generation). Everything can be written to JSON so the
/// store can keep it in the browser between page reloads.

/// What is being approved. Both kinds share the same approval route and
/// screens; bulk payments add payee lines and a payment date.
enum AdjKind {
  adjustment(
    path: 'adjustment',
    refPrefix: 'SA',
    menuTitle: 'Adjustment Approval',
    requestTitle: 'Adjustment Request',
    newTitle: 'New Adjustment Request',
    typeLabel: 'Type of Adjustment',
    accountLabel: 'Account Number',
    reasonLabel: 'Reason for Adjustment',
  ),
  bulkPayment(
    path: 'bulkpayment',
    refPrefix: 'BP',
    menuTitle: 'Bulk Payment Approval',
    requestTitle: 'Bulk Payment Request',
    newTitle: 'New Bulk Payment Request',
    typeLabel: 'Payment Type',
    accountLabel: 'Debit Account',
    reasonLabel: 'Purpose of Payment',
  ),
  bankGuarantee(
    path: 'bankguarantee',
    refPrefix: 'BG',
    menuTitle: 'Bank Guarantee Expiry',
    requestTitle: 'Bank Guarantee Expiry: Credit Limit Adjustment',
    newTitle: 'New Credit Limit Adjustment',
    typeLabel: 'Expiry Outcome',
    accountLabel: 'Customer Account',
    reasonLabel: 'Justification',
    amountLabel: 'Credit Limit Reduction',
  ),
  lpc(
    path: 'lpc',
    refPrefix: 'LP',
    menuTitle: 'LPC Charges',
    requestTitle: 'Late Payment Charge Approval',
    newTitle: 'New LPC Charge',
    typeLabel: 'Charge Basis',
    accountLabel: 'Customer Account',
    reasonLabel: 'Justification',
    amountLabel: 'LPC Amount',
  ),
  dataEntry(
    path: 'dataentry',
    refPrefix: 'DE',
    menuTitle: 'Data Entry Approval',
    requestTitle: 'Data Entry Transaction Approval',
    newTitle: 'Request Approval for a Transaction',
    typeLabel: 'Transaction Type',
    accountLabel: 'Account',
    reasonLabel: 'Reason for Approval',
    amountLabel: 'Transaction Amount',
  ),
  creditAdjustment(
    path: 'creditadj',
    refPrefix: 'CA',
    menuTitle: 'Credit Adjustment',
    requestTitle: 'Credit Limit Adjustment Request',
    newTitle: 'New Credit Limit Adjustment',
    typeLabel: 'Type of Credit Adjustment',
    accountLabel: 'Customer Account',
    reasonLabel: 'Justification',
    amountLabel: 'Limit Change',
  );

  const AdjKind({
    required this.path,
    required this.refPrefix,
    required this.menuTitle,
    required this.requestTitle,
    required this.newTitle,
    required this.typeLabel,
    required this.accountLabel,
    required this.reasonLabel,
    this.amountLabel = 'Total Amount',
  });

  /// URL segment: /workflowmgmt/<path>.
  final String path;

  /// Start of reference codes, e.g. SA2611110355181477.
  final String refPrefix;
  final String menuTitle;
  final String requestTitle;
  final String newTitle;
  final String typeLabel;
  final String accountLabel;
  final String reasonLabel;
  final String amountLabel;

  static AdjKind fromPath(String? path) {
    for (final k in values) {
      if (k.path == path) return k;
    }
    return adjustment;
  }
}

/// One payee in a bulk payment.
class AdjPaymentLine {
  const AdjPaymentLine({
    required this.payeeName,
    required this.bankName,
    required this.accountNumber,
    required this.amount,
    this.reference = '',
  });

  final String payeeName;
  final String bankName;
  final String accountNumber;
  final double amount;
  final String reference;

  Map<String, Object?> toJson() => {
        'payee': payeeName,
        'bank': bankName,
        'account': accountNumber,
        'amount': amount,
        'ref': reference,
      };

  factory AdjPaymentLine.fromJson(Map<String, dynamic> j) => AdjPaymentLine(
        payeeName: j['payee'] as String,
        bankName: j['bank'] as String,
        accountNumber: j['account'] as String,
        amount: (j['amount'] as num).toDouble(),
        reference: (j['ref'] as String?) ?? '',
      );
}

/// A customer's bank guarantee and the credit limit it secures.
/// Kept in the local guarantee register (see adj_seed.dart).
class AdjGuarantee {
  const AdjGuarantee({
    required this.bgNumber,
    required this.customerName,
    required this.accountNumber,
    required this.issuingBank,
    required this.amount,
    required this.expiryDate,
    required this.creditLimit,
    this.adjustedBy,
  });

  final String bgNumber;
  final String customerName;
  final String accountNumber;
  final String issuingBank;

  /// Guarantee amount.
  final double amount;
  final DateTime expiryDate;

  /// Customer's current credit limit.
  final double creditLimit;

  /// Reference of the completed task that adjusted the limit, if any.
  final String? adjustedBy;

  /// Days until expiry (negative once expired), counted in whole days.
  int daysToExpiry(DateTime today) {
    final t = DateTime(today.year, today.month, today.day);
    final e = DateTime(expiryDate.year, expiryDate.month, expiryDate.day);
    return e.difference(t).inDays;
  }

  AdjGuarantee copyWith({double? creditLimit, String? adjustedBy}) => AdjGuarantee(
        bgNumber: bgNumber,
        customerName: customerName,
        accountNumber: accountNumber,
        issuingBank: issuingBank,
        amount: amount,
        expiryDate: expiryDate,
        creditLimit: creditLimit ?? this.creditLimit,
        adjustedBy: adjustedBy ?? this.adjustedBy,
      );

  Map<String, Object?> toJson() => {
        'bg': bgNumber,
        'customer': customerName,
        'account': accountNumber,
        'bank': issuingBank,
        'amount': amount,
        'expiry': expiryDate.toIso8601String(),
        'limit': creditLimit,
        'adjustedBy': adjustedBy,
      };

  factory AdjGuarantee.fromJson(Map<String, dynamic> j) => AdjGuarantee(
        bgNumber: j['bg'] as String,
        customerName: j['customer'] as String,
        accountNumber: j['account'] as String,
        issuingBank: j['bank'] as String,
        amount: (j['amount'] as num).toDouble(),
        expiryDate: DateTime.parse(j['expiry'] as String),
        creditLimit: (j['limit'] as num).toDouble(),
        adjustedBy: j['adjustedBy'] as String?,
      );
}

/// A customer account's credit limit and the figures a credit evaluation
/// uses. Kept in the local customer credit register (see adj_seed.dart).
class AdjCreditProfile {
  const AdjCreditProfile({
    required this.accountNumber,
    required this.customerName,
    required this.creditLimit,
    required this.monthsActive,
    required this.avgMonthlySpend,
    required this.balance,
    required this.latePayments12m,
    required this.maxDaysPastDue,
    this.securityAmount = 0,
    this.adjustedBy,
  });

  final String accountNumber;
  final String customerName;
  final double creditLimit;

  /// Months since the account was opened.
  final int monthsActive;

  /// Average monthly spend over the last 6 months.
  final double avgMonthlySpend;

  /// Current outstanding balance.
  final double balance;

  /// Late payments in the last 12 months.
  final int latePayments12m;

  /// Worst days past due in the last 12 months.
  final int maxDaysPastDue;

  /// Bank guarantee or deposit held.
  final double securityAmount;

  /// Reference of the completed task that last changed the limit.
  final String? adjustedBy;

  double get utilisationPct => creditLimit <= 0 ? 0 : balance / creditLimit * 100;

  AdjCreditProfile copyWith({double? creditLimit, String? adjustedBy}) => AdjCreditProfile(
        accountNumber: accountNumber,
        customerName: customerName,
        creditLimit: creditLimit ?? this.creditLimit,
        monthsActive: monthsActive,
        avgMonthlySpend: avgMonthlySpend,
        balance: balance,
        latePayments12m: latePayments12m,
        maxDaysPastDue: maxDaysPastDue,
        securityAmount: securityAmount,
        adjustedBy: adjustedBy ?? this.adjustedBy,
      );

  Map<String, Object?> toJson() => {
        'account': accountNumber,
        'customer': customerName,
        'limit': creditLimit,
        'months': monthsActive,
        'spend': avgMonthlySpend,
        'balance': balance,
        'late': latePayments12m,
        'dpd': maxDaysPastDue,
        'security': securityAmount,
        'adjustedBy': adjustedBy,
      };

  factory AdjCreditProfile.fromJson(Map<String, dynamic> j) => AdjCreditProfile(
        accountNumber: j['account'] as String,
        customerName: j['customer'] as String,
        creditLimit: (j['limit'] as num).toDouble(),
        monthsActive: (j['months'] as num).toInt(),
        avgMonthlySpend: (j['spend'] as num).toDouble(),
        balance: (j['balance'] as num).toDouble(),
        latePayments12m: (j['late'] as num).toInt(),
        maxDaysPastDue: (j['dpd'] as num).toInt(),
        securityAmount: (j['security'] as num?)?.toDouble() ?? 0,
        adjustedBy: j['adjustedBy'] as String?,
      );
}

/// One scored line of a credit evaluation.
class AdjEvalFactor {
  const AdjEvalFactor(this.label, this.value, this.points, this.maxPoints);
  final String label;

  /// The figure scored, as shown, e.g. "2 in 12 months".
  final String value;
  final int points;
  final int maxPoints;
}

/// Credit evaluation for a credit limit change: a snapshot of the customer's
/// figures when the request was raised, scored out of 100.
///
/// Scoring (sample policy, see README):
/// payment history 30, worst days past due 20, relationship 15,
/// utilisation 15, security cover 20. Grade A 80+, B 65+, C 50+, D below.
/// Recommended limit = average monthly spend x 2.0 / 1.5 / 1.0 / 0.5 for
/// A / B / C / D, plus the security held, rounded down to RM 1,000.
class AdjCreditEval {
  const AdjCreditEval({
    required this.customerName,
    required this.currentLimit,
    required this.requestedLimit,
    required this.monthsActive,
    required this.avgMonthlySpend,
    required this.balance,
    required this.latePayments12m,
    required this.maxDaysPastDue,
    required this.securityAmount,
  });

  final String customerName;
  final double currentLimit;
  final double requestedLimit;
  final int monthsActive;
  final double avgMonthlySpend;
  final double balance;
  final int latePayments12m;
  final int maxDaysPastDue;
  final double securityAmount;

  /// Balance against the requested limit, in percent.
  double get utilisationPct => requestedLimit <= 0 ? 999 : balance / requestedLimit * 100;

  /// Security held against the requested limit, in percent.
  double get securityCoverPct => requestedLimit <= 0 ? 0 : securityAmount / requestedLimit * 100;

  List<AdjEvalFactor> get factors {
    final late = latePayments12m;
    final dpd = maxDaysPastDue;
    final m = monthsActive;
    final u = utilisationPct;
    final c = securityCoverPct;
    return [
      AdjEvalFactor('Payment history', late == 0 ? 'No late payments in 12 months' : '$late late in 12 months',
          late == 0 ? 30 : late <= 2 ? 20 : late <= 5 ? 10 : 0, 30),
      AdjEvalFactor('Worst days past due', dpd == 0 ? 'Never overdue' : '$dpd days',
          dpd == 0 ? 20 : dpd <= 30 ? 12 : dpd <= 60 ? 5 : 0, 20),
      AdjEvalFactor('Relationship', m >= 12 ? '${m ~/ 12} yr ${m % 12} mo' : '$m months',
          m >= 36 ? 15 : m >= 12 ? 10 : m >= 6 ? 5 : 0, 15),
      AdjEvalFactor('Utilisation of requested limit', '${u.toStringAsFixed(0)}%',
          u <= 50 ? 15 : u <= 80 ? 10 : u <= 100 ? 5 : 0, 15),
      AdjEvalFactor('Security cover', c <= 0 ? 'None' : '${c.toStringAsFixed(0)}% of requested limit',
          c >= 50 ? 20 : c >= 25 ? 12 : c > 0 ? 6 : 0, 20),
    ];
  }

  int get score => factors.fold(0, (t, f) => t + f.points);

  /// A, B, C or D.
  String get grade => score >= 80 ? 'A' : score >= 65 ? 'B' : score >= 50 ? 'C' : 'D';

  String get riskLabel => switch (grade) {
        'A' => 'Low risk',
        'B' => 'Moderate risk',
        'C' => 'Elevated risk',
        _ => 'High risk',
      };

  double get _multiplier => switch (grade) {
        'A' => 2.0,
        'B' => 1.5,
        'C' => 1.0,
        _ => 0.5,
      };

  double get recommendedLimit {
    final raw = avgMonthlySpend * _multiplier + securityAmount;
    return (raw / 1000).floorToDouble() * 1000;
  }

  /// Requested limit is at or below the recommended limit.
  bool get withinRecommendation => requestedLimit <= recommendedLimit;

  Map<String, Object?> toJson() => {
        'customer': customerName,
        'current': currentLimit,
        'requested': requestedLimit,
        'months': monthsActive,
        'spend': avgMonthlySpend,
        'balance': balance,
        'late': latePayments12m,
        'dpd': maxDaysPastDue,
        'security': securityAmount,
      };

  factory AdjCreditEval.fromJson(Map<String, dynamic> j) => AdjCreditEval(
        customerName: j['customer'] as String,
        currentLimit: (j['current'] as num).toDouble(),
        requestedLimit: (j['requested'] as num).toDouble(),
        monthsActive: (j['months'] as num).toInt(),
        avgMonthlySpend: (j['spend'] as num).toDouble(),
        balance: (j['balance'] as num).toDouble(),
        latePayments12m: (j['late'] as num).toInt(),
        maxDaysPastDue: (j['dpd'] as num).toInt(),
        securityAmount: (j['security'] as num).toDouble(),
      );
}

/// A customer statement past its due date. Statements with no payment
/// received are offered for a late payment charge (LPC).
class AdjOverdue {
  const AdjOverdue({
    required this.statementNo,
    required this.customerName,
    required this.accountNumber,
    required this.dueDate,
    required this.amountDue,
    this.amountPaid = 0,
    this.chargedBy,
  });

  final String statementNo;
  final String customerName;
  final String accountNumber;
  final DateTime dueDate;
  final double amountDue;
  final double amountPaid;

  /// Reference of the completed task that posted the LPC, if any.
  final String? chargedBy;

  double get outstanding => amountDue - amountPaid;
  bool get noPaymentReceived => amountPaid <= 0;

  int daysOverdue(DateTime on) {
    final d = DateTime(on.year, on.month, on.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final n = d.difference(due).inDays;
    return n < 0 ? 0 : n;
  }

  /// outstanding × rate% × days ÷ 365, rounded to sen.
  double lpcFor({required double ratePct, required DateTime on}) =>
      (outstanding * ratePct / 100 * daysOverdue(on) / 365 * 100).roundToDouble() / 100;

  AdjOverdue copyWith({String? chargedBy}) => AdjOverdue(
        statementNo: statementNo,
        customerName: customerName,
        accountNumber: accountNumber,
        dueDate: dueDate,
        amountDue: amountDue,
        amountPaid: amountPaid,
        chargedBy: chargedBy ?? this.chargedBy,
      );

  Map<String, Object?> toJson() => {
        'stmt': statementNo,
        'customer': customerName,
        'account': accountNumber,
        'due': dueDate.toIso8601String(),
        'amountDue': amountDue,
        'paid': amountPaid,
        'chargedBy': chargedBy,
      };

  factory AdjOverdue.fromJson(Map<String, dynamic> j) => AdjOverdue(
        statementNo: j['stmt'] as String,
        customerName: j['customer'] as String,
        accountNumber: j['account'] as String,
        dueDate: DateTime.parse(j['due'] as String),
        amountDue: (j['amountDue'] as num).toDouble(),
        amountPaid: (j['paid'] as num?)?.toDouble() ?? 0,
        chargedBy: j['chargedBy'] as String?,
      );
}

/// A Data Entry transaction sent for approval with "Request for approval":
/// where it came from and a snapshot of its form fields at that moment.
class AdjSourceRecord {
  const AdjSourceRecord({
    required this.screen,
    required this.txnType,
    required this.txnId,
    required this.path,
    this.fields = const [],
  });

  /// Screen name, e.g. "Adjustment", "Payment", "Sale".
  final String screen;

  /// Data Entry transaction type (route parameter).
  final String txnType;
  final String txnId;

  /// App path that opens the transaction, e.g. /dataentry/manual/ADJ/adjust/123.
  final String path;

  /// (label, value) pairs as shown on the form.
  final List<(String, String)> fields;

  Map<String, Object?> toJson() => {
        'screen': screen,
        'txnType': txnType,
        'txnId': txnId,
        'path': path,
        'fields': [for (final f in fields) [f.$1, f.$2]],
      };

  factory AdjSourceRecord.fromJson(Map<String, dynamic> j) => AdjSourceRecord(
        screen: j['screen'] as String,
        txnType: j['txnType'] as String,
        txnId: j['txnId'] as String,
        path: j['path'] as String,
        fields: [
          for (final f in (j['fields'] as List? ?? const []))
            ((f as List)[0] as String, f[1] as String),
        ],
      );
}

/// The six stages shown on the stepper, in order.
enum AdjStage {
  submitted('Submitted'),
  businessReviewed('Business Reviewed'),
  aaApproved('AA Approved'),
  financeReviewed('Finance Reviewed'),
  financeApproved('Finance Approved'),
  completed('Completed');

  const AdjStage(this.label);
  final String label;

  int get step => index + 1;
}

enum AdjStatus {
  inProgress('In progress'),
  returned('Returned for amendment'),
  rejected('Rejected'),
  completed('Completed');

  const AdjStatus(this.label);
  final String label;
}

enum AdjRole {
  requestor('Requestor', 'Submission'),
  businessReviewer('Business Reviewer', 'Business Review'),
  aaApprover('Approving Authority', 'Approving Authority'),
  financeReviewer('Finance Reviewer', 'Finance Review'),
  financeApprover('Finance Approver', 'Finance Approver'),
  financeOps('Finance Processor', 'Finance Processor');

  const AdjRole(this.label, this.levelTitle);

  /// A person's role, e.g. "Finance Reviewer".
  final String label;

  /// Heading of this level in Application Approval, e.g. "Finance Review".
  final String levelTitle;

  /// Approval levels in the order a request passes through them.
  static const levels = [
    AdjRole.businessReviewer,
    AdjRole.aaApprover,
    AdjRole.financeReviewer,
    AdjRole.financeApprover,
    AdjRole.financeOps,
  ];
}

class AdjUser {
  const AdjUser({required this.name, required this.email, required this.role});

  final String name;
  final String email;
  final AdjRole role;

  String get initials {
    final parts = name.split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  bool operator ==(Object other) => other is AdjUser && other.email == email;

  @override
  int get hashCode => email.hashCode;
}

enum AdjAction {
  submitted('Submitted'),
  reviewed('Reviewed'),
  approved('Approved'),
  completed('Completed'),
  returned('Returned for amendment'),
  rejected('Rejected'),
  resubmitted('Resubmitted'),
  documentsAdded('Attached files'),
  documentRemoved('Removed file');

  const AdjAction(this.label);
  final String label;

  /// File changes are logged for audit but are not approval decisions.
  bool get isDocumentChange =>
      this == AdjAction.documentsAdded || this == AdjAction.documentRemoved;
}

class AdjHistoryEntry {
  const AdjHistoryEntry({
    required this.action,
    required this.actorEmail,
    required this.at,
    this.remarks = '',
  });

  final AdjAction action;
  final String actorEmail;
  final DateTime at;
  final String remarks;

  Map<String, Object?> toJson() => {
        'action': action.name,
        'actor': actorEmail,
        'at': at.toIso8601String(),
        'remarks': remarks,
      };

  factory AdjHistoryEntry.fromJson(Map<String, dynamic> j) => AdjHistoryEntry(
        action: AdjAction.values.byName(j['action'] as String),
        actorEmail: j['actor'] as String,
        at: DateTime.parse(j['at'] as String),
        remarks: (j['remarks'] as String?) ?? '',
      );
}

class AdjDocument {
  const AdjDocument({
    required this.id,
    required this.fileName,
    required this.sizeBytes,
    required this.step,
    this.uploadedBy,
    this.uploadedAt,
    this.bytes,
    this.isSample = false,
  });

  final String id;
  final String fileName;
  final int sizeBytes;

  /// Step the file was added at: [AdjRole.requestor] for the submission
  /// (or a resubmission), otherwise the approval level's role.
  final AdjRole step;
  final String? uploadedBy;
  final DateTime? uploadedAt;

  /// File content. Null for sample rows, and for large files after a page
  /// reload (only small files are kept in browser storage).
  final Uint8List? bytes;

  /// Seeded demo row with no file behind it.
  final bool isSample;

  bool get hasContent => bytes != null;

  String get extension {
    final dot = fileName.lastIndexOf('.');
    return dot < 0 ? '' : fileName.substring(dot + 1).toLowerCase();
  }

  String get mimeType => switch (extension) {
        'pdf' => 'application/pdf',
        'png' => 'image/png',
        'jpg' || 'jpeg' => 'image/jpeg',
        'csv' => 'text/csv',
        'xlsx' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        'xls' => 'application/vnd.ms-excel',
        'docx' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'doc' => 'application/msword',
        _ => 'application/octet-stream',
      };

  /// Types a browser can show in a tab; everything else downloads instead.
  bool get previewable =>
      mimeType == 'application/pdf' || mimeType.startsWith('image/');

  /// [keepContent] decides whether the file's bytes are written too.
  Map<String, Object?> toJson({required bool keepContent}) => {
        'id': id,
        'name': fileName,
        'size': sizeBytes,
        'step': step.name,
        'by': uploadedBy,
        'at': uploadedAt?.toIso8601String(),
        'sample': isSample,
        if (keepContent && bytes != null) 'data': base64Encode(bytes!),
      };

  factory AdjDocument.fromJson(Map<String, dynamic> j) => AdjDocument(
        id: j['id'] as String,
        fileName: j['name'] as String,
        sizeBytes: (j['size'] as num).toInt(),
        step: AdjRole.values.byName((j['step'] as String?) ?? 'requestor'),
        uploadedBy: j['by'] as String?,
        uploadedAt: j['at'] == null ? null : DateTime.parse(j['at'] as String),
        isSample: (j['sample'] as bool?) ?? false,
        bytes: j['data'] == null ? null : base64Decode(j['data'] as String),
      );
}

class AdjRequest {
  const AdjRequest({
    this.kind = AdjKind.adjustment,
    required this.referenceCode,
    required this.requestorEmail,
    required this.requestDate,
    required this.businessLine,
    required this.adjustmentType,
    required this.totalAmount,
    required this.accountNumber,
    required this.reason,
    required this.approvers,
    this.ccEmails = const [],
    this.stage = AdjStage.submitted,
    this.status = AdjStatus.inProgress,
    this.documents = const [],
    this.history = const [],
    this.paymentLines = const [],
    this.paymentDate,
    this.guarantee,
    this.newCreditLimit,
    this.effectiveDate,
    this.overdue,
    this.lpcRatePct,
    this.source,
    this.creditEval,
    this.endDate,
    this.sourcePath,
  });

  final AdjKind kind;
  final String referenceCode;
  final String requestorEmail;
  final DateTime requestDate;
  final String businessLine;
  final String adjustmentType;
  final double totalAmount;
  final String accountNumber;
  final String reason;

  /// Email of the person assigned to each approval level.
  final Map<AdjRole, String> approvers;

  /// Kept informed; cannot act on the request.
  final List<String> ccEmails;

  /// Last stage the request has reached.
  final AdjStage stage;
  final AdjStatus status;
  final List<AdjDocument> documents;
  final List<AdjHistoryEntry> history;

  /// Bulk payments: one line per payee. [totalAmount] is their sum.
  final List<AdjPaymentLine> paymentLines;

  /// Bulk payments: date the payment should be released.
  final DateTime? paymentDate;

  /// Bank guarantee expiry: the guarantee as it was when the task was raised.
  final AdjGuarantee? guarantee;

  /// Bank guarantee expiry: proposed credit limit. [totalAmount] is the
  /// reduction (guarantee's credit limit minus this).
  final double? newCreditLimit;

  /// Bank guarantee expiry: date the new limit takes effect.
  final DateTime? effectiveDate;

  /// LPC: the statement as it was when the task was raised.
  final AdjOverdue? overdue;

  /// LPC: annual rate in percent. The charge date is [effectiveDate] and
  /// [totalAmount] is the charge.
  final double? lpcRatePct;

  /// Data Entry approval: the transaction this task is about.
  final AdjSourceRecord? source;

  /// Credit adjustment: the credit evaluation. Current limit, requested
  /// limit ([newCreditLimit]) and the customer's figures are in it;
  /// [totalAmount] is the size of the change.
  final AdjCreditEval? creditEval;

  /// Credit adjustment, temporary increase: last day of the higher limit.
  final DateTime? endDate;

  /// Credit adjustment raised from Customer Management: the screen to go
  /// back to.
  final String? sourcePath;

  bool get isCreditAdjustment => kind == AdjKind.creditAdjustment;

  bool get isLpc => kind == AdjKind.lpc;
  bool get isBulkPayment => kind == AdjKind.bulkPayment;
  bool get isBankGuarantee => kind == AdjKind.bankGuarantee;

  /// Approval decisions only (no file changes).
  Iterable<AdjHistoryEntry> get decisions =>
      history.where((e) => !e.action.isDocumentChange);

  AdjRequest copyWith({
    String? reason,
    AdjStage? stage,
    AdjStatus? status,
    List<AdjDocument>? documents,
    List<AdjHistoryEntry>? history,
  }) =>
      AdjRequest(
        kind: kind,
        referenceCode: referenceCode,
        requestorEmail: requestorEmail,
        requestDate: requestDate,
        businessLine: businessLine,
        adjustmentType: adjustmentType,
        totalAmount: totalAmount,
        accountNumber: accountNumber,
        reason: reason ?? this.reason,
        approvers: approvers,
        ccEmails: ccEmails,
        stage: stage ?? this.stage,
        status: status ?? this.status,
        documents: documents ?? this.documents,
        history: history ?? this.history,
        paymentLines: paymentLines,
        paymentDate: paymentDate,
        guarantee: guarantee,
        newCreditLimit: newCreditLimit,
        effectiveDate: effectiveDate,
        overdue: overdue,
        lpcRatePct: lpcRatePct,
        source: source,
        creditEval: creditEval,
        endDate: endDate,
        sourcePath: sourcePath,
      );

  Map<String, Object?> toJson({required bool Function(AdjDocument) keepContent}) => {
        'kind': kind.name,
        'ref': referenceCode,
        'requestor': requestorEmail,
        'date': requestDate.toIso8601String(),
        'businessLine': businessLine,
        'type': adjustmentType,
        'amount': totalAmount,
        'account': accountNumber,
        'reason': reason,
        'approvers': {for (final e in approvers.entries) e.key.name: e.value},
        'cc': ccEmails,
        'stage': stage.name,
        'status': status.name,
        'documents': [for (final d in documents) d.toJson(keepContent: keepContent(d))],
        'history': [for (final h in history) h.toJson()],
        'lines': [for (final l in paymentLines) l.toJson()],
        'payDate': paymentDate?.toIso8601String(),
        'guarantee': guarantee?.toJson(),
        'newLimit': newCreditLimit,
        'effective': effectiveDate?.toIso8601String(),
        'overdue': overdue?.toJson(),
        'lpcRate': lpcRatePct,
        'source': source?.toJson(),
        'creditEval': creditEval?.toJson(),
        'endDate': endDate?.toIso8601String(),
        'sourcePath': sourcePath,
      };

  factory AdjRequest.fromJson(Map<String, dynamic> j) => AdjRequest(
        kind: AdjKind.values.byName((j['kind'] as String?) ?? 'adjustment'),
        referenceCode: j['ref'] as String,
        requestorEmail: j['requestor'] as String,
        requestDate: DateTime.parse(j['date'] as String),
        businessLine: j['businessLine'] as String,
        adjustmentType: j['type'] as String,
        totalAmount: (j['amount'] as num).toDouble(),
        accountNumber: j['account'] as String,
        reason: j['reason'] as String,
        approvers: {
          for (final e in (j['approvers'] as Map<String, dynamic>).entries)
            AdjRole.values.byName(e.key): e.value as String,
        },
        ccEmails: [for (final c in (j['cc'] as List? ?? const [])) c as String],
        stage: AdjStage.values.byName(j['stage'] as String),
        status: AdjStatus.values.byName(j['status'] as String),
        documents: [
          for (final d in (j['documents'] as List? ?? const []))
            AdjDocument.fromJson(d as Map<String, dynamic>),
        ],
        history: [
          for (final h in (j['history'] as List? ?? const []))
            AdjHistoryEntry.fromJson(h as Map<String, dynamic>),
        ],
        paymentLines: [
          for (final l in (j['lines'] as List? ?? const []))
            AdjPaymentLine.fromJson(l as Map<String, dynamic>),
        ],
        paymentDate: j['payDate'] == null ? null : DateTime.parse(j['payDate'] as String),
        guarantee: j['guarantee'] == null
            ? null
            : AdjGuarantee.fromJson(j['guarantee'] as Map<String, dynamic>),
        newCreditLimit: (j['newLimit'] as num?)?.toDouble(),
        effectiveDate: j['effective'] == null ? null : DateTime.parse(j['effective'] as String),
        overdue: j['overdue'] == null ? null : AdjOverdue.fromJson(j['overdue'] as Map<String, dynamic>),
        lpcRatePct: (j['lpcRate'] as num?)?.toDouble(),
        source: j['source'] == null ? null : AdjSourceRecord.fromJson(j['source'] as Map<String, dynamic>),
        creditEval: j['creditEval'] == null
            ? null
            : AdjCreditEval.fromJson(j['creditEval'] as Map<String, dynamic>),
        endDate: j['endDate'] == null ? null : DateTime.parse(j['endDate'] as String),
        sourcePath: j['sourcePath'] as String?,
      );
}
