import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=632;

@RoutePage()
class CustMgmtMemberCtrlTransList extends StatelessWidget {
  const CustMgmtMemberCtrlTransList({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('mbrEttyId') this.mbrEttyId,
  });

  final String? custEttyId;
  final String? mbrEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return CustMgmtMemberCtrlTransListGrid(
          custEttyId: custEttyId,
          mbrEttyId: mbrEttyId,
        );
  }
}

class CustMgmtMemberCtrlTransListGrid extends HookConsumerWidget {
  const CustMgmtMemberCtrlTransListGrid({
    super.key,
    this.custEttyId,
    this.mbrEttyId,
  });
  final String? custEttyId;
  final String? mbrEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtMbrTxnLimitList/queryasync',
        params: {"CustEttyId": custEttyId, "MbrEttyId": mbrEttyId},
        showMsg: false));
    final listData = ref.watch(listQuery);

    return AsyncValueWidget<Returndata>(
        value: listData,
        data: (dv) {
          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 54.0),
                child: SelectableText(
                    'Define the allowable transaction Category and spending limit at Member level'),
              ),
              SizedBox(
                height: 1280,
                child: AcxTrinaGridExtDataCheckBox(
                  idField: 'LimitId',
                  spName: 'ApiMgmtMbrTxnLimitList',
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
                            querysql: '/sp/ApiMgmtMbrTxnLimitDel/queryasync',
                            params: {
                              "CustEttyId": custEttyId,
                              "MbrEttyId": mbrEttyId,
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
                        final resultDel = ref
                            .read(ReturndatafreezedProvider(queryDel).future);
                        futures.add(resultDel);
                      }
                      await Future.wait(futures, eagerError: true)
                          .then((value) {
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
                  onNew: () {
                      if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                    //     singleton<AppRouter>().navigatePath('$toNavUrl/new');
                    singleton<AppRouter>().navigatePath(
                        '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/translimt/translimtsel');
                  },
                  onSelectedTap: (TrinaRow val) {
                    singleton<AppRouter>().navigatePath(
                        '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/translimt/detail/${val.cells['PrgEttyId']!.value.toString()}/${val.cells['LimitId']!.value.toString()}');
                  },
                ),
              ),
            ],
          );
        });
  }
}
