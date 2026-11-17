import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_action_spacing.dart';
import 'package:nucleusv2/src/utils/toast.dart';

import '../adj_models.dart';
import '../adj_nav.dart';
import '../adj_store.dart';

/// "Request credit adjustment" for Customer Management screens.
///
/// Put it in the screen's action column (next to Save, Back to list and
/// Audit log). It opens Task Approval > New Credit Limit Adjustment with the
/// account filled in; the credit evaluation figures load from the credit
/// register when the account is in it. While a credit adjustment for the
/// account is open, the button opens that task instead.
///
///     AdjCreditRequestBtn(
///       accountNumber: formNewValue['AcctNo'],
///       customerName: formNewValue['BillingTo'],
///       currentLimit: formNewValue['CrLimit'],
///     )
class AdjCreditRequestBtn extends ConsumerWidget {
  const AdjCreditRequestBtn({
    super.key,
    required this.accountNumber,
    this.customerName,
    this.currentLimit,
  });

  /// Account number (any type; digits are kept).
  final Object? accountNumber;
  final Object? customerName;

  /// Current credit limit if the screen has it (number or text).
  final Object? currentLimit;

  String get _account => (accountNumber ?? '').toString().replaceAll(RegExp(r'[^0-9]'), '');

  static double? _number(Object? v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString().replaceAll(RegExp(r'[^0-9.\-]'), ''));
  }

  static String? _path() {
    try {
      return singleton<AppRouter>().currentPath;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adjStoreProvider);
    final account = _account;
    final open = account.isEmpty ? null : store.openTaskForCreditAccount(account);

    return AcxActionSpacing(
      child: Tooltip(
        message: open != null
            ? 'View credit adjustment ${open.referenceCode} (${open.stage.label})'
            : (account.isEmpty ? 'Save the account first' : 'Request credit adjustment'),
        child: ElevatedButton(
          child: SizedBox(
            width: 30,
            child: Icon(open != null ? Icons.pending_actions : Icons.credit_score_outlined),
          ),
          onPressed: () {
            if (open != null) {
              adjGoDetail(open);
            } else if (account.isEmpty) {
              Toast.message('Save the account first, then request a credit adjustment.');
            } else {
              final name = customerName?.toString().trim();
              ref.read(adjCreditPrefillProvider.notifier).state = AdjCreditPrefill(
                accountNumber: account,
                customerName: (name == null || name.isEmpty || name == 'null') ? null : name,
                currentLimit: _number(currentLimit),
                sourcePath: _path(),
              );
              adjGoNew(AdjKind.creditAdjustment);
            }
          },
        ),
      ),
    );
  }
}
