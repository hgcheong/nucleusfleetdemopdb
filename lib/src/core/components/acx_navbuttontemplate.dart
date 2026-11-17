import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

/// Count card used for "Cost Center 3 [+]" style shortcuts.
///
/// Design: surface card with rounded corners and a thin border, a coloured
/// accent bar on the left, a small muted label on top, a large value under
/// it, and the action icon(s) on the right in the accent colour. Theme
/// colours only, so it follows light and dark mode.
///
/// [listOfContent] as before: with two items the first is the label and the
/// second the value (large). With one item it is the label; with more than
/// two, the first is a title and the rest are muted lines.
/// When [listOfButton] holds a single IconButton, tapping anywhere on the card
/// does the same as that button.
class AcxNavButton extends StatefulWidget {
  const AcxNavButton({
    super.key,
    required this.listOfContent,
    required this.listOfButton,
    this.theheight,
    this.thewidth = 200,
    this.accent,
  });

  final List<Widget> listOfContent;
  final List<Widget>? listOfButton;
  /// Card height. Null (default): 84, or taller to fit more than two lines.
  final double? theheight;
  final double? thewidth;

  /// Accent bar and icon colour; defaults to the theme's primary.
  final Color? accent;

  @override
  State<AcxNavButton> createState() => _AcxNavButtonState();
}

class _AcxNavButtonState extends State<AcxNavButton> {
  bool _hover = false;

  VoidCallback? get _cardTap {
    final buttons = widget.listOfButton ?? const <Widget>[];
    if (buttons.length != 1) return null;
    final b = buttons.first;
    return b is IconButton ? b.onPressed : null;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final accent = widget.accent ?? cs.primary;
    final content = widget.listOfContent;
    final buttons = widget.listOfButton ?? const <Widget>[];
    final onTap = _cardTap;

    final labelStyle = text.bodySmall!.copyWith(color: cs.onSurfaceVariant, fontWeight: FontWeight.w500);
    final valueStyle = text.headlineSmall!.copyWith(color: cs.onSurface, fontWeight: FontWeight.w700, height: 1.15);
    final titleStyle = text.titleSmall!.copyWith(color: cs.onSurface, fontWeight: FontWeight.w700);

    TextStyle styleAt(int i) {
      if (content.length == 2) return i == 0 ? labelStyle : valueStyle;
      if (content.length == 1) return titleStyle;
      return i == 0 ? titleStyle : labelStyle;
    }

    final body = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < content.length; i++)
          Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : (content.length == 2 ? 4 : 2)),
            child: DefaultTextStyle.merge(
              style: styleAt(i),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: content[i],
            ),
          ),
      ],
    );

    final actions = buttons.isEmpty
        ? null
        : IconButtonTheme(
            data: IconButtonThemeData(
              style: IconButton.styleFrom(
                foregroundColor: accent,
                hoverColor: accent.withValues(alpha: 0.08),
                visualDensity: VisualDensity.compact,
              ),
            ),
            child: IconTheme.merge(
              data: IconThemeData(color: accent, size: 24),
              child: Row(mainAxisSize: MainAxisSize.min, children: buttons),
            ),
          );

    final card = MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DiboldTheme.radius),
            boxShadow: _hover
                ? [BoxShadow(color: cs.shadow.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))]
                : null,
          ),
          child: Material(
            color: cs.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DiboldTheme.radius),
              side: BorderSide(color: _hover ? accent.withValues(alpha: 0.5) : cs.outlineVariant),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              mouseCursor: onTap == null ? SystemMouseCursors.basic : SystemMouseCursors.click,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(width: 5, color: accent),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
                      child: body,
                    ),
                  ),
                  if (actions != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Center(child: actions),
                    ),
                ],
              ),
            ),
          ),
        ),
      );

    if (widget.theheight != null) {
      return SizedBox(height: widget.theheight, width: widget.thewidth, child: card);
    }
    return SizedBox(
      width: widget.thewidth,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 84),
        child: IntrinsicHeight(child: card),
      ),
    );
  }
}
