import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

import '../adj_models.dart';
import '../adj_nav.dart';
import '../adj_store.dart';
import '../adj_workflow.dart';
import '../widgets/adj_approval_levels.dart';
import '../widgets/adj_common.dart';
import '../widgets/adj_credit_eval.dart';
import '../widgets/adj_decision_panel.dart';
import '../widgets/adj_documents.dart';
import '../widgets/adj_history.dart';
import '../widgets/adj_payment_lines.dart';
import '../widgets/adj_step_details.dart';
import '../widgets/adj_stepper.dart';

const int _wid = 9302;

/// One request (adjustment or bulk payment).
/// Path: /workflowmgmt/:kind/view/:refcode
@RoutePage()
class AdjApprovalDetail extends BaseScreen {
  const AdjApprovalDetail({super.key});

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    if (isPageDeniedView(AcxAuthAccess.pageDeniedList, _wid)) return const NotAuthorised();
    final params = context.routeData.inheritedPathParams;
    final code = params.optString('refcode') ?? '';
    final kind = AdjKind.fromPath(params.optString('kind'));
    // Fill the area so the page sits at the top (see dashboard screen).
    return SizedBox.expand(child: _DetailBody(key: ValueKey(code), referenceCode: code, kind: kind));
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) => desktopBody(context, ref);

  @override
  Widget sideBar() => provideSideBar('workflowmgmt');

  @override
  PreferredSizeWidget breadCrumb() => provideBreadCrumb('workflowmgmt');
}

class _DetailBody extends ConsumerStatefulWidget {
  const _DetailBody({super.key, required this.referenceCode, required this.kind});
  final String referenceCode;

  /// Kind from the URL; used only when the request isn't found.
  final AdjKind kind;

  @override
  ConsumerState<_DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends ConsumerState<_DetailBody> {
  bool _summary = false;
  int? _selectedStep;
  final _decisionKey = GlobalKey();

  void _toggleStep(int i) => setState(() => _selectedStep = _selectedStep == i ? null : i);

  void _goToDecision() {
    final ctx = _decisionKey.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(ctx,
        duration: const Duration(milliseconds: 350), curve: Curves.easeOut, alignment: 0.05);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final store = ref.watch(adjStoreProvider);
    final r = store.find(widget.referenceCode);
    final me = store.currentUser;

    if (r == null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('No request found with reference ${widget.referenceCode}.',
              style: TextStyle(color: cs.onSurfaceVariant)),
          const SizedBox(height: 14),
          FilledButton(onPressed: () => adjGoList(widget.kind), child: const Text('Back to approval queue')),
        ]),
      );
    }

    final levels = store.levelsOf(r);
    final canAct = AdjWorkflow.canAct(r, me);
    final selected = _selectedStep;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
      // Left-aligned like the rest of the app; max width keeps lines readable.
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(children: [
                IconButton.outlined(
                  tooltip: 'Back to approval queue',
                  onPressed: () => adjGoList(r.kind),
                  icon: const Icon(Icons.arrow_back, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AdjPageHeader(
                    title: r.kind.requestTitle,
                    subtitle: 'Reference ${r.referenceCode}. ${AdjWorkflow.pendingDescription(r)}',
                    actions: [
                      const AdjActingAs(),
                      OutlinedButton(
                        onPressed: () => setState(() => _summary = !_summary),
                        child: Text(_summary ? 'Detail View' : 'Overview'),
                      ),
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 18),

              // Progress: click a step for its details and files.
              AdjCard(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  AdjStepper(levels: levels, selectedIndex: selected, onStepTap: _toggleStep),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.topCenter,
                    child: selected == null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text('Select a step to see who handles it, what happened and its files.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                          )
                        : AdjStepDetails(
                            referenceCode: r.referenceCode,
                            index: selected,
                            onClose: () => setState(() => _selectedStep = null),
                            onGoToDecision: canAct &&
                                    r.status == AdjStatus.inProgress &&
                                    selected == r.stage.index + 1
                                ? _goToDecision
                                : null,
                          ),
                  ),
                ]),
              ),
              const SizedBox(height: 20),

              if (r.status == AdjStatus.returned || r.status == AdjStatus.rejected) ...[
                _OutcomeBanner(request: r, store: store),
                const SizedBox(height: 20),
              ],

              if (_summary)
                AdjCard(
                  child: AdjSection(title: 'Summary', children: [
                    AdjDetailRow(label: 'Reference Code', value: r.referenceCode),
                    AdjDetailRow(label: 'Requestor Name', value: r.requestorEmail),
                    AdjDetailRow(label: r.kind.amountLabel, value: adjRM(r.totalAmount)),
                    AdjDetailRow(label: r.kind.accountLabel, value: r.accountNumber),
                    if (r.guarantee != null) ...[
                      AdjDetailRow(label: 'Customer', value: r.guarantee!.customerName),
                      AdjDetailRow(
                        label: 'Credit Limit',
                        value: '${adjRM(r.guarantee!.creditLimit)} to ${adjRM(r.newCreditLimit ?? 0)}',
                      ),
                    ],
                    if (r.overdue != null) ...[
                      AdjDetailRow(label: 'Customer', value: r.overdue!.customerName),
                      AdjDetailRow(label: 'Statement', value: r.overdue!.statementNo),
                    ],
                    if (r.creditEval != null) ...[
                      AdjDetailRow(label: 'Customer', value: r.creditEval!.customerName),
                      AdjDetailRow(
                        label: 'Credit Limit',
                        value: '${adjRM(r.creditEval!.currentLimit)} to ${adjRM(r.newCreditLimit ?? 0)}'
                            '${r.endDate == null ? '' : ' until ${adjDate(r.endDate!)}'}',
                      ),
                      AdjDetailRow(
                        label: 'Credit Evaluation',
                        value: 'Grade ${r.creditEval!.grade} (${r.creditEval!.score}/100), '
                            'recommended ${adjRM(r.creditEval!.recommendedLimit)}',
                      ),
                    ],
                    if (r.isBulkPayment) ...[
                      AdjDetailRow(label: 'Number of Payees', value: '${r.paymentLines.length}'),
                      AdjDetailRow(
                        label: 'Payment Date',
                        value: r.paymentDate == null ? '-' : adjDate(r.paymentDate!),
                      ),
                    ],
                    AdjDetailRow(
                      label: 'Current Stage',
                      child: Align(alignment: Alignment.centerLeft, child: AdjStatusChip(request: r)),
                    ),
                    AdjDetailRow(label: 'Next Step', value: AdjWorkflow.pendingDescription(r)),
                  ]),
                )
              else ...[
                AdjCard(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    AdjSection(title: 'General Information', children: [
                      AdjDetailRow(label: 'Reference Code', value: r.referenceCode),
                      AdjDetailRow(label: 'Requestor Name', value: r.requestorEmail),
                      AdjDetailRow(label: 'Request Date', value: adjDate(r.requestDate)),
                      AdjDetailRow(label: 'Business Line', value: r.businessLine),
                    ]),
                    const SizedBox(height: 32),
                    AdjSection(title: 'Request Details', children: [
                      AdjDetailRow(label: r.kind.typeLabel, value: r.adjustmentType),
                      AdjDetailRow(label: r.kind.amountLabel, value: adjRM(r.totalAmount)),
                      AdjDetailRow(label: r.kind.accountLabel, value: r.accountNumber),
                      if (r.isBulkPayment) ...[
                        AdjDetailRow(
                          label: 'Payment Date',
                          value: r.paymentDate == null ? '-' : adjDate(r.paymentDate!),
                        ),
                        AdjDetailRow(label: 'Number of Payees', value: '${r.paymentLines.length}'),
                      ],
                      AdjDetailRow(label: r.kind.reasonLabel, value: r.reason),
                    ]),
                    if (r.guarantee != null) ...[
                      const SizedBox(height: 32),
                      _GuaranteeSection(request: r),
                    ],
                    if (r.overdue != null) ...[
                      const SizedBox(height: 32),
                      _LpcSection(request: r),
                    ],
                    if (r.source != null) ...[
                      const SizedBox(height: 32),
                      _SourceSection(source: r.source!),
                    ],
                    if (r.creditEval != null) ...[
                      const SizedBox(height: 32),
                      _CreditSection(request: r),
                      const SizedBox(height: 32),
                      AdjSection(title: 'Credit Evaluation', children: [
                        const SizedBox(height: 12),
                        AdjCreditEvalView(eval: r.creditEval!),
                      ]),
                    ],
                    if (r.isBulkPayment) ...[
                      const SizedBox(height: 32),
                      AdjSection(title: 'Payment Lines', children: [
                        const SizedBox(height: 10),
                        AdjPaymentLinesTable(
                          lines: r.paymentLines,
                          total: r.totalAmount,
                          fileName: '${r.referenceCode}-payment-lines.csv',
                        ),
                      ]),
                    ],
                    const SizedBox(height: 32),
                    AdjSection(title: 'Supporting Documents', children: [
                      const SizedBox(height: 14),
                      AdjDocuments(referenceCode: r.referenceCode),
                    ]),
                  ]),
                ),
                const SizedBox(height: 20),
                AdjCard(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    AdjSection(title: 'Application Approval', children: [
                      const SizedBox(height: 6),
                      AdjApprovalLevels(referenceCode: r.referenceCode),
                    ]),
                    const SizedBox(height: 16),
                    AdjDetailRow(
                      label: 'CC Email List',
                      value: r.ccEmails.isEmpty ? '-' : r.ccEmails.join('\n'),
                    ),
                  ]),
                ),
              ],

              if (canAct) ...[
                const SizedBox(height: 20),
                AdjCard(
                  key: _decisionKey,
                  child: AdjDecisionPanel(
                    // Fresh form whenever the request moves on or the user changes.
                    key: ValueKey('${r.referenceCode}-${r.decisions.length}-${me.email}'),
                    referenceCode: r.referenceCode,
                  ),
                ),
              ],

              if (!_summary) ...[
                const SizedBox(height: 20),
                AdjCard(
                  child: AdjSection(title: 'Activity Log', children: [AdjHistory(request: r, store: store)]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

DateTime _today() {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day);
}

/// Data Entry transaction this task was raised from, as it was then.
class _SourceSection extends StatelessWidget {
  const _SourceSection({required this.source});
  final AdjSourceRecord source;

  @override
  Widget build(BuildContext context) {
    return AdjSection(
      title: 'Data Entry Transaction',
      trailing: TextButton.icon(
        onPressed: () => singleton<AppRouter>().navigatePath(source.path),
        icon: const Icon(Icons.open_in_new, size: 18),
        label: const Text('Open transaction'),
      ),
      children: [
        AdjDetailRow(label: 'Screen', value: source.screen),
        AdjDetailRow(label: 'Transaction ID', value: source.txnId),
        for (final f in source.fields) AdjDetailRow(label: f.$1, value: f.$2),
      ],
    );
  }
}

/// Customer and the proposed credit limit change.
class _CreditSection extends StatelessWidget {
  const _CreditSection({required this.request});
  final AdjRequest request;

  @override
  Widget build(BuildContext context) {
    final r = request;
    final e = r.creditEval!;
    final newLimit = r.newCreditLimit ?? e.currentLimit;
    return AdjSection(
      title: 'Customer and Credit Limit',
      trailing: r.sourcePath == null
          ? null
          : TextButton.icon(
              onPressed: () => singleton<AppRouter>().navigatePath(r.sourcePath!),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text('Open customer account'),
            ),
      children: [
        AdjDetailRow(label: 'Customer', value: '${e.customerName} (${r.accountNumber})'),
        AdjDetailRow(label: 'Current Credit Limit', value: adjRM(e.currentLimit)),
        AdjDetailRow(label: 'New Credit Limit', value: adjRM(newLimit)),
        AdjDetailRow(
          label: newLimit >= e.currentLimit ? 'Increase' : 'Decrease',
          value: adjRM((newLimit - e.currentLimit).abs()),
        ),
        AdjDetailRow(label: 'Effective Date', value: r.effectiveDate == null ? '-' : adjDate(r.effectiveDate!)),
        if (r.endDate != null) AdjDetailRow(label: 'End Date', value: adjDate(r.endDate!)),
        if (r.sourcePath != null) const AdjDetailRow(label: 'Raised From', value: 'Customer Management'),
      ],
    );
  }
}

/// Bank guarantee and the proposed credit limit change.
class _GuaranteeSection extends StatelessWidget {
  const _GuaranteeSection({required this.request});
  final AdjRequest request;

  @override
  Widget build(BuildContext context) {
    final r = request;
    final g = r.guarantee!;
    final newLimit = r.newCreditLimit ?? g.creditLimit;
    return AdjSection(title: 'Bank Guarantee and Credit Limit', children: [
      AdjDetailRow(label: 'Customer', value: '${g.customerName} (${g.accountNumber})'),
      AdjDetailRow(label: 'Guarantee Number', value: g.bgNumber),
      AdjDetailRow(label: 'Issuing Bank', value: g.issuingBank),
      AdjDetailRow(label: 'Guarantee Amount', value: adjRM(g.amount)),
      AdjDetailRow(
        label: 'Expiry Date',
        value: r.status == AdjStatus.completed
            ? adjDate(g.expiryDate)
            : '${adjDate(g.expiryDate)} (${adjExpiryText(g, _today())})',
      ),
      AdjDetailRow(label: 'Credit Limit Before', value: adjRM(g.creditLimit)),
      AdjDetailRow(label: 'New Credit Limit', value: adjRM(newLimit)),
      AdjDetailRow(label: 'Reduction', value: adjRM(g.creditLimit - newLimit)),
      AdjDetailRow(label: 'Effective Date', value: r.effectiveDate == null ? '-' : adjDate(r.effectiveDate!)),
    ]);
  }
}

/// Unpaid statement and how the late payment charge was worked out.
class _LpcSection extends StatelessWidget {
  const _LpcSection({required this.request});
  final AdjRequest request;

  @override
  Widget build(BuildContext context) {
    final r = request;
    final o = r.overdue!;
    final on = r.effectiveDate ?? r.requestDate;
    final rate = r.lpcRatePct ?? 0;
    return AdjSection(title: 'Unpaid Statement and Charge', children: [
      AdjDetailRow(label: 'Customer', value: '${o.customerName} (${o.accountNumber})'),
      AdjDetailRow(label: 'Statement', value: o.statementNo),
      AdjDetailRow(label: 'Due Date', value: adjDate(o.dueDate)),
      AdjDetailRow(label: 'Amount Due', value: adjRM(o.amountDue)),
      const AdjDetailRow(label: 'Payment Received', value: 'None'),
      AdjDetailRow(label: 'Charge Date', value: adjDate(on)),
      AdjDetailRow(label: 'Days Overdue', value: '${o.daysOverdue(on)}'),
      AdjDetailRow(label: 'Rate', value: '${rate.toStringAsFixed(2)}% a year'),
      AdjDetailRow(
        label: 'LPC Amount',
        value: '${adjRM(r.totalAmount)} (${adjRM(o.outstanding)} × ${rate.toStringAsFixed(2)}% × '
            '${o.daysOverdue(on)} days ÷ 365)',
      ),
    ]);
  }
}

class _OutcomeBanner extends StatelessWidget {
  const _OutcomeBanner({required this.request, required this.store});
  final AdjRequest request;
  final AdjState store;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final rejected = request.status == AdjStatus.rejected;
    final color = rejected ? context.dbStatus.danger : context.dbStatus.warning;
    final last = request.decisions.last;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(DiboldTheme.radius),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(rejected ? Icons.block : Icons.undo, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '${rejected ? 'Rejected' : 'Returned for amendment'} by ${store.nameOf(last.actorEmail)} '
              'on ${adjDate(last.at)}',
              style: TextStyle(fontWeight: FontWeight.w700, color: color),
            ),
            if (last.remarks.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(last.remarks, style: TextStyle(height: 1.5, color: cs.onSurface)),
            ],
          ]),
        ),
      ]),
    );
  }
}
