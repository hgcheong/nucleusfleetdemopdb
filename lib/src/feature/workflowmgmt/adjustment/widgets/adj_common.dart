import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';
import 'package:nucleusv2/src/utils/toast.dart';

import '../adj_models.dart';
import '../adj_store.dart';
import '../adj_workflow.dart';

// ── Formatting ──────────────────────────────────────────────────────────────

final _money = NumberFormat('#,##0.00', 'en_US');
final _kb = NumberFormat('#,##0.##', 'en_US');

String adjRM(double v) => 'RM ${_money.format(v)}';
String adjDate(DateTime d) => DateFormat('d MMM yyyy').format(d);
String adjDateTime(DateTime d) => DateFormat('d MMM yyyy, h:mm a').format(d);
String adjSize(int bytes) => '${_kb.format(bytes / 1024)} KB';

/// "expires in 9 days", "expires today" or "expired 4 days ago".
String adjExpiryText(AdjGuarantee g, DateTime today) {
  final d = g.daysToExpiry(today);
  if (d > 0) return 'expires in $d ${d == 1 ? 'day' : 'days'}';
  if (d == 0) return 'expires today';
  return 'expired ${-d} ${d == -1 ? 'day' : 'days'} ago';
}

/// Runs a store action and shows its result; returns true on success.
bool adjRun(void Function() action, {String? success}) {
  try {
    action();
    if (success != null) Toast.success(success);
    return true;
  } on AdjError catch (e) {
    Toast.error(e.message);
    return false;
  }
}

// ── Layout parts ────────────────────────────────────────────────────────────

/// Input box in the app's DiBold form style: wraps [FbField] (fixed
/// [DiboldTheme.fieldHeight], [DiboldTheme.fieldSpacing] between fields,
/// two-line errors) and keeps labels on the border like the Fb* fields.
class AdjField extends StatelessWidget {
  const AdjField({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
      child: FbField(child: child),
    );
  }
}

/// Bordered surface card, as used across the DiBold theme.
class AdjCard extends StatelessWidget {
  const AdjCard({super.key, required this.child, this.padding = const EdgeInsets.all(24)});
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final narrow = MediaQuery.sizeOf(context).width < 700;
    return Container(
      width: double.infinity,
      padding: narrow ? const EdgeInsets.all(14) : padding,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(DiboldTheme.radius),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: child,
    );
  }
}

/// Section heading with a short accent bar, followed by its rows.
class AdjSection extends StatelessWidget {
  const AdjSection({super.key, required this.title, required this.children, this.trailing});
  final String title;
  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 18,
              decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: cs.onSurface)),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 12),
        Divider(height: 1, color: cs.outlineVariant),
        ...children,
      ],
    );
  }
}

/// Label on the left, value on the right; stacks on narrow widths.
class AdjDetailRow extends StatelessWidget {
  const AdjDetailRow({super.key, required this.label, this.value, this.child});
  final String label;
  final String? value;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final labelWidget = Text(label,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: cs.onSurfaceVariant));
    final valueWidget =
        child ?? SelectableText(value ?? '-', style: TextStyle(fontSize: 14, height: 1.6, color: cs.onSurface));

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 4),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: cs.outlineVariant))),
      child: LayoutBuilder(builder: (context, c) {
        if (c.maxWidth < 520) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [labelWidget, const SizedBox(height: 4), valueWidget],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: c.maxWidth * 0.32, child: labelWidget),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 680), child: valueWidget),
              ),
            ),
          ],
        );
      }),
    );
  }
}

/// Small rounded label in a status colour.
class AdjPill extends StatelessWidget {
  const AdjPill({super.key, required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700)),
    );
  }
}

class AdjStatusChip extends StatelessWidget {
  const AdjStatusChip({super.key, required this.request});
  final AdjRequest request;

  @override
  Widget build(BuildContext context) {
    final st = context.dbStatus;
    final cs = Theme.of(context).colorScheme;
    return switch (request.status) {
      AdjStatus.completed => AdjPill(text: 'Completed', color: st.success),
      AdjStatus.rejected => AdjPill(text: 'Rejected', color: st.danger),
      AdjStatus.returned => AdjPill(text: 'Returned', color: st.warning),
      AdjStatus.inProgress => AdjPill(text: request.stage.label, color: cs.primary),
    };
  }
}

/// Colour for an approval-level state, shared by stepper and level list.
Color adjLevelColor(BuildContext context, AdjLevelState s) {
  final st = context.dbStatus;
  final cs = Theme.of(context).colorScheme;
  return switch (s) {
    AdjLevelState.done => st.success,
    AdjLevelState.waiting => cs.primary,
    AdjLevelState.returned => st.warning,
    AdjLevelState.rejected => st.danger,
    AdjLevelState.upcoming => cs.onSurfaceVariant,
  };
}

/// Page heading: title, optional subtitle and actions on the right.
class AdjPageHeader extends StatelessWidget {
  const AdjPageHeader({super.key, required this.title, this.subtitle, this.actions = const []});
  final String title;
  final String? subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 12,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: cs.onSurface)),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(subtitle!, style: TextStyle(color: cs.onSurfaceVariant)),
            ],
          ],
        ),
        if (actions.isNotEmpty)
          Wrap(spacing: DiboldTheme.actionSpacing, runSpacing: 8, children: actions),
      ],
    );
  }
}

/// "Acting as" switcher. The workflow runs on local demo users, so this is
/// how one person can play each role and walk a request through every step.
class AdjActingAs extends ConsumerWidget {
  const AdjActingAs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final store = ref.watch(adjStoreProvider);
    final me = store.currentUser;
    final pending = store.pendingFor(me).length;

    return PopupMenuButton<String>(
      tooltip: 'Switch demo user',
      position: PopupMenuPosition.under,
      onSelected: (email) {
        if (email == '__reset') {
          ref.read(adjStoreProvider.notifier).resetDemo();
          Toast.success('Demo data restored');
        } else {
          ref.read(adjStoreProvider.notifier).switchUser(email);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          enabled: false,
          child: Text('Act as', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurfaceVariant)),
        ),
        for (final u in store.users)
          PopupMenuItem<String>(
            value: u.email,
            child: Row(
              children: [
                Icon(u.email == me.email ? Icons.radio_button_checked : Icons.radio_button_off,
                    size: 18, color: cs.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(u.name, style: TextStyle(color: cs.onSurface)),
                      Text(u.role.label, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                    ],
                  ),
                ),
                if (store.pendingFor(u).isNotEmpty)
                  AdjPill(text: '${store.pendingFor(u).length}', color: cs.primary),
              ],
            ),
          ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: '__reset',
          child: Row(children: [
            Icon(Icons.restart_alt, size: 18, color: cs.onSurfaceVariant),
            const SizedBox(width: 10),
            const Text('Reset demo data'),
          ]),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 5, 12, 5),
        decoration: BoxDecoration(
          border: Border.all(color: cs.outlineVariant),
          borderRadius: BorderRadius.circular(DiboldTheme.radiusSm),
          color: cs.surface,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Badge(
              isLabelVisible: pending > 0,
              label: Text('$pending'),
              backgroundColor: cs.primary,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: cs.primaryContainer,
                child: Text(me.initials,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: cs.onPrimaryContainer)),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Acting as ${me.name}',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: cs.onSurface)),
                Text(me.role.label, style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant)),
              ],
            ),
            const SizedBox(width: 4),
            Icon(Icons.expand_more, size: 18, color: cs.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
