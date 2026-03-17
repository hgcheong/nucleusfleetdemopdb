import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/mcenroll/screens/location/program/fees/trans/mc_enroll_loc_prg_fees_trans_provider.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=850;

@RoutePage()
class MchtEnrlLocPrgTransList extends ConsumerWidget {
  const MchtEnrlLocPrgTransList(
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
        querysql: '/sp/ApiEnrlLocTxnFeeList/queryasync',
        params: {"PrgEttyId": prgEttyId, "LocEttyId": locEttyId},
        showMsg: false));
    final listData = ref.watch(listQuery);

    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          return AcxTrinaGridExtDataCheckBox(
            idField: 'FeeId',
            spName: 'ApiEnrlLocTxnFeeList',
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
                      querysql: '/sp/ApiEnrlLocTxnFeeDel/queryasync',
                      params: {
                        "PrgEttyId": prgEttyId,
                        "LocEttyId": rows
                            .elementAt(i)
                            .cells["LocEttyId"]!
                            .value
                            .toString(),
                        "FeeId": rows
                            .elementAt(i)
                            .cells["FeeId"]!
                            .value
                            .toString(),
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
            onRefresh: () async {},
            onNew: () {
                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
              // singleton<AppRouter>().navigatePath('./dtltxn/new');
              singleton<AppRouter>()
                  .navigate(MchtEnrlLocPrgTrans(feeId: null));
            },
            onSelectedTap: (TrinaRow val) {
              ref.read(mchtEnrollLocPrgFeestransProvider.notifier).state = {
                "FeeId": val.cells["FeeId"]!.value.toString(),
                "MediaType": val.cells["MediaType"]!.value.toString(),
                "TxnCtgry": val.cells["TxnCtgry"]!.value.toString()
              };
              singleton<AppRouter>()
                  .navigate(MchtEnrlLocPrgTrans(
                    feeId: val.cells["FeeId"]!.value.toString(),
                  ))
                  .then((val) {});
            },
          );
        });
  }
}
