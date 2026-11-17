import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:nucleusv2/src/core/components/acx_nav_tile.dart';

class AcxListButtonNavWrap extends HookConsumerWidget {
  const AcxListButtonNavWrap(
      {super.key,
      required this.querysql,
      required this.params,
      required this.returnSelectedRef,
      required this.displayfield,
      required this.keyField,
      this.filterField,
      this.filterValue,
      this.deleteSelectedRef,
      this.addNew,
      this.selectedKey,
      this.editIcon = Icons.edit});
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
  final IconData editIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = QueryObject(querysql: querysql, params: params, showMsg: false);
    final value = ref.watch(ReturndatafreezedProvider(query));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AsyncValueWidget<Returndata>(
        value: value,
        data: (Returndata returnData) {
          if (returnData.data == null) {
            return const AcxNavEmpty(message: 'No data');
          }
          if (returnData.data![0][keyField] == null) {
            return AcxNavEmpty(onAdd: addNew == null ? null : () => addNew!());
          }
          final toAdd = <Widget>[];
          for (final item in returnData.data!) {
            final dynamic row = item;
            if (filterField != null) {
              if (filterValue == "!null") {
                if (row[filterField] == null) continue;
              } else if (row[filterField] != filterValue) {
                continue;
              }
            }
            toAdd.add(AcxNavTile(
              width: 300,
              height: 150,
              lines: [for (final f in displayfield) row[f]?.toString()],
              selected: selectedKey != null && row[keyField]?.toString() == selectedKey,
              editIcon: editIcon,
              onEdit: () => returnSelectedRef(row),
              onDelete: deleteSelectedRef == null
                  ? null
                  : () async {
                      final confirmed = await ConfirmDialog.show(title: 'Are you Sure to delete the record?');
                      if (confirmed == true) deleteSelectedRef!(row);
                    },
            ));
          }
          if (addNew != null) {
            toAdd.add(AcxNavAddTile(width: 300, height: 150, onTap: () => addNew!()));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22, top: 8),
                child: IconButton(
                  tooltip: 'Refresh',
                  onPressed: () => ref.invalidate(ReturndatafreezedProvider(query)),
                  icon: const Icon(Icons.refresh),
                ),
              ),
              AcxNavWrapLayout(children: toAdd),
            ],
          );
        },
      ),
    );
  }
}
