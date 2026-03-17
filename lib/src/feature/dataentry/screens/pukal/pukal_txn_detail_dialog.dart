import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class PukalTxnDetailDialog extends ConsumerWidget {
  const PukalTxnDetailDialog({
    super.key,
    this.txnId,
    this.acctId,
  });

  final String? txnId;
  final String? acctId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pukalTxnDtlKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "CompanyName": null,
      "BillingDate": null,
      "ObjectCode": null,
      "BillingAmt": null,
      "TxnStsDscp": null,
      "Agency": null,
      "BusinessArea": null,
      "DueDate": null,
      "ProcessDate": null,
      "ErrMsg": null
    };

    final query = QueryObject(
        querysql: '/sp/ApiMnlTxnPukal/queryasync',
        params: {
          "TxnId": txnId,
          "AcctId": acctId,
        },
        showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          if (theData.data != null) {
            formValue =
                convertFormValueToDisplay(theData.data![0], theData.columnInfo);
          }
          return FormBuilder(
            key: pukalTxnDtlKey,
            initialValue: formValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8, left: 8),
                  child: SelectableText(
                    'Pukal Transaction Info',
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 11,
                          child: Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ListView(
                                    children: [
                                      const FbHiddenText(name: 'TxnId'),
                                      const FbHiddenText(name: 'AcctId'),
                                      FbText(
                                        name: 'CompanyName',
                                        label: 'Company Name',
                                        initialValue:
                                            formValue['CompanyName'] ?? '',
                                        readOnly: true,
                                      ),
                                      const FbDateTimePicker(
                                          name: 'ProcessDate',
                                          label: 'Process date'),
                                      const FbDateTimePicker(
                                          name: 'BillingDate',
                                          label: 'Billing date'),
                                      const FbDateTimePicker(
                                          name: 'DueDate', label: 'Due date'),
                                      FbText(
                                        name: 'ObjectCode',
                                        label: 'Object Code',
                                        initialValue:
                                            formValue['ObjectCode'] ?? '',
                                        readOnly: true,
                                      ),
                                      FbText(
                                        name: 'BillingAmt',
                                        label: 'Billing Amount',
                                        initialValue:
                                            formValue['BillingAmt'] ?? '',
                                        readOnly: true,
                                      ),
                                      FbText(
                                        name: 'TxnStsDscp',
                                        label: 'Transaction Status Description',
                                        initialValue:
                                            formValue['TxnStsDscp'] ?? '',
                                        readOnly: true,
                                      ),
                                      FbText(
                                        name: 'Agency',
                                        label: 'Agency',
                                        initialValue: formValue['Agency'] ?? '',
                                        readOnly: true,
                                      ),
                                      FbText(
                                        name: 'BusinessArea',
                                        label: 'Business Area',
                                        initialValue:
                                            formValue['BusinessArea'] ?? '',
                                        readOnly: true,
                                      ),
                                    ],
                                  ),
                                ),
                                // const Spacer(
                                //   flex: 1,
                                // ),
                                // Expanded(
                                //   flex: 5,
                                //   child: ListView(
                                //     children: [
                                //       FbText(
                                //         name: 'StsDscp',
                                //         label: 'Current Status',
                                //         initialValue: formValue['StsDscp'] ?? '',
                                //         readOnly: true,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ))),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  singleton<AppRouter>().maybePop();
                                },
                                child: const Icon(Icons.exit_to_app))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Expanded(
                //   flex: 10,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         flex: 11,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             const Padding(
                //               padding: EdgeInsets.only(top: 8, left: 8),
                //               child: SelectableText(
                //                 'Termination',
                //                 //   style: hdrStyle,
                //               ),
                //             ),
                //             Expanded(
                //               flex: 5,
                //               child: Card(
                //                 child: ListView(
                //                   children: const [

                //                     ListTile(title: FbDateTimePicker(name: 'TmntionDate', label: 'Termination Date')),
                //                     ListTile(
                //                         title: FbText(
                //                       name: 'Note',
                //                       label: 'Note',
                //                       maxLines: 3,
                //                     )),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),

                //       ),
                //       const Spacer(flex: 1,)
                //     ],
                //   ),
                // ),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          );
        });
  }
}
