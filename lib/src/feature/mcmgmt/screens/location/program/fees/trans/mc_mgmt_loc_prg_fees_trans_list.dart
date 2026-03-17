import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/mcmgmt/screens/location/program/fees/trans/mc_mgmt_loc_prg_fees_trans_provider.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=865;

@RoutePage()
class MchtMgmtLocPrgTransList extends ConsumerWidget {
  const MchtMgmtLocPrgTransList(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId});

  final String? prgEttyId;
  final String? locEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtLocTxnFeeList/queryasync',
        params: {"PrgEttyId": prgEttyId, "LocEttyId": locEttyId},
        showMsg: false));
    final listData = ref.watch(listQuery);

    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          return AcxTrinaGridExtDataCheckBox(
            idField: 'FeeId',
            spName: 'ApiMgmtLocTxnFeeList',
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
                      querysql: '/sp/ApiMgmtLocTxnFeeDel/queryasync',
                      params: {
                        "PrgEttyId": prgEttyId,
                        "FeeId": rows
                            .elementAt(i)
                            .cells["FeeId"]!
                            .value
                            .toString(),
                         "LocEttyId": rows
                            .elementAt(i)
                            .cells["LocEttyId"]!
                            .value
                            .toString(),

                      },
                      showMsg: true);
                  final resultDel =
                      ref.read(ReturndatafreezedProvider(queryDel).future);
                  futures.add(resultDel);
                }
                await Future.wait(futures).then((value) {
                  ref.invalidate(listQuery);
                });
              }
            },
            onRefresh: () async {},
            onNew: () {
                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
              singleton<AppRouter>()
                  .navigate(MchtMgmtLocPrgTrans(feeId: null));
            },
            onSelectedTap: (TrinaRow val) {
              ref.read(mchtMgmtLocPrgFeestransProvider.notifier).state = {
                "FeeId": val.cells["FeeId"]!.value.toString(),
                "MediaType": val.cells["MediaType"]!.value.toString(),
                "TxnCtgry": val.cells["TxnCtgry"]!.value.toString()
              };
          
              AutoRouter.of(context).navigate(MchtMgmtLocPrgTrans(
                  feeId: val.cells["FeeId"]!.value.toString()));
              // singleton<AppRouter>().navigatePath('./dtltxn/${val.cells["TxnCtgry"]!.value}/${val.cells["MediaType"]!.value}/${val.cells["FeeId"]!.value}');
            },
          );
        });
  }
}
