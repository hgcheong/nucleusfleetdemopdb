import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class CustMgmtBillingAcctBlockDialog extends ConsumerWidget {
  const CustMgmtBillingAcctBlockDialog(
      {super.key,
      this.prgEttyId,
      this.acctId,
      this.ettyId,
      required this.blockFlag
      });

  final String? prgEttyId;
  final String? acctId;
  final String? ettyId;
  final String blockFlag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custBillingAcctBlock = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "PrgEttyId": prgEttyId,
      "AcctId": acctId,
      "FromDate": null,
      "ToDate": null,
    };

    final query = QueryObject(
        querysql: '/sp/ApiMgmtAcctBlock/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "AcctId": acctId,
        },
        showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          {
            if (theData.data != null) {
              formValue = convertFormValueToDisplay(
                  theData.data![0], theData.columnInfo);
            }
            if(blockFlag=="N"){
     return FormBuilder(
              key: custBillingAcctBlock,
              initialValue: formValue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 8),
                      child: SelectableText(
                        'Account Info',
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
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
                                          const FbHiddenText(
                                              name: 'PrgEttyId'),

                                          const FbHiddenText(
                                              name: 'AcctId'),
                                          FbText(
                                            name: 'PrgDscp',
                                            label: 'Program Description',
                                            initialValue:
                                                formValue['PrgDscp'] ?? '',
                                            readOnly: true,
                                          ),

                               
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ))),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                AcxSaveButtonManual(onSave: () {
                           
                                  custBillingAcctBlock.currentState!.save();
                                  Map<String, dynamic> toPost = 
                                      convertFormValueToSave(
                                          custBillingAcctBlock.currentState!.value,
                                          theData.columnInfo);
                                        
                                  toPost.remove('PrgDscp');

                                  final querySave = QueryObject(
                                      querysql:
                                          '/sp/ApiMgmtAcctBlockSave/queryasync?logId=${convStrNewOrNullToNull(acctId) ?? 0}',
                                      params: toPost,
                                      showMsg: false);
                                  final saveResult = ref.read(
                                      ReturndatafreezedProvider(querySave)
                                          .future);
                                  saveResult.then((Returndata value) {
                                    Toast.showresult(value);
                                    if (isSuccess(value.message)) {
                                      ref.invalidate(
                                          ReturndatafreezedProvider(query));
                                    }
                                  });
                                }),
                                AcxAuditLogReqBtn('ApiMgmtAcctBlockSave',ettyId: acctId.toString(),),
                                sbh10,
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
                    Expanded(
                      flex: 10,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, left: 8),
                                  child: SelectableText(
                                    'Block Account',
                                    //   style: hdrStyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        children:   [
                                           ListTile(
                                              title: FbDateTimePicker(
                                                onreset: (){
                                                  custBillingAcctBlock.currentState!.patchValue({
                                                    "FromDate":null
                                                  });
                                                },
                                            label: 'From Date',
                                            name: 'FromDate',
                                          )),
                                           ListTile(
                                              title: FbDateTimePicker(
                                                 onreset: (){
                                                  custBillingAcctBlock.currentState!.patchValue({
                                                    "ToDate":null
                                                  });
                                                },
                                            label: 'To Date',
                                            name: 'ToDate',
                                          )),
                                          // ListTile(
                                          //   title: FbLibView(
                                          //                                           name: 'RsnCd',
                                          //                                           label: 'Reason',
                                          //                                           params: {"EttyId": ettyId},
                                          //                                           keyField: 'RefCd',
                                          //                                           searchText: 'Dscp',
                                          //                                           querySql:
                                          //     '/sp/ApiRsnCdList/queryasyncnouser'),
                                          // ),
                                           ListTile(
                                              title: FbText(
                                            name: 'Note',
                                            label: 'Note',
                                            maxLines: 3,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // sbw20,
                          // sbw20,
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, left: 8),
                                  child: SelectableText(
                                    'Alerts',
                                    //   style: hdrStyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Card(
                                      child: ListView(
                                    children: [
                                      ListTile(
                                          title: SelectableText(
                                              formValue['AlertMsg'] ?? ''))
                                    ],
                                  )),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(flex: 1)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
            }
            else{
     return FormBuilder(
              key: custBillingAcctBlock,
              initialValue: formValue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 8),
                      child: SelectableText(
                        'Account Info',
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
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
                                          const FbHiddenText(
                                              name: 'PrgEttyId'),

                                          const FbHiddenText(
                                              name: 'AcctId'),
                                          FbText(
                                            name: 'PrgDscp',
                                            label: 'Program Description',
                                            initialValue:
                                                formValue['PrgDscp'] ?? '',
                                            readOnly: true,
                                          ),

                               
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ))),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                AcxSaveButtonManual(onSave: () {
                            
                                  custBillingAcctBlock.currentState!.patchValue({"FromDate":null, "ToDate":null});
                         
                                  custBillingAcctBlock.currentState!.save();
                                  // Map<String, dynamic> toPost =
                                  //     convertFormValueToSave(
                                  //         custBillingAcctBlock.currentState!.value,
                                  //         theData.columnInfo);
                                  Map<String, dynamic> toPost =  Map.from(custBillingAcctBlock.currentState!.value);
                                  toPost.remove('PrgDscp');
                                  
                                  final querySave = QueryObject(
                                      querysql:
                                          '/sp/ApiMgmtAcctBlockSave/queryasync?logId=${convStrNewOrNullToNull(acctId) ?? 0}',
                                      params: toPost,
                                      showMsg: false);
                                  final saveResult = ref.read(
                                      ReturndatafreezedProvider(querySave)
                                          .future);
                                  saveResult.then((Returndata value) {
                                    Toast.showresult(value);
                                    if (isSuccess(value.message)) {
                                      ref.invalidate(
                                          ReturndatafreezedProvider(query));
                                    }
                                  });
                                }),
                                AcxAuditLogReqBtn('ApiMgmtAcctBlockSave', ettyId: acctId.toString(),),
                                sbh10,
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
                    Expanded(
                      flex: 10,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               const FbHiddenDateTime(name: 'FromDate', initialValue: null,),
                                 const FbHiddenDateTime(name: 'ToDate', initialValue: null,),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, left: 8),
                                  child: SelectableText(
                                    'Unblock Account',
                                    //   style: hdrStyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Card(
                                    child: Padding(
                                      padding:  const EdgeInsets.all(8.0),
                                      child: ListView(
                                        children:  const [
                                            ListTile(
                                              title: FbText(
                                            name: 'Note',
                                            label: 'Note',
                                            maxLines: 3,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // sbw20,
                          // sbw20,
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, left: 8),
                                  child: SelectableText(
                                    'Alerts',
                                    //   style: hdrStyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Card(
                                      child: ListView(
                                    children: [
                                      ListTile(
                                          title: SelectableText(
                                              formValue['AlertMsg'] ?? ''))
                                    ],
                                  )),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(flex: 1)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
            }
       
          }
        });
  }
}
