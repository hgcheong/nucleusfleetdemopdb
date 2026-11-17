import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

/// Record card used by the AcxListButtonNavWrap* widgets.
///
/// Theme colours only (works in light and dark mode): an accent bar on the
/// left, the first line as the title and the rest as small muted capitals,
/// an optional badge ([icon] or a custom [leading], e.g. a progress ring), a
/// check when [selected] with a light tint and 2 px accent border, a hover
/// highlight, and Delete and Edit on the right under an inset divider.
class AcxNavTile extends StatefulWidget {
  const AcxNavTile({
    super.key,
    required this.lines,
    this.width = 250,
    this.height = 150,
    this.selected = false,
    this.onEdit,
    this.editIcon = Icons.edit,
    this.editTooltip = 'Edit',
    this.onDelete,
    this.leading,
    this.icon,
    this.accent,
  });

  /// Values to show, top to bottom. Null or empty values are skipped.
  final List<String?> lines;
  final double width;
  final double height;
  final bool selected;

  /// Edit / open the record. Tapping the card does the same.
  final VoidCallback? onEdit;
  final IconData editIcon;
  final String editTooltip;
  final VoidCallback? onDelete;

  /// Optional widget on the left in place of the badge (e.g. a percentage ring).
  final Widget? leading;

  /// Icon for the badge; without it the badge shows the title's initials.
  final IconData? icon;

  /// Badge and selection colour; defaults to the theme's primary.
  final Color? accent;

  @override
  State<AcxNavTile> createState() => _AcxNavTileState();
}

class _AcxNavTileState extends State<AcxNavTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final selected = widget.selected;
    final lines = widget.lines.where((l) => l != null && l.trim().isNotEmpty && l != 'null').cast<String>().toList();

    final accent = widget.accent ?? cs.primary;
    final borderColor = selected ? accent : (_hover ? accent.withValues(alpha: 0.6) : cs.outlineVariant);
    final titleColor = cs.onSurface;
    final mutedColor = cs.onSurfaceVariant;

    // Optional badge: only when a [leading] widget or an [icon] is given
    // (e.g. the progress ring on the director cards).
    final Widget? badge = widget.leading ??
        (widget.icon == null
            ? null
            : Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(DiboldTheme.radiusSm),
                ),
                child: Icon(widget.icon, color: accent),
              ));

    // Title, then the other values as small muted capitals.
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < lines.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == 0 ? 6 : 2),
            child: Text(
              i == 0 ? lines[i] : lines[i].toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: i == 0
                  ? text.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: titleColor)
                  : text.bodySmall?.copyWith(color: mutedColor, letterSpacing: 0.4),
            ),
          ),
      ],
    );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DiboldTheme.radius),
            boxShadow: _hover && !selected
                ? [BoxShadow(color: cs.shadow.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))]
                : null,
          ),
          child: Material(
            color: selected ? Color.alphaBlend(accent.withValues(alpha: 0.08), cs.surface) : cs.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DiboldTheme.radius),
              side: BorderSide(color: borderColor, width: selected ? 2 : 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: widget.onEdit,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Accent bar on the left, as on the count cards.
                  Container(width: 5, color: accent),
                  Expanded(
                    child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      // Keep content steady when the border thickens on select.
                      padding: EdgeInsets.fromLTRB(14, selected ? 11 : 12, selected ? 9 : 10, 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (badge != null) ...[badge, const SizedBox(width: 12)],
                          Expanded(child: SingleChildScrollView(child: body)),
                          if (selected) Icon(Icons.check_circle, size: 20, color: accent),
                        ],
                      ),
                    ),
                  ),
                  // Divider inset from the edges, actions on the right.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: selected ? accent.withValues(alpha: 0.3) : cs.outlineVariant,
                    ),
                  ),
                  SizedBox(
                    height: 42,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (widget.onDelete != null)
                          IconButton(
                            tooltip: 'Delete',
                            visualDensity: VisualDensity.compact,
                            iconSize: 20,
                            color: context.dbStatus.danger,
                            icon: const Icon(Icons.delete_outline),
                            onPressed: widget.onDelete,
                          ),
                        if (widget.onEdit != null)
                          IconButton(
                            tooltip: widget.editTooltip,
                            visualDensity: VisualDensity.compact,
                            iconSize: 20,
                            color: accent,
                            icon: Icon(widget.editIcon),
                            onPressed: widget.onEdit,
                          ),
                        const SizedBox(width: 4),
                      ],
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

/// "Add new" card, the same size as the record cards beside it.
class AcxNavAddTile extends StatelessWidget {
  const AcxNavAddTile({super.key, required this.onTap, this.width = 250, this.height = 150});

  final VoidCallback onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: cs.primary.withValues(alpha: 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DiboldTheme.radius),
          side: BorderSide(color: cs.primary.withValues(alpha: 0.5)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline, size: 30, color: cs.primary),
              const SizedBox(height: 6),
              Text('Add new', style: TextStyle(fontWeight: FontWeight.w700, color: cs.primary)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shown when a NavWrap list has no records.
class AcxNavEmpty extends StatelessWidget {
  const AcxNavEmpty({super.key, this.onAdd, this.message = 'No records yet'});

  final VoidCallback? onAdd;
  final String message;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, color: cs.onSurfaceVariant),
          Text(message, style: TextStyle(color: cs.onSurfaceVariant)),
          if (onAdd != null)
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add new'),
            ),
        ],
      ),
    );
  }
}

/// Wrap layout shared by the NavWrap widgets: same padding and gaps.
class AcxNavWrapLayout extends StatelessWidget {
  const AcxNavWrapLayout({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
      child: Wrap(spacing: 12, runSpacing: 12, children: children),
    );
  }
}
