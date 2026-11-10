import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/form_action_align.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

/// Wraps every visible form-builder field (FbText, FbNumber, FbDateTimePicker,
/// FbLibView, FbOption, …) so they share one layout:
///
/// * fixed height — single-line inputs are exactly [DiboldTheme.fieldHeight]
///   tall (multi-line fields with maxLines > 1 can still grow);
/// * fixed spacing — [DiboldTheme.fieldSpacing] between two fields, split
///   half above (room for the floating label) and half below;
/// * button alignment — reports where its input box is, so the save /
///   back-to-list buttons beside the form line up with the first field
///   (see form_action_align.dart).
///
/// The height rule is scoped to form fields only, so grid cell editors,
/// column filters and the header search box keep their compact size.
class FbField extends StatefulWidget {
  const FbField({super.key, required this.child});

  final Widget child;

  @override
  State<FbField> createState() => _FbFieldState();
}

class _FbFieldState extends State<FbField> {
  final Set<FormActionAlignGroup> _groups = {};
  // Post-frame callbacks and listeners can fire while this element is
  // deactivated (e.g. during a route change). Looking up ancestors then
  // throws, so track activity and skip work while inactive.
  bool _active = true;

  @override
  void activate() {
    super.activate();
    _active = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => _report());
  }

  @override
  void deactivate() {
    _active = false;
    // Stop counting this field while it's off-screen / being moved.
    for (final g in _groups) {
      g.removeField(this);
    }
    _groups.clear();
    super.deactivate();
  }

  @override
  void dispose() {
    for (final g in _groups) {
      g.removeField(this);
    }
    super.dispose();
  }

  void _report() {
    if (!mounted || !_active) return;
    final self = context.findRenderObject();
    if (self is! RenderBox || !self.hasSize || !self.attached) return;

    // Centre of the input box: the text input itself if there is one,
    // otherwise the fixed-height box below the top inset.
    final input = findFirstInputBox(context);
    final RenderBox target = input ?? self;
    final double localCenter = input != null
        ? input.size.height / 2
        : DiboldTheme.fieldSpacing / 2 + DiboldTheme.fieldHeight / 2;

    for (final row in FormActionAlignGroup.rowAncestors(context)) {
      final rowBox = row.renderObject;
      if (rowBox is! RenderBox || !rowBox.attached) continue;
      final y = target
          .localToGlobal(Offset(0, localCenter), ancestor: rowBox)
          .dy;
      final g = FormActionAlignGroup.of(row);
      _groups.add(g);
      g.reportField(this, y);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _report());
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
        child: _FbFieldScope(child: widget.child),
      ),
    );
  }
}

/// Marks the subtree of an [FbField], so inner widgets can tell they are
/// already spaced and sized.
class _FbFieldScope extends InheritedWidget {
  const _FbFieldScope({required super.child});

  @override
  bool updateShouldNotify(_FbFieldScope oldWidget) => false;
}

/// Wraps [child] in an [FbField] unless it is already inside one.
///
/// Used by the lookup / dropdown components (AcxSearchBoxMap and friends),
/// which many forms place directly — on their own or inside a
/// FormBuilderField builder — instead of through FbLibView. This gives them
/// the same height, spacing and button alignment as every other field,
/// without double spacing when they *are* used through FbLibView.
class FbFieldIfNeeded extends StatelessWidget {
  const FbFieldIfNeeded({super.key, required this.child});

  final Widget child;

  static bool isInside(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_FbFieldScope>() != null;

  @override
  Widget build(BuildContext context) =>
      isInside(context) ? child : FbField(child: child);
}

/// Standard horizontal gap between two form fields placed side by side in a
/// Row — the same size as the vertical gap between fields.
const fbFieldGap = SizedBox(width: DiboldTheme.fieldSpacing);

/// Extra vertical space to put after a row of fields when the next row's
/// floating labels would otherwise sit tight against it (half a field gap).
const fbFieldBottomGap = SizedBox(height: DiboldTheme.fieldSpacing / 2);
