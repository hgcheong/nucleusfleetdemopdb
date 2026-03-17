import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_acxlangkeyval.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/dialogs.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'package:nucleusv2/src/utils/uiplutogridhelpers.dart';
import 'package:trina_grid/trina_grid.dart';

class AcxTrinaGridExtData extends HookConsumerWidget {
  const AcxTrinaGridExtData({
    super.key,
    this.showCheckBox = false,
    this.showActions = false,
    this.isMultiSelect = false,
    this.useCheckBox = false,
    this.showBorder = true,
    this.useNav = true,
    this.idField = '',
    this.navPrefix = '',
    this.gridLabel = '',
    required this.spName,
    this.onSelectedTap,
    this.onChecked,
    this.onCheckedAll,
    this.onNew,
    this.onRefresh,
    this.onDelete,
    required this.extData,
  });
  final bool showCheckBox;
  final bool showActions;
  final bool isMultiSelect;
  final bool useNav;
  final bool useCheckBox;
  final bool showBorder;
  final String idField;
  final String navPrefix;
  final String gridLabel;
  final String spName;
  final Function? onSelectedTap;
  final Function? onNew;
  final Function? onChecked;
  final Function? onCheckedAll;
  final Returndata extData;
  final Function? onRefresh;
  final Function? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRow = useState<TrinaRow>(TrinaRow(cells: {}));
    void onFocus(TrinaRow row) {
      currentRow.value = row;
    }

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
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  onRefresh == null
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            onRefresh!();
                          },
                          icon: const Icon(Icons.refresh)),
                  onNew == null
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            onNew!();
                          },
                          icon: const Icon(Icons.add)),
                  onDelete == null
                      ? Container()
                      : IconButton(
                          onPressed: () async {
                            try {
                              if(currentRow.value.data == null){
                                Toast.message('No row selected');
                                return;
                              }

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
                              onDelete!(currentRow);
                            } catch (e) {
                              Toast.message('Error Loading');
                            } finally {}
                          },
                          icon: const Icon(Icons.delete)),
                  sbw10
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 250,
                child: buildDataTableExtUniqueKey(extData,
                    getGridConfig(context), idField, navPrefix, keyinfo, useNav,
                    useCheckBox: useCheckBox,
                    onChecked: onChecked,
                    onCheckAll: onCheckedAll,
                    onSelected: onSelectedTap,
                    onFocus: onFocus),
              )
            ],
          );
        },
        error: (err, m) => Center(child: Text(err.toString()),),
        loading: () => const Center(child: SizedBox()));
  }
}
