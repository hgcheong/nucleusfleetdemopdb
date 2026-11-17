import 'adj_models.dart';
import 'adj_samples.dart';

/// Demo users and requests. Local data only — nothing is fetched.
/// Replace [adjDemoUsers] with your users (or the signed-in session) when
/// connecting the workflow to the backend.

const adjDemoUsers = <AdjUser>[
  AdjUser(name: 'M Faris Bakri', email: 'mfaris.bakri@petronas.com.my', role: AdjRole.requestor),
  AdjUser(name: 'Hafiz Rahman', email: 'hafiz.rahman@example.com', role: AdjRole.businessReviewer),
  AdjUser(name: 'Nurul Huda Kamal', email: 'nurul.kamal@example.com', role: AdjRole.businessReviewer),
  AdjUser(name: 'Nor Aishah M Azman', email: 'noraishah.azman@example.com', role: AdjRole.aaApprover),
  AdjUser(name: 'Rashid Omar', email: 'rashid.omar@example.com', role: AdjRole.aaApprover),
  AdjUser(name: 'Lim Wei Ling', email: 'weiling.lim@example.com', role: AdjRole.financeReviewer),
  AdjUser(name: 'Tan Mei Ling', email: 'meiling.tan@example.com', role: AdjRole.financeReviewer),
  AdjUser(name: 'Azyan Azmi', email: 'azyan.azmi@petronas.com.my', role: AdjRole.financeApprover),
  AdjUser(name: 'Farah Hassan', email: 'farah.hassan@example.com', role: AdjRole.financeApprover),
  AdjUser(name: 'Azlan Ismail', email: 'azlan.ismail@example.com', role: AdjRole.financeOps),
  AdjUser(name: 'Kumar Selvam', email: 'kumar.selvam@example.com', role: AdjRole.financeOps),
];

/// Starting user: the Approving Authority, so the first request is waiting.
const adjDefaultUserEmail = 'noraishah.azman@example.com';

const adjBusinessLines = ['Customer', 'Fleet', 'Dealer'];

const adjAdjustmentTypes = [
  'Credit Misc Transfer Adjust',
  'Debit Misc Transfer Adjust',
  'Reload Reversal',
  'Duplicate Transaction Reversal',
  'Fuel Price Correction',
  'Rebate Adjustment',
  'Card Balance Transfer',
  'Fee Waiver',
  'LPC Reversal',
  'Chargeback Adjustment',
  'Small Balance Write-off',
];

const adjPaymentTypes = [
  'Dealer settlement',
  'Customer refund',
  'Rebate payout',
  'Vendor payment',
];

/// Suggestions only; any bank name can be typed.
const adjBanks = [
  'Maybank',
  'CIMB Bank',
  'Public Bank',
  'RHB Bank',
  'Hong Leong Bank',
  'AmBank',
  'Bank Islam',
  'BSN',
];

const adjGuaranteeOutcomes = [
  'Not renewed',
  'Renewed at a lower amount',
  'Replaced by other security',
];

const adjLpcBases = [
  'Standard rate',
  'Reduced rate (goodwill)',
];

/// Credit adjustment types. The New request form and the store rely on this
/// order: index 1 is the temporary increase, the last one is the decrease.
const adjCreditTypes = [
  'Permanent increase',
  'Temporary increase',
  'Permanent decrease',
];

/// Longest temporary credit limit increase, in days.
const adjMaxTemporaryDays = 180;

/// Default LPC rate, percent per year.
const adjDefaultLpcRate = 18.0;

/// Data Entry screens that can send a transaction for approval.
const adjDataEntryScreens = ['Adjustment', 'Payment', 'Sale', 'Fee', 'Pukal', 'Manual transaction'];

/// Request types offered on the New request form for each kind.
List<String> adjTypesFor(AdjKind kind) => switch (kind) {
      AdjKind.bulkPayment => adjPaymentTypes,
      AdjKind.bankGuarantee => adjGuaranteeOutcomes,
      AdjKind.lpc => adjLpcBases,
      AdjKind.dataEntry => adjDataEntryScreens,
      AdjKind.creditAdjustment => adjCreditTypes,
      AdjKind.adjustment => adjAdjustmentTypes,
    };

/// Guarantees expiring within this many days are listed for action.
const adjGuaranteeWindowDays = 30;

DateTime _today() {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day);
}

DateTime _days(int d) => _today().add(Duration(days: d));

/// Sample guarantee register. Expiry dates are relative to today so the
/// "expiring soon" list always has entries.
List<AdjGuarantee> adjSeedGuarantees() => [
      AdjGuarantee(
        bgNumber: 'BG-MBB-2024-00871',
        customerName: 'Logistik Cepat Sdn Bhd',
        accountNumber: '60711842',
        issuingBank: 'Maybank',
        amount: 150000,
        expiryDate: _days(9),
        creditLimit: 250000,
      ),
      AdjGuarantee(
        bgNumber: 'BG-CIMB-2025-01204',
        customerName: 'Armada Biru Transport Sdn Bhd',
        accountNumber: '60702219',
        issuingBank: 'CIMB Bank',
        amount: 80000,
        expiryDate: _days(21),
        creditLimit: 120000,
      ),
      AdjGuarantee(
        bgNumber: 'BG-PBB-2023-00412',
        customerName: 'Teksi Ehsan Enterprise',
        accountNumber: '60698830',
        issuingBank: 'Public Bank',
        amount: 30000,
        expiryDate: _days(-4),
        creditLimit: 45000,
      ),
      AdjGuarantee(
        bgNumber: 'BG-RHB-2024-00733',
        customerName: 'Kenderaan Niaga Utara Sdn Bhd',
        accountNumber: '60700417',
        issuingBank: 'RHB Bank',
        amount: 100000,
        expiryDate: _days(52),
        creditLimit: 180000,
      ),
      AdjGuarantee(
        bgNumber: 'BG-HLB-2023-00198',
        customerName: 'Bas Ekspres Selatan Sdn Bhd',
        accountNumber: '60709308',
        issuingBank: 'Hong Leong Bank',
        amount: 50000,
        expiryDate: _days(-20),
        creditLimit: 40000,
        adjustedBy: _seed.bgDoneRef,
      ),
    ];

/// Sample customer credit register: current limits and the figures the
/// credit evaluation uses.
List<AdjCreditProfile> adjSeedCreditProfiles() => [
      const AdjCreditProfile(
        accountNumber: '60711842',
        customerName: 'Logistik Cepat Sdn Bhd',
        creditLimit: 250000,
        monthsActive: 30,
        avgMonthlySpend: 140000,
        balance: 230000,
        latePayments12m: 3,
        maxDaysPastDue: 35,
        securityAmount: 150000,
      ),
      const AdjCreditProfile(
        accountNumber: '60702219',
        customerName: 'Armada Biru Transport Sdn Bhd',
        creditLimit: 120000,
        monthsActive: 52,
        avgMonthlySpend: 68000,
        balance: 74000,
        latePayments12m: 1,
        maxDaysPastDue: 12,
        securityAmount: 80000,
      ),
      const AdjCreditProfile(
        accountNumber: '60700417',
        customerName: 'Kenderaan Niaga Utara Sdn Bhd',
        creditLimit: 180000,
        monthsActive: 64,
        avgMonthlySpend: 96000,
        balance: 61000,
        latePayments12m: 0,
        maxDaysPastDue: 0,
        securityAmount: 100000,
      ),
      const AdjCreditProfile(
        accountNumber: '60709308',
        customerName: 'Bas Ekspres Selatan Sdn Bhd',
        creditLimit: 40000,
        monthsActive: 41,
        avgMonthlySpend: 27500,
        balance: 21800,
        latePayments12m: 2,
        maxDaysPastDue: 18,
        securityAmount: 0,
      ),
      const AdjCreditProfile(
        accountNumber: '60698830',
        customerName: 'Teksi Ehsan Enterprise',
        creditLimit: 45000,
        monthsActive: 9,
        avgMonthlySpend: 14200,
        balance: 39500,
        latePayments12m: 4,
        maxDaysPastDue: 46,
        securityAmount: 30000,
      ),
      AdjCreditProfile(
        accountNumber: '60715520',
        customerName: 'Pengangkutan Damai Sdn Bhd',
        creditLimit: 40000,
        monthsActive: 20,
        avgMonthlySpend: 25000,
        balance: 18000,
        latePayments12m: 6,
        maxDaysPastDue: 75,
        adjustedBy: _seed.caDoneRef,
      ),
    ];

/// Sample statements past due. Due dates are relative to today.
List<AdjOverdue> adjSeedOverdues() => [
      AdjOverdue(
        statementNo: 'STM-60711842-2610',
        customerName: 'Logistik Cepat Sdn Bhd',
        accountNumber: '60711842',
        dueDate: _days(-18),
        amountDue: 48250.60,
      ),
      AdjOverdue(
        statementNo: 'STM-60702219-2610',
        customerName: 'Armada Biru Transport Sdn Bhd',
        accountNumber: '60702219',
        dueDate: _days(-11),
        amountDue: 12780.00,
      ),
      AdjOverdue(
        statementNo: 'STM-60700417-2610',
        customerName: 'Kenderaan Niaga Utara Sdn Bhd',
        accountNumber: '60700417',
        dueDate: _days(-25),
        amountDue: 31400.00,
      ),
      AdjOverdue(
        statementNo: 'STM-60698830-2609',
        customerName: 'Teksi Ehsan Enterprise',
        accountNumber: '60698830',
        dueDate: _days(-46),
        amountDue: 6420.15,
        chargedBy: _seed.lpDoneRef,
      ),
      // Partly paid: not offered for LPC (this flow is for no payment received).
      AdjOverdue(
        statementNo: 'STM-60709308-2610',
        customerName: 'Bas Ekspres Selatan Sdn Bhd',
        accountNumber: '60709308',
        dueDate: _days(-9),
        amountDue: 9800.00,
        amountPaid: 5000.00,
      ),
    ];


final _bgOpenAt = _days(-2).add(const Duration(hours: 10, minutes: 15));
final _bgDoneAt = _days(-35).add(const Duration(hours: 9, minutes: 5));
final _lpOpenAt = _days(-1).add(const Duration(hours: 9, minutes: 40));
final _lpDoneAt = _days(-15).add(const Duration(hours: 8, minutes: 50));
final _deAt = _days(-1).add(const Duration(hours: 15, minutes: 20));
final _caOpenAt = _days(-3).add(const Duration(hours: 11, minutes: 5));
final _caTempAt = _days(0).add(const Duration(hours: 8, minutes: 25));
final _caDoneAt = _days(-26).add(const Duration(hours: 14, minutes: 10));

/// Sample adjustments: request date and type. `null` type = random type.
final _saPlan = <(DateTime, String?)>[
  (DateTime(2026, 11, 11, 10, 3), null),
  (DateTime(2026, 11, 10, 9, 15), null),
  (DateTime(2026, 11, 9, 11, 20), 'Reload Reversal'), // returned: remark is about a reload
  (DateTime(2026, 11, 6, 14, 32), null),
  (DateTime(2026, 11, 3, 8, 40), 'Fee Waiver'),
];

/// Random values for one seeding: reference codes, and the adjustment
/// samples' type, amount, account and reason. A new set is made each time
/// the demo data is (re)built, so codes and values differ after a reset.
class _SeedRun {
  final bgOpenRef = adjRandomReference('BG', _bgOpenAt);
  final bgDoneRef = adjRandomReference('BG', _bgDoneAt);
  final lpOpenRef = adjRandomReference('LP', _lpOpenAt);
  final lpDoneRef = adjRandomReference('LP', _lpDoneAt);
  final deRef = adjRandomReference('DE', _deAt);
  final caOpenRef = adjRandomReference('CA', _caOpenAt);
  final caTempRef = adjRandomReference('CA', _caTempAt);
  final caDoneRef = adjRandomReference('CA', _caDoneAt);
  final bpRefs = [
    for (final t in [
      DateTime(2026, 11, 12, 9, 30),
      DateTime(2026, 11, 14, 8, 15),
      DateTime(2026, 11, 7, 9, 10),
      DateTime(2026, 11, 2, 8, 30),
    ])
      adjRandomReference('BP', t),
  ];
  final sa = <(String, AdjSampleAdjustment)>[
    for (final (at, type) in _saPlan)
      (
        adjRandomReference('SA', at),
        adjRandomAdjustment(
          type: type ??
              (adjSampleAdjustmentTypes.where((t) => t != 'Reload Reversal' && t != 'Fee Waiver').toList()
                    ..shuffle())
                  .first,
          at: at,
        ),
      ),
  ];
}

_SeedRun? _run;
_SeedRun get _seed => _run ??= _SeedRun();

/// Makes new random reference codes and sample values for the next seeding.
/// Called by the store before it builds the demo data.
void adjNewSeedRun() => _run = _SeedRun();

const _faris = 'mfaris.bakri@petronas.com.my';
const _hafiz = 'hafiz.rahman@example.com';
const _aishah = 'noraishah.azman@example.com';
const _weiling = 'weiling.lim@example.com';
const _azyan = 'azyan.azmi@petronas.com.my';
const _azlan = 'azlan.ismail@example.com';

const adjDefaultRoute = <AdjRole, String>{
  AdjRole.businessReviewer: _hafiz,
  AdjRole.aaApprover: _aishah,
  AdjRole.financeReviewer: _weiling,
  AdjRole.financeApprover: _azyan,
  AdjRole.financeOps: _azlan,
};

AdjHistoryEntry _h(AdjAction a, String who, DateTime at, [String remarks = '']) =>
    AdjHistoryEntry(action: a, actorEmail: who, at: at, remarks: remarks);

AdjPaymentLine _line(String payee, String bank, String account, double amount, [String ref = '']) =>
    AdjPaymentLine(payeeName: payee, bankName: bank, accountNumber: account, amount: amount, reference: ref);

double _sum(List<AdjPaymentLine> lines) =>
    (lines.fold<double>(0, (t, l) => t + l.amount) * 100).roundToDouble() / 100;

final _dealerLines = [
  _line('Stesen Bandar Baru Sdn Bhd', 'Maybank', '514012345678', 18450.20, 'OCT26-0012'),
  _line('Syarikat Minyak Harmoni Sdn Bhd', 'CIMB Bank', '8007654321', 22310.75, 'OCT26-0013'),
  _line('Pusat Servis Kenari Enterprise', 'Public Bank', '3198765401', 9875.00, 'OCT26-0014'),
  _line('Stesen Seri Kembangan Sdn Bhd', 'RHB Bank', '21234500098765', 15020.40, 'OCT26-0015'),
];

final _refundLines = [
  _line('Logistik Cepat Sdn Bhd', 'Hong Leong Bank', '04501234567', 3200.00, 'RF-60711842'),
  _line('Armada Biru Transport Sdn Bhd', 'AmBank', '8881002345678', 1480.50, 'RF-60702219'),
  _line('Teksi Ehsan Enterprise', 'Bank Islam', '12029010012345', 560.00, 'RF-60698830'),
];

final _rebateLines = [
  _line('Kenderaan Niaga Utara Sdn Bhd', 'Maybank', '558012233445', 4150.00, 'RB-Q3-001'),
  _line('Bas Ekspres Selatan Sdn Bhd', 'CIMB Bank', '8001239876', 2875.25, 'RB-Q3-002'),
];

final _vendorLines = [
  _line('Cetak Kad Pintar Sdn Bhd', 'Public Bank', '3201122334', 36400.00, 'INV-2026-0981'),
  _line('Sistem Terminal Jaya Sdn Bhd', 'RHB Bank', '21455600011223', 12750.00, 'INV-2026-0144'),
];

/// Evaluation snapshot from a register entry, for the seed tasks.
AdjCreditEval _evalFor(String account, double requested) {
  final p = adjSeedCreditProfiles().firstWhere((p) => p.accountNumber == account);
  return AdjCreditEval(
    customerName: p.customerName,
    currentLimit: account == '60715520' ? 60000 : p.creditLimit,
    requestedLimit: requested,
    monthsActive: p.monthsActive,
    avgMonthlySpend: p.avgMonthlySpend,
    balance: p.balance,
    latePayments12m: p.latePayments12m,
    maxDaysPastDue: p.maxDaysPastDue,
    securityAmount: p.securityAmount,
  );
}

List<AdjRequest> adjSeedRequests() => [
      // Credit adjustment: permanent increase, evaluation grade A, waiting
      // for the Approving Authority (the starting user).
      AdjRequest(
        kind: AdjKind.creditAdjustment,
        referenceCode: _seed.caOpenRef,
        requestorEmail: _faris,
        requestDate: _caOpenAt,
        businessLine: 'Fleet',
        adjustmentType: 'Permanent increase',
        totalAmount: 40000,
        accountNumber: '60702219',
        reason: 'Customer added 14 lorries to the fleet card programme from next month. Spend has '
            'grown for three quarters and the balance regularly sits near the current limit.',
        approvers: adjDefaultRoute,
        stage: AdjStage.businessReviewed,
        newCreditLimit: 160000,
        effectiveDate: _days(7),
        creditEval: _evalFor('60702219', 160000),
        documents: [
          AdjDocument(
            id: 'seed-ca-1',
            fileName: 'Fleet expansion letter.pdf',
            sizeBytes: 148300,
            step: AdjRole.requestor,
            uploadedBy: _faris,
            uploadedAt: _caOpenAt,
            isSample: true,
          ),
          AdjDocument(
            id: 'seed-ca-2',
            fileName: 'Credit evaluation worksheet.xlsx',
            sizeBytes: 52700,
            step: AdjRole.businessReviewer,
            uploadedBy: _hafiz,
            uploadedAt: _caOpenAt.add(const Duration(hours: 22)),
            isSample: true,
          ),
        ],
        history: [
          _h(AdjAction.submitted, _faris, _caOpenAt),
          _h(AdjAction.documentsAdded, _hafiz, _caOpenAt.add(const Duration(hours: 22)),
              'Credit evaluation worksheet.xlsx'),
          _h(AdjAction.reviewed, _hafiz, _caOpenAt.add(const Duration(hours: 22, minutes: 4)),
              'Grade A. Requested limit is within the recommended limit.'),
        ],
      ),
      // Temporary increase above the recommended limit, waiting for
      // Business Review.
      AdjRequest(
        kind: AdjKind.creditAdjustment,
        referenceCode: _seed.caTempRef,
        requestorEmail: _faris,
        requestDate: _caTempAt,
        businessLine: 'Customer',
        adjustmentType: 'Temporary increase',
        totalAmount: 70000,
        accountNumber: '60711842',
        reason: 'Festive season peak: the customer is running extra delivery routes for six weeks '
            'and asked for a temporary increase to avoid declined transactions.',
        approvers: adjDefaultRoute,
        newCreditLimit: 320000,
        effectiveDate: _days(3),
        endDate: _days(45),
        creditEval: _evalFor('60711842', 320000),
        history: [_h(AdjAction.submitted, _faris, _caTempAt)],
      ),
      // Completed decrease after repeated late payments.
      AdjRequest(
        kind: AdjKind.creditAdjustment,
        referenceCode: _seed.caDoneRef,
        requestorEmail: _faris,
        requestDate: _caDoneAt,
        businessLine: 'Fleet',
        adjustmentType: 'Permanent decrease',
        totalAmount: 20000,
        accountNumber: '60715520',
        reason: 'Six late payments in the last year and one statement 75 days past due. Reducing '
            'the limit to lower exposure until the payment record improves.',
        approvers: adjDefaultRoute,
        stage: AdjStage.completed,
        status: AdjStatus.completed,
        newCreditLimit: 40000,
        effectiveDate: _days(-18),
        creditEval: _evalFor('60715520', 40000),
        history: [
          _h(AdjAction.submitted, _faris, _caDoneAt),
          _h(AdjAction.reviewed, _hafiz, _days(-25), 'Grade D. Customer informed by the account manager.'),
          _h(AdjAction.approved, _aishah, _days(-23)),
          _h(AdjAction.reviewed, _weiling, _days(-21)),
          _h(AdjAction.approved, _azyan, _days(-20)),
          _h(AdjAction.completed, _azlan, _days(-18), 'Credit limit set to RM 40,000.00.'),
        ],
      ),
      AdjRequest(
        kind: AdjKind.dataEntry,
        referenceCode: _seed.deRef,
        requestorEmail: _faris,
        requestDate: _deAt,
        businessLine: 'Customer',
        adjustmentType: 'Payment',
        totalAmount: 12500.00,
        accountNumber: '60702219',
        reason: 'Manual payment keyed in from a bank transfer slip; amount is above the manual entry limit.',
        approvers: adjDefaultRoute,
        stage: AdjStage.businessReviewed,
        source: const AdjSourceRecord(
          screen: 'Payment',
          txnType: 'PYMT',
          txnId: '880214',
          path: '/dataentry/manual/PYMT/payment/880214',
          fields: [
            ('Account', '60702219'),
            ('Transaction Plan', 'Manual payment - bank transfer'),
            ('Transaction Amount', '12500.00'),
            ('Date', '16 Nov 2026'),
            ('Ref Doc No.', 'TT-20261116-0042'),
            ('Transaction Description', 'Payment received by bank transfer, slip attached'),
          ],
        ),
        history: [
          _h(AdjAction.submitted, _faris, _deAt),
          _h(AdjAction.reviewed, _hafiz, _days(0).add(const Duration(hours: 9)), 'Slip matches the bank statement.'),
        ],
      ),
      () {
        final stmt = adjSeedOverdues()[2];
        final on = _days(0);
        return AdjRequest(
          kind: AdjKind.lpc,
          referenceCode: _seed.lpOpenRef,
          requestorEmail: _faris,
          requestDate: _lpOpenAt,
          businessLine: 'Fleet',
          adjustmentType: 'Standard rate',
          totalAmount: stmt.lpcFor(ratePct: adjDefaultLpcRate, on: on),
          accountNumber: stmt.accountNumber,
          reason: 'No payment received for the October statement and no payment arrangement in '
              'place. Charge LPC at the standard rate.',
          approvers: adjDefaultRoute,
          overdue: stmt,
          lpcRatePct: adjDefaultLpcRate,
          effectiveDate: on,
          history: [_h(AdjAction.submitted, _faris, _lpOpenAt)],
        );
      }(),
      () {
        final stmt = adjSeedOverdues()[3].copyWith();
        final on = _days(-15);
        final unchargedStmt = AdjOverdue(
          statementNo: stmt.statementNo,
          customerName: stmt.customerName,
          accountNumber: stmt.accountNumber,
          dueDate: stmt.dueDate,
          amountDue: stmt.amountDue,
        );
        return AdjRequest(
          kind: AdjKind.lpc,
          referenceCode: _seed.lpDoneRef,
          requestorEmail: _faris,
          requestDate: _lpDoneAt,
          businessLine: 'Customer',
          adjustmentType: 'Standard rate',
          totalAmount: unchargedStmt.lpcFor(ratePct: adjDefaultLpcRate, on: on),
          accountNumber: stmt.accountNumber,
          reason: 'No payment received 31 days after the due date; reminders sent twice.',
          approvers: adjDefaultRoute,
          stage: AdjStage.completed,
          status: AdjStatus.completed,
          overdue: unchargedStmt,
          lpcRatePct: adjDefaultLpcRate,
          effectiveDate: on,
          history: [
            _h(AdjAction.submitted, _faris, _lpDoneAt),
            _h(AdjAction.reviewed, _hafiz, _days(-15).add(const Duration(hours: 14))),
            _h(AdjAction.approved, _aishah, _days(-14)),
            _h(AdjAction.reviewed, _weiling, _days(-13)),
            _h(AdjAction.approved, _azyan, _days(-12)),
            _h(AdjAction.completed, _azlan, _days(-11), 'LPC posted to the November statement.'),
          ],
        );
      }(),
      AdjRequest(
        kind: AdjKind.bankGuarantee,
        referenceCode: _seed.bgOpenRef,
        requestorEmail: _faris,
        requestDate: _bgOpenAt,
        businessLine: 'Fleet',
        adjustmentType: 'Not renewed',
        totalAmount: 150000,
        accountNumber: '60711842',
        reason: 'Customer confirmed the guarantee will not be renewed. The credit limit must drop '
            'by the guarantee amount when it expires so exposure stays covered.',
        approvers: adjDefaultRoute,
        stage: AdjStage.businessReviewed,
        guarantee: adjSeedGuarantees()[0],
        newCreditLimit: 100000,
        effectiveDate: _days(9),
        documents: [
          AdjDocument(
            id: 'seed-bg-1',
            fileName: 'Customer letter - BG not renewed.pdf',
            sizeBytes: 96200,
            step: AdjRole.requestor,
            uploadedBy: _faris,
            uploadedAt: _bgOpenAt,
            isSample: true,
          ),
        ],
        history: [
          _h(AdjAction.submitted, _faris, _bgOpenAt),
          _h(AdjAction.reviewed, _hafiz, _bgOpenAt.add(const Duration(hours: 5)),
              'Confirmed with the account manager; no renewal in progress.'),
        ],
      ),
      AdjRequest(
        kind: AdjKind.bankGuarantee,
        referenceCode: _seed.bgDoneRef,
        requestorEmail: _faris,
        requestDate: _bgDoneAt,
        businessLine: 'Fleet',
        adjustmentType: 'Not renewed',
        totalAmount: 50000,
        accountNumber: '60709308',
        reason: 'Guarantee expiring and the customer has moved to prepaid top-ups for part of the '
            'fleet. Reduce the limit by the guarantee amount on expiry.',
        approvers: adjDefaultRoute,
        stage: AdjStage.completed,
        status: AdjStatus.completed,
        guarantee: AdjGuarantee(
          bgNumber: 'BG-HLB-2023-00198',
          customerName: 'Bas Ekspres Selatan Sdn Bhd',
          accountNumber: '60709308',
          issuingBank: 'Hong Leong Bank',
          amount: 50000,
          expiryDate: _days(-20),
          creditLimit: 90000,
        ),
        newCreditLimit: 40000,
        effectiveDate: _days(-20),
        history: [
          _h(AdjAction.submitted, _faris, _bgDoneAt),
          _h(AdjAction.reviewed, _hafiz, _days(-34)),
          _h(AdjAction.approved, _aishah, _days(-32)),
          _h(AdjAction.reviewed, _weiling, _days(-30)),
          _h(AdjAction.approved, _azyan, _days(-27)),
          _h(AdjAction.completed, _azlan, _days(-20), 'Credit limit set to RM 40,000.00 on expiry.'),
        ],
      ),
      AdjRequest(
        kind: AdjKind.bulkPayment,
        referenceCode: _seed.bpRefs[0],
        requestorEmail: _faris,
        requestDate: DateTime(2026, 11, 12, 9, 30),
        businessLine: 'Fleet',
        adjustmentType: 'Dealer settlement',
        totalAmount: _sum(_dealerLines),
        accountNumber: '5140999900011',
        reason: 'October 2026 settlement for dealer stations on the fleet programme. Amounts match '
            'the settlement report generated on 1 Nov after reconciliation with Nucleus transactions.',
        approvers: adjDefaultRoute,
        ccEmails: const ['amirahsyaffinaz.juso@petronas.com.my'],
        stage: AdjStage.businessReviewed,
        paymentLines: _dealerLines,
        paymentDate: DateTime(2026, 11, 20),
        documents: [
          AdjDocument(
            id: 'seed-bp-1',
            fileName: 'Dealer settlement Oct 2026.csv',
            sizeBytes: 4210,
            step: AdjRole.requestor,
            uploadedBy: _faris,
            uploadedAt: DateTime(2026, 11, 12, 9, 30),
            isSample: true,
          ),
          AdjDocument(
            id: 'seed-bp-2',
            fileName: 'Reconciliation summary Oct 2026.pdf',
            sizeBytes: 182400,
            step: AdjRole.businessReviewer,
            uploadedBy: _hafiz,
            uploadedAt: DateTime(2026, 11, 13, 10, 5),
            isSample: true,
          ),
        ],
        history: [
          _h(AdjAction.submitted, _faris, DateTime(2026, 11, 12, 9, 30)),
          _h(AdjAction.documentsAdded, _hafiz, DateTime(2026, 11, 13, 10, 5), 'Reconciliation summary Oct 2026.pdf'),
          _h(AdjAction.reviewed, _hafiz, DateTime(2026, 11, 13, 10, 7),
              'Totals agree with the reconciliation summary.'),
        ],
      ),
      AdjRequest(
        kind: AdjKind.bulkPayment,
        referenceCode: _seed.bpRefs[1],
        requestorEmail: _faris,
        requestDate: DateTime(2026, 11, 14, 8, 15),
        businessLine: 'Customer',
        adjustmentType: 'Customer refund',
        totalAmount: _sum(_refundLines),
        accountNumber: '5140999900011',
        reason: 'Refunds of prepaid balances for three closed fleet accounts, as approved in the '
            'account closure requests.',
        approvers: adjDefaultRoute,
        paymentLines: _refundLines,
        paymentDate: DateTime(2026, 11, 21),
        history: [_h(AdjAction.submitted, _faris, DateTime(2026, 11, 14, 8, 15))],
      ),
      AdjRequest(
        kind: AdjKind.bulkPayment,
        referenceCode: _seed.bpRefs[2],
        requestorEmail: _faris,
        requestDate: DateTime(2026, 11, 7, 9, 10),
        businessLine: 'Fleet',
        adjustmentType: 'Vendor payment',
        totalAmount: _sum(_vendorLines),
        accountNumber: '5140999900028',
        reason: 'Payment for card production (October batch) and terminal maintenance, per invoices attached.',
        approvers: adjDefaultRoute,
        stage: AdjStage.financeReviewed,
        paymentLines: _vendorLines,
        paymentDate: DateTime(2026, 11, 18),
        history: [
          _h(AdjAction.submitted, _faris, DateTime(2026, 11, 7, 9, 10)),
          _h(AdjAction.reviewed, _hafiz, DateTime(2026, 11, 7, 14, 0)),
          _h(AdjAction.approved, _aishah, DateTime(2026, 11, 10, 11, 20)),
          _h(AdjAction.reviewed, _weiling, DateTime(2026, 11, 11, 16, 45), 'Invoices checked against POs.'),
        ],
      ),
      AdjRequest(
        kind: AdjKind.bulkPayment,
        referenceCode: _seed.bpRefs[3],
        requestorEmail: _faris,
        requestDate: DateTime(2026, 11, 2, 8, 30),
        businessLine: 'Fleet',
        adjustmentType: 'Rebate payout',
        totalAmount: _sum(_rebateLines),
        accountNumber: '5140999900011',
        reason: 'Q3 2026 volume rebate for fleet customers that met the tier 2 threshold.',
        approvers: adjDefaultRoute,
        stage: AdjStage.completed,
        status: AdjStatus.completed,
        paymentLines: _rebateLines,
        paymentDate: DateTime(2026, 11, 6),
        history: [
          _h(AdjAction.submitted, _faris, DateTime(2026, 11, 2, 8, 30)),
          _h(AdjAction.reviewed, _hafiz, DateTime(2026, 11, 2, 15, 10)),
          _h(AdjAction.approved, _aishah, DateTime(2026, 11, 3, 9, 0)),
          _h(AdjAction.reviewed, _weiling, DateTime(2026, 11, 4, 10, 30)),
          _h(AdjAction.approved, _azyan, DateTime(2026, 11, 5, 14, 15)),
          _h(AdjAction.completed, _azlan, DateTime(2026, 11, 6, 9, 40), 'Released in payment run PR-2026-1106.'),
        ],
      ),
      AdjRequest(
        referenceCode: _seed.sa[0].$1,
        requestorEmail: _faris,
        requestDate: DateTime(2026, 11, 11, 10, 3),
        businessLine: 'Customer',
        adjustmentType: _seed.sa[0].$2.type,
        totalAmount: _seed.sa[0].$2.amount,
        accountNumber: _seed.sa[0].$2.account,
        reason: _seed.sa[0].$2.reason,
        approvers: adjDefaultRoute,
        ccEmails: const ['amirahsyaffinaz.juso@petronas.com.my'],
        stage: AdjStage.businessReviewed,
        documents: [
          AdjDocument(
            id: 'seed-1',
            fileName: 'Transaction extract - ${_seed.sa[0].$2.account}.xlsx',
            sizeBytes: 315904,
            step: AdjRole.requestor,
            uploadedBy: _faris,
            uploadedAt: DateTime(2026, 11, 11, 10, 3),
            isSample: true,
          ),
          AdjDocument(
            id: 'seed-2',
            fileName: 'Customer confirmation.pdf',
            sizeBytes: 286188,
            step: AdjRole.requestor,
            uploadedBy: _faris,
            uploadedAt: DateTime(2026, 11, 11, 10, 3),
            isSample: true,
          ),
        ],
        history: [
          _h(AdjAction.submitted, _faris, DateTime(2026, 11, 11, 10, 3)),
          _h(AdjAction.reviewed, _hafiz, DateTime(2026, 11, 12, 9, 20),
              'Checked the amount against the transaction log.'),
        ],
      ),
      AdjRequest(
        referenceCode: _seed.sa[1].$1,
        requestorEmail: _faris,
        requestDate: DateTime(2026, 11, 10, 9, 15),
        businessLine: 'Fleet',
        adjustmentType: _seed.sa[1].$2.type,
        totalAmount: _seed.sa[1].$2.amount,
        accountNumber: _seed.sa[1].$2.account,
        reason: _seed.sa[1].$2.reason,
        approvers: adjDefaultRoute,
        history: [_h(AdjAction.submitted, _faris, DateTime(2026, 11, 10, 9, 15))],
      ),
      AdjRequest(
        referenceCode: _seed.sa[2].$1,
        requestorEmail: _faris,
        requestDate: DateTime(2026, 11, 9, 11, 20),
        businessLine: 'Customer',
        adjustmentType: _seed.sa[2].$2.type,
        totalAmount: _seed.sa[2].$2.amount,
        accountNumber: _seed.sa[2].$2.account,
        reason: _seed.sa[2].$2.reason,
        approvers: adjDefaultRoute,
        stage: AdjStage.businessReviewed,
        status: AdjStatus.returned,
        history: [
          _h(AdjAction.submitted, _faris, DateTime(2026, 11, 9, 11, 20)),
          _h(AdjAction.reviewed, _hafiz, DateTime(2026, 11, 9, 15, 2)),
          _h(AdjAction.returned, _aishah, DateTime(2026, 11, 10, 8, 41),
              'Add the correct destination account number and the bank slip for the original reload.'),
        ],
      ),
      AdjRequest(
        referenceCode: _seed.sa[3].$1,
        requestorEmail: _faris,
        requestDate: DateTime(2026, 11, 6, 14, 32),
        businessLine: 'Customer',
        adjustmentType: _seed.sa[3].$2.type,
        totalAmount: _seed.sa[3].$2.amount,
        accountNumber: _seed.sa[3].$2.account,
        reason: _seed.sa[3].$2.reason,
        approvers: adjDefaultRoute,
        stage: AdjStage.financeReviewed,
        history: [
          _h(AdjAction.submitted, _faris, DateTime(2026, 11, 6, 14, 32)),
          _h(AdjAction.reviewed, _hafiz, DateTime(2026, 11, 7, 9, 5)),
          _h(AdjAction.approved, _aishah, DateTime(2026, 11, 7, 16, 40)),
          _h(AdjAction.reviewed, _weiling, DateTime(2026, 11, 10, 10, 12)),
        ],
      ),
      AdjRequest(
        referenceCode: _seed.sa[4].$1,
        requestorEmail: _faris,
        requestDate: DateTime(2026, 11, 3, 8, 40),
        businessLine: 'Fleet',
        adjustmentType: _seed.sa[4].$2.type,
        totalAmount: _seed.sa[4].$2.amount,
        accountNumber: _seed.sa[4].$2.account,
        reason: _seed.sa[4].$2.reason,
        approvers: adjDefaultRoute,
        stage: AdjStage.completed,
        status: AdjStatus.completed,
        history: [
          _h(AdjAction.submitted, _faris, DateTime(2026, 11, 3, 8, 40)),
          _h(AdjAction.reviewed, _hafiz, DateTime(2026, 11, 3, 11, 0)),
          _h(AdjAction.approved, _aishah, DateTime(2026, 11, 4, 9, 30)),
          _h(AdjAction.reviewed, _weiling, DateTime(2026, 11, 4, 14, 15)),
          _h(AdjAction.approved, _azyan, DateTime(2026, 11, 5, 10, 2), 'Approved.'),
          _h(AdjAction.completed, _azlan, DateTime(2026, 11, 5, 15, 48), 'Posted to account.'),
        ],
      ),
    ];
