import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/dialogs.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:nucleusv2/src/core/components/acx_nav_tile.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

//With external query object so that I can refresh it
class AcxListButtonNavWrapManualDirector extends ConsumerWidget {
  const AcxListButtonNavWrapManualDirector(
      {super.key,
      required this.returnSelectedRef,
      required this.displayfield,
      required this.keyField,
      this.filterField,
      this.filterValue,
      this.deleteSelectedRef,
      this.addNew,
      this.selectedKey,
      required this.query});
  final List<String> displayfield;
  final Function returnSelectedRef;
  final String keyField;
  final String? filterField;
  final String? filterValue;
  final String? selectedKey;
  final Function? deleteSelectedRef;
  final Function? addNew;
  final QueryObject query;


        // {
        //     "DirectorshipDscp": "Director Only",
        //     "FullName": "Abdul Halim",
        //     "ShareHolding": 9.0000,
        //     "TtlShareHolding": 18.0000,
        //     "StsDscp": "ACTIVE",
        //     "Directorship": "2070",
        //     "Sts": "A",
        //     "EttyId": 318,
        //     "IndvdId": 198
        // }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(ReturndatafreezedProvider(query));
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    double pct(Object? v) => (((v as num?) ?? 0) / 100).clamp(0.0, 1.0).toDouble();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AsyncValueWidget<Returndata>(
        value: value,
        data: (Returndata returnData) {
          if (returnData.data == null || returnData.data![0][keyField] == null) {
            return AcxNavEmpty(onAdd: addNew == null ? null : () => addNew!());
          }
          final rows = returnData.data!;
          final toAdd = <Widget>[];
          for (final item in rows) {
            final dynamic row = item;
            if (filterField != null && filterValue != null && row[filterField] != filterValue) continue;
            toAdd.add(AcxNavTile(
              width: 320,
              height: 150,
              leading: CircularPercentIndicator(
                radius: 36.0,
                lineWidth: 6.0,
                percent: pct(row["ShareHolding"]),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: cs.surfaceContainerHighest,
                progressColor: cs.primary,
                center: Text(
                  '${row["ShareHolding"] ?? 0}%\nShare',
                  textAlign: TextAlign.center,
                  style: text.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: cs.onSurface),
                ),
              ),
              lines: [
                for (final f in displayfield)
                  if (f != 'ShareHolding') row[f]?.toString(),
              ],
              selected: selectedKey != null && row[keyField]?.toString() == selectedKey,
              onEdit: () => returnSelectedRef(row),
              onDelete: row["ContactId"] == null || deleteSelectedRef == null
                  ? null
                  : () async {
                      final confirmed = await ConfirmDialog.show(title: 'Are you Sure to delete the record?');
                      if (confirmed == true) deleteSelectedRef!(row);
                    },
            ));
          }
          if (addNew != null) {
            toAdd.add(AcxNavAddTile(width: 320, height: 150, onTap: () => addNew!()));
          }
          final total = rows[0]["TtlShareHolding"];
          return Column(
            children: [
              const SizedBox(height: 8),
              SelectableText(
                '${rows.length} ShareHolder/Director${rows.length > 1 ? 's' : ''} hold $total/100% of Company Shares',
                style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: cs.onSurface),
              ),
              const SizedBox(height: 8),
              LinearPercentIndicator(
                alignment: MainAxisAlignment.center,
                width: 260,
                animation: true,
                lineHeight: 12.0,
                animationDuration: 1500,
                percent: pct(total),
                barRadius: const Radius.circular(6),
                backgroundColor: cs.surfaceContainerHighest,
                progressColor: context.dbStatus.warning,
              ),
              SingleChildScrollView(child: AcxNavWrapLayout(children: toAdd)),
            ],
          );
        },
      ),
    );
  }
}
