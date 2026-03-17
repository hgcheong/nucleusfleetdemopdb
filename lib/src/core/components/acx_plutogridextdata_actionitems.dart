import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_acxlangkeyval.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/uiplutogridhelpers.dart';

class AcxTrinaGridExtDataActionItems extends ConsumerWidget {
  const AcxTrinaGridExtDataActionItems({
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
    this.onPopUp,
    this.popMenuItems,
    this.popupIcon = const Icon(Icons.more_vert),
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
  final Function? onPopUp;
  final List<Map<String, dynamic>>? popMenuItems;
  final Icon popupIcon;

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
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                  sbw10
                ],
              ),
              SizedBox(
                height: 1280,
                child: buildDataTableExtActionItems(extData, getGridConfig(context),
                    idField, navPrefix, keyinfo, useNav,
                    useCheckBox: useCheckBox,
                    onChecked: onChecked,
                    onCheckAll: onCheckedAll,
                    onSelected: onSelectedTap,
                    onPopUp: onPopUp,
                    popMenuItems: popMenuItems,
                    popUpIcon: popupIcon),
              )
        
            ],
          );
        },
        error: (err, m) => Center(child: Text(err.toString()),),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
