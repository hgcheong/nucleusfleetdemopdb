import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=553;

@RoutePage()
class CustMgmtCmpyCtrlCrEvaList extends ConsumerWidget {
  const CustMgmtCmpyCtrlCrEvaList(
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
        querysql: '/sp/ApiMgmtCrRiskList/queryasync',
        params: {"CustEttyId": custEttyId, "CmpyEttyId": cmpyEttyId},
        showMsg: false));
    final listData = ref.watch(listQuery);
    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          return AcxTrinaGridExtDataCheckBox(
            idField: 'CrScoreId',
            spName: 'ApiMgmtCrRiskList',
            extData: dv,
     
            onRefresh: () async {
              ref.invalidate(listQuery);
            },
            onNew: () {
                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
              singleton<AppRouter>().navigatePath('./detail/new');
            },
            onSelectedTap: (TrinaRow val) {
              singleton<AppRouter>()
                  .navigatePath('./detail/${val.cells["CrScoreId"]!.value}');
            },
          );
        });
  }
}
