import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

import '../adj_models.dart';
import 'adj_common.dart';

/// Colour for a credit grade: A success, B info, C warning, D danger.
Color adjGradeColor(BuildContext context, String grade) {
  final st = context.dbStatus;
  return switch (grade) {
    'A' => st.success,
    'B' => st.info,
    'C' => st.warning,
    _ => st.danger,
  };
}

/// Credit evaluation result: grade, score, recommended against requested
/// limit, and each scored factor with a bar. Used on the request page and as
/// a live preview on the New request form.
class AdjCreditEvalView extends StatelessWidget {
  const AdjCreditEvalView({super.key, required this.eval});

  final AdjCreditEval eval;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final st = context.dbStatus;
    final color = adjGradeColor(context, eval.grade);
    final within = eval.withinRecommendation;
    final gap = eval.requestedLimit - eval.recommendedLimit;

    final summary = Wrap(
      spacing: 20,
      runSpacing: 14,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(DiboldTheme.radius),
              border: Border.all(color: color.withValues(alpha: 0.5)),
            ),
            child: Text(eval.grade,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: color, height: 1)),
          ),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Grade ${eval.grade}, ${eval.riskLabel}',
                style: text.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: cs.onSurface)),
            const SizedBox(height: 2),
            Text('Score ${eval.score} of 100', style: text.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
          ]),
        ]),
        _Figure(label: 'Current limit', value: adjRM(eval.currentLimit)),
        _Figure(label: 'Requested limit', value: adjRM(eval.requestedLimit)),
        _Figure(label: 'Recommended limit', value: adjRM(eval.recommendedLimit)),
        AdjPill(
          text: within ? 'Within recommendation' : 'Above recommendation by ${adjRM(gap)}',
          color: within ? st.success : st.warning,
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        summary,
        const SizedBox(height: 18),
        for (final f in eval.factors) _FactorRow(factor: f),
        const SizedBox(height: 6),
        Text(
          'Recommended limit = average monthly spend (${adjRM(eval.avgMonthlySpend)}) × '
          '${_multiplierText(eval.grade)} for grade ${eval.grade}, plus security held '
          '(${adjRM(eval.securityAmount)}), rounded down to RM 1,000.',
          style: text.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
      ],
    );
  }

  static String _multiplierText(String grade) => switch (grade) {
        'A' => '2.0',
        'B' => '1.5',
        'C' => '1.0',
        _ => '0.5',
      };
}

class _Figure extends StatelessWidget {
  const _Figure({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
      const SizedBox(height: 2),
      Text(value, style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
    ]);
  }
}

class _FactorRow extends StatelessWidget {
  const _FactorRow({required this.factor});
  final AdjEvalFactor factor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final share = factor.maxPoints == 0 ? 0.0 : factor.points / factor.maxPoints;
    final st = context.dbStatus;
    final color = share >= 0.75 ? st.success : (share >= 0.4 ? st.warning : st.danger);

    final label = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(factor.label, style: TextStyle(fontWeight: FontWeight.w600, color: cs.onSurface)),
      Text(factor.value, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
    ]);
    final bar = Row(children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: share,
            minHeight: 8,
            backgroundColor: cs.surfaceContainerHighest,
            color: color,
          ),
        ),
      ),
      const SizedBox(width: 10),
      SizedBox(
        width: 48,
        child: Text('${factor.points}/${factor.maxPoints}',
            textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
      ),
    ]);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: LayoutBuilder(builder: (context, c) {
        if (c.maxWidth < 520) {
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            label,
            const SizedBox(height: 6),
            bar,
          ]);
        }
        return Row(children: [
          SizedBox(width: 260, child: label),
          const SizedBox(width: 16),
          Expanded(child: bar),
        ]);
      }),
    );
  }
}
