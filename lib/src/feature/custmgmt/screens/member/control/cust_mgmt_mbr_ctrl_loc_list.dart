import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=624;

@RoutePage()
class CustMgmtMemberCtrlLocList extends ConsumerWidget {
  const CustMgmtMemberCtrlLocList(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId});

  final String? custEttyId;
  final String? mbrEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtMbrLocAccptList/queryasync',
        params: {"CustEttyId": custEttyId, "MbrEttyId": mbrEttyId},
        showMsg: false));
    final listData = ref.watch(listQuery);
    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          return ListView(
            children: [
              SizedBox(
                height: 1280,
                child: AcxTrinaGridExtDataCheckBox(
                            idField: 'AccptId',
                            extData: dv,
                            spName: 'ApiMgmtMbrLocAccptList',
                            onRefresh: () {
                ref.invalidate(listQuery);
                            },
                            onSelectedTap: (val) {
                singleton<AppRouter>().navigatePath(
                    '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/locaccpt/detail/${val.cells['PrgEttyId']!.value.toString()}/${val.cells['AccptId']!.value.toString()}');
                            },
                            onNew: () {
                                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                //     singleton<AppRouter>().navigatePath('$toNavUrl/new');
                singleton<AppRouter>().navigatePath(
                    '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/locaccpt/locaccptsel');
                            },
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
                        querysql: '/sp/ApiMgmtMbrLocAccptDel/queryasync',
                        params: {
                          "CustEttyId": custEttyId,
                          "MbrEttyId": mbrEttyId,
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
                                  "AccptType": rows
                              .elementAt(i)
                              .cells["AccptType"]!
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
                          ),
              ),
            ],
          );
        });
  }
}
