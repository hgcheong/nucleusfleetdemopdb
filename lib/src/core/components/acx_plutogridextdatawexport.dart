import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/utils/uihelpers.dart';
import 'package:nucleusv2/src/utils/uiplutogridhelpers.dart';

class AcxTrinaGridExtDatawExport extends ConsumerWidget {
  const AcxTrinaGridExtDatawExport(
      {super.key,
      required this.extData,
      required this.idField,
      this.onNew,
      this.onDelete,
      this.onRefresh,
      this.onSelected,
      this.appButtons,
      this.gridTitle = '',
      this.exportTitle = "Report"});

  final Returndata extData;
  final String idField;
  final String exportTitle;
  final String gridTitle;
  final Function? onNew;
  final Function? onDelete;
  final Function? onRefresh;
  final Function? onSelected;
 final List<AppButtonWithFunction>? appButtons;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(extData.data ==null){
          return const Center(child:Text('No Data'));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: buildDataTableExtwExport(extData, getGridConfig(context), idField,
          '', List<Langkeypair>.empty(), false,
          onSelected: onSelected,
      
          gridTitle: gridTitle,
          appButtons: appButtons,
          exportTitle: exportTitle),
    );
  }
}
