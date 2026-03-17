import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/transaction/transaction_controller.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/transaction/transaction_dtl.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=789;

@RoutePage()
class CustMgmtTxnPostedLanding extends ConsumerWidget {
  const CustMgmtTxnPostedLanding(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final txnSearchFormKey = GlobalKey<FormBuilderState>();
    final txnParam = ref.read(txnSearchPostedContorllerProvider);
    Map<String, dynamic> formNewValue = {
      "AcctId": txnParam['AcctId'],
      "CustEttyId": txnParam['CustEttyId'],
      "PrgEttyId": txnParam['PrgEttyId'],
      "MediaNo": txnParam['MediaNo'],
      "PostDate": txnParam['PostDate'] == null
          ? null
          : DateTime.parse(txnParam['PostDate'].toString()),
      "FromDate": txnParam['FromDate'] == null
          ? null
          : DateTime.parse(txnParam['FromDate'].toString()),
      "ToDate": txnParam['ToDate'] == null
          ? null
          : DateTime.parse(txnParam['ToDate'].toString()),
      "TxnCtgry": txnParam['TxnCtgry']
    };
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      sbh10,
      const SelectableText(
          "Posted Transactions are fully processed transactions. The transaction amount already reflected in the Account’s Current Balance and Available Credit"),
      sbh20,
      const SelectableText(
        "Transaction Search",
      ),
      sbh10,
      FormBuilder(
        key: txnSearchFormKey,
        initialValue: formNewValue,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FbHiddenText(
                  name: 'CustEttyId'
                ),
                const FbHiddenText(
                  name: 'PrgEttyId'
                ),
                FbHiddenText(
                  name: 'AcctId',
                ),
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
                                inputIcon: Icon(Icons.sell),
                                name: 'TxnCtgry',
                                label: 'Transaction Category',
                                searchText: 'Dscp',
                                keyField: 'TxnCtgry',
                                params: {},
                                querySql: '/view/async/VwLibTxnCtgry ',
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.person),
                          ),
                          sbw20,
                          Expanded(
                              child:
                                  FbNumber(label: 'Media No', name: 'MediaNo')),
                        ],
                      ),
                 
                    ],
                  ),
                ),
               
                sbw10,
                  
                  Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                     Row(children: [  Flexible(
                      flex: 6,
                      child: FbSwitchWatch(txnSearchFormKey: txnSearchFormKey),
                                         ),const Spacer(flex: 2,)],),
                           const SizedBox(height: 8,),
                    const SwitchOption(),
                     
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                      txnSearchFormKey.currentState!.save();
                                    Map<String, dynamic> toPost =
                                    convertFormDateValue(
                                        txnSearchFormKey.currentState!.value,
                                        ['FromDate', 'ToDate', 'PostDate']);  
                            
                              var isV = ref.read(txnSearchSwitchByPostedDate.notifier).state;

                              if(isV){
                              if(txnSearchFormKey.currentState!.value['PostDate']== null){
                                  Toast.message("Posting Date required");
                                  return;
                                 
                              }
  
                              //  txnSearchFormKey.currentState!.patchValue({'FromDate':null, 'ToDate':null});
    toPost['FromDate'] = null;
    toPost['ToDate'] = null;
                              } else{
                               

                                 if(txnSearchFormKey.currentState!.value['FromDate']== null || txnSearchFormKey.currentState!.value['ToDate']==null){
                                  Toast.message("From Date and To Date are required");
                                  return;
                                 }
                               // txnSearchFormKey.currentState!.patchValue({'PostDate':null});
                             toPost['PostDate'] = null;
       
                              }

                                              toPost.remove("UsePostedDate");    
 ref
                                    .read(txnSearchPostedContorllerProvider.notifier)
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
      ),
 
      // AcxTrinaGridExtData(
      //     extData: toUseTxnList,
      //     spName: 'ApiEnrlCustList',
      //     idField: 'UserId',
      //     navPrefix: '/custenroll/cust',
      //     onSelectedTap: (TrinaRow val) {
      //       singleton<AppRouter>().navigatePath('/usermgmt/webportaluser/dtl/${val.cells['UserId']!.value.toString()}');
      //     })
    ]),),
           const SliverFillRemaining(child: TxnGridSearch(),)
      
      ],
    );
   
  }

}

class FbSwitchWatch extends ConsumerWidget {
  const FbSwitchWatch({
    super.key,
    required this.txnSearchFormKey,
  });

  final GlobalKey<FormBuilderState> txnSearchFormKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var isByPostedDate = ref.watch(txnSearchSwitchByPostedDate);
    if(isByPostedDate){
    return FbSwitch(name: 'UsePostedDate', label: 'By Posted',initialValue: 'Y',  
    onChanged: (val){
          ref.read(txnSearchSwitchByPostedDate.notifier).state = val!;
        },);
    }
    else{
    return FbSwitch(name: 'UsePostedDate', label: 'By Transaction Date',initialValue: 'N',   
    onChanged: (val){
          ref.read(txnSearchSwitchByPostedDate.notifier).state = val!;
        },);
    }

  }
}

class SwitchOption extends ConsumerWidget{
    const SwitchOption({super.key});
    

      @override
      Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
          var isByPostedDate = ref.watch(txnSearchSwitchByPostedDate);

   return  Row(
                        children: [
                          Visibility(
                            visible: isByPostedDate,
                            child: const Flexible(
                                child: FbDateTimePicker(
                              name: 'PostDate',
                              label: 'Posted Date',
                              initialValue: null,
                            )),
                          ),
                          sbw10,
                     Visibility(
                         visible: !isByPostedDate,
                       child: const Flexible(
                                child: FbDateTimePicker(
                              name: 'FromDate',
                              label: 'From Date',
                              initialValue: null,
                            )),
                     ),
                          sbw10,
                          Visibility(
                               visible: !isByPostedDate,
                            child: const Flexible(
                                child: FbDateTimePicker(
                                  initialValue: null,
                                    name: 'ToDate', label: 'To Date')),
                          )
                        ],
                      );
          
      }

  //         if(isByPostedDate){
  //  return const Row(
  //                       children: [
  //                         Flexible(
  //                             child: FbDateTimePicker(
  //                           name: 'PostDate',
  //                           label: 'Posted Date',
  //                           initialValue: null,
  //                         )),
  //                         sbw10,
                    
  //                       ],
  //                     );
  //         }
  //         else{
          
  //                     return const Row(
  //                       children: [
  //                         // Flexible(child: FbDateTimePicker( name: 'FromDate', label: 'From Date', onreset: () {
  //                         //     txnSearchFormKey.currentState!.fields['FromDate']?.didChange(null);
  //                         //   },)),
  //                         Flexible(
  //                             child: FbDateTimePicker(
  //                           name: 'FromDate',
  //                           label: 'From Date',
  //                           initialValue: null,
  //                         )),
  //                         sbw10,
  //                         Flexible(
  //                             child: FbDateTimePicker(
  //                               initialValue: null,
  //                                 name: 'ToDate', label: 'To Date'))
  //                       ],
  //                     );
  //         }
  //     }

}

class TxnGridSearch extends ConsumerWidget {
  const TxnGridSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(txnSearchPostedContorllerProvider);
    final query = QueryObject(
        querysql: '/sp/ApiMgmtCustAcctTxnList/queryasync',
        params: toPost,
        showMsg: false);
      if(toPost['PostDate']==null && toPost['FromDate']==null ){
        return const Center(child: Text('No Data'),);
      }
      else{
   final data = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget(
        value: data,
        data: (theData) {
          return AcxTrinaGridExtDatawExport(
              gridTitle: 'Recent Transactions',
              extData: theData,
              idField: 'TxnId',
              onSelected: (TrinaRow val) async {
                await showAcxDialog(
                    context,
                    TransactionDtl(
                      val: val,
                    ));
              });
        });
      }
 
  }
}
