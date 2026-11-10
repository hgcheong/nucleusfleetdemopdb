import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_fb_grid.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/transaction/transaction_controller.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/transaction/transaction_dtl.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=791;

@RoutePage()
class CustMgmtTxnUnBilledLanding extends ConsumerWidget {
  const CustMgmtTxnUnBilledLanding(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final txnSearchFormKey = GlobalKey<FormBuilderState>();
    final txnParam = ref.read(txnSearchContorllerUnbilledProvider);
    Map<String, dynamic> formNewValue = {
      "AcctId": txnParam['AcctId'].toString(),
      "CustEttyId": txnParam['CustEttyId'].toString(),
      "PrgEttyId":txnParam['PrgEttyId'].toString(),
      "EttyId":txnParam['EttyId'].toString(),
      "MediaNo": txnParam['MediaNo'],
      "FromDate": txnParam['FromDate'] == null
          ? null
          : DateTime.parse(txnParam['FromDate'].toString()),
      "ToDate": txnParam['ToDate'] == null
          ? null
          : DateTime.parse(txnParam['ToDate'].toString()),
      "TxnCtgry": txnParam['TxnCtgry']
    };
    return CustomScrollView(
      slivers: [SliverToBoxAdapter(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      sbh10,
      const SelectableText(
          "UnBilled Transactions are un processed transactions. The transaction amount are not reflected in the Account’s Current Balance and Available Credit"),
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
                  name: 'PrgEttyId',
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
                                    .read(txnSearchContorllerUnbilledProvider.notifier)
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
    ],),),  const SliverFillRemaining(child : TxnGridSearch())],
    );
  }
}

class TxnGridSearch extends ConsumerWidget {
   const TxnGridSearch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(txnSearchContorllerUnbilledProvider);
  var nuclesPost = {
          'CustEttyId':toPost['CustEttyId'],
          'EttyId':toPost['EttyId'],
          'PrgEttyId':toPost['PrgEttyId'],
          'AcctId':toPost['AcctId'],
          'TxnCtgry':toPost['TxnCtgry'],
          'MediaNo':toPost['MediaNo'],
          'FromDate':toPost['FromDate'],
          'ToDate':toPost['ToDate']};
            var oltpPost = {
          'EttyId':toPost['EttyId'],
          'PrgEttyId':toPost['PrgEttyId'],
          'AcctId':toPost['AcctId'],
          'TxnCtgry':toPost['TxnCtgry'],
          'MediaNo':toPost['MediaNo'],
          'FromDate':toPost['FromDate'],
          'ToDate':toPost['ToDate']};
    if(toPost['FromDate']==null){
      return const Center(child: Text('No Data'),);
    }

    return AcxFbGrid(
      querysql: '/sp/qmultisrc?joinrs=1&sortKey=TxnDate|TxnId&sortDir=desc',
      params: {
        'ApiMgmtCustAcctTxnUnbillSearch': {'param':nuclesPost,'src':'nucleus'},
      'RpeDrivewayTxnUnbillSearch':{'param':oltpPost
      ,'src':'oltp'}},
      idField: 'TxnId',
      gridTitle: 'UnBilled Transactions',
      onSelected: (TrinaRow val) async {
            await showAcxDialog(
                  context,
                  TransactionDtl(
                    val: val,
                  ));
            }
    );
  }
}
 