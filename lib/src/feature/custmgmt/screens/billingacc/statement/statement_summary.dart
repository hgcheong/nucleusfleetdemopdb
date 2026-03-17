import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_dtp_year.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/statement/statement_controller.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=538;

@RoutePage()
class CustMgmtStatementSummary extends ConsumerWidget {
  const CustMgmtStatementSummary({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('prgEttyId') this.prgEttyId,
    @PathParam.inherit('ettyId') this.ettyId,
    @PathParam.inherit('acctId') this.acctId,
  });

  final String? custEttyId;
  final String? prgEttyId;
  final String? ettyId;
  final String? acctId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final settleFormKey = GlobalKey<FormBuilderState>();

    // final query = QueryObject(querysql:'/sp/ApiMgmtLocList/queryasync' , params: {"CustEttyId": custEttyId}, showMsg: false);
    // final queryRes = ref.watch(ReturndatafreezedProvider(query));
    final txnStmtParam = ref.read(statementSearchContorllerProvider);
    Map<String, dynamic> formNewValue = {
                  "CustEttyId": txnStmtParam["CustEttyId"],
                  "PrgEttyId": txnStmtParam["PrgEttyId"],
                  "EttyId": txnStmtParam["EttyId"],
                  "AcctId": txnStmtParam["AcctId"],
                  "Yr":null
                };

    return ListView(children: [
      const SelectableText(
        "Statement Search",
      ),
      sbh10,
      FormBuilder(
        key: settleFormKey,
        initialValue: formNewValue,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                 FbHiddenText(name: 'CustEttyId'),
                 FbHiddenText(name: 'PrgEttyId'),
                 FbHiddenText(name: 'EttyId'),
                 FbHiddenText(name: 'AcctId'),
  
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [         
                             Flexible( flex:2,child:  FbDateTimePickerYear(label: 'Year', name: 'Yr',initialValue: DateTime.now(),)),
                            IconButton(onPressed: () {
                              
                             settleFormKey.currentState!.save();
                            Map<String, dynamic> toPost = settleFormKey.currentState!.value;
                            ref
                                .read(statementSearchContorllerProvider.notifier)
                                .state = toPost;
                                },
                                icon: const Icon(Icons.search)),
                               const Spacer(flex: 10,),
                
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
      // const SelectableText(
      //   'Settlements',
      // ),
      SizedBox(
          height: 1280,
          child: const SettlementGridPage())
    ]);
  }
}

class SettlementGridPage extends ConsumerWidget {
  const SettlementGridPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final toPost = ref.watch(statementSearchContorllerProvider);
    final query = QueryObject(
        querysql: 'ApiMgmtCustAcctStmtSmry', params: toPost, showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
            if(theData.data==null){
              return buildEmptyDtaTable(theData,getGridConfig(context) );
            }
            List<dynamic> list1=[];
var list2 = theData.data as List<dynamic>;
list1.addAll((list2.where((spot)=>list1.every((repoSpot)=>spot["StmtId"] != repoSpot["StmtId"]))));
          Returndata toUseHere = Returndata(
            message: theData.message,
            output: theData.output,
            error: theData.error,
            columnInfo: theData.columnInfo,
            data:list1);
          return AcxTrinaGridExtDatawExport(
              
              gridTitle: 'Statement',
              extData: toUseHere,
              idField: 'StmtId',
              onSelected: (TrinaRow val) async {
            
                
                    
                bool confirmed = await ConfirmDialog.show(
                  title: "Download?",
                  body: "Are you sure you want to download ?",
                  destructive: true,
                  confirmText: "Yes",
                  cancelText: "Cancel", 
                );
                    
                if (!confirmed) {
                  return;
                } 
             
                if( val.cells["BillingDate"]!.value==""){
                  Toast.message("No Report for Billing Date");
                  return;
                }
              var toPostStmtList =   {
                "BillingDate": val.cells["BillingDate"]!.value.toString(),
                   "AcctId":  val.cells["AcctId"]!.value.toString(),
                  "PrgEttyId":  val.cells["PrgEttyId"]!.value.toString(),
                "CustEttyId":  val.cells["CustEttyId"]!.value.toString(),
                  "EttyId":  val.cells["EttyId"]!.value == "" ? null: val.cells["EttyId"]!.value.toString()
                  };
                final query = QueryObject(
                querysql: 'ApiMgmtCustAcctStmtList', params: toPostStmtList, showMsg: false);
                final queryRpt = await ref.watch(ReturndatafreezedProvider(query).future);
                if(queryRpt.data!=null){
                      for (var element in queryRpt.data!) {
          if(element["Url"] !=null){
                     try {
          await ApiService().postDownload(
            '/s3/download',
            params: {'key': element["Url"]},
          ).then((v){
                       Toast.message('Downloaded');
          });
          await Future.delayed(const Duration(seconds: 1));
                     
                      } catch (ex) {
          Toast.error(ex.toString());
                      } finally {
             
              }
          } else{
            Toast.message("No Report Found");
          }
                                   
                    
                      }
                } else{
                          Toast.message("No Report Data Found");
                }
                    
                   }     );
        });
  }
}

class SettleMentDetailsDialog extends StatelessWidget {
  const SettleMentDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return const Column(
      children: [
        Expanded(
          flex: 1,
          child: Placeholder(),
        ),
        Expanded(
          flex: 1,
          child: Placeholder(),
        )
      ],
    );
  }
}
