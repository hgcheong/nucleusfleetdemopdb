import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

import '../adj_models.dart';
import '../adj_store.dart';
import '../adj_workflow.dart';
import 'adj_common.dart';
import 'adj_documents.dart';

/// Details for one stepper step: who handles it, status, when it was
/// actioned, remarks, and the files added at that step.
class AdjStepDetails extends ConsumerWidget {
  const AdjStepDetails({
    super.key,
    required this.referenceCode,
    required this.index,
    required this.onClose,
    this.onGoToDecision,
  });

  final String referenceCode;

  /// Index into [AdjStage.values]; 0 is the submission.
  final int index;
  final VoidCallback onClose;

  /// Set when this step is waiting for the current user.
  final VoidCallback? onGoToDecision;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final store = ref.watch(adjStoreProvider);
    final r = store.find(referenceCode);
    if (r == null) return const SizedBox.shrink();
    final stage = AdjStage.values[index];
    final closed = r.status == AdjStatus.rejected || r.status == AdjStatus.completed;

    String person(String? email) => email == null ? 'Not assigned' : '${store.nameOf(email)} ($email)';

    late final String handledBy;
    late final String personText;
    late final AdjLevelState state;
    AdjHistoryEntry? entry;
    String? assigned;

    if (index == 0) {
      for (final e in r.history) {
        if (e.action == AdjAction.submitted || e.action == AdjAction.resubmitted) entry = e;
      }
      handledBy = AdjRole.requestor.label;
      personText = person(r.requestorEmail);
      state = AdjLevelState.done;
    } else {
      final level = store.levelsOf(r)[index - 1];
      handledBy = level.role.label;
      assigned = level.approverEmail;
      personText = person(assigned);
      state = level.state;
      entry = level.entry;
    }

    final statusText = switch (state) {
      AdjLevelState.done => 'Done',
      AdjLevelState.waiting => 'Awaiting action',
      AdjLevelState.returned => 'Returned',
      AdjLevelState.rejected => 'Rejected',
      AdjLevelState.upcoming => closed ? 'Not reached' : 'Not started',
    };

    final decisions = r.decisions.toList();
    final waitingSince = state == AdjLevelState.waiting && decisions.isNotEmpty ? decisions.last.at : null;

    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.fromLTRB(18, 12, 10, 18),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(DiboldTheme.radius),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Expanded(
              child: Wrap(
                spacing: 10,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('Step ${stage.step} of ${AdjStage.values.length}: ${stage.label}',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: cs.onSurface)),
                  AdjPill(text: statusText, color: adjLevelColor(context, state)),
                ],
              ),
            ),
            IconButton(tooltip: 'Close details', icon: const Icon(Icons.close), onPressed: onClose),
          ]),
          AdjDetailRow(label: 'Handled by', value: handledBy),
          AdjDetailRow(label: 'Person', value: personText),
          if (waitingSince != null)
            AdjDetailRow(label: 'Waiting since', value: adjDateTime(waitingSince))
          else
            AdjDetailRow(
              label: entry == null ? 'Date' : 'Date ${entry.action.label.toLowerCase()}',
              value: entry == null ? '-' : adjDateTime(entry.at),
            ),
          if (index > 0 && entry != null && entry.actorEmail != assigned)
            AdjDetailRow(label: 'Actioned by', value: person(entry.actorEmail)),
          AdjDetailRow(label: 'Remarks', value: (entry == null || entry.remarks.isEmpty) ? '-' : entry.remarks),
          const SizedBox(height: 16),
          Text('Files for this step', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
          const SizedBox(height: 8),
          AdjDocuments(referenceCode: referenceCode, onlyStep: AdjWorkflow.fileStepAt(index)),
          if (onGoToDecision != null) ...[
            const SizedBox(height: 16),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                Text('This step is waiting for you.', style: TextStyle(color: cs.onSurface)),
                FilledButton(onPressed: onGoToDecision, child: const Text('Go to your decision')),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
