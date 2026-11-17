import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_action_spacing.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';
import 'package:nucleusv2/src/utils/toast.dart';

import '../adj_models.dart';
import '../adj_nav.dart';
import '../adj_seed.dart';
import '../adj_store.dart';
import 'adj_common.dart';

/// "Request for approval" for Data Entry transaction screens.
///
/// Put it in the screen's action column (next to Save, Back to list and
/// Audit log). It reads the form, lets the user add a reason and confirm the
/// approvers, and creates a task in Task Approval > Data Entry Approval.
/// While that task is open the button opens it instead.
///
///     AdjRequestApprovalBtn(
///       formKey: dataEntryManualFormKey,
///       screen: 'Adjustment',
///       txnType: txnType,
///       txnId: txnId,
///       path: '/dataentry/manual/$txnType/adjust/$txnId',
///       fields: const {'AcctId': 'Account', 'TxnAmt': 'Transaction Amount'},
///     )
class AdjRequestApprovalBtn extends ConsumerWidget {
  const AdjRequestApprovalBtn({
    super.key,
    required this.formKey,
    required this.screen,
    required this.txnType,
    required this.txnId,
    required this.path,
    required this.fields,
    this.amountField = 'TxnAmt',
    this.accountField = 'AcctId',
  });

  final GlobalKey<FormBuilderState> formKey;

  /// Screen name shown on the task, e.g. "Adjustment".
  final String screen;
  final String? txnType;

  /// Null or "new" until the transaction is saved.
  final String? txnId;

  /// Path that opens this transaction, for the link back from the task.
  final String path;

  /// Form field name to label, in display order.
  final Map<String, String> fields;
  final String amountField;
  final String accountField;

  bool get _saved => txnId != null && txnId!.isNotEmpty && txnId != 'new' && txnId != 'null';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adjStoreProvider);
    final open = _saved ? store.openTaskForTransaction(txnType ?? '', txnId!) : null;

    return AcxActionSpacing(
      child: Tooltip(
        message: open != null
            ? 'View approval task ${open.referenceCode} (${open.stage.label})'
            : (_saved ? 'Request for approval' : 'Save the transaction first, then request approval'),
        child: ElevatedButton(
          child: SizedBox(
            width: 30,
            child: Icon(open != null ? Icons.pending_actions : Icons.approval_outlined),
          ),
          onPressed: () {
            if (open != null) {
              adjGoDetail(open);
            } else if (!_saved) {
              Toast.message('Save the transaction first, then request approval.');
            } else {
              _request(context);
            }
          },
        ),
      ),
    );
  }

  void _request(BuildContext context) {
    final form = formKey.currentState;
    if (form == null) {
      Toast.error('The form is not ready yet.');
      return;
    }
    form.save();
    final values = form.value;
    final snapshot = <(String, String)>[
      for (final e in fields.entries) (e.value, _display(values[e.key])),
    ];
    final amount = _number(values[amountField]) ?? 0;
    final account = values[accountField];
    showDialog<void>(
      context: context,
      builder: (_) => _RequestDialog(
        source: AdjSourceRecord(
          screen: screen,
          txnType: txnType ?? '',
          txnId: txnId!,
          path: path,
          fields: snapshot,
        ),
        amount: amount,
        account: account == null ? '' : _display(account),
      ),
    );
  }

  static double? _number(Object? v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString().replaceAll(',', '').trim());
  }

  static String _display(Object? v) {
    if (v == null) return '-';
    if (v is DateTime) {
      return (v.hour == 0 && v.minute == 0) ? adjDate(v) : adjDateTime(v);
    }
    final s = v.toString().trim();
    return s.isEmpty || s == 'null' ? '-' : s;
  }
}

class _RequestDialog extends ConsumerStatefulWidget {
  const _RequestDialog({required this.source, required this.amount, required this.account});

  final AdjSourceRecord source;
  final double amount;
  final String account;

  @override
  ConsumerState<_RequestDialog> createState() => _RequestDialogState();
}

class _RequestDialogState extends ConsumerState<_RequestDialog> {
  final _formKey = GlobalKey<FormState>();
  final _reason = TextEditingController();
  late Map<AdjRole, String?> _approvers;
  String _businessLine = adjBusinessLines.first;

  @override
  void initState() {
    super.initState();
    final store = ref.read(adjStoreProvider);
    _approvers = Map.of(store.defaultRouteFor(store.currentUserEmail));
  }

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  void _send() {
    if (!_formKey.currentState!.validate()) return;
    try {
      final r = ref.read(adjStoreProvider.notifier).submit(
            kind: AdjKind.dataEntry,
            businessLine: _businessLine,
            adjustmentType: widget.source.screen,
            totalAmount: widget.amount,
            accountNumber: widget.account == '-' ? '' : widget.account,
            reason: _reason.text,
            approvers: _approvers,
            source: widget.source,
          );
      Navigator.pop(context);
      Toast.success('Sent for approval as ${r.referenceCode}. You can follow it in Task Approval.');
    } on AdjError catch (e) {
      Toast.error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final store = ref.watch(adjStoreProvider);
    final me = store.currentUser;
    final src = widget.source;

    return AlertDialog(
      title: Text('Request approval: ${src.screen} transaction ${src.txnId}'),
      content: SizedBox(
        width: 560,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'This sends a copy of the transaction details to Task Approval. '
                  'Requested by ${me.name}.',
                  style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: cs.outlineVariant),
                    borderRadius: BorderRadius.circular(DiboldTheme.radiusSm),
                  ),
                  child: Column(children: [
                    for (final f in src.fields) AdjDetailRow(label: f.$1, value: f.$2),
                  ]),
                ),
                AdjField(child: DropdownButtonFormField<String>(
                  // ignore: deprecated_member_use
                  value: _businessLine,
                  decoration: const InputDecoration(labelText: 'Business line'),
                  items: [for (final b in adjBusinessLines) DropdownMenuItem(value: b, child: Text(b))],
                  onChanged: (v) => setState(() => _businessLine = v ?? _businessLine),
                )),
                AdjField(child: TextFormField(
                  controller: _reason,
                  autofocus: true,
                  minLines: 3,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Reason for approval',
                    alignLabelWithHint: true,
                    helperText: 'Why this transaction needs approval.',
                  ),
                  validator: (v) =>
                      (v ?? '').trim().length < 10 ? 'Give a reason of at least 10 characters.' : null,
                )),
                const SizedBox(height: 8),
                Text('Approvers', style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                const SizedBox(height: 8),
                for (final role in AdjRole.levels) ...[
                  AdjField(child: DropdownButtonFormField<String>(
                    key: ValueKey('${role.name}-${me.email}'),
                    // ignore: deprecated_member_use
                    value: store.usersWithRole(role).any((u) => u.email == _approvers[role] && u.email != me.email)
                        ? _approvers[role]
                        : null,
                    isExpanded: true,
                    decoration: InputDecoration(labelText: role.levelTitle, isDense: true),
                    items: [
                      for (final u in store.usersWithRole(role))
                        if (u.email != me.email) DropdownMenuItem(value: u.email, child: Text(u.name)),
                    ],
                    onChanged: (v) => setState(() => _approvers[role] = v),
                    validator: (v) => v == null ? 'Choose a ${role.label.toLowerCase()}.' : null,
                  )),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton.icon(
          onPressed: _send,
          icon: const Icon(Icons.send, size: 18),
          label: const Text('Send for approval'),
        ),
      ],
    );
  }
}
