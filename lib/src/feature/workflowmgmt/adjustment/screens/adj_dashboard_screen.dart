import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

import '../adj_models.dart';
import '../adj_nav.dart';
import '../adj_store.dart';
import '../adj_workflow.dart';
import '../widgets/adj_common.dart';
import '../widgets/adj_registers.dart';

const int _wid = 9301;

/// Approval queue for one kind (adjustment or bulk payment): summary
/// cards, tabs, search and the list. Path: /workflowmgmt/:kind
@RoutePage()
class AdjApprovalDashboard extends BaseScreen {
  const AdjApprovalDashboard({super.key});

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    if (isPageDeniedView(AcxAuthAccess.pageDeniedList, _wid)) return const NotAuthorised();
    final kind = AdjKind.fromPath(context.routeData.inheritedPathParams.optString('kind'));
    // Fill the area so the page sits at the top (BaseScreen's Row centres
    // shorter children vertically).
    return SizedBox.expand(child: _DashboardBody(key: ValueKey(kind), kind: kind));
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) => desktopBody(context, ref);

  @override
  Widget sideBar() => provideSideBar('workflowmgmt');

  @override
  PreferredSizeWidget breadCrumb() => provideBreadCrumb('workflowmgmt');
}

enum _View { awaiting, mine, all }

class _DashboardBody extends ConsumerStatefulWidget {
  const _DashboardBody({super.key, required this.kind});
  final AdjKind kind;

  @override
  ConsumerState<_DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends ConsumerState<_DashboardBody> {
  _View _view = _View.awaiting;
  AdjStatus? _status;
  String _query = '';

  void _showAwaiting() => setState(() {
        final already = _view == _View.awaiting && _status == null;
        _view = already ? _View.all : _View.awaiting;
        _status = null;
      });

  void _toggleStatus(AdjStatus s) => setState(() {
        if (_status == s) {
          _status = null;
        } else {
          _status = s;
          _view = _View.all;
        }
      });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final st = context.dbStatus;
    final store = ref.watch(adjStoreProvider);
    final me = store.currentUser;
    final kind = widget.kind;
    final all = store.sortedOf(kind);
    final pending = store.pendingFor(me, kind);
    final mine = all.where((r) => r.requestorEmail == me.email).toList();
    final source = switch (_view) {
      _View.awaiting => pending,
      _View.mine => mine,
      _View.all => all,
    };
    final q = _query.trim().toLowerCase();
    final items = source
        .where((r) => _status == null || r.status == _status)
        .where((r) =>
            q.isEmpty ||
            r.referenceCode.toLowerCase().contains(q) ||
            r.accountNumber.contains(q) ||
            r.adjustmentType.toLowerCase().contains(q) ||
            r.paymentLines.any((l) => l.payeeName.toLowerCase().contains(q)) ||
            (r.guarantee?.customerName.toLowerCase().contains(q) ?? false) ||
            (r.guarantee?.bgNumber.toLowerCase().contains(q) ?? false) ||
            (r.overdue?.customerName.toLowerCase().contains(q) ?? false) ||
            (r.overdue?.statementNo.toLowerCase().contains(q) ?? false) ||
            store.nameOf(r.requestorEmail).toLowerCase().contains(q) ||
            r.requestorEmail.toLowerCase().contains(q))
        .toList();
    int count(AdjStatus s) => all.where((r) => r.status == s).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdjPageHeader(
            title: kind.menuTitle,
            subtitle: switch (kind) {
              AdjKind.bulkPayment => 'Review, approve and release bulk payments to multiple payees.',
              AdjKind.bankGuarantee =>
                'Adjust customer credit limits when the bank guarantee securing them expires.',
              AdjKind.lpc => 'Approve late payment charges on statements with no payment received.',
              AdjKind.dataEntry =>
                'Transactions sent from Data Entry screens with Request for approval.',
              AdjKind.adjustment => 'Review, approve and track adjustment requests.',
              AdjKind.creditAdjustment =>
                'Raise, evaluate and approve changes to customer credit limits.',
            },
            actions: [
              const AdjActingAs(),
              if (kind == AdjKind.dataEntry)
                OutlinedButton.icon(
                  onPressed: () => singleton<AppRouter>().navigatePath('/dataentry/main'),
                  icon: const Icon(Icons.edit_note, size: 18),
                  label: const Text('Go to Data Entry'),
                )
              else
                FilledButton.icon(
                  onPressed: () => adjGoNew(kind),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('New request'),
                ),
            ],
          ),
          const SizedBox(height: 20),
          _StatGrid(stats: [
            _Stat('Awaiting your action', pending.length, Icons.pending_actions_outlined, cs.primary,
                _view == _View.awaiting && _status == null, _showAwaiting),
            _Stat('In progress', count(AdjStatus.inProgress), Icons.autorenew, st.info,
                _status == AdjStatus.inProgress, () => _toggleStatus(AdjStatus.inProgress)),
            _Stat('Returned', count(AdjStatus.returned), Icons.undo, st.warning, _status == AdjStatus.returned,
                () => _toggleStatus(AdjStatus.returned)),
            _Stat('Completed', count(AdjStatus.completed), Icons.task_alt, st.success,
                _status == AdjStatus.completed, () => _toggleStatus(AdjStatus.completed)),
          ]),
          if (kind == AdjKind.bankGuarantee) ...[const SizedBox(height: 20), const AdjGuaranteeRegister()],
          if (kind == AdjKind.lpc) ...[const SizedBox(height: 20), const AdjLpcRegister()],
          if (kind == AdjKind.creditAdjustment) ...[const SizedBox(height: 20), const AdjCreditRegister()],
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SegmentedButton<_View>(
                showSelectedIcon: false,
                segments: [
                  ButtonSegment(value: _View.awaiting, label: Text('Awaiting my action (${pending.length})')),
                  ButtonSegment(value: _View.mine, label: Text('My requests (${mine.length})')),
                  ButtonSegment(value: _View.all, label: Text('All requests (${all.length})')),
                ],
                selected: {_view},
                onSelectionChanged: (s) => setState(() => _view = s.first),
              ),
              SizedBox(
                width: 300,
                height: 40,
                child: TextField(
                  onChanged: (v) => setState(() => _query = v),
                  decoration: const InputDecoration(
                    isDense: true,
                    prefixIcon: Icon(Icons.search, size: 20),
                    hintText: 'Search reference, account, type or requestor',
                  ),
                ),
              ),
              if (_status != null)
                InputChip(
                  label: Text('Status: ${_status!.label}'),
                  onDeleted: () => setState(() => _status = null),
                  deleteButtonTooltipMessage: 'Clear status filter',
                ),
            ],
          ),
          const SizedBox(height: 14),
          AdjCard(
            padding: EdgeInsets.zero,
            child: items.isEmpty
                ? _Empty(kind: kind, view: _view, filtered: q.isNotEmpty || _status != null)
                : Column(children: [
                    _HeaderRow(
                      typeLabel: switch (kind) {
                        AdjKind.bankGuarantee || AdjKind.lpc || AdjKind.creditAdjustment => 'Customer',
                        _ => kind.typeLabel,
                      },
                      amountLabel: switch (kind) {
                        AdjKind.bankGuarantee => 'Reduction',
                        AdjKind.lpc => 'LPC',
                        AdjKind.creditAdjustment => 'Change',
                        _ => 'Amount',
                      },
                    ),
                    for (final r in items) _RequestRow(request: r, store: store),
                  ]),
          ),
        ],
      ),
    );
  }
}

class _Stat {
  _Stat(this.label, this.value, this.icon, this.color, this.selected, this.onTap);
  final String label;
  final int value;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;
}

class _StatGrid extends StatelessWidget {
  const _StatGrid({required this.stats});
  final List<_Stat> stats;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, c) {
      final perRow = c.maxWidth >= 900 ? 4 : (c.maxWidth >= 480 ? 2 : 1);
      final width = (c.maxWidth - 14 * (perRow - 1)) / perRow;
      return Wrap(spacing: 14, runSpacing: 14, children: [
        for (final s in stats)
          SizedBox(
            width: width,
            child: Semantics(
              button: true,
              selected: s.selected,
              label: '${s.label}: ${s.value}. Show these requests',
              excludeSemantics: true,
              child: Material(
                color: s.selected ? s.color.withValues(alpha: 0.08) : cs.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DiboldTheme.radius),
                  side: BorderSide(color: s.selected ? s.color : cs.outlineVariant, width: s.selected ? 2 : 1),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: s.onTap,
                  child: Padding(
                    padding: EdgeInsets.all(s.selected ? 15 : 16),
                    child: Row(children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: s.color.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(DiboldTheme.radiusSm),
                        ),
                        child: Icon(s.icon, color: s.color),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('${s.value}',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: cs.onSurface)),
                          Text(s.label, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                        ]),
                      ),
                      Icon(s.selected ? Icons.filter_alt : Icons.chevron_right,
                          size: 20, color: s.selected ? s.color : cs.onSurfaceVariant),
                    ]),
                  ),
                ),
              ),
            ),
          ),
      ]);
    });
  }
}

const _wide = 860.0;

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.typeLabel, required this.amountLabel});
  final String typeLabel;
  final String amountLabel;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < _wide) return const SizedBox.shrink();
    final cs = Theme.of(context).colorScheme;
    final style = TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: cs.onSurfaceVariant);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        border: Border(bottom: BorderSide(color: cs.outlineVariant)),
      ),
      child: Row(children: [
        Expanded(flex: 4, child: Text('Reference', style: style)),
        Expanded(flex: 3, child: Text(typeLabel, style: style)),
        Expanded(flex: 2, child: Text('Request date', style: style)),
        Expanded(flex: 2, child: Text(amountLabel, style: style, textAlign: TextAlign.right)),
        const SizedBox(width: 24),
        Expanded(flex: 3, child: Text('Stage', style: style)),
      ]),
    );
  }
}

class _RequestRow extends StatelessWidget {
  const _RequestRow({required this.request, required this.store});
  final AdjRequest request;
  final AdjState store;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final r = request;
    final wide = MediaQuery.sizeOf(context).width >= _wide;
    final ref = Text(r.referenceCode, style: TextStyle(fontWeight: FontWeight.w700, color: cs.primary));
    final next = Text(AdjWorkflow.pendingDescription(r),
        style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant));
    final type = switch (r.kind) {
      AdjKind.bulkPayment =>
        '${r.adjustmentType}, ${r.paymentLines.length} ${r.paymentLines.length == 1 ? 'payee' : 'payees'}',
      AdjKind.bankGuarantee => '${r.guarantee?.customerName ?? r.accountNumber}, ${r.adjustmentType.toLowerCase()}',
      AdjKind.lpc => '${r.overdue?.customerName ?? r.accountNumber}, ${r.overdue?.statementNo ?? ''}',
      AdjKind.dataEntry => '${r.adjustmentType}, transaction ${r.source?.txnId ?? '-'}',
      AdjKind.adjustment => r.adjustmentType,
      AdjKind.creditAdjustment =>
        '${r.creditEval?.customerName ?? r.accountNumber}, ${r.adjustmentType.toLowerCase()}'
            '${r.creditEval == null ? '' : ', grade ${r.creditEval!.grade}'}',
    };
    final amount = Text(adjRM(r.totalAmount),
        textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600, color: cs.onSurface));

    return InkWell(
      onTap: () => adjGoDetail(r),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: cs.outlineVariant))),
        child: wide
            ? Row(children: [
                Expanded(
                  flex: 4,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ref,
                    const SizedBox(height: 2),
                    Text(store.nameOf(r.requestorEmail),
                        style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                  ]),
                ),
                Expanded(flex: 3, child: Text(type, style: TextStyle(color: cs.onSurface))),
                Expanded(flex: 2, child: Text(adjDate(r.requestDate), style: TextStyle(color: cs.onSurface))),
                Expanded(flex: 2, child: amount),
                const SizedBox(width: 24),
                Expanded(
                  flex: 3,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    AdjStatusChip(request: r),
                    const SizedBox(height: 4),
                    next,
                  ]),
                ),
              ])
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [Expanded(child: ref), amount]),
                const SizedBox(height: 4),
                Text('$type, ${adjDate(r.requestDate)}',
                    style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                const SizedBox(height: 8),
                AdjStatusChip(request: r),
                const SizedBox(height: 4),
                next,
              ]),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.kind, required this.view, required this.filtered});
  final AdjKind kind;
  final _View view;
  final bool filtered;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = filtered
        ? 'No requests match your search or filter.'
        : switch (view) {
            _View.awaiting =>
              'Nothing is waiting on you. Check My requests or All requests, or act as someone else from the menu at the top.',
            _View.mine => "You haven't created any requests yet.",
            _View.all => 'No ${kind.menuTitle} tasks yet.',
          };
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(text, textAlign: TextAlign.center, style: TextStyle(color: cs.onSurfaceVariant)),
          if (!filtered && view != _View.awaiting && kind != AdjKind.dataEntry) ...[
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: () => adjGoNew(kind),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Create a request'),
            ),
          ],
        ]),
      ),
    );
  }
}
