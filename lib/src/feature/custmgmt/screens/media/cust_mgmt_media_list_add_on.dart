import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/media/cust_mgmt_media_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=324;

@RoutePage()
class CustMgmtMediaListAddOn extends StatelessWidget {
  const CustMgmtMediaListAddOn(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Center(
      child: CustMgmtMediaListGrid(custEttyId: custEttyId),
    );
  }
}

class CustMgmtMediaListGrid extends HookConsumerWidget {
  const CustMgmtMediaListGrid({
    super.key,
    this.custEttyId,
  });
  final String? custEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtMediaAddOnList/queryasync',
        params: {
          "CustEttyId": custEttyId,
        },
        showMsg: false));
    final listData = ref.watch(listQuery);
    return AsyncValueWidget<Returndata>(
        value: listData,
        data: (dv) {
          return AcxTrinaGridExtDataCheckBox(
          

               onRefresh: (){
              ref.invalidate(listQuery);
            },
            idField: 'MediaId',
            spName: 'ApiMgmtMediaAddOnList',
            extData: dv,
            isMultiSelect: true,
            onDelete: (Set<TrinaRow> rows) async {
                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
              bool confirmed = await ConfirmDialog.show(
                  title: 'Are you sure you want to delete the record?');
              if (confirmed) {
                var futures = <Future>[];
                for (var i = 0; i < rows.length; i++) {
                  final rowToDelete = rows.elementAt(i);
                  final queryDel = QueryObject(
                      querysql: '/sp/ApiMgmtMediaAddOnDel/queryasync',
                      params: {
                        "CustEttyId": custEttyId,
                        "PrgEttyId":
                            rowToDelete.cells["PrgEttyId"]!.value.toString(),
                        "MbrEttyId":
                            rowToDelete.cells['MbrEttyId']!.value.toString(),
                        "MediaId":
                            rowToDelete.cells['MediaId']!.value.toString(),
                      },
                      showMsg: false);
                  final resultDel =
                      ref.read(ReturndatafreezedProvider(queryDel).future);
                  futures.add(resultDel);
                }
                await Future.wait(futures).then((value) {
                  ref.invalidate(listQuery);
                });
              }
            },
            onNew: () {
              singleton<AppRouter>()
                  .navigatePath('/custmgmt/media/$custEttyId/selmedia');
                     ref.read(mediaCustMgmtMediaCategorySelectProvider.notifier).state = {
                    "MediaCtgry": null,
                    "Dscp":null
                  };
              ref.read(mediaCustMgmtCostCenterEttyIdProvider.notifier).state = {
                "CustEttyId": custEttyId,
                "CmpyEttyId": null,
                "CostCtrEttyId": null,
                "MbrEttyId": null,
                "MediaId": 'new'
              };
            },
            onSelectedTap: (TrinaRow val) {
              ref.read(mediaCustMgmtCostCenterEttyIdProvider.notifier).state = {
                "CustEttyId": custEttyId,
                "CmpyEttyId": val.cells['CmpyEttyId']!.value.toString(),
                "CostCtrEttyId": val.cells['CostCtrEttyId']!.value.toString(),
                "MbrEttyId": val.cells['MbrEttyId']!.value.toString(),
                "MediaId": val.cells['MediaId']!.value.toString()
              };
              ref.read(mediaCustMgmtMediaHolderNameProvider.notifier).state =
                "${val.cells['MemberName']!.value} ${val.cells['VehicleNo']!.value ?? ''}";
          
              singleton<AppRouter>().navigatePath(
                  '/custmgmt/media/$custEttyId/detailAddOn/${val.cells['MediaCtgry']!.value}/${val.cells['PrgEttyId']!.value}/${val.cells['MbrEttyId']!.value}/${val.cells['MediaId']!.originalValue}');
            },
          );
        });
  }
}
