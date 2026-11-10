import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/transaction/transaction_controller.dart';
import 'package:nucleusv2/src/feature/mcmgmt/screens/billingacc/transaction/oltp/oltp_detail.dart';
import 'package:nucleusv2/src/feature/mcmgmt/screens/billingacc/transaction/transaction_controller.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=804;

@RoutePage()
class MchtMgmtTxnOltpLanding extends ConsumerWidget {
  const MchtMgmtTxnOltpLanding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final txnSearchFormKey = GlobalKey<FormBuilderState>();
    final txnParam = ref.watch(txnSearchMchtOltpContorllerProvider);
    Map<String, dynamic> formNewValue = {
      "AcctId": txnParam['AcctId'],
      "EttyId": txnParam['EttyId'],
      "MediaNo": txnParam['MediaNo'],
      "TadNo": txnParam['TadNo'],
      "LocNo": txnParam['LocNo'],
      "TxnInd": txnParam['TxnInd'],
      "TxnDate": txnParam['TxnDate'] == null
          ? null
          : DateTime.parse(txnParam['TxnDate'].toString()),
      "TxnCtgry": txnParam['TxnCtgry']
    };
    return SingleChildScrollView(
      child: SizedBox(
        height: 1280,
        child: ListView(children: [
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
                    FbHiddenText(
                        name: 'EttyId'),
                    FbHiddenText(
                        name: 'AcctId'),

                    //                              "AcctId":14,
                    //  "PrgEttyId":1,
                    //  "CustEttyId":528,
                    //  "EttyId":529,
                    //  "MediaNo":null,
                    // "FromDate": '20240101',
                    // "ToDate": '20241231',
                    // "TxnCtgry":null
                    const Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(Icons.person),
                              ),
                              sbw20,
                              Expanded(
                                  child: FbNumber(
                                      label: 'Media No', name: 'MediaNo')),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(Icons.point_of_sale),
                              ),
                              sbw20,
                              Expanded(
                                  child:
                                      FbNumber(label: 'TAD No', name: 'TadNo')),
                            ],
                          ),
                        ],
                      ),
                    ),
//                     const Expanded(
//                         child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                                  Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(left: 8),
//                                 child: Icon(Icons.person),
//                               ),
// sbw20,
//                               Expanded(child: FbText(label: 'Media No', name: 'MediaNo')),
//                             ],
//                           ),
//                         Row(
//                           children: [sbw20, Flexible(child: FbDateTimePicker(name: 'FromDate', label: 'From Date')), sbw10, Flexible(child: FbDateTimePicker(name: 'ToDate', label: 'To Date'))],
//                         ),
//                       ],
//                     )),
                    sbw10,
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              // Flexible(child: FbDateTimePicker( name: 'FromDate', label: 'From Date', onreset: () {
                              //     txnSearchFormKey.currentState!.fields['FromDate']?.didChange(null);
                              //   },)),
                              Flexible(
                                  child: FbDateTimePicker(
                                name: 'TxnDate',
                                label: 'Trsanction Date',
                              )),
                            ],
                          ),
                          Row(
                            children: [
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
                              //    const  Padding(
                              //   padding: EdgeInsets.only(left: 8),
                              //   child: Icon(Icons.store),
                              // ),
                              fbFieldGap,
                              const Expanded(
                                  child: FbText(
                                label: 'Loc No',
                                name: 'LocNo',
                              )),
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
                                            txnSearchFormKey
                                                .currentState!.value,
                                            [
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
          const TxnGridSearch()
        ]),
      ),
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
    var toPost = ref.watch(txnSearchOltpContorllerProvider);
    final query = QueryObject(
        querysql: '/sp/RpeDrivewayTxnSearch/queryasyncoltp',
        params: toPost,
        showMsg: false);
    final data = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget(
        value: data,
        data: (theData) {
          return SingleChildScrollView(
              child: SizedBox(
            height: 500,
            child: AcxTrinaGridExtDatawExport(
                gridTitle: 'Online Transactions',
                extData: theData,
                idField: 'Id',
                onSelected: (TrinaRow val) async {
                  await showAcxDialog(
                      context,
                      McmgmtOltpDetail(
                        val: val,
                      ));
                }),
          ));
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
