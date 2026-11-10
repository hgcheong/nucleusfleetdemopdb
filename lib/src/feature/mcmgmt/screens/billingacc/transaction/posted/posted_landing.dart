import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_fb_grid.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/mcmgmt/screens/billingacc/transaction/transaction_controller.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=805;

@RoutePage()
class MchtMgmtTxnPostedLanding extends ConsumerWidget {
  const MchtMgmtTxnPostedLanding(
      {super.key, @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final txnSearchFormKey = GlobalKey<FormBuilderState>();
    return SingleChildScrollView(
      child: SizedBox(
        height: 1280,
        child: ListView(children: [
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
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //we set this at txnSearchMchtContorllerProvider
                    // FbHiddenText(
                    //   name: 'MchtEttyId'
                    // ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
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
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: FbLibView(
                                    inputIcon: const Icon(Icons.store),
                                    name: 'LocEttyId',
                                    label: 'Location',
                                    searchText: 'LocName',
                                    keyField: 'LocEttyId',
                                    params: {"MchtEttyId": mchtEttyId},
                                    querySql:
                                        '/sp/ApiMgmtEttyLocList/queryasync',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 4,
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.only(left: 8),
                            //   child: Icon(Icons.person),
                            // ),
                            sbw20,
                            Expanded(
                                child: FbNumber(
                                    label: 'Media No', name: 'MediaNo')),
                          ],
                        ),
                        Row(
                          children: [
                            sbw20,
                            Flexible(
                                child: FbDateTimePicker(
                                    name: 'FromDate', label: 'From Date')),
                            fbFieldGap,
                            Flexible(
                                child: FbDateTimePicker(
                                    name: 'ToDate', label: 'To Date'))
                          ],
                        ),
                      ],
                    )),
                    Expanded(
                      child: Column(
                        children: [
                          IconButton(
                                  onPressed: () {
                                    try {
                                       ref.read(isLoadingProvider.notifier).state = true;
                                    txnSearchFormKey.currentState!.save();
                                                       
                                    Map<String, dynamic> toPost =
                                        convertFormDateValue(
                                            txnSearchFormKey.currentState!.value,
                                            ['FromDate', 'ToDate']);
                                        toPost["MchtEttyId"] = mchtEttyId;
                                       
                                    ref
                                        .read(txnSearchMchtContorllerProvider.notifier)
                                        .state = toPost;
                                    } 
                                    finally{
        //                             Future.delayed(Duration(milliseconds: 100), () {
        //     ref.read(isLoadingProvider.notifier).state = false;
        //  });
        
                                    }
                                   
                                  },
                                  icon: const Icon(Icons.search)),
//                           Consumer(
//                             builder: (BuildContext context, WidgetRef ref, Widget? child) {
//                          final isLoading = ref.watch(isLoadingProvider);

//                          return isLoading ? Text('...') :
// IconButton(
//                                   onPressed: () {
//                                     try {
//                                        ref.read(isLoadingProvider.notifier).state = true;
//                                     txnSearchFormKey.currentState!.save();
                                                       
//                                     Map<String, dynamic> toPost =
//                                         convertFormDateValue(
//                                             txnSearchFormKey.currentState!.value,
//                                             ['FromDate', 'ToDate']);
//                                         toPost["MchtEttyId"] = mchtEttyId;
                                       
//                                     ref
//                                         .read(txnSearchMchtContorllerProvider.notifier)
//                                         .state = toPost;
//                                     } 
//                                     finally{
//         //                             Future.delayed(Duration(milliseconds: 100), () {
//         //     ref.read(isLoadingProvider.notifier).state = false;
//         //  });
        
//                                     }
                                   
//                                   },
//                                   icon: const Icon(Icons.search));}
//                           ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1280,
            child: const TxnGridSearch())
          // AcxTrinaGridExtData(
          //     extData: toUseTxnList,
          //     spName: 'ApiEnrlCustList',
          //     idField: 'UserId',
          //     navPrefix: '/custenroll/cust',
          //     onSelectedTap: (TrinaRow val) {
          //       singleton<AppRouter>().navigatePath('/usermgmt/webportaluser/dtl/${val.cells['UserId']!.value.toString()}');
          //     })
        ]),
      ),
    );
  }
}

class TxnGridSearchDetail extends ConsumerWidget {
  const TxnGridSearchDetail(this.id, this.txnCategory, {super.key});

  final String? id;
  final String? txnCategory;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtMchtTxnIdPostedSearch/queryasync',
        params: {
          "TxnId": id,
          "TxnCtgry": txnCategory
        },
        showMsg: false);
    final data = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget(
        value: data,
        data: (theData) {
          return SingleChildScrollView(
              child: SizedBox(
            height: 1280,
            child: Column(
              children: [             
                    Flexible(
                      flex: 1,
                      child: IconButton(onPressed: (){
                                        context.maybePop();
                                    }, icon: Icon(Icons.close))),
                Expanded(
                  flex: 11,
                  child: AcxTrinaGridExtDatawExport(
                      gridTitle: 'Transaction Details',
                      extData: theData,
                      idField: 'Id',
                     ),
                ),
              ],
            ),
          ));
        });
  }
}

class TxnGridSearch extends ConsumerWidget {
  const TxnGridSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(txnSearchMchtContorllerProvider);
    if(toPost["TxnCtgry"] ==null){
        Future.delayed(Duration(milliseconds: 100), () {
            ref.read(isLoadingProvider.notifier).state = false;
         });
        
      return Center(child: Text("No Data"),);
    }


     return AcxFbGrid(
      querysql: '/sp/ApiMgmtMchtTxnPostedSearch/queryasync',
      params: toPost,
      idField: 'Id',
      gridTitle: 'Recent Transactions',
      onSelected: (TrinaRow val) async {
     
            }
    );


  }
}
