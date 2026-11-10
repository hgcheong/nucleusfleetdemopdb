import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Lines up the action buttons (save, back to list, …) with the first entry
/// field of the form beside them — not with a title, info text or the
/// field's floating label.
///
/// How it works: the form and its button column always sit in the same
/// `Row`. Every [FbField] reports the vertical centre of its input box,
/// measured inside each `Row` it belongs to. The first action button in the
/// button column reads the top-most of those centres for its own `Row` and
/// pushes itself down so its centre matches. Everything is measured
/// relative to the `Row`, so scrolling doesn't affect it.
class FormActionAlignGroup {
  final Map<Object, double> _fields = {};
  final Map<Object, double> _buttons = {};

  /// Centre (y, relative to the Row) of the top-most entry field, if any.
  final ValueNotifier<double?> firstFieldCenter = ValueNotifier<double?>(null);

  void reportField(Object id, double centerY) {
    _fields[id] = centerY;
    _recompute();
  }

  void removeField(Object id) {
    if (_fields.remove(id) != null) _recompute();
  }

  void reportButton(Object id, double outerTop) => _buttons[id] = outerTop;

  void removeButton(Object id) => _buttons.remove(id);

  /// True if [outerTop] belongs to the top-most button in this Row.
  bool isFirstButton(double outerTop) =>
      _buttons.values.every((t) => outerTop <= t + 0.5);

  void _recompute() {
    final v = _fields.isEmpty ? null : _fields.values.reduce(math.min);
    final cur = firstFieldCenter.value;
    if (v == null || cur == null) {
      if (v != cur) firstFieldCenter.value = v;
    } else if ((v - cur).abs() > 0.5) {
      firstFieldCenter.value = v;
    }
  }

  static final Expando<FormActionAlignGroup> _groups = Expando();

  static FormActionAlignGroup of(Element row) =>
      _groups[row] ??= FormActionAlignGroup();

  /// Nearest `Row` ancestors of [context] (closest first).
  static List<Element> rowAncestors(BuildContext context, {int max = 12}) {
    final rows = <Element>[];
    context.visitAncestorElements((e) {
      if (e.widget is Row) rows.add(e);
      return rows.length < max;
    });
    return rows;
  }
}

/// Finds the render box of the first text input inside [context], or null.
RenderBox? findFirstInputBox(BuildContext context) {
  RenderBox? found;
  void visit(Element e) {
    if (found != null) return;
    if (e.widget is EditableText) {
      final ro = e.renderObject;
      if (ro is RenderBox && ro.hasSize) found = ro;
      return;
    }
    e.visitChildElements(visit);
  }

  context.visitChildElements(visit);
  return found;
}
