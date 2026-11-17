import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

import '../adj_csv.dart';
import '../adj_files.dart';
import '../adj_models.dart';
import 'adj_common.dart';

/// Read-only list of bulk payment payees with a total and CSV export.
class AdjPaymentLinesTable extends StatelessWidget {
  const AdjPaymentLinesTable({super.key, required this.lines, required this.total, this.fileName});

  final List<AdjPaymentLine> lines;
  final double total;

  /// Name for the exported CSV; defaults to "payment-lines.csv".
  final String? fileName;

  static const _wide = 760.0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final wide = MediaQuery.sizeOf(context).width >= _wide;
    final head = TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: cs.onSurfaceVariant);
    final cell = TextStyle(color: cs.onSurface);

    Widget row(List<Widget> cells, {Color? color, bool divider = true}) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: color,
            border: divider ? Border(bottom: BorderSide(color: cs.outlineVariant)) : null,
          ),
          child: Row(children: cells),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(DiboldTheme.radiusSm),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: [
            if (wide)
              row([
                SizedBox(width: 36, child: Text('#', style: head)),
                Expanded(flex: 4, child: Text('Payee', style: head)),
                Expanded(flex: 2, child: Text('Bank', style: head)),
                Expanded(flex: 3, child: Text('Account', style: head)),
                Expanded(flex: 2, child: Text('Reference', style: head)),
                Expanded(flex: 2, child: Text('Amount', style: head, textAlign: TextAlign.right)),
              ], color: cs.surfaceContainerLow),
            for (var i = 0; i < lines.length; i++)
              wide
                  ? row([
                      SizedBox(width: 36, child: Text('${i + 1}', style: TextStyle(color: cs.onSurfaceVariant))),
                      Expanded(flex: 4, child: Text(lines[i].payeeName, style: cell)),
                      Expanded(flex: 2, child: Text(lines[i].bankName, style: cell)),
                      Expanded(flex: 3, child: SelectableText(lines[i].accountNumber, style: cell)),
                      Expanded(
                          flex: 2,
                          child: Text(lines[i].reference.isEmpty ? '-' : lines[i].reference, style: cell)),
                      Expanded(
                          flex: 2,
                          child: Text(adjRM(lines[i].amount), textAlign: TextAlign.right, style: cell)),
                    ])
                  : row([
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('${i + 1}. ${lines[i].payeeName}',
                              style: cell.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 2),
                          Text(
                            '${lines[i].bankName}, ${lines[i].accountNumber}'
                            '${lines[i].reference.isEmpty ? '' : ', ${lines[i].reference}'}',
                            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                          ),
                        ]),
                      ),
                      Text(adjRM(lines[i].amount), style: cell),
                    ]),
            row([
              Expanded(
                child: Text('Total, ${lines.length} ${lines.length == 1 ? 'payee' : 'payees'}',
                    style: cell.copyWith(fontWeight: FontWeight.w700)),
              ),
              Text(adjRM(total), style: cell.copyWith(fontWeight: FontWeight.w700)),
            ], color: cs.surfaceContainerLow, divider: false),
          ]),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton.icon(
            onPressed: () => adjSaveText(fileName ?? 'payment-lines.csv', adjLinesToCsv(lines)),
            icon: const Icon(Icons.download, size: 18),
            label: const Text('Export as CSV'),
          ),
        ),
      ],
    );
  }
}
