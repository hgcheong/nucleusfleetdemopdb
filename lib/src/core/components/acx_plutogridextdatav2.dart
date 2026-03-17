import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/utils/uihelpers.dart';
import 'package:nucleusv2/src/utils/uiplutogridhelpers.dart';

class AcxTrinaGridExtv2 extends ConsumerWidget {
  const AcxTrinaGridExtv2(
      {super.key,
      required this.extData,
      required this.idField,
      this.onNew,
      this.onDelete,
      this.onRefresh,
      this.onSelected,
      this.appButtons,
      this.iconButtons,
      this.gridTitle = '',
      this.useCheckBox = false,
      this.exportTitle = 'Report'});

  final bool? useCheckBox;
  final Returndata extData;
  final String idField;
  final String exportTitle;
  final String gridTitle;
  final Function? onNew;
  final Function? onDelete;
  final Function? onRefresh;
  final Function? onSelected;
  final List<AppButtonWithFunction>? appButtons;
  final List<IconWithFunction>? iconButtons;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: buildDataTableExtV2(extData, getGridConfig(context), idField,
          List<Langkeypair>.empty(), 
          onSelected: onSelected,
          gridTitle: gridTitle,
          appButtons: appButtons,
          iconButtons: iconButtons,
          onNew: onNew,
          onRefresh: onRefresh,
          onDelete: onDelete,
          useCheckBox: useCheckBox??useCheckBox!,
          exportTitle: exportTitle),
    );
  }
}

