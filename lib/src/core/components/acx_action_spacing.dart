import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nucleusv2/src/core/components/form_action_align.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

/// Shared layout for action buttons (AcxSaveButtonManual, AcxBackToList,
/// AcxAuditLogReqBtn, copy / paste):
///
/// * same size — every button is exactly [DiboldTheme.actionButtonSize],
///   including the save button's loading state;
/// * same spacing — two buttons next to each other (Column or Row) are
///   always [DiboldTheme.actionSpacing] apart;
/// * aligned — the first button in the column lines up with the first
///   entry field of the form beside it (centre to centre), skipping any
///   title or info text above that field. With no form beside it, the
///   button simply stays at the top.
class AcxActionSpacing extends StatefulWidget {
  const AcxActionSpacing({super.key, required this.child});

  final Widget child;

  @override
  State<AcxActionSpacing> createState() => _AcxActionSpacingState();
}

class _AcxActionSpacingState extends State<AcxActionSpacing> {
  FormActionAlignGroup? _group;
  double _extraTop = 0;
  // Post-frame callbacks and listeners can fire while this element is
  // deactivated (e.g. during a route change). Looking up ancestors then
  // throws, so track activity and skip work while inactive.
  bool _active = true;

  @override
  void activate() {
    super.activate();
    _active = true;
  }

  @override
  void deactivate() {
    _active = false;
    super.deactivate();
  }

  @override
  void dispose() {
    _group?.firstFieldCenter.removeListener(_onFieldsChanged);
    _group?.removeButton(this);
    super.dispose();
  }

  // Field positions can change in the middle of a build (a field being
  // removed or deactivated). Never measure or setState then — wait for the
  // end of the frame instead.
  bool _syncScheduled = false;
  void _onFieldsChanged() {
    if (_syncScheduled) return;
    _syncScheduled = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _syncScheduled = false;
      _sync();
    });
    SchedulerBinding.instance.ensureVisualUpdate();
  }

  void _sync() {
    if (!mounted || !_active) return;
    final rows = FormActionAlignGroup.rowAncestors(context, max: 1);
    double extra = 0;
    if (rows.isNotEmpty) {
      final row = rows.first;
      final g = FormActionAlignGroup.of(row);
      if (!identical(g, _group)) {
        _group?.firstFieldCenter.removeListener(_onFieldsChanged);
        _group?.removeButton(this);
        _group = g;
        g.firstFieldCenter.addListener(_onFieldsChanged);
      }
      final self = context.findRenderObject();
      final rowBox = row.renderObject;
      if (self is RenderBox &&
          self.hasSize &&
          rowBox is RenderBox &&
          rowBox.attached) {
        // Top of this widget's own box: does not move when _extraTop
        // changes (that only adds padding inside it).
        final outerTop =
            self.localToGlobal(Offset.zero, ancestor: rowBox).dy;
        g.reportButton(this, outerTop);
        final center = g.firstFieldCenter.value;
        if (center != null && g.isFirstButton(outerTop)) {
          final naturalCenter = outerTop +
              DiboldTheme.actionSpacing / 2 +
              DiboldTheme.actionButtonSize.height / 2;
          extra = center - naturalCenter;
          if (extra < 0) extra = 0;
        }
      }
    }
    if ((extra - _extraTop).abs() > 0.5) {
      setState(() => _extraTop = extra);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
    final themeStyle = Theme.of(context).elevatedButtonTheme.style;
    final fixed = ElevatedButton.styleFrom(
      fixedSize: DiboldTheme.actionButtonSize,
      minimumSize: DiboldTheme.actionButtonSize,
      maximumSize: DiboldTheme.actionButtonSize,
      padding: EdgeInsets.zero,
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(
        DiboldTheme.actionSpacing / 2,
        DiboldTheme.actionSpacing / 2 + _extraTop,
        DiboldTheme.actionSpacing / 2,
        DiboldTheme.actionSpacing / 2,
      ),
      // Align keeps the fixed size even inside a stretched Column.
      child: Align(
        widthFactor: 1,
        heightFactor: 1,
        child: ElevatedButtonTheme(
          data: ElevatedButtonThemeData(style: fixed.merge(themeStyle)),
          child: widget.child,
        ),
      ),
    );
  }
}
