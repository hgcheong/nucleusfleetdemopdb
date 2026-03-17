import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=761;

@RoutePage()
class PrgCustFeeTransList extends ConsumerWidget {
  const PrgCustFeeTransList(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiPrgCustTxnFeeList/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
        },
        showMsg: false));
    final listData = ref.watch(listQuery);
    final toNavUrl =
        '/prgmgmt/custsetup/$prgEttyId/pcfeelanding/pcfeemtranslist/pcfeemtrans';

    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          return AcxTrinaGridExtDataCheckBox(
            idField: 'FeeId',
            spName: 'ApiPrgCustTxnFeeList',
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
                      querysql: '/sp/ApiPrgCustTxnFeeDel/queryasync',
                      params: {
                        "PrgEttyId": prgEttyId,
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
              singleton<AppRouter>().navigatePath('$toNavUrl/new');
            },
            onSelectedTap: (TrinaRow val) {
              singleton<AppRouter>()
                  .navigatePath('$toNavUrl/${val.cells["FeeId"]!.value}');
            },
          );
        });
  }
}
