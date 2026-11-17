import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/core/components/acx_nav_tile.dart';

class AcxListButtonNavWrapSelect extends HookConsumerWidget {
  const AcxListButtonNavWrapSelect({
    super.key,
    required this.querysql,
    required this.params,
    required this.returnSelectedRef,
    required this.displayfield,
    required this.keyField,
    required this.toWatch,
    this.filterField,
    this.filterValue,
    this.deleteSelectedRef,
    this.addNew,
    this.selectedKey,
  });
  final String querysql;
  final List<String> displayfield;
  final Map<String, dynamic> params;
  final Function returnSelectedRef;
  final String keyField;
  final String? filterField;
  final String? filterValue;
  final String? selectedKey;
  final Function? deleteSelectedRef;
  final Function? addNew;
  final StateProvider<Map<String, dynamic>> toWatch;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProgram = ref.watch(toWatch);
    final value = ref.watch(ReturndataProvider(querysql: querysql, params: params, showMsg: false));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AsyncValueWidget<Returndata>(
        value: value,
        data: (Returndata returnData) {
          if (returnData.data == null) {
            return const AcxNavEmpty(message: 'No data');
          }
          final toAdd = <Widget>[];
          for (final item in returnData.data!) {
            final dynamic row = item;
            if (filterField != null && filterValue != null && row[filterField] != filterValue) continue;
            // The selected program is the one held in [toWatch].
            final selected = row['PrgEttyId'].toString() == selectedProgram['PrgEttyId'].toString();
            toAdd.add(AcxNavTile(
              width: 230,
              height: 124,
              lines: [for (final f in displayfield) row[f]?.toString()],
              selected: selected,
              editIcon: Icons.water_drop,
              editTooltip: selected ? 'Selected' : 'Select',
              onEdit: () => returnSelectedRef(row),
              onDelete: deleteSelectedRef == null ? null : () => deleteSelectedRef!(row),
            ));
          }
          if (addNew != null) {
            toAdd.add(AcxNavAddTile(width: 230, height: 124, onTap: () => addNew!()));
          }
          return AcxNavWrapLayout(children: toAdd);
        },
      ),
    );
  }
}
