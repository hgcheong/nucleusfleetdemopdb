import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_fb_grid.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/transaction/transaction_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=787;

@RoutePage()
class CustMgmtTxnBilledLanding extends ConsumerWidget {
  const CustMgmtTxnBilledLanding(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final txnSearchFormKey = GlobalKey<FormBuilderState>();
    final txnParam = ref.read(txnSearchContorllerProvider);
    Map<String, dynamic> formNewValue = {
      "AcctId": txnParam['AcctId'].toString(),
      "CustEttyId": txnParam['CustEttyId'].toString(),
      "PrgEttyId":txnParam['PrgEttyId'].toString(),
      "MediaNo": txnParam['MediaNo'],
      "FromDate": txnParam['FromDate'] == null
          ? null
          : DateTime.parse(txnParam['FromDate'].toString()),
      "ToDate": txnParam['ToDate'] == null
          ? null
          : DateTime.parse(txnParam['ToDate'].toString()),
      "TxnCtgry": txnParam['TxnCtgry'],
      "EttyId":null
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      sbh10,
      const SelectableText(
          "Billed Transactions are fully processed transactions. The transaction amount already reflected in the Account’s Current Balance and Available Credit"),
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
                  name: 'CustEttyId',
                ),
                FbHiddenText(
                  name: 'PrgEttyId'
                ),
               const FbHiddenText(
                  name: 'EttyId',
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
                const Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: FbDateTimePicker(
                            name: 'FromDate',
                            label: 'From Date',
                          )),
                          fbFieldGap,
                          Flexible(
                              child: FbDateTimePicker(
                                  name: 'ToDate', label: 'To Date'))
                        ],
                      ),
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
                                        ['FromDate', 'ToDate']);
                           
                                ref
                                    .read(txnSearchContorllerProvider.notifier)
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
      const Expanded(child:  TxnGridSearch())
      // AcxTrinaGridExtData(
      //     extData: toUseTxnList,
      //     spName: 'ApiEnrlCustList',
      //     idField: 'UserId',
      //     navPrefix: '/custenroll/cust',
      //     onSelectedTap: (TrinaRow val) {
      //       singleton<AppRouter>().navigatePath('/usermgmt/webportaluser/dtl/${val.cells['UserId']!.value.toString()}');
      //     })
    ]);
  }
}

class TxnGridSearch extends ConsumerWidget {
  const TxnGridSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(txnSearchContorllerProvider);


    return AcxFbGrid(
        querysql: '/sp/ApiMgmtCustAcctTxnBilledSearch/queryasync',
        params: toPost,
        idField: 'TxnId',
        showMsg: false,
        gridTitle: 'Billed Transactions');


  }
}
 