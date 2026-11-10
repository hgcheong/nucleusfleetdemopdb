import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class CustMgmgtBillingAccTempCreBalDialog extends ConsumerWidget {
  const CustMgmgtBillingAccTempCreBalDialog({
    super.key,
    this.custEttyId,
    this.acctId,
    this.prgEttyId,
    this.ettyId,
  });

  //  "CustEttyId": 528,
  //   "PrgEttyId": 1,
  //   "EttyId": 529,
  //   "AcctId":14
  final String? custEttyId;
  final String? acctId;
  final String? prgEttyId;
  final String? ettyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adjutCreBalStateKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "CustEttyId": custEttyId,
      "AcctId": acctId,
      "PrgEttyId": prgEttyId,
      "EttyId": ettyId,
      "CrId": null
    };

    final query = QueryObject(
        querysql: '/sp/ApiMgmtCustBillingTempCr/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "AcctId": acctId,
          "PrgEttyId": prgEttyId,
          "EttyId": ettyId
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
            key: adjutCreBalStateKey,
            initialValue: formValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8, left: 8),
                  child: SelectableText(
                    'Temporary Credit Limit',
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
                                  flex: 2,
                                  child: ListView(
                                    children: [
                                      const FbHiddenDateTime(name: 'MdfDate'),
                                      const FbHiddenText(name: 'CustEttyId'),
                                      const FbHiddenText(name: 'AcctId'),
                                      const FbHiddenText(name: 'EttyId'),
                                      const FbHiddenText(name: 'PrgEttyId'),
                                      const FbHiddenText(name: 'CrId'),
                                      FbText(
                                        name: 'Dscp',
                                        label: 'Description',
                                        initialValue: formValue['Dscp'] ?? '',
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
      
                              adjutCreBalStateKey.currentState!.save();
                              Map<String, dynamic> toPost =
                                  convertFormValueToSave(
                                      adjutCreBalStateKey.currentState!.value,
                                      theData.columnInfo);
                              toPost.remove('Dscp');

                              final querySave = QueryObject(
                                  querysql:
                                      '/sp/ApiMgmtCustBillingTempCrSave/queryasync?logId=${convStrNewOrNullToNull(acctId) ?? 0}',
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
                            AcxAuditLogReqBtn('ApiMgmtCustBillingTempCrSave',ettyId: formValue["AcctId"].toString(),),
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
                                'Change Temporary Credit Limit',
                                //   style: hdrStyle,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Card(
                                child: ListView(
                                  children: [
                                    const ListTile(
                                        title: Row(
                                      children: [
                                        Expanded(
                                            child: FbDateTimePicker(
                                                name: 'FromDate',
                                                label: 'From Date')),
                                        fbFieldGap,
                                        Expanded(
                                            child: FbDateTimePicker(
                                                name: 'ToDate',
                                                label: 'To Date'))
                                      ],
                                    )),
                                    ListTile(
                                        title: FbNumber(
                                            name: 'TmpCr',
                                            label: 'Temporary Credit Limit',
                                            initialValue: num.parse(
                                              formValue['TmpCr'].toString(),
                                            ))),
                                    const ListTile(
                                        title: FbLibView(
                                            name: 'RsnCd',
                                            label: 'Reason to Change',
                                            params: {
                                              "RefType": "CRLIMITTEMPRSNCD"
                                            },
                                            keyField: 'RefCd',
                                            searchText: 'Dscp',
                                            querySql:
                                                '/sp/ApiRsnCdList/queryasyncnouser')),
                                    const ListTile(
                                      title: FbText(
                                        name: 'Note',
                                        label: 'Note',
                                        maxLines: 5,
                                      ),
                                    )
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
