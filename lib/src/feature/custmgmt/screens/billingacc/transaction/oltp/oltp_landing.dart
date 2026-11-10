import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/transaction/transaction_controller.dart';
import 'package:nucleusv2/src/feature/mcmgmt/screens/billingacc/transaction/oltp/oltp_detail.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=788;

@RoutePage()
class CustMgmtTxnOltpLanding extends ConsumerWidget {
  const CustMgmtTxnOltpLanding(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final txnSearchFormKey = GlobalKey<FormBuilderState>();
    final txnParam = ref.read(txnSearchOltpContorllerProvider);
    Map<String, dynamic> formNewValue = {
      "AcctId": txnParam['AcctId'],
      "CustEttyId": custEttyId,
      "EttyId": null,
      "MediaNo": txnParam['MediaNo'],
      "TadNo": txnParam['TadNo'],
      "LocNo": txnParam['LocNo'],
      "TxnInd": txnParam['TxnInd'],
      "TxnDate": txnParam['TxnDate'] == null
          ? null
          : DateTime.parse(txnParam['TxnDate'].toString()),
      "TxnCtgry": txnParam['TxnCtgry'],
    };
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      sbh10,
      const SelectableText(
          "OLTP Transactions are NOT processed transactions. The transaction amount are not reflected in the Account’s Current Balance and Available Credit"),
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
                FbHiddenText(name: 'CustEttyId'),
                const FbHiddenText(
                    name: 'EttyId'),
                FbHiddenText(name: 'AcctId'),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.person),
                          ),
                          sbw20,
                          Flexible(
                            child: FbLibViewExt(
                              name: 'TxnInd',
                              label: 'Transaction Indicator',
                              datasrc: txnIndicator,
                              initialValue: formNewValue['TxnInd'],
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.point_of_sale),
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
                            name: 'TxnDate',
                            label: 'Transaction Date',
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: FbText(
                            label: 'Loc No',
                            name: 'LocNo',
                          )),
                          fbFieldGap,
                          Expanded(
                              child: FbNumber(label: 'TAD No', name: 'TadNo')),
                        ],
                      ),

                      // Row(children: [    Flexible(
                      //           child: FbOptionExt(
                      //                                       name: 'TxnInd',
                      //                                       label: 'Txn Option',
                      //                                       dataext: txnIndicator,
                      //                                       orientation: OptionsOrientation.horizontal,
                      //                                     ),
                      //         )],)
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
                                        txnSearchFormKey.currentState!.value, [
                                  'TxnDate',
                                ]);

                                ref
                                    .read(txnSearchOltpContorllerProvider
                                        .notifier)
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
    ]),),const SliverFillRemaining(child: TxnGridSearch(),)
    ],);

    
  }
}

class TxnGridSearch extends ConsumerWidget {
  const TxnGridSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(txnSearchOltpContorllerProvider);
    final query = QueryObject(
        querysql: '/sp/RpeDrivewayTxnSearch/queryasyncoltp',
        params: toPost,
        showMsg: false);
    final data = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget(
        value: data,
        data: (theData) {
          return AcxTrinaGridExtDatawExport(
              gridTitle: 'Online Transactions',
              extData: theData,
              idField: 'Id',
              onSelected: (TrinaRow val) async {
                await showAcxDialog(
                    context,
                    McmgmtOltpDetail(
                      val: val,
                    ));
              });
        });
  }
}

Returndata txnIndicator = Returndata.fromJson({
  "data": [
    {"RefType": "SALE", "RefCd": "0", "Dscp": "SALE transaction"},
    {"RefType": "OTHERS", "RefCd": "1", "Dscp": "OTHER transaction"},
  ],
  "output": [
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 2,
  "columnInfo": [
    {
      "title": "RefType",
      "data": "RefType",
      "dataType": "varchar",
      "visible": true
    },
    {"title": "RefCd", "data": "RefCd", "dataType": "varchar", "visible": true},
    {"title": "Dscp", "data": "Dscp", "dataType": "nvarchar", "visible": true},
  ],
  "message": null,
  "error": null
});
