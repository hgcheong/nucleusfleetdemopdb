import 'package:flutter/widgets.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

/// Gives every action button (AcxSaveButtonManual, AcxBackToList,
/// AcxAuditLogReqBtn) the same spacing on all sides, so two buttons next to
/// each other — stacked in a Column or side by side in a Row — are always
/// exactly [DiboldTheme.actionSpacing] apart without extra sbh10/sbw10.
class AcxActionSpacing extends StatelessWidget {
  const AcxActionSpacing({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DiboldTheme.actionSpacing / 2),
      child: child,
    );
  }
}
