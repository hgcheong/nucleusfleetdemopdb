import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

import 'package:nucleusv2/src/core/components/acx_plutogridquery.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=856;

@RoutePage()
class McEnrollLocPrgTpTransList extends ConsumerWidget {
  const McEnrollLocPrgTpTransList(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId});
//ApiPrgMchtTadFeeList
  final String? prgEttyId;
  final String? locEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiEnrlLocTxnPlanList/queryasync',
        params: {"PrgEttyId": prgEttyId, "LocEttyId": locEttyId},
        showMsg: false);

    final queryDel = QueryObject(
        querysql: '/sp/ApiEnrlLocTxnPlanDel/queryasync',
        params: {"PrgEttyId": null, "LocEttyId": null, "MsgTypePlanId": null},
        showMsg: false);

    return AcxTrinaGridQuery(
        idField: 'MsgTypePlanId',
        query: query,
        queryDel: queryDel,
        onRefresh: () {
          ref.invalidate(ReturndatafreezedProvider(query));
        },
        onDelete: (val) {
            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
        },
        onSelected: (val) {
          singleton<AppRouter>().navigate(McEnrollLocPrgTpTrans(
            msgTypePlanId: val.cells["MsgTypePlanId"]!.value.toString(),
            poe: val.cells["Poe"]!.value.toString(),
            txnMsgCd: val.cells["TxnMsgCd"]!.value.toString(),
          ));
        },
        onNew: () {
          
            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          //         onNew: (){
          singleton<AppRouter>().navigate(McEnrollLocPrgTpTrans(
              msgTypePlanId: null, poe: null, txnMsgCd: null));
        });
  }
}
