import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/feature/custenroll/custenroll_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/core_imports.dart';

const int wid=440;

@RoutePage()
class CustEnrollCmpyCtrlTxnList extends ConsumerWidget {
  const CustEnrollCmpyCtrlTxnList({
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
        querysql: '/sp/ApiEnrlCmpyTxnLimitList/queryasync',
        params: {"CustEttyId": custEttyId, "CmpyEttyId": cmpyEttyId},
        showMsg: false));
    final listData = ref.watch(listQuery);
    final toNavUrl =
        '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/control/translimt/detail';

    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          return AcxTrinaGridExtDataCheckBox(
            idField: 'LimitId',
            spName: 'ApiEnrlCmpyTxnLimitList',
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
                      querysql: '/sp/ApiEnrlCmpyTxnLimitDel/queryasync',
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
                  '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/control/translimt/translimtsel');
            },
            onSelectedTap: (TrinaRow val) {
              ref
                  .read(custEnrollCmpyCtrlTxnPrgSelectProvider.notifier)
                  .state = {
                "PrgEttyId": val.cells["PrgEttyId"]!.value,
                "Program": val.cells["Program"]!.value
              };
              singleton<AppRouter>().navigatePath(
                  '$toNavUrl/${val.cells["PrgEttyId"]!.value}/${val.cells["LimitId"]!.value}');
            },
          );
        });
    // return CustEnrollCmptyControlTxn(
    //   cmpyEttyId: cmpyEttyId,
    //   custEttyId: custEttyId,
    // );
  }
}

