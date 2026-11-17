import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

import '../adj_models.dart';
import '../adj_store.dart';
import '../adj_workflow.dart';
import 'adj_common.dart';
import 'adj_documents.dart';

enum _Decision { approve, returnBack, reject, resubmit }

/// Shown only to the person the request is waiting for: approve, return or
/// reject — or, for the requestor of a returned request, amend and resubmit.
class AdjDecisionPanel extends ConsumerStatefulWidget {
  const AdjDecisionPanel({super.key, required this.referenceCode});
  final String referenceCode;

  @override
  ConsumerState<AdjDecisionPanel> createState() => _AdjDecisionPanelState();
}

class _AdjDecisionPanelState extends ConsumerState<AdjDecisionPanel> {
  final _remarks = TextEditingController();
  final _reason = TextEditingController();
  String? _remarksError;
  String? _reasonError;

  @override
  void initState() {
    super.initState();
    _reason.text = ref.read(adjStoreProvider).find(widget.referenceCode)?.reason ?? '';
  }

  @override
  void dispose() {
    _remarks.dispose();
    _reason.dispose();
    super.dispose();
  }

  String _verb(_Decision d, AdjRequest r) => switch (d) {
        _Decision.approve => AdjWorkflow.approveLabel(r.stage, r.kind),
        _Decision.returnBack => 'Return to requestor',
        _Decision.reject => 'Reject',
        _Decision.resubmit => 'Resubmit',
      };

  String _done(_Decision d, AdjRequest r) => switch (d) {
        _Decision.approve => switch (AdjWorkflow.approveAction(r.stage)) {
            AdjAction.reviewed => 'Request marked as reviewed',
            AdjAction.approved => 'Request approved',
            _ => switch (r.kind) {
                AdjKind.bulkPayment => 'Payment released',
                AdjKind.bankGuarantee => 'New credit limit applied',
                AdjKind.lpc => 'LPC charge posted',
                AdjKind.dataEntry => 'Transaction approved',
                AdjKind.adjustment => 'Request marked as completed',
                AdjKind.creditAdjustment => 'New credit limit applied',
              },
          },
        _Decision.returnBack => 'Request returned to requestor',
        _Decision.reject => 'Request rejected',
        _Decision.resubmit => 'Request resubmitted',
      };

  Future<void> _run(_Decision d, AdjRequest r) async {
    final remarks = _remarks.text.trim();
    setState(() {
      _remarksError = null;
      _reasonError = null;
    });
    if (d == _Decision.returnBack && remarks.isEmpty) {
      setState(() => _remarksError = 'Add remarks so the requestor knows what to change.');
      return;
    }
    if (d == _Decision.reject && remarks.isEmpty) {
      setState(() => _remarksError = 'Add remarks explaining why this request is rejected.');
      return;
    }
    if (d == _Decision.resubmit && _reason.text.trim().length < 20) {
      setState(() => _reasonError = 'Describe the reason in at least 20 characters.');
      return;
    }

    final danger = context.dbStatus.danger;
    final summary = switch (r.kind) {
      AdjKind.bulkPayment =>
        '${adjRM(r.totalAmount)} to ${r.paymentLines.length} payees from account ${r.accountNumber}',
      AdjKind.bankGuarantee =>
        '${r.guarantee?.customerName ?? r.accountNumber}: credit limit '
            '${adjRM(r.guarantee?.creditLimit ?? 0)} to ${adjRM(r.newCreditLimit ?? 0)}',
      AdjKind.lpc =>
        '${r.overdue?.customerName ?? r.accountNumber}: LPC ${adjRM(r.totalAmount)} '
            'on ${r.overdue?.statementNo ?? 'statement'}',
      AdjKind.adjustment => '${adjRM(r.totalAmount)} to account ${r.accountNumber}',
      AdjKind.creditAdjustment =>
        '${r.creditEval?.customerName ?? r.accountNumber}: credit limit '
            '${adjRM(r.creditEval?.currentLimit ?? 0)} to ${adjRM(r.newCreditLimit ?? 0)}'
            '${r.endDate == null ? '' : ' until ${adjDate(r.endDate!)}'}',
      AdjKind.dataEntry =>
        '${r.adjustmentType} transaction ${r.source?.txnId ?? '-'}, ${adjRM(r.totalAmount)}',
    };
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${_verb(d, r)}?'),
        content: Text(
          '${r.referenceCode}\n$summary'
          '${d == _Decision.reject ? '\n\nRejection closes this request permanently.' : ''}',
          style: const TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(
            style: d == _Decision.reject ? FilledButton.styleFrom(backgroundColor: danger) : null,
            onPressed: () => Navigator.pop(context, true),
            child: Text(_verb(d, r)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final store = ref.read(adjStoreProvider.notifier);
    final code = r.referenceCode;
    final reason = _reason.text;
    adjRun(() {
      switch (d) {
        case _Decision.approve:
          store.approve(code, remarks: remarks);
        case _Decision.returnBack:
          store.returnForAmendment(code, remarks: remarks);
        case _Decision.reject:
          store.reject(code, remarks: remarks);
        case _Decision.resubmit:
          store.resubmit(code, reason: reason, remarks: remarks);
      }
    }, success: _done(d, r));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final store = ref.watch(adjStoreProvider);
    final r = store.find(widget.referenceCode);
    if (r == null) return const SizedBox.shrink();
    final resubmit = r.status == AdjStatus.returned;
    final step = AdjWorkflow.currentFileStep(r);

    return AdjSection(
      title: resubmit ? 'Amend and resubmit' : 'Your decision',
      children: [
        const SizedBox(height: 12),
        Text(
          resubmit
              ? 'Update the reason using the remarks in the approval history, then resubmit. '
                  'The request restarts at business review.'
              : 'This request is waiting for you as ${store.currentUser.role.label}.',
          style: TextStyle(color: cs.onSurfaceVariant, height: 1.5),
        ),
        const SizedBox(height: 16),
        if (resubmit) ...[
          AdjField(child: TextField(
            controller: _reason,
            minLines: 4,
            maxLines: 8,
            decoration: InputDecoration(
              labelText: 'Reason for adjustment',
              alignLabelWithHint: true,
              errorText: _reasonError,
            ),
          )),
          const SizedBox(height: 8),
        ],
        if (step != null) ...[
          Text(resubmit ? 'Files for your resubmission' : 'Files for this step',
              style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
          const SizedBox(height: 4),
          Text('Add any evidence for your decision before you submit it.',
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
          const SizedBox(height: 10),
          AdjDocuments(referenceCode: r.referenceCode, onlyStep: step),
          const SizedBox(height: 20),
        ],
        AdjField(child: TextField(
          controller: _remarks,
          minLines: 3,
          maxLines: 6,
          decoration: InputDecoration(
            labelText: 'Remarks',
            alignLabelWithHint: true,
            helperText: resubmit ? 'Optional. Note what you changed.' : 'Required when returning or rejecting.',
            errorText: _remarksError,
          ),
        )),
        const SizedBox(height: 18),
        Wrap(
          alignment: WrapAlignment.end,
          spacing: DiboldTheme.actionSpacing,
          runSpacing: 8,
          children: resubmit
              ? [FilledButton(onPressed: () => _run(_Decision.resubmit, r), child: const Text('Resubmit'))]
              : [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.dbStatus.danger,
                      side: BorderSide(color: context.dbStatus.danger),
                    ),
                    onPressed: () => _run(_Decision.reject, r),
                    child: const Text('Reject'),
                  ),
                  OutlinedButton(
                    onPressed: () => _run(_Decision.returnBack, r),
                    child: const Text('Return to requestor'),
                  ),
                  FilledButton(
                    onPressed: () => _run(_Decision.approve, r),
                    child: Text(AdjWorkflow.approveLabel(r.stage, r.kind)),
                  ),
                ],
        ),
      ],
    );
  }
}
