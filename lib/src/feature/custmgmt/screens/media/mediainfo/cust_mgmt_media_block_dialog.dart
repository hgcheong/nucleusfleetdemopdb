import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class CustMgmtMediaBlockDialog extends ConsumerWidget {
  const CustMgmtMediaBlockDialog(
      {super.key,
      this.custEttyId,
      this.mediaEttyId,
      required this.blockFlag
});

  final String? custEttyId;
  final String? mediaEttyId;
  final String blockFlag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final issueReissue = GlobalKey<FormBuilderState>();
    // Map<String, dynamic> formValue = {
    //   "MediaId": mediaId,
    //   "ExpDate": null,
    //   "RsnCd": null,
    //   "Note": null,
    //   "IssueType": null,
    //   "CustEttyId": custEttyId,
    //   "MbrEttyId": mbrEttyId,
    //   "MediaEttyId": mediaEttyId,
    //   "TaskId": null
    // };

      Map<String, dynamic> formValue = {
      "CustEttyId": custEttyId,
      "MediaEttyId": mediaEttyId,
      "FromDate": null,
      "ToDate": null,
      "Note": null,

   
    };

    final query = QueryObject(
        querysql: '/sp/ApiMgmtMediaBlock/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "MediaEttyId": mediaEttyId,
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
              key: issueReissue,
              initialValue: formValue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 8),
                      child: SelectableText(
                        'Card Info',
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
                                              name: 'CustEttyId'),

                                          const FbHiddenText(
                                              name: 'MediaEttyId'),

                                          //    "PrgDscp": null,
                                          // "MemberName": "Chen Loong Tan",
                                          // "VhcRgsNo": "W9388",
                                          // "MediaCtgryDscp": "DRIVER CARD",
                                          FbText(
                                            name: 'PrgDscp',
                                            label: 'Program Description',
                                            initialValue:
                                                formValue['PrgDscp'] ?? '',
                                            readOnly: true,
                                          ),

                                          FbText(
                                            name: 'MemberName',
                                            label: 'Member Name',
                                            initialValue:
                                                formValue['MemberName'] ?? '',
                                            readOnly: true,
                                          ),
                                          FbText(
                                            name: 'VhcRgsNo',
                                            label: 'Vehicle Registration',
                                            initialValue:
                                                formValue['VhcRgsNo'] ?? '',
                                            readOnly: true,
                                          ),

                                          FbText(
                                            name: 'MediaCtgryDscp',
                                            label: 'Card Category',
                                            initialValue:
                                                formValue['MediaCtgryDscp'] ??
                                                    '',
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
                
                                  issueReissue.currentState!.save();
                                  Map<String, dynamic> toPost =
                                      convertFormValueToSave(
                                          issueReissue.currentState!.value,
                                          theData.columnInfo);

                                  toPost.remove('PrgDscp');
                                  toPost.remove('MemberName');
                                  toPost.remove('VhcRgsNo');
                                  toPost.remove('MediaCtgryDscp');

                                  final querySave = QueryObject(
                                      querysql:
                                          '/sp/ApiMgmtMediaBlockSave/queryasync?logId=${convStrNewOrNullToNull(mediaEttyId) ?? 0}',
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
                                AcxAuditLogReqBtn('ApiMgmtMediaBlockSave',ettyId: mediaEttyId.toString(),),
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
                            flex: 11,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, left: 8),
                                  child: SelectableText(
                                    'Block Card',
                                    //   style: hdrStyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        children: [
                                          ListTile(
                                              title: FbDateTimePicker(
                                                       onreset: (){
                                                  issueReissue.currentState!.patchValue({
                                                    "FromDate":null
                                                  });
                                                },
                                            label: 'From Date',
                                            name: 'FromDate',
                                          )),
                                          ListTile(
                                              title: FbDateTimePicker(
                                                       onreset: (){
                                                  issueReissue.currentState!.patchValue({
                                                    "ToDate":null
                                                  });
                                                },
                                            label: 'To Date',
                                            name: 'ToDate',
                                          )),
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
              key: issueReissue,
              initialValue: formValue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 8),
                      child: SelectableText(
                        'Card Info',
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
                                              name: 'CustEttyId'),

                                          const FbHiddenText(
                                              name: 'MediaEttyId'),

                                          //    "PrgDscp": null,
                                          // "MemberName": "Chen Loong Tan",
                                          // "VhcRgsNo": "W9388",
                                          // "MediaCtgryDscp": "DRIVER CARD",
                                          FbText(
                                            name: 'PrgDscp',
                                            label: 'Program Description',
                                            initialValue:
                                                formValue['PrgDscp'] ?? '',
                                            readOnly: true,
                                          ),

                                          FbText(
                                            name: 'MemberName',
                                            label: 'Member Name',
                                            initialValue:
                                                formValue['MemberName'] ?? '',
                                            readOnly: true,
                                          ),
                                          FbText(
                                            name: 'VhcRgsNo',
                                            label: 'Vehicle Registration',
                                            initialValue:
                                                formValue['VhcRgsNo'] ?? '',
                                            readOnly: true,
                                          ),

                                          FbText(
                                            name: 'MediaCtgryDscp',
                                            label: 'Card Category',
                                            initialValue:
                                                formValue['MediaCtgryDscp'] ??
                                                    '',
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
                  
                                        issueReissue.currentState!.patchValue({"FromDate":null, "ToDate":null});
                         
                                  issueReissue.currentState!.save();
                                  Map<String, dynamic> toPost =
                                      convertFormValueToSave(
                                          issueReissue.currentState!.value,
                                          theData.columnInfo);

                                  toPost.remove('PrgDscp');
                                  toPost.remove('MemberName');
                                  toPost.remove('VhcRgsNo');
                                  toPost.remove('MediaCtgryDscp');

                                  final querySave = QueryObject(
                                      querysql:
                                          '/sp/ApiMgmtMediaBlockSave/queryasync?logId=${convStrNewOrNullToNull(mediaEttyId) ?? 0}',
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
                                AcxAuditLogReqBtn('ApiMgmtMediaBlockSave',ettyId: mediaEttyId.toString(),),
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
                                    'Unblock Card',
                                    //   style: hdrStyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        children: const [
                                        
                                         FbHiddenDateTime(
                                            
                                            name: 'FromDate',
                                          ),
                                              FbHiddenDateTime(
                                  
                                            name: 'ToDate',
                                          ),
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
