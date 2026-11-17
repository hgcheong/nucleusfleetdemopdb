import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

import '../adj_models.dart';
import '../adj_workflow.dart';
import 'adj_common.dart';

/// Six-step progress as a row of step cards (same card style as the stat
/// and record cards). Each card can be clicked to show that step's details.
class AdjStepper extends StatelessWidget {
  const AdjStepper({
    super.key,
    required this.levels,
    required this.selectedIndex,
    required this.onStepTap,
  });

  /// Approval levels in order (step 0, Submitted, is always done).
  final List<AdjLevelStatus> levels;
  final int? selectedIndex;
  final ValueChanged<int> onStepTap;

  AdjLevelState stateAt(int i) => i == 0 ? AdjLevelState.done : levels[i - 1].state;

  static const _cardMinWidth = 140.0;
  static const _arrowWidth = 22.0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final stages = AdjStage.values;
    final done = [for (var i = 0; i < stages.length; i++) stateAt(i)]
        .where((s) => s == AdjLevelState.done)
        .length;

    Widget cards({required bool fixedWidth}) {
      final children = <Widget>[];
      for (var i = 0; i < stages.length; i++) {
        final card = _StepCard(
          number: stages[i].step,
          label: stages[i].label,
          state: stateAt(i),
          selected: selectedIndex == i,
          onTap: () => onStepTap(i),
        );
        children.add(fixedWidth ? SizedBox(width: _cardMinWidth, child: card) : Expanded(child: card));
        if (i < stages.length - 1) {
          children.add(SizedBox(
            width: _arrowWidth,
            child: Icon(Icons.chevron_right, size: 18, color: cs.outline),
          ));
        }
      }
      return IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          Text('Approval progress', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
          const Spacer(),
          Text('$done of ${stages.length} steps done',
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
        ]),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: done / stages.length,
            minHeight: 6,
            backgroundColor: cs.surfaceContainerHighest,
            color: cs.primary,
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(builder: (context, c) {
          final needed = stages.length * _cardMinWidth + (stages.length - 1) * _arrowWidth;
          if (c.maxWidth >= needed) return cards(fixedWidth: false);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: cards(fixedWidth: true),
          );
        }),
      ],
    );
  }
}

class _StepCard extends StatefulWidget {
  const _StepCard({
    required this.number,
    required this.label,
    required this.state,
    required this.selected,
    required this.onTap,
  });

  final int number;
  final String label;
  final AdjLevelState state;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_StepCard> createState() => _StepCardState();
}

class _StepCardState extends State<_StepCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final color = adjLevelColor(context, widget.state);
    final selected = widget.selected;

    final (IconData icon, String status) = switch (widget.state) {
      AdjLevelState.done => (Icons.check_circle, 'Done'),
      AdjLevelState.waiting => (Icons.hourglass_top, 'Awaiting action'),
      AdjLevelState.returned => (Icons.undo, 'Returned'),
      AdjLevelState.rejected => (Icons.block, 'Rejected'),
      AdjLevelState.upcoming => (Icons.more_horiz, 'Not started'),
    };
    final upcoming = widget.state == AdjLevelState.upcoming;
    final waiting = widget.state == AdjLevelState.waiting;

    final borderColor = selected
        ? cs.primary
        : (_hover ? cs.primary.withValues(alpha: 0.6) : (waiting ? cs.primary.withValues(alpha: 0.5) : cs.outlineVariant));

    return Semantics(
      button: true,
      selected: selected,
      label: 'Step ${widget.number}, ${widget.label}, $status. Show details',
      excludeSemantics: true,
      child: Tooltip(
        message: selected ? 'Hide details' : 'View details',
        waitDuration: const Duration(milliseconds: 500),
        child: MouseRegion(
          onEnter: (_) => setState(() => _hover = true),
          onExit: (_) => setState(() => _hover = false),
          child: Material(
            color: selected ? Color.alphaBlend(cs.primary.withValues(alpha: 0.08), cs.surface) : cs.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DiboldTheme.radiusSm),
              side: BorderSide(color: borderColor, width: selected ? 2 : 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: widget.onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Status strip: solid when done / returned / rejected,
                  // half-filled while awaiting, grey when not started.
                  SizedBox(
                    height: 4,
                    child: waiting
                        ? Row(children: [
                            Expanded(child: Container(color: color)),
                            Expanded(child: Container(color: color.withValues(alpha: 0.2))),
                          ])
                        : Container(color: upcoming ? cs.surfaceContainerHighest : color),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(selected ? 11 : 12, 10, selected ? 11 : 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('Step ${widget.number}',
                              style: text.labelSmall?.copyWith(color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
                          const Spacer(),
                          Icon(icon, size: 16, color: upcoming ? cs.outline : color),
                        ]),
                        const SizedBox(height: 6),
                        Text(
                          widget.label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: text.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                            color: upcoming ? cs.onSurfaceVariant : cs.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          status,
                          style: text.bodySmall?.copyWith(
                            fontWeight: upcoming ? FontWeight.w400 : FontWeight.w600,
                            color: upcoming ? cs.onSurfaceVariant : color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
