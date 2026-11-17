import 'dart:math';

/// Random sample values for demo data: adjustment amount, account, reason
/// text and reference codes. All text here is made up for the demo.

final _rng = Random();

/// Adjustment types that have sample text (the New request dropdown uses
/// `adjAdjustmentTypes` in adj_seed.dart, which lists the same types).
List<String> get adjSampleAdjustmentTypes => _reasons.keys.toList();

/// Random adjustment, ready to put into a request or the New request form.
typedef AdjSampleAdjustment = ({String type, double amount, String account, String reason});

String _two(int n) => n.toString().padLeft(2, '0');

String _digits(int n) => List.generate(n, (_) => _rng.nextInt(10)).join();

const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

String _day(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

String _money(double v) {
  final fixed = v.toStringAsFixed(2);
  final whole = fixed.split('.').first;
  final grouped = whole.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
  return 'RM $grouped.${fixed.split('.').last}';
}

/// Reference code: prefix + yyMMddHHmm + 6 random digits (same format the
/// store uses for new requests).
String adjRandomReference(String prefix, DateTime t) =>
    '$prefix${_two(t.year % 100)}${_two(t.month)}${_two(t.day)}${_two(t.hour)}${_two(t.minute)}${_digits(6)}';

/// Random 8-digit account number in the demo range.
String adjRandomAccount() => '607${_digits(5)}';

/// Reason templates per adjustment type. Placeholders: {amt} amount,
/// {acct} account, {date} date of the original posting, {txn} transaction id.
const _reasons = <String, List<String>>{
  'Credit Misc Transfer Adjust': [
    'A fuel purchase of {amt} on {date} was posted twice to account {acct} after the terminal '
        'lost connection during settlement. The terminal log shows one completed sale, so the '
        'second posting is being credited back.',
    'The customer topped up {amt} at the counter on {date}, but the reload went to a closed '
        'sub-account. Moving the balance to active account {acct}; the counter receipt is attached.',
    'The quarterly rebate of {amt} was not credited to account {acct} because the account was on '
        'hold when the batch ran on {date}. Crediting it manually now that the hold is lifted.',
    'A balance of {amt} stayed on the old card after a card replacement on {date}. Transferring '
        'it to account {acct} so the customer can use it on the new card.',
  ],
  'Debit Misc Transfer Adjust': [
    'A promotional credit of {amt} was given to account {acct} on {date} by mistake; the customer '
        'did not meet the campaign criteria. Debiting it back as agreed with the account manager.',
    'A refund of {amt} was paid by bank transfer on {date}, but the prepaid balance on account '
        '{acct} was not reduced. Debiting the balance so it matches the refund.',
    'The settlement batch on {date} credited {amt} to account {acct} instead of the intended '
        'dealer account. Debiting it here; the matching credit is raised separately.',
  ],
  'Reload Reversal': [
    'A reload of {amt} on {date} (transaction {txn}) was keyed against account {acct} instead of '
        "the customer's own account. Reversing it so it can be posted to the right account.",
    'A reload of {amt} was posted on {date}, but the bank later returned the payment as '
        'unsuccessful. Reversing the reload on account {acct}; the bank return notice is attached.',
    'The customer cancelled a reload of {amt} on {date} before using it and asked for a refund. '
        'Reversing transaction {txn} on account {acct}.',
  ],
  'Fee Waiver': [
    'A card replacement fee of {amt} was charged to account {acct} on {date} for a card that was '
        'faulty when issued. Waiving the fee under the product terms.',
    'A late payment fee of {amt} was charged to account {acct} on {date} although the payment '
        'reached the bank before the due date. Waiving it; the bank statement is attached.',
    'A statement fee of {amt} was charged to account {acct} on {date} for a statement the '
        'customer could not download during a portal outage.',
  ],
  'Duplicate Transaction Reversal': [
    'Transaction {txn} for {amt} on {date} appears twice on account {acct}; the second copy was '
        'created when the batch file was reloaded. Reversing the duplicate.',
    'The same fuel sale of {amt} was settled on {date} by two terminals at one station. Account '
        '{acct} should be charged once, so the second sale is reversed.',
  ],
  'Fuel Price Correction': [
    'Sales on {date} were priced with the previous week\'s pump price for several hours. Account '
        '{acct} was overcharged {amt} in total; crediting the difference.',
    'A station price update was late on {date}, so fuel bought on account {acct} was charged '
        '{amt} more than the gazetted price. Refunding the difference to the balance.',
  ],
  'Rebate Adjustment': [
    'The volume rebate for account {acct} was calculated on the wrong tier in the run on {date}. '
        'The correct rebate is {amt} higher; crediting the difference.',
    'Fleet cards added to account {acct} mid-month were left out of the rebate run on {date}. '
        'Crediting the missing rebate of {amt}.',
  ],
  'Card Balance Transfer': [
    'The customer is closing one card and keeping account {acct}. Moving the remaining {amt} '
        'balance across, as requested in the letter dated {date}.',
    'Two fleet cards were merged on {date}. Transferring the {amt} balance from the retired card '
        'to account {acct}.',
  ],
  'LPC Reversal': [
    'Late payment charge of {amt} was posted to account {acct} on {date}, but the customer had an '
        'approved payment arrangement. Reversing the charge.',
    'Payment for account {acct} was received on time but posted late because of a bank holiday; '
        'the {amt} late charge on {date} is reversed.',
  ],
  'Chargeback Adjustment': [
    'The customer disputed transaction {txn} for {amt} on {date}; the station confirmed the sale '
        'was not completed. Crediting account {acct}.',
    'A card used without authorisation on {date} for {amt} was reported the same day. Investigation '
        'closed in the customer\'s favour; crediting account {acct}.',
  ],
  'Small Balance Write-off': [
    'Account {acct} was closed on {date} with a small debit balance of {amt} left. Writing it off '
        'because collection costs would be more than the amount.',
    'A rounding difference of {amt} remained on account {acct} after the migration on {date}. '
        'Writing it off to clear the account.',
  ],
};

const _feeAmounts = [10.0, 15.0, 25.0, 35.0, 45.0, 50.0, 75.0];

double _amountFor(String type) {
  switch (type) {
    case 'Fee Waiver':
      return _feeAmounts[_rng.nextInt(_feeAmounts.length)];
    case 'Small Balance Write-off':
      return (100 + _rng.nextInt(9900)) / 100; // RM 1.00 to RM 99.99
    case 'LPC Reversal':
      return (2000 + _rng.nextInt(78000)) / 100; // RM 20.00 to RM 800.00
    case 'Reload Reversal':
      return (2 + _rng.nextInt(99)) * 50.0; // RM 100 to RM 5,000 in steps of 50
    default:
      return (15000 + _rng.nextInt(585000)) / 100; // RM 150.00 to RM 6,000.00
  }
}

/// Random adjustment of [type] (or a random type). [at] is the request date;
/// the original posting is dated 1 to 10 days before it.
AdjSampleAdjustment adjRandomAdjustment({String? type, DateTime? at}) {
  final types = _reasons.keys.toList();
  final t = (type != null && _reasons.containsKey(type)) ? type : types[_rng.nextInt(types.length)];
  final amount = _amountFor(t);
  final account = adjRandomAccount();
  final when = (at ?? DateTime.now()).subtract(Duration(days: 1 + _rng.nextInt(10)));
  final templates = _reasons[t]!;
  final reason = templates[_rng.nextInt(templates.length)]
      .replaceAll('{amt}', _money(amount))
      .replaceAll('{acct}', account)
      .replaceAll('{date}', _day(when))
      .replaceAll('{txn}', _digits(8));
  return (type: t, amount: amount, account: account, reason: reason);
}
