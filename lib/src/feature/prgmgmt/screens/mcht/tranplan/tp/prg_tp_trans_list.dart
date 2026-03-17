import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridquery.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=141;
@RoutePage()
class PrgMgmtMchtTpTransList extends ConsumerWidget {
  const PrgMgmtMchtTpTransList(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});
//ApiPrgMchtTadFeeList
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiPrgMchtTxnPlanList/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
        },
        showMsg: false);

    final queryDel = QueryObject(
        querysql: '/sp/ApiPrgMchtTxnPlanDel/queryasync',
        params: {"PrgEttyId": null, "MsgTypePlanId": null},
        showMsg: false);

    return AcxTrinaGridQuery(
        idField: 'MsgTypePlanId',
        query: query,
        queryDel: queryDel,
        exportTitle: 'Merchant Transaction Plan',
        onRefresh: () {},
        onDelete: (val) {},
        onSelected: (val) {
                      if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          singleton<AppRouter>().navigate(PrgMgmtMchtTpTrans(
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
          singleton<AppRouter>().navigate(PrgMgmtMchtTpTrans(
            msgTypePlanId: null,
            poe: null,
            txnMsgCd: null,
          ));
        });
  }
}

