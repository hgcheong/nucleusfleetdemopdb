import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/feature/custenroll/custenroll_controller.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=436;

@RoutePage()
class CustEnrollCmpyCtrlLocList extends ConsumerWidget {
  const CustEnrollCmpyCtrlLocList(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('cmpyEttyId') this.cmpyEttyId});

  final String? custEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiEnrlCmpyLocAccptList/queryasync',
        params: {"CustEttyId": custEttyId, "CmpyEttyId": cmpyEttyId},
        showMsg: false));
    final listData = ref.watch(listQuery);
    final toNavUrl =
        '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/control/locaccpt/detail';
    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          return AcxTrinaGridExtDataCheckBox(
            idField: 'AccptId',
            spName: 'ApiEnrlCmpyLocAccpt',
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
                      querysql: '/sp/ApiEnrlCmpyLocAccptDel/queryasync',
                      params: {
                        "CustEttyId": custEttyId,
                        "CmpyEttyId": cmpyEttyId,
                        "PrgEttyId": rows
                            .elementAt(i)
                            .cells["PrgEttyId"]!
                            .value
                            .toString(),
                        "AccptId": rows
                            .elementAt(i)
                            .cells["AccptId"]!
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
                  '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/control/locaccpt/locaccptsel');
            },
            onSelectedTap: (TrinaRow val) {
              ref
                  .read(custEnrollCmpyCtrlLocPrgSelectProvider.notifier)
                  .state = {
                "PrgEttyId": val.cells["PrgEttyId"]!.value,
                "PrgDscp": val.cells["Description"]!.value
              };
              singleton<AppRouter>().navigatePath(
                  '$toNavUrl/${val.cells["PrgEttyId"]!.value}/${val.cells["AccptId"]!.value}');
            },
          );
        });

    // return AsyncValueWidget<Returndata>(
    //     value: listData,
    //     data: (dv) {
    //       return Column(
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               IconButton(
    //                 icon: const Icon(Icons.delete),
    //                 onPressed: () async {
    //                   bool confirmed = await ConfirmDialog.show(
    //                     title: "Delete?",
    //                     body: "Are you sure you want to Delete?",
    //                     destructive: true,
    //                     confirmText: "Yes",
    //                     cancelText: "Cancel",
    //                   );

    //                   if (!confirmed) {
    //                     return;
    //                   }

    //                   for (var element in checkedItem.value) {
    //                     final queryDel = QueryObject(querysql: '/sp/ApiEnrlCmpyLocAccptLocDel/queryasync', params: {"CustEttyId": custEttyId, "CmpyEttyId": cmpyEttyId,
    //                     "PrgEttyId": "${element.cells['PrgEttyId']!.value}", "AccptId": "${element.cells['AccptId']!.value}"}, showMsg: false);
    //                     final resultDel = ref.read(ReturndatafreezedProvider(queryDel).future);
    //                     resultDel.then((value) {
    //                       ref.invalidate(ReturndatafreezedProvider(query));
    //                       Toast.showresult(value);
    //                     });
    //                   }
    //                   Debugger.log(checkedItem.value);
    //                 },
    //               ),
    //               IconButton(
    //                 icon: const Icon(Icons.add),
    //                 onPressed: () {
    //                   ///custenroll/cmpy/10/detail/37/control/translimt
    //                   singleton<AppRouter>().navigatePath('/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/control/locaccpt/locaccptsel');
    //                 },
    //               )
    //             ],
    //           ),
    //           SingleChildScrollView(
    //             child: AcxTrinaGridExtDataCheckBox(
    //               idField: 'AccptId',
    //               spName: 'ApiEnrlCmpyLocAccpt',
    //               extData: dv,
    //         //      useCheckBox: true,
    //               onSelectedTap: (val) {
    //                 singleton<AppRouter>().navigatePath('/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/control/locaccpt/detail/${val["PrgEttyId"].value.toString()}/${val["AccptId"].value.toString()}');
    //               },
    //               onCheckedAll: (TrinaGridOnRowCheckedEvent v) {
    //                 if (v.isAll) {
    //                   if (v.isChecked!) {
    //                     if (dv.data != null) {
    //                       final theD = dv;
    //                       checkedItem.value.addAll(getRows(theD.data!, theD.columnInfo!, theD.columnInfo!.length));
    //                     }
    //                   } else {
    //                     checkedItem.value.clear();
    //                   }
    //                 }
    //               },
    //               onChecked: (TrinaRow? rw) {
    //                 if (rw!.checked!) {
    //                   checkedItem.value.add(rw);
    //                 } else {
    //                   checkedItem.value.remove(rw);
    //                 }
    //               },
    //             ),
    //           ),
    //         ],
    //       );
    //     });
  }
}
