import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatav3.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/pukal/pukal_controller.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=890;

@RoutePage()
class PukalListInbound extends ConsumerWidget {
  const PukalListInbound({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
  return const Scaffold(
    body:  PukalAutoGenSearchSliver(),

  );
  }
  }

class PukalAutoGenSearchSliver extends ConsumerWidget {
  const PukalAutoGenSearchSliver(
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final pukalSearchInboundFormKey = GlobalKey<FormBuilderState>();
    final pukalParam = ref.read(pukalSearchInboundContorllerProvider);
    Map<String, dynamic> formNewValue = {
      "PrgEttyId":pukalParam['PrgEttyId']
    };
 return CustomScrollView(
    slivers: <Widget>[
      const SliverAppBar(  title:  Text('Pukal Billing Inbound (AP506, AP507)'),
      automaticallyImplyLeading: false, centerTitle: false,
      
    ),
      //2
      SliverToBoxAdapter(child: Column(
        mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            FormBuilder(
              key: pukalSearchInboundFormKey,
              initialValue: formNewValue,
              child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: FbLibView(
                            inputIcon: Icon(Icons.list),
                            name: 'PrgEttyId',              
                            label: 'Program',
                            searchText: 'Dscp',
                            keyField: 'EttyId',
                            params: {},
                            querySql: '/view/async/VwPrgKadInden',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            sbw10,
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            pukalSearchInboundFormKey.currentState!.save();
                            Map<String, dynamic> toPost =  Map.from(pukalSearchInboundFormKey.currentState!.value);
                            toPost["DateTime"] = DateTime.now();
                            ref
                                .read(pukalSearchInboundContorllerProvider.notifier)
                                .state = toPost;
                          },
                          icon: const Icon(Icons.search)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
              ),
            )
          ]),),
     const SliverFillRemaining(child: TxnPukalInboundGridSearch(),)
    ],
  );

  }
}

class TxnPukalInboundGridSearch extends ConsumerWidget {
  const TxnPukalInboundGridSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(pukalSearchInboundContorllerProvider);
    final qo = QueryObject(
        querysql: '/sp/ApiMgmtCustBillingAcctPukalInboundTxnList/queryasync',
        params: {
          "PrgEttyId":toPost["PrgEttyId"]
        },
        showMsg: false);
        final query = ReturndatafreezedProvider(qo);
    final data = ref.watch(query);
     late void Function(QueryObject returndata) myMethod;
    return AsyncValueWidget(
        value: data,
        data: (theData) {
          if(theData.data == null){
            return const Center(child: Text('No Data'),);
          }
          return AcxTrinaGridExtv3(
               builder: (BuildContext context, 
               void Function(QueryObject A) methodA) { 
                  myMethod = methodA;
                 },
               useCheckBox:false,
            
              gridTitle: 'Pukal Billing List',
              extData: theData,
              onRefresh: (){
                    myMethod.call(qo);
              },
      //            appButtons: [
      //                       //  AppButtonWithFunction(btn: AppButton(
      //                       //     icon: Icons.visibility,
      //                       //     label: 'Show Source'), func: (TrinaRow<dynamic>? row) async {
      //                       //    singleton<AppRouter>().navigatePath(
      //                       //         '/dataentry/manual/PUKAL/pukalfiles/in');
      //                       //     }),
      //                  AppButtonWithFunction(
      //                         btn: const AppButton(                        
      //                           icon: Icons.update,
      //                           label: "Regen Pukal File",
      //                         ),
      //                         func: (TrinaRow<dynamic>? row) async {
      //                         if(row==null){
      //                           Toast.message("Please Select Row to Proceed");
      //                           return;
      //                         }
      //                 bool confirmed = await ConfirmDialog.show(
      //                     title: "Confirm Rerun File Generation?",
      //                     body: "Are you sure you want to Confirm to Rerun File Regen?",
      //                     destructive: true,
      //                     confirmText: "Yes",
      //                     cancelText: "Cancel",
      //                   );
      //                      if (!confirmed) {
      //                     return;
      //                   }
                  
      //             final confirmRegen = ref.read(ReturndatafreezedProvider(
      //                 QueryObject(
      //                     querysql: '/sp/ApiRptFilePukalTxnRerun/queryasync',
      //                     params: {
      //                           "RptType": "PUKAL",
      //                           "RptInd":"PREVIEW",
      //                         "PId": row.cells["PId"]!.value.toString(),
      //                         "RunId": row.cells["RunId"]!.value.toString(),
      //                     },
      //                     showMsg: false))
      //             .future);
      //                  confirmRegen.then((Returndata? value) {
      //           if(value==null){
      //             return;
      //           }
      //                 Toast.showresult(value);
      //  myMethod.call(qo);
      //                           });
      //                         }),
                   
                             
      //         AppButtonWithFunction(
      //                         btn: const AppButton(                        
      //                           icon: Icons.checklist,
      //                           label: "Billing Confirmation",
      //                         ),
      //                      func: (TrinaRow<dynamic>? row) async {
      //                        if(row==null){
      //                        Toast.message("Please Select Row to Proceed");
      //                           return;
      //                         }
      //                                bool confirmed = await ConfirmDialog.show(
      //                     title: "Confirm Billing?",
      //                     body: "Are you sure you want to Confirm?",
      //                     destructive: true,
      //                     confirmText: "Yes",
      //                     cancelText: "Cancel",
      //                   );

      //                   if (!confirmed) {
      //                     return;
      //                   }

      //                     bool reconfirmed = await ConfirmDialog.show(
      //                     title: "Please ReConfirm Billing?",
      //                     body: 'Are you sure you want to ReConfirm? Once Reconfirmed billing will be sent to IGFMAS',
      //                     destructive: true,
      //                     confirmText: "Yes",
      //                     cancelText: "Cancel",
      //                   );

      //                   if (!reconfirmed) {
      //                     return;
      //                   }
      //                           if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
      //                   Toast.message("Action Not Authorised");
      //                   return;
      //                 }            

                             
      //               final confirmBilling = ref.read(ReturndatafreezedProvider(
      //                 QueryObject(
      //                     querysql: '/sp/ApiRptFilePukalTxnSave/queryasync',
      //                     params: {
      //                         "RptType": "PUKAL",
      //                         "PId": row.cells["PId"]!.value.toString(),
      //                         "RunId": row.cells["RunId"]!.value.toString(),
      //                     },
      //                     showMsg: false))
      //             .future);
      //                           confirmBilling.then((Returndata? value) {
      //           if(value==null){
      //             return;
      //           }
      //                 Toast.showresult(value);
      //                    myMethod.call(qo);
                              
      //                           });
                  
                          
      //                         }),
     // ],
              checkIndicatorField: 'TxnId',
              onSelected: (TrinaRow val) async {
                      await showAcxAlertDialog(context,  ApiMgmtCustBillingPukalSaveDialog(
                        selectedRow: val,
                  )).then((val){
                     myMethod.call(qo);
                  });
      
              });
        });
  }
}


class ApiMgmtCustBillingPukalSaveDialog extends ConsumerWidget{
  const ApiMgmtCustBillingPukalSaveDialog({this.selectedRow,  super.key});

  final TrinaRow? selectedRow;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(selectedRow == null){
      return const Center(child: Text('No Record Selected'),);
    }
    final formCustPukalBilling = GlobalKey<FormBuilderState>();
     Map<String, dynamic> formRoleAssign= {
      "PrgEttyId": convStrNewOrNullToNull(selectedRow!.cells['PrgEttyId']!.value.toString()),
      "PukalId": convStrNewOrNullToNull(selectedRow!.cells['PukalId']!.value.toString()),
      "AcctId": convStrNewOrNullToNull(selectedRow!.cells['AcctId']!.value.toString()),
      "TxnId": convStrNewOrNullToNull(selectedRow!.cells['TxnId']!.value.toString()),
      "BillAmt": convStrNewOrNullToNull(selectedRow!.cells['BillingAmt']!.value.toString()),
      "CmpyName": convStrNewOrNullToNull(selectedRow!.cells['CmpyName']!.value.toString()),
      "AcctNo": convStrNewOrNullToNull(selectedRow!.cells['AcctNo']!.value.toString()),
      "BillingDate": DateTime.parse(selectedRow!.cells['BillingDate']!.value) ,
        "ObjCdDscp": convStrNewOrNullToNull(selectedRow!.cells['ObjCdDscp']!.value.toString()),
            "PukalStsDscp": convStrNewOrNullToNull(selectedRow!.cells['PukalStsDscp']!.value.toString()),
            "AcctOffcSad": convStrNewOrNullToNull(selectedRow!.cells['AcctOffcSad']!.value.toString()),
            "SortKey": convStrNewOrNullToNull(selectedRow!.cells['SortKey']!.value.toString()),
            "DeptGrpCd": convStrNewOrNullToNull(selectedRow!.cells['DeptGrpCd']!.value.toString()),
            "Vot": convStrNewOrNullToNull(selectedRow!.cells['Vot']!.value.toString()),
            "TrustFund": convStrNewOrNullToNull(selectedRow!.cells['TrustFund']!.value.toString()),
            "Acctble": convStrNewOrNullToNull(selectedRow!.cells['Acctble']!.value.toString()),
            "PrgActvtyCd":convStrNewOrNullToNull(selectedRow!.cells['PrgActvtyCd']!.value.toString()),
            "ProjCd": convStrNewOrNullToNull(selectedRow!.cells['ProjCd']!.value.toString())
};
 return FormBuilder(
            key: formCustPukalBilling,
            initialValue: formRoleAssign, child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Expanded(
                  flex:5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const  Text('Pukal Billing Detail'),
  sbh10,
                        FbHiddenText(name: 'PrgEttyId'),
                        FbHiddenText(name: 'PukalId'),
                        FbHiddenText(name: 'AcctId'),
                         FbHiddenText(name: 'TxnId'),
                    
                                 const FbText(
                           name: 'CmpyName', label: 'Company Name'),
                                 const FbText(
                           name: 'AcctNo', label: 'Account Number'),
                                const Flexible(
                                   child:  FbDateTimePicker(
                                                              name: 'BillingDate', label: 'Billing Date',
                                 )),      const FbText(
                           name: 'Vot', label: 'Vot'),
  const FbText(
                           name: 'ObjCdDscp', label: 'ObjCdDscp'),
                             const  FbText(name: 'DeptGrpCd', label:'DeptGrpCd'),
                           
                             const FbText(
                           name: 'PukalStsDscp', label: 'PukalStsDscp'),
                           
                    ],
                  ),
                ),
                sbw10,
                     const Expanded(
                  flex:5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bill Amt can be change for OUTBOUND/ ERROR, REJECTED status only'),
                      sbh10,
                        FbText(
                           name: 'BillAmt', label: 'Bill Amount'),
                        FbText(name: 'AcctOffcSad', label:'AcctOffcSad' ,),
                        FbText(name: 'SortKey',label:'SortKey', ),
                    
               
                                  FbText(
                           name: 'TrustFund', label: 'TrustFund'),
                                  FbText(
                           name: 'Acctble', label: 'Acctble'),
                       
   FbText(
                           name: 'PrgActvtyCd', label: 'PrgActvtyCd'),
                              FbText(
                           name: 'ProjCd', label: 'ProjCd'),
                           
                    ],
                  ),
                ),
                sbw10,
                Expanded(flex: 1,child:   Column(
                  children: [
                         
                    AcxSaveButtonManual(onSave: () {
                        if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                        Toast.message("Action Not Authorised");
                        return;
                      }
                      formCustPukalBilling.currentState!.save();
                                Map<String, dynamic> toPost = Map.from(formCustPukalBilling.currentState!.value);

                           
                                 //   toPost.remove('UserId');
                                final saveResult = ref.read(ReturndatafreezedProvider(
                      QueryObject(
                          querysql: '/sp/ApiMgmtCustBillingAcctPukalInboundTxnSave/queryasync',
                          params: {
                                  "PrgEttyId": toPost["PrgEttyId"],
      "PukalId": toPost["PukalId"],
      "TxnId":toPost["TxnId"],
      "AcctId": toPost["AcctId"],
      "BillAmt": toPost["BillAmt"],
                          },
                          showMsg: false))
                  .future);
                                saveResult.then((Returndata? value) {
                if(value==null){
                  return;
                }
                      Toast.showresult(value);
                                  if(isSuccess(value.message)){
        
                                       if (context.mounted) {
                                          context.maybePop();
                                        }
                                  }
                              
                                });
                    }), 
                                AcxBackToList(listUrl: '',useFunctionOnly: true,fnBeforeNav: (){
   if (context.mounted) {
                                          context.maybePop();
                                        }
                               },
                        ),
                    AcxAuditLogReqBtn('ApiMgmtCustBillingAcctPukalInboundTxnSave',)
                  ],
                ),)
              ],
            ), );
  }

}
 

 
