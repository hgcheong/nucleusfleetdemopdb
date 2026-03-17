import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class CustMgmtMediaReissueDialog extends ConsumerWidget {
  const CustMgmtMediaReissueDialog(
      {super.key,
      this.custEttyId,
      this.issId,
      this.mbrEttyId,
      this.mediaEttyId,
      this.mediaId});

  final String? custEttyId;
  final String? issId;
  final String? mbrEttyId;
  final String? mediaEttyId;
  final String? mediaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final issueReissue = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "MediaId": mediaId,
      "ExpDate": null,
      "RsnCd": null,
      "Note": null,
      "IssueType": null,
      "CustEttyId": custEttyId,
      "MbrEttyId": mbrEttyId,
      "MediaEttyId": mediaEttyId,
      "TaskId": null
    };

    final query = QueryObject(
        querysql: '/sp/ApiMgmtMediaIssue/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "MbrEttyId": mbrEttyId,
          "MediaEttyId": mediaEttyId,
          // "MediaId": mediaId,
          "IssId": issId
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
                        'Media Info',
                      ),
                    ),
                    Expanded(
                      flex: 2,
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
                                          const FbHiddenText(name: 'MediaId'),
                                          const FbHiddenText(
                                              name: 'CustEttyId'),
                                          const FbHiddenText(name: 'MbrEttyId'),
                                          const FbHiddenText(
                                              name: 'MediaEttyId'),
                                          const FbHiddenText(name: 'TaskId'),
                                      
                                          //                     "PrgDscp": "X-Fleet Government Kad Inden (Postpaid)",
                                          // "MediaNo": "78971341000000017",
                                          // "ExpDate": "2044-06-27T00:00:00",
                                          FbText(
                                            name: 'PrgDscp',
                                            label: 'Description',
                                            initialValue:
                                                formValue['PrgDscp'] ?? '',
                                            readOnly: true,
                                          ),

                                          FbText(
                                            name: 'MediaNo',
                                            label: 'Media Number',
                                            initialValue:
                                                formValue['MediaNo'] ?? '',
                                            readOnly: true,
                                          ),
                                              const FbDateTimePicker(
                                                label: 'Expiry Date',
                                              name: 'ExpDate'),
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
                                AcxSaveButtonManual(onSave: () {
                                  issueReissue.currentState!.save();
                                  Map<String, dynamic> toPost =
                                      convertFormValueToSave(
                                          issueReissue.currentState!.value,
                                          theData.columnInfo);
                                  toPost.remove('PrgDscp');
                                  toPost.remove('MediaNo');

                                  final querySave = QueryObject(
                                      querysql:
                                          '/sp/ApiMgmtMediaIssueSave/queryasync?logId=${convStrNewOrNullToNull(mediaEttyId) ?? 0}',
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
                                sbh10,
                                AcxAuditLogReqBtn('ApiMgmtMediaIssueSave', ettyId: mediaEttyId.toString(),),
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
                      flex: 5,
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
                                    'Replace/Reissue',
                                    //   style: hdrStyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        children: [
                                          const ListTile(
                                            title: FbOption(
                                              orientation:
                                                  OptionsOrientation.wrap,
                                              label: 'Choose One',
                                              name: 'IssueType',
                                              querysql:
                                                  '/view/async/vwmediaissue',
                                              params: {},
                                            ),
                                          ),
                                          ListTile(
                                              title: FbLibView(
                                                  name: 'RsnCd',
                                                  label: 'Reason to Change',
                                                  params: {
                                                    "EttyId": mediaEttyId,
                                                  },
                                                  keyField: 'RefCd',
                                                  searchText: 'Dscp',
                                                  querySql:
                                                      '/sp/ApiRsnCdList/queryasyncnouser')),
                                          const ListTile(
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
                          // Expanded(
                          //   flex: 7,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       const Padding(
                          //         padding: EdgeInsets.only(top: 8, left: 8),
                          //         child: SelectableText(
                          //           'Alerts',
                          //           //   style: hdrStyle,
                          //         ),
                          //       ),
                          //       Expanded(
                          //         flex: 6,
                          //         child: Card(
                          //             child: ListView(
                          //           children: [
                          //             ListTile(
                          //                 title: SelectableText(
                          //                     formValue['AlertMsg'] ?? ''))
                          //           ],
                          //         )),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const Spacer(flex: 1)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
