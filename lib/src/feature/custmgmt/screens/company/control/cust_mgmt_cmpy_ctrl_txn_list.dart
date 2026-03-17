import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/feature/custmgmt/custmgmt_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/core_imports.dart';

const int wid=548;

@RoutePage()
class CustMgmtCmpyCtrlTxnList extends ConsumerWidget {
  const CustMgmtCmpyCtrlTxnList({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtCmpyTxnLimitList/queryasync',
        params: {"CustEttyId": custEttyId, "CmpyEttyId": cmpyEttyId},
        showMsg: false));
    final listData = ref.watch(listQuery);
    final toNavUrl =
        '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/control/translimt/detail';

    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          if(dv.data ==null){
            return const Center(child: Text('No Data'));
          }
          return AcxTrinaGridExtDataCheckBox(
            idField: 'LimitId',
            spName: 'ApiMgmtCmpyTxnLimitList',
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
                  final queryDel = QueryObject(
                      querysql: '/sp/ApiMgmtCmpyTxnLimitDel/queryasync',
                      params: {
                        "CustEttyId": custEttyId,
                        "CmpyEttyId": cmpyEttyId,
                        "PrgEttyId": rows
                            .elementAt(i)
                            .cells["PrgEttyId"]!
                            .value
                            .toString(),
                        "LimitId": rows
                            .elementAt(i)
                            .cells["LimitId"]!
                            .value
                            .toString(),
                        "TxnCtgry": rows
                            .elementAt(i)
                            .cells["TxnCtgry"]!
                            .value
                            .toString()
                      },
                      showMsg: false);
                  final resultDel =
                      ref.read(ReturndatafreezedProvider(queryDel).future);
                  futures.add(resultDel);
                }
                await Future.wait(futures, eagerError: true).then((value) {
                  //   ref.invalidate(listQuery);
                  List<dynamic> rtt = value;
          
                  for (var element in rtt) {
                    if (!isSuccess(element.message)) {
                      Toast.showresult(element);
                    }
                  }
                  ref.invalidate(listQuery);
                }).onError((error, stackTrace) {
                  Toast.message(error.toString());
                });
              }
            },
            onRefresh: () async {
              ref.invalidate(listQuery);
            },
            onNew: () {
                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
              //     singleton<AppRouter>().navigatePath('$toNavUrl/new');
              singleton<AppRouter>().navigatePath(
                  '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/control/translimt/translimtsel');
            },
            onSelectedTap: (TrinaRow val) {
              ref.read(custMgmtCmpyCtrlTxnPrgSelectProvider.notifier).state =
                  {
                "PrgEttyId": val.cells["PrgEttyId"]!.value,
                "Program": val.cells["PrgDscp"]!.value
              };
              singleton<AppRouter>().navigatePath(
                  '$toNavUrl/${val.cells["PrgEttyId"]!.value}/${val.cells["LimitId"]!.value}');
            },
          );
        });
    // return CustMgmtCmptyControlTxn(
    //   cmpyEttyId: cmpyEttyId,
    //   custEttyId: custEttyId,
    // );
  }
}

