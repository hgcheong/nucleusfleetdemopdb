import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_hiddentext.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_text.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

const int wid=475;

@RoutePage()
class CustEnrollRiskSetting extends StatelessWidget {
  const CustEnrollRiskSetting({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  });

  final String? custEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return CustEnrollRiskForm(
      custEttyId: custEttyId,
    );
  }
}

class CustEnrollRiskForm extends HookConsumerWidget {
  const CustEnrollRiskForm({
    super.key,
    this.custEttyId,
  });
  final String? custEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custEnrollCreditRiskFormKey = GlobalKey<FormBuilderState>();
    final querySql = QueryObject(
        querysql: '/sp/ApiEnrlCrRisk/queryasync',
        params: {"CustEttyId": custEttyId},
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "MaxCrExpsr": null,
      "SecuritySumReq": null,
      "SecureAmt": null,
      "RcmmdCrLimit": null,
      "RcmmdSecuritySum": null,
      "ProposeSecuritySum": null,
      "QttvFactorRate": null,
      "QltvFactorRate": null,
      "Note": null,
      "CustEttyId": custEttyId,
      "CrScore": null
    };
    final formValue = useState<Map<String, dynamic>>(formNewValue);
    final formData = ref.watch(ReturndatafreezedProvider(querySql));
    return formData.when(
        error: (x, e) => Center(child: Text(e.toString()),),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (theData) {
          if (theData.data != null) {
            formValue.value = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          } else {
            formValue.value = formNewValue;
          }
          return FormBuilder(
              initialValue: formValue.value,
              key: custEnrollCreditRiskFormKey,
              onChanged: () {
                custEnrollCreditRiskFormKey.currentState!.save();
              },
              child: Row(children: [
                sbw54,
                Flexible(
                    flex: 5,
                    child: Column(children: [
                      FbHiddenText(
                        name: 'CustEttyId',
                      ),
                      FbText(
                          name: 'CrScore',
                          label: "Credit Score",
                          initialValue: formValue.value['CrScore']),
                      FbText(
                        name: 'MaxCrExpsr',
                        label: "Max Credit Exposure",
                        initialValue: formValue.value['MaxCrExpsr'],
                      ),
                      FbText(
                        name: 'SecuritySumReq',
                        label: "Security Sum Required",
                        initialValue: formValue.value['SecuritySumReq'],
                      ),
                      FbText(
                        name: 'SecureAmt',
                        label: "Security Amount",
                        initialValue: formValue.value['SecureAmt'],
                      ),
                      FbText(
                        name: 'RcmmdCrLimit',
                        label: "Recommended Credit Limit",
                        initialValue: formValue.value['RcmmdCrLimit'],
                      ),
                    ])),
                sbw20,
                Flexible(
                    flex: 5,
                    child: Column(
                      children: [
                        FbText(
                          name: 'RcmmdSecuritySum',
                          label: "Recommended Security Sum",
                          initialValue:
                              formValue.value['RcmmdSecuritySum'],
                        ),
                        FbText(
                          name: 'ProposeSecuritySum',
                          label: "Porpose Security Sum",
                          initialValue:
                              formValue.value['ProposeSecuritySum'],
                        ),
                        FbText(
                          name: 'QttvFactorRate',
                          label: "Quantitative Factor Rate",
                          initialValue:
                              formValue.value['QttvFactorRate'],
                        ),
                        FbText(
                          name: 'QltvFactorRate',
                          label: "Qualitative Factor Rate",
                          initialValue:
                              formValue.value['QltvFactorRate'],
                        ),
                        FbText(
                          name: 'Note',
                          label: "Note",
                          initialValue: formValue.value['Note'],
                        ),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    AcxSaveButtonManual(
                      onSave: () {
                               if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                        custEnrollCreditRiskFormKey.currentState!.save();
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            custEnrollCreditRiskFormKey.currentState!.value,
                            theData.columnInfo);
                        final querySave = QueryObject(
                            querysql: '/sp/ApiEnrlCrRiskSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
                            params: toPost,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((Returndata value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            ref.invalidate(ReturndatafreezedProvider(querySql));
                          }
                        });
                      },
                    ),
                    sbh10,
                    AcxAuditLogReqBtn('ApiEnrlCrRiskSave',ettyId: custEttyId.toString(),)
                  ]),
                )
              ]));
        });
  }
}
