import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatav3.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=868;

@RoutePage()
class MchtMgmtLocPrgTpTransList extends ConsumerWidget {
  const MchtMgmtLocPrgTpTransList(
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

     final qo = QueryObject(
        querysql: '/sp/ApiMgmtLocTxnPlanList/queryasync',
        params: {"PrgEttyId": prgEttyId, "LocEttyId": locEttyId},
        showMsg: false);
           final queryRes = ref.watch(ReturndatafreezedProvider(qo));
              late void Function(QueryObject returndata) myMethod;
       return AsyncValueWidget(value: queryRes, data: (theData){

     return AcxTrinaGridExtv3(
               builder: (BuildContext context, 
               void Function(QueryObject A) methodA) { 
                  myMethod = methodA;
                 },
               useCheckBox:false,

              extData: theData,
              checkIndicatorField: "MsgTypePlanId",
              onNew: (){
                     if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
    
          singleton<AppRouter>().navigate(MchtMgmtLocPrgTpTrans(
              msgTypePlanId: null, poe: null, txnMsgCd: null));
              },
              onDelete: (TrinaRow<dynamic> val){
                        if (val.cells == {})
        {
           Toast.message("Please select row to delete");
           return;
        }
   
                        final saveResult = ref.read(ReturndatafreezedProvider(
                                QueryObject(
                                    querysql: '/sp/ApiMgmtLocTxnPlanDel/queryasync',
                                    params: {
                                    "PrgEttyId":val.cells["PrgEttyId"]!.value.toString(),
                                       "LocEttyId":val.cells["LocEttyId"]!.value.toString(),
                                       "MsgTypePlanId":val.cells["MsgTypePlanId"]!.value.toString()
                                    },
                                    showMsg: false))
                            .future);
                        saveResult.then((Returndata? value) {
                          if(value==null){
                            return;
                          }
                          Toast.showresult(value);
                            myMethod.call(qo);
                        });
              },
              onSelected: (TrinaRow val){
                         singleton<AppRouter>().navigate(MchtMgmtLocPrgTpTrans(
           msgTypePlanId: val.cells["MsgTypePlanId"]!.value.toString(),
         poe: val.cells["Poe"]!.value.toString(),
             txnMsgCd: val.cells["TxnMsgCd"]!.value.toString())).then((val){
                myMethod.call(qo);
              });
              },
              onRefresh: (){
                    myMethod.call(qo);
              },);
       });
    // final query = QueryObject(
    //     querysql: '/sp/ApiMgmtLocTxnPlanList/queryasync',
    //     params: {"PrgEttyId": prgEttyId, "LocEttyId": locEttyId},
    //     showMsg: false);

    // final queryDel = QueryObject(
    //     querysql: '/sp/ApiMgmtLocTxnPlanDel/queryasync',
    //     params: {"PrgEttyId": null, "LocEttyId": null, "MsgTypePlanId": null},
    //     showMsg: false);

    // return AcxTrinaGridQuery(
    //     idField: 'MsgTypePlanId',
    //     query: query,
    //     queryDel: queryDel,
    //     exportTitle: 'Merchant Loc Transaction Plan',
    //     onRefresh: () {},
    //      onDelete: (TrinaRow<dynamic> val){
    //                   if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
    //                               Toast.message("Action Not Authorised");
    //                               return;
    //                             }
    //     print(val);
    //     print(val.cells);
    //           if (val.cells == {})
    //     {
    //        Toast.message("Please select row to delete");
    //        return;
    //     }
   
    //                     final saveResult = ref.read(ReturndatafreezedProvider(
    //                             QueryObject(
    //                                 querysql: '/sp/ApiMgmtSiteDel/queryasync',
    //                                 params: {
    //                                   "PrgEttyId":val.cells["PrgEttyId"]!.value.toString(),
    //                                   "LocEttyId":val.cells["LocEttyId"]!.value.toString(),
    //                                   "MsgTypePlanId":val.cells["MsgTypePlanId"]!.value.toString()
    //                                 },
    //                                 showMsg: false))
    //                         .future);
    //                     saveResult.then((Returndata? value) {
    //                       if(value==null){
    //                         return;
    //                       }
    //                       Toast.showresult(value);
                 
    //                     });
    //           },
    //     onSelected: (val) {
          
    //       singleton<AppRouter>().navigate(MchtMgmtLocPrgTpTrans(
    //         msgTypePlanId: val.cells["MsgTypePlanId"]!.value.toString(),
    //         poe: val.cells["Poe"]!.value.toString(),
    //         txnMsgCd: val.cells["TxnMsgCd"]!.value.toString(),
    //       ));
    //     },
    //     onNew: () {
    //         if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
    //                               Toast.message("Action Not Authorised");
    //                               return;
    //                             }
    
    //       singleton<AppRouter>().navigate(MchtMgmtLocPrgTpTrans(
    //           msgTypePlanId: null, poe: null, txnMsgCd: null));
    //     });
  }
}
