import 'adj_models.dart';

/// CSV for bulk payment lines. Columns, in order:
///   payee, bank, account, amount, reference
/// The first row is a header and is skipped if it doesn't hold an amount.
const adjCsvHeader = 'payee,bank,account,amount,reference';

const adjCsvTemplate = '$adjCsvHeader\n'
    'Stesen Contoh Sdn Bhd,Maybank,514012345678,1250.00,INV-0001\n'
    'Syarikat Contoh Enterprise,CIMB Bank,8007654321,980.50,INV-0002\n';

class AdjCsvResult {
  AdjCsvResult(this.lines, this.errors);
  final List<AdjPaymentLine> lines;

  /// One message per row that couldn't be read, e.g. "Row 4: amount ...".
  final List<String> errors;
}

String _quote(String v) =>
    v.contains(RegExp(r'[",\n\r]')) ? '"${v.replaceAll('"', '""')}"' : v;

String adjLinesToCsv(List<AdjPaymentLine> lines) {
  final b = StringBuffer('$adjCsvHeader\n');
  for (final l in lines) {
    b.writeln([
      _quote(l.payeeName),
      _quote(l.bankName),
      _quote(l.accountNumber),
      l.amount.toStringAsFixed(2),
      _quote(l.reference),
    ].join(','));
  }
  return b.toString();
}

/// Reads payment lines from CSV text. Rows with problems are reported in
/// [AdjCsvResult.errors] and left out; blank rows are ignored.
AdjCsvResult adjParseCsv(String text) {
  final rows = _rows(text.startsWith('﻿') ? text.substring(1) : text);
  final lines = <AdjPaymentLine>[];
  final errors = <String>[];
  for (var i = 0; i < rows.length; i++) {
    final row = rows[i];
    if (row.every((c) => c.trim().isEmpty)) continue;
    final rowNo = i + 1;
    final amountText = row.length > 3 ? row[3].replaceAll(',', '').trim() : '';
    final amount = double.tryParse(amountText.replaceAll('RM', '').trim());
    if (i == 0 && amount == null) continue; // header row
    if (row.length < 4) {
      errors.add('Row $rowNo: expected payee, bank, account and amount.');
      continue;
    }
    final account = row[2].replaceAll(RegExp(r'[\s-]'), '');
    final line = AdjPaymentLine(
      payeeName: row[0].trim(),
      bankName: row[1].trim(),
      accountNumber: account,
      amount: amount == null ? 0 : (amount * 100).roundToDouble() / 100,
      reference: row.length > 4 ? row[4].trim() : '',
    );
    if (line.payeeName.isEmpty) {
      errors.add('Row $rowNo: payee name is missing.');
    } else if (line.bankName.isEmpty) {
      errors.add('Row $rowNo: bank is missing.');
    } else if (!RegExp(r'^\d{6,20}$').hasMatch(account)) {
      errors.add('Row $rowNo: account number must be 6 to 20 digits.');
    } else if (amount == null || line.amount <= 0) {
      errors.add('Row $rowNo: amount must be a number greater than zero.');
    } else {
      lines.add(line);
    }
  }
  return AdjCsvResult(lines, errors);
}

/// Splits CSV into rows of fields, handling quotes and "" escapes.
List<List<String>> _rows(String text) {
  final rows = <List<String>>[];
  var row = <String>[];
  final field = StringBuffer();
  var quoted = false;
  for (var i = 0; i < text.length; i++) {
    final c = text[i];
    if (quoted) {
      if (c == '"') {
        if (i + 1 < text.length && text[i + 1] == '"') {
          field.write('"');
          i++;
        } else {
          quoted = false;
        }
      } else {
        field.write(c);
      }
    } else if (c == '"') {
      quoted = true;
    } else if (c == ',') {
      row.add(field.toString());
      field.clear();
    } else if (c == '\n' || c == '\r') {
      if (c == '\r' && i + 1 < text.length && text[i + 1] == '\n') i++;
      row.add(field.toString());
      field.clear();
      rows.add(row);
      row = <String>[];
    } else {
      field.write(c);
    }
  }
  if (field.isNotEmpty || row.isNotEmpty) {
    row.add(field.toString());
    rows.add(row);
  }
  return rows;
}
