import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=628;

@RoutePage()
class CustMgmtMemberCtrlProdList extends ConsumerWidget {
  const CustMgmtMemberCtrlProdList({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('mbrEttyId') this.mbrEttyId,
  });

  final String? custEttyId;
  final String? mbrEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtMbrPrdAccptPrgList/queryasync',
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
                  idField: 'PrgEttyId',
                  spName: 'ApiMgmtMbrPrdAccptPrgList',
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
                            querysql: '/sp/ApiMgmtMbrPrdAccptDel/queryasync',
                            params: {
                              "CustEttyId": custEttyId,
                              "MbrEttyId": mbrEttyId,
                              "PrgEttyId": rows
                                  .elementAt(i)
                                  .cells["PrgEttyId"]!
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
                    if(dv.data != null && dv.data![0]['PrgEttyId'] != null){
                      Toast.message('Only 1 Product Acceptance Record allowed per Member');
                      return;
                    }
                    singleton<AppRouter>().navigatePath(
                        '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/prodaccpt/prodaccptsel');
                
                    //detail/:prgEttyId
                  },
                  onSelectedTap: (TrinaRow val) {
                    singleton<AppRouter>().navigatePath(
                        '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/prodaccpt/detail/${val.cells['PrgEttyId']!.value.toString()}');
                  },
                ),
              ),
            ],
          );
        });
  }
}
