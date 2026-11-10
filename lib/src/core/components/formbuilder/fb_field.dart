import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

/// Wraps every visible form-builder field (FbText, FbNumber, FbDateTimePicker,
/// FbLibView, FbOption, …) so they share one layout:
///
/// * fixed height — single-line inputs are exactly [DiboldTheme.fieldHeight]
///   tall (multi-line fields with maxLines > 1 can still grow);
/// * fixed spacing — [DiboldTheme.fieldSpacing] between two fields, split
///   half above (room for the floating label) and half below.
///
/// The height rule is scoped to form fields only, so grid cell editors,
/// column filters and the header search box keep their compact size.
class FbField extends StatelessWidget {
  const FbField({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: DiboldTheme.fieldSpacing / 2,
      ),
      child: Theme(
        data: theme.copyWith(
          inputDecorationTheme: theme.inputDecorationTheme.copyWith(
            constraints:
                const BoxConstraints(minHeight: DiboldTheme.fieldHeight),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            errorMaxLines: 2,
          ),
        ),
        child: child,
      ),
    );
  }
}
