import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

import '../adj_models.dart';
import '../adj_store.dart';
import '../adj_workflow.dart';
import 'adj_common.dart';

/// "Application Approval": one expandable row per level with the assigned
/// person, the date they acted, their remarks and the files they added.
class AdjApprovalLevels extends ConsumerWidget {
  const AdjApprovalLevels({super.key, required this.referenceCode});
  final String referenceCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final store = ref.watch(adjStoreProvider);
    final r = store.find(referenceCode);
    if (r == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final level in store.levelsOf(r))
          ExpansionTile(
            // Re-open the waiting level whenever the request moves on.
            key: ValueKey('${r.referenceCode}-${level.role.name}-${r.decisions.length}'),
            initiallyExpanded: level.state == AdjLevelState.waiting,
            tilePadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
            shape: Border(bottom: BorderSide(color: cs.outlineVariant)),
            collapsedShape: Border(bottom: BorderSide(color: cs.outlineVariant)),
            leading: _icon(context, level.state),
            title: Wrap(
              spacing: 10,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(level.role.levelTitle,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: cs.onSurface)),
                if (level.state == AdjLevelState.waiting)
                  AdjPill(text: 'Awaiting action', color: cs.primary),
                if (level.state == AdjLevelState.returned)
                  AdjPill(text: 'Returned', color: context.dbStatus.warning),
                if (level.state == AdjLevelState.rejected)
                  AdjPill(text: 'Rejected', color: context.dbStatus.danger),
              ],
            ),
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DiboldTheme.radiusSm),
                  border: Border.all(color: cs.outlineVariant),
                ),
                child: Column(children: [
                  AdjDetailRow(label: level.role.label, value: level.approverEmail ?? 'Not assigned'),
                  AdjDetailRow(
                    label: _dateLabel(level),
                    value: level.entry == null ? '-' : adjDateTime(level.entry!.at),
                  ),
                  AdjDetailRow(
                    label: 'Remarks',
                    value: (level.entry == null || level.entry!.remarks.isEmpty) ? '-' : level.entry!.remarks,
                  ),
                  AdjDetailRow(
                    label: 'Files',
                    value: _files(r, level.role),
                  ),
                ]),
              ),
            ],
          ),
      ],
    );
  }

  String _files(AdjRequest r, AdjRole role) {
    final names = [for (final d in r.documents) if (d.step == role) d.fileName];
    return names.isEmpty ? '-' : names.join('\n');
  }

  Widget _icon(BuildContext context, AdjLevelState s) {
    final st = context.dbStatus;
    return switch (s) {
      AdjLevelState.done => Icon(Icons.check_circle_outline, color: st.success, size: 28),
      AdjLevelState.waiting || AdjLevelState.upcoming => Icon(Icons.error, color: st.warning, size: 28),
      AdjLevelState.returned => Icon(Icons.replay_circle_filled, color: st.warning, size: 28),
      AdjLevelState.rejected => Icon(Icons.cancel, color: st.danger, size: 28),
    };
  }

  String _dateLabel(AdjLevelStatus level) => switch (level.entry?.action) {
        AdjAction.approved => 'Date Approved',
        AdjAction.reviewed => 'Date Reviewed',
        AdjAction.completed => 'Date Completed',
        AdjAction.returned => 'Date Returned',
        AdjAction.rejected => 'Date Rejected',
        _ => switch (level.role) {
            AdjRole.businessReviewer || AdjRole.financeReviewer => 'Date Reviewed',
            AdjRole.financeOps => 'Date Completed',
            _ => 'Date Approved',
          },
      };
}
