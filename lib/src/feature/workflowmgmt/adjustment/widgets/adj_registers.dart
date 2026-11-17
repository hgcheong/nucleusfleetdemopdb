import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

import '../adj_models.dart';
import '../adj_nav.dart';
import '../adj_seed.dart';
import '../adj_store.dart';
import 'adj_common.dart';

DateTime _today() {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day);
}

void _startTask(WidgetRef ref, AdjKind kind, String itemNumber) {
  ref.read(adjPrefillProvider.notifier).state = itemNumber;
  adjGoNew(kind);
}

/// Guarantees expiring within the window (or already expired) that still
/// need a credit limit decision. "Show all" lists the whole register.
class AdjGuaranteeRegister extends ConsumerStatefulWidget {
  const AdjGuaranteeRegister({super.key});

  @override
  ConsumerState<AdjGuaranteeRegister> createState() => _AdjGuaranteeRegisterState();
}

class _AdjGuaranteeRegisterState extends ConsumerState<AdjGuaranteeRegister> {
  bool _all = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final st = context.dbStatus;
    final store = ref.watch(adjStoreProvider);
    final today = _today();
    final needing = store.guaranteesNeedingAction(today);
    final rows = _all ? ([...store.guarantees]..sort((a, b) => a.expiryDate.compareTo(b.expiryDate))) : needing;

    return AdjCard(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
      child: AdjSection(
        title: 'Bank guarantees expiring within $adjGuaranteeWindowDays days',
        trailing: TextButton(
          onPressed: () => setState(() => _all = !_all),
          child: Text(_all ? 'Show expiring only' : 'Show all guarantees'),
        ),
        children: [
          if (rows.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text('No guarantees need a credit limit decision.',
                  style: TextStyle(color: cs.onSurfaceVariant)),
            ),
          for (final g in rows)
            _RegisterRow(
              title: '${g.customerName} (${g.accountNumber})',
              detail: '${g.bgNumber}, ${g.issuingBank}, ${adjRM(g.amount)}. '
                  'Credit limit ${adjRM(g.creditLimit)}.',
              badge: AdjPill(
                text: '${adjDate(g.expiryDate)}, ${adjExpiryText(g, today)}',
                color: g.adjustedBy != null
                    ? cs.onSurfaceVariant
                    : (g.daysToExpiry(today) <= 7 ? st.danger : st.warning),
              ),
              action: _action(
                context,
                done: g.adjustedBy,
                doneText: 'Limit adjusted',
                open: store.openTaskForGuarantee(g.bgNumber),
                onCreate: () => _startTask(ref, AdjKind.bankGuarantee, g.bgNumber),
                store: store,
              ),
            ),
        ],
      ),
    );
  }
}

/// Statements past due with no payment received and no LPC posted yet.
class AdjLpcRegister extends ConsumerStatefulWidget {
  const AdjLpcRegister({super.key});

  @override
  ConsumerState<AdjLpcRegister> createState() => _AdjLpcRegisterState();
}

class _AdjLpcRegisterState extends ConsumerState<AdjLpcRegister> {
  bool _all = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final st = context.dbStatus;
    final store = ref.watch(adjStoreProvider);
    final today = _today();
    final needing = store.statementsNeedingLpc(today);
    final rows = _all ? ([...store.overdues]..sort((a, b) => a.dueDate.compareTo(b.dueDate))) : needing;

    return AdjCard(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
      child: AdjSection(
        title: 'Overdue statements with no payment received',
        trailing: TextButton(
          onPressed: () => setState(() => _all = !_all),
          child: Text(_all ? 'Show unpaid only' : 'Show all overdue'),
        ),
        children: [
          if (rows.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text('No unpaid statements are waiting for an LPC decision.',
                  style: TextStyle(color: cs.onSurfaceVariant)),
            ),
          for (final o in rows)
            _RegisterRow(
              title: '${o.customerName} (${o.accountNumber})',
              detail: '${o.statementNo}, due ${adjDate(o.dueDate)}. '
                  '${o.noPaymentReceived ? 'No payment received' : 'Paid ${adjRM(o.amountPaid)}'} '
                  'of ${adjRM(o.amountDue)}.',
              badge: AdjPill(
                text: '${o.daysOverdue(today)} days overdue',
                color: o.chargedBy != null || !o.noPaymentReceived
                    ? cs.onSurfaceVariant
                    : (o.daysOverdue(today) > 30 ? st.danger : st.warning),
              ),
              action: o.noPaymentReceived
                  ? _action(
                      context,
                      done: o.chargedBy,
                      doneText: 'LPC posted',
                      open: store.openTaskForStatement(o.statementNo),
                      onCreate: () => _startTask(ref, AdjKind.lpc, o.statementNo),
                      store: store,
                    )
                  : Text('Partly paid, no LPC', style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
            ),
        ],
      ),
    );
  }
}

/// Customer credit register: current limits and utilisation, with
/// Request credit adjustment (or View task while one is open).
class AdjCreditRegister extends ConsumerWidget {
  const AdjCreditRegister({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final st = context.dbStatus;
    final store = ref.watch(adjStoreProvider);
    final rows = [...store.creditProfiles]..sort((a, b) => b.utilisationPct.compareTo(a.utilisationPct));

    return AdjCard(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
      child: AdjSection(
        title: 'Customer credit limits',
        children: [
          if (rows.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text('No customers in the credit register.', style: TextStyle(color: cs.onSurfaceVariant)),
            ),
          for (final p in rows)
            () {
              final u = p.utilisationPct;
              final open = store.openTaskForCreditAccount(p.accountNumber);
              final last = p.adjustedBy == null ? null : store.find(p.adjustedBy!);
              final until = last?.endDate == null ? '' : ' (temporary until ${adjDate(last!.endDate!)})';
              final lastText = last == null ? '' : ' Last changed by ${last.referenceCode}$until.';
              final lateText = p.latePayments12m == 1 ? 'payment' : 'payments';
              return _RegisterRow(
                title: '${p.customerName} (${p.accountNumber})',
                detail: 'Credit limit ${adjRM(p.creditLimit)}, balance ${adjRM(p.balance)}. '
                    '${p.latePayments12m} late $lateText in 12 months.$lastText',
                badge: AdjPill(
                  text: '${u.toStringAsFixed(0)}% used',
                  color: u > 90 ? st.danger : (u > 70 ? st.warning : st.success),
                ),
                action: open != null
                    ? OutlinedButton(
                        onPressed: () => adjGoDetail(open),
                        child: Text('View task ${open.referenceCode}'),
                      )
                    : FilledButton.icon(
                        onPressed: () {
                          ref.read(adjCreditPrefillProvider.notifier).state = AdjCreditPrefill(
                            accountNumber: p.accountNumber,
                            customerName: p.customerName,
                            currentLimit: p.creditLimit,
                          );
                          adjGoNew(AdjKind.creditAdjustment);
                        },
                        icon: const Icon(Icons.add_task, size: 18),
                        label: const Text('Request credit adjustment'),
                      ),
              );
            }(),
        ],
      ),
    );
  }
}

/// Create task, View task, or a "done" link to the completed task.
Widget _action(
  BuildContext context, {
  required String? done,
  required String doneText,
  required AdjRequest? open,
  required VoidCallback onCreate,
  required AdjState store,
}) {
  if (done != null) {
    final r = store.find(done);
    return TextButton.icon(
      onPressed: r == null ? null : () => adjGoDetail(r),
      icon: Icon(Icons.check_circle_outline, size: 18, color: context.dbStatus.success),
      label: Text(doneText),
    );
  }
  if (open != null) {
    return OutlinedButton(
      onPressed: () => adjGoDetail(open),
      child: Text('View task ${open.referenceCode}'),
    );
  }
  return FilledButton.icon(
    onPressed: onCreate,
    icon: const Icon(Icons.add_task, size: 18),
    label: const Text('Create approval task'),
  );
}

class _RegisterRow extends StatelessWidget {
  const _RegisterRow({required this.title, required this.detail, required this.badge, required this.action});

  final String title;
  final String detail;
  final Widget badge;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
        const SizedBox(height: 2),
        Text(detail, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
        const SizedBox(height: 6),
        badge,
      ],
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: cs.outlineVariant))),
      child: LayoutBuilder(builder: (context, c) {
        if (c.maxWidth < 620) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            text,
            const SizedBox(height: 10),
            action,
          ]);
        }
        return Row(children: [
          Expanded(child: text),
          const SizedBox(width: DiboldTheme.actionSpacing),
          action,
        ]);
      }),
    );
  }
}
