import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class CustMgmtEarlyTerminateDialog extends ConsumerWidget {
  const CustMgmtEarlyTerminateDialog({
    super.key,
    this.custEttyId,
    this.issId,
    this.mbrEttyId,
    this.mediaEttyId,
    this.mediaId,
  });

  final String? custEttyId;
  final String? issId;
  final String? mbrEttyId;
  final String? mediaEttyId;
  final String? mediaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stsChangeKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "CustEttyId": custEttyId,
      "IssId": issId,
      "MbrEttyId": mbrEttyId,
      "MediaEttyId": mediaEttyId,
      "MediaId": mediaId,
      "Rmrk": null,
      "RsnCd": null,
      "TmntionDate": null
    };

    final query = QueryObject(
        querysql: '/sp/ApiMgmtMediaTerminate/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "IssId": issId,
          "MbrEttyId": mbrEttyId,
          "MediaEttyId": mediaEttyId,
          "MediaId": mediaId
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
            key: stsChangeKey,
            initialValue: formValue,
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
                                      const FbHiddenText(name: 'CustEttyId'),
                                      const FbHiddenText(name: 'MediaEttyId'),
                                      const FbHiddenText(name: 'MediaId'),
                                      const FbHiddenText(name: 'MbrEttyId'),
                                      const FbHiddenText(name: 'IssId'),
                                      FbText(
                                        name: 'PrgDscp',
                                        label: 'Description',
                                        initialValue:
                                            formValue['PrgDscp'] ?? '',
                                        readOnly: true,
                                      ),
                                      FbText(
                                        name: 'HolderName',
                                        label: 'Name',
                                        initialValue:
                                            formValue['HolderName'] ?? '',
                                        readOnly: true,
                                      ),
                                      FbText(
                                        name: 'MediaNo',
                                        label: 'Media Number',
                                        initialValue:
                                            formValue['MediaNo'] ?? '',
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
                            AcxSaveButtonManual(onSave: () {
                              
                              stsChangeKey.currentState!.save();
                              Map<String, dynamic> toPost =
                                  convertFormValueToSave(
                                      stsChangeKey.currentState!.value,
                                      theData.columnInfo);
                              toPost.remove('PrgDscp');
                              toPost.remove('HolderName');
                              toPost.remove('MediaNo');

                              final querySave = QueryObject(
                                  querysql:
                                      '/sp/ApiMgmtMediaTerminateSave/queryasync?logId=${convStrNewOrNullToNull(mediaEttyId) ?? 0}',
                                  params: toPost,
                                  showMsg: false);
                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((Returndata value) {
                                Toast.showresult(value);
                                if (isSuccess(value.message)) {
                                  ref.invalidate(
                                      ReturndatafreezedProvider(query));
                                }
                              });
                            }),
                            AcxAuditLogReqBtn('ApiMgmtMediaTerminateSave', ettyId: mediaEttyId.toString(),),
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
                                'Termination',
                                //   style: hdrStyle,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Card(
                                child: ListView(
                                  children: const [
                                    ListTile(
                                        title: FbDateTimePicker(
                                            name: 'TmntionDate',
                                            label: 'Termination Date')),
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
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      )
                    ],
                  ),
                ),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          );
        });
  }
}
