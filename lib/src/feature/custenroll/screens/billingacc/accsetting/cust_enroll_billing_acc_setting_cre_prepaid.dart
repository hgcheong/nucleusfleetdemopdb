import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=430;

@RoutePage()
class CustEnrollBillingAccPrePaid extends ConsumerWidget {
  const CustEnrollBillingAccPrePaid(
      {this.custEttyId, this.prgEttyId, this.acctId, this.ettyId, super.key});

  final String? custEttyId;
  final String? prgEttyId;
  final String? acctId;
  final String? ettyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    
    final custEnrlBillAccPostFormKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      "EttyId": ettyId,
      "AcctId": acctId,
      "AcctType": null,
      "SchdId": null
    };
    final qryObj = QueryObject(
        querysql: '/sp/ApiEnrlCustBillingAcctPrePaid/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "PrgEttyId": prgEttyId,
          "EttyId": ettyId,
          "AcctId": acctId,
          "AcctType": null,
          "SchdId": null
        },
        showMsg: false);

    final qryResult = ref.watch(ReturndatafreezedProvider(qryObj));

    return AsyncValueWidget(
        value: qryResult,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
            key: custEnrlBillAccPostFormKey,
            initialValue: formNewValue,
            child: SizedBox(
                height: 1280,
                child: Row(children: [
                  const Flexible(
                    flex: 3,
                    child: Column(children: [
                      SelectableText('Credit Expiry Settings'),
                      Flexible(
                        child: FbLibView(
                            name: 'CrExpType',
                            label: 'Credit Expiry Type',
                            params: {"RefType": "CrExpType", "BitInd": null},
                            keyField: 'RefCd',
                            searchText: 'Dscp',
                            querySql: '/sp/GetLibRef/queryasyncnouser'),
                      ),
                      Flexible(
                        child: FbLibView(
                            name: 'CrExpUnit',
                            label: 'Creidt Expiry Unit',
                            params: {"RefType": "CrExpUnit", "BitInd": null},
                            keyField: 'RefCd',
                            searchText: 'Dscp',
                            querySql: '/sp/GetLibRef/queryasyncnouser'),
                      ),
                      FbText(name: 'CrExpValue', label: 'Credit Expiry Period'),
                    ]),
                  ),
                  const Flexible(child: Column(children: [])),
                  Flexible(
                      child: Column(
                    children: [
                      AcxSaveButtonManual(onSave: () {
                               if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                        custEnrlBillAccPostFormKey.currentState!.save();
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            custEnrlBillAccPostFormKey.currentState!.value,
                            theData.columnInfo);

                        final querySave = QueryObject(
                            querysql:
                                '/sp/ApiEnrlCustBillingAcctPrePaidSave/queryasync',
                            params: toPost,
                            showMsg: false);

                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            ref.invalidate(ReturndatafreezedProvider(qryObj));
                          }
                        });
                      }),
                      const AcxBackToList(listUrl: '././././list'),
                    AcxAuditLogReqBtn('ApiEnrlCustBillingAcctPrePaidSave', ettyId: ettyId.toString(),)
                    ],
                  ))
                ])),
          );
        });
  }
}
