import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

import '../adj_models.dart';
import '../adj_store.dart';
import 'adj_common.dart';

/// Activity log: every decision and file change, oldest first.
class AdjHistory extends StatelessWidget {
  const AdjHistory({super.key, required this.request, required this.store});
  final AdjRequest request;
  final AdjState store;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final st = context.dbStatus;
    final entries = request.history;

    Color dot(AdjAction a) => switch (a) {
          AdjAction.rejected => st.danger,
          AdjAction.returned => st.warning,
          AdjAction.completed => st.success,
          AdjAction.documentsAdded || AdjAction.documentRemoved => cs.outline,
          _ => cs.primary,
        };

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 0),
      child: Column(children: [
        for (var i = 0; i < entries.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 18,
                  child: Column(children: [
                    const SizedBox(height: 4),
                    Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(color: dot(entries[i].action), shape: BoxShape.circle),
                    ),
                    if (i < entries.length - 1) Expanded(child: Container(width: 2, color: cs.outlineVariant)),
                  ]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: '${entries[i].action.label} ',
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(text: 'by ${store.nameOf(entries[i].actorEmail)}'),
                          ]),
                          style: TextStyle(color: cs.onSurface),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${store.roleOf(entries[i].actorEmail)?.label ?? 'User'}, ${adjDateTime(entries[i].at)}',
                          style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                        ),
                        if (entries[i].remarks.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: cs.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(DiboldTheme.radiusSm),
                            ),
                            child: Text(entries[i].remarks, style: TextStyle(height: 1.5, color: cs.onSurface)),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ]),
    );
  }
}
