import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:nucleusv2/src/core/components/acx_nav_tile.dart';

class AcxListButtonNavWrapExt extends HookConsumerWidget {
  const AcxListButtonNavWrapExt({
    super.key,
    required this.returnSelectedRef,
    required this.displayfield,
    required this.keyField,
    this.filterField,
    this.filterValue,
    this.deleteSelectedRef,
    this.addNew,
    this.selectedKey,
    this.editIcon = Icons.edit,
    required this.returnData,
  });
  final List<String> displayfield;
  final Function returnSelectedRef;
  final String keyField;
  final String? filterField;
  final String? filterValue;
  final String? selectedKey;
  final Function? deleteSelectedRef;
  final Function? addNew;
  final IconData editIcon;
  final Returndata returnData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: getWidgetNavWrap(),
    );
  }

  bool _passesFilter(Map<String, dynamic> row) {
    if (filterField == null) return true;
    if (filterValue == "!null") return row[filterField] != null;
    return row[filterField] == filterValue;
  }

  Widget getWidgetNavWrap() {
    if (returnData.data == null) {
      return const AcxNavEmpty(message: 'No data');
    }
    if (returnData.data![0][keyField] == null) {
      return AcxNavEmpty(onAdd: addNew == null ? null : () => addNew!());
    }
    final toAdd = <Widget>[];
    for (final item in returnData.data!) {
      final dynamic row = item;
      if (!_passesFilter(row)) continue;
      toAdd.add(AcxNavTile(
        width: 250,
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
      toAdd.add(AcxNavAddTile(width: 250, height: 150, onTap: () => addNew!()));
    }
    return AcxNavWrapLayout(children: toAdd);
  }
}
