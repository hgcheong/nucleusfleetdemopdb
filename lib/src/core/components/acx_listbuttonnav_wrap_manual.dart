import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/dialogs.dart';
import 'package:nucleusv2/src/core/components/acx_nav_tile.dart';

//With external query object so that I can refresh it
class AcxListButtonNavWrapManual extends ConsumerWidget {
  const AcxListButtonNavWrapManual(
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(ReturndatafreezedProvider(query));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AsyncValueWidget<Returndata>(
        value: value,
        data: (Returndata returnData) {
          if (returnData.data == null || returnData.data![0][keyField] == null) {
            return AcxNavEmpty(onAdd: addNew == null ? null : () => addNew!());
          }
          final toAdd = <Widget>[];
          for (final item in returnData.data!) {
            final dynamic row = item;
            if (filterField != null && filterValue != null && row[filterField] != filterValue) continue;
            toAdd.add(AcxNavTile(
              width: 250,
              height: 150,
              lines: [for (final f in displayfield) row[f]?.toString()],
              selected: selectedKey != null && row[keyField]?.toString() == selectedKey,
              onEdit: () => returnSelectedRef(row),
              // Only saved contacts can be deleted.
              onDelete: row["ContactId"] == null || deleteSelectedRef == null
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
          return SingleChildScrollView(child: AcxNavWrapLayout(children: toAdd));
        },
      ),
    );
  }
}
