import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app/api_acxlangkeyval.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/dialogs.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'package:nucleusv2/src/utils/uiplutogridhelpers.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../utils/uihelpers.dart';

//class IconWithFunction {
//   IconWithFunction({required this.icon, required this.func});
//   final Icon icon;
//   final Function func;
// }

// class AppButtonWithFunction {
//   AppButtonWithFunction({required this.btn, required this.func});
//   final AppButton btn;
//   final Function func;
// }

class AcxTrinaGridExtDataCheckBox extends HookConsumerWidget {
  AcxTrinaGridExtDataCheckBox({
    super.key,
    this.isMultiSelect = true,
    this.idField = '',
    this.gridLabel = '',
    required this.spName,
    this.onSelectedTap,
    this.onNew,
    this.onDelete,
    this.onRefresh,
    this.onChecked,
    this.onCheckedAll,
    this.iconButtons,
    this.appButtons,
    this.checkIndicatorField,
    required this.extData,
  });
  final bool isMultiSelect;
  final String idField;
  final String gridLabel;
  final String spName;
  //we will check the items based on the below indicator, Y= checked
  final String? checkIndicatorField;
  final Function? onSelectedTap;
  final Function? onNew;
  final Function? onRefresh;
  final Function? onDelete;
  final Function? onChecked;
  final Function? onCheckedAll;
  final Returndata extData;
  final List<IconWithFunction>? iconButtons;
  final List<AppButtonWithFunction>? appButtons;
  final checkedItem = useState<Set<TrinaRow>>(<TrinaRow>{});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clmDefinition = ref.watch(returnLangKeyProvider(QueryObject(
        querysql: '/sp/ApiConstructLblName/queryasync',
        params: {
          "UserType": "I",
          "ObjName": spName,
          "ApplVer": null,
        },
        showMsg: false)));

    return clmDefinition.when(
        data: (keyinfo) {
          List<IconButton> toAdd = List.empty(growable: true);
          if (iconButtons != null) {
            if (iconButtons!.isNotEmpty) {
              for (var element in iconButtons!.toList()) {
                toAdd.add(IconButton(
                  
                  tooltip: element.tooltip,
                  onPressed: () {
                    element.func(checkedItem);
                  },
                  icon: element.icon,
                ));
              }
            }
          }
          List<AppButton> toAddAppButton = List.empty(growable: true);
          if (appButtons != null) {
            if (appButtons!.isNotEmpty) {
              for (var element in appButtons!.toList()) {
                toAddAppButton.add(AppButton(
                  tooltip: element.btn.tooltip,
                  icon: element.btn.icon,
                  label: element.btn.label,
                  onPressed: () {
                    element.func(checkedItem);
                  },
                ));
              }
            }
          }
          return Column(
            children: [
              Row(
                children: [
                  ...toAddAppButton,
                  ...toAdd,
                  Expanded(
                      child: Column(
                    children: [
                      gridLabel == ''
                          ? Container()
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Text(gridLabel)),
                    ],
                  )),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        onRefresh == null
                            ? Container()
                            : IconButton(
                                onPressed: () {
                                  onRefresh!();
                                },
                                icon: const Icon(Icons.refresh)),
                        onDelete == null
                            ? Container()
                            : IconButton(
                                onPressed: () async {
                                  bool confirmed = await ConfirmDialog.show(
                                    title: "Delete?",
                                    body: "Are you sure you want to Delete?",
                                    destructive: true,
                                    confirmText: "Yes",
                                    cancelText: "Cancel",
                                  );

                                  if (!confirmed) {
                                    return;
                                  }

                                  if (checkedItem.value.isNotEmpty) {
                                    if (isMultiSelect == false &&
                                        checkedItem.value.length > 1) {
                                      Toast.message(
                                          'You are not allowed to delete for multiple rows. Please checked 1 item only to delete');
                                      return;
                                    }
                                    onDelete!(checkedItem.value);
                                  } else {
                                    Toast.message(
                                        'Please select items to delete');
                                  }
                                },
                                icon: const Icon(Icons.delete)),
                        onNew == null
                            ? Container()
                            : IconButton(
                                onPressed: () {
                                  onNew!();
                                },
                                icon: const Icon(Icons.add)),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Card(
                    child: buildDataTableExtCheckBox(
                        extData,
                        getGridConfig(context),
                        checkedItem.value,
                        idField,
                        keyinfo,
                        onChecked: onChecked,
                        onCheckAll: onCheckedAll,
                        onSelected: onSelectedTap,
                        checkIndicatorField: checkIndicatorField)),
              ),
            ],
          );
        },
        error: (err, m) => Center(child: Text(err.toString()),),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
