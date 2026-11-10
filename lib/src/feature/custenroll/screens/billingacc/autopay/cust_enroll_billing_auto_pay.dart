import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custenroll/screens/billingacc/cust_enroll_billing_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

//PREPAID NO AUTOPAYMENT so don't show
const int wid=432;

@RoutePage()
class CustEnrollBillingAutoPay extends StatelessWidget {
  const CustEnrollBillingAutoPay({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return const CustEnrlBilAccBankForm();
  }
}

class CustEnrlBilAccBankForm extends ConsumerWidget {
  const CustEnrlBilAccBankForm({
    super.key,
    this.prgEttyId,
  });

  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final billingAccautopKey = GlobalKey<FormBuilderState>();
    final params = ref.watch(billingAccDetailProvider);
    if (params['CustEttyId'] == null) {
      singleton<AppRouter>().navigatePath('././././list');
    }

    final query = QueryObject(
        querysql: '/sp/ApiEnrlCustAutoPymt/queryasync',
        params: params,
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "AcctHolderName": null,
      "AcctId": null,
      "AcctType": null,
      "AutoExecDays": null,
      "AutoPymtInd": null,
      "Bank": null,
      "BankAcctId": null,
      "BankAcctNo": null,
      "BankAcctType": null,
      "BranchCd": null,
      "CustEttyId": null,
      "EttyId": null,
      "MdfDate": null,
      "PayeeCd": null,
      "PayeeRef": null,
      "PrgEttyId": null,
      "PymtType": null
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);

          formNewValue['AcctId'] = params['AcctId'].toString();
          return FormBuilder(
              key: billingAccautopKey,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                billingAccautopKey.currentState!.save();
              },
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FbHiddenText(name: 'CustEttyId'),
                          const FbHiddenText(name: 'EttyId'),
                          const FbHiddenText(name: 'AcctId'),
                          const FbHiddenText(name: 'BankAcctId'),
                          const FbHiddenText(name: 'PrgEttyId'),
                          const FbHiddenText(name: 'PymtType'),
                          const FbHiddenText(name: 'AcctType'),
                          const FbHiddenDateTime(name: 'MdfDate'),
                          FbSwitch(
                            name: 'AutoPymtInd',
                            label: 'Enable Auto Payment',
                            initialValue: formNewValue['AutoPymtInd'],
                          ),
                          FbLibView(
                              name: 'AutoExecDays',
                              label: 'Dr Customer x day after Settlement',
                              params: const {
                                "RefType": "AUTOEXECDAY",
                                "BitInd": null
                              },
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/sp/GetLibRef/queryasyncnouser',
                              initialValue:
                                  formNewValue['AutoExecDays'].toString()),
                          const SelectableText('Payment Bank Details'),
                          FbLibView(
                              name: 'Bank',
                              label: 'Bank',
                              params: const {},
                              keyField: 'Bank',
                              searchText: 'BankName',
                              querySql: '/view/async/VwBank',
                              initialValue: formNewValue['Bank'].toString()),
                          const FbText(name: 'BranchCd', label: 'Branch Code'),
                          FbLibref(
                              name: 'BankAcctType',
                              label: 'Bank Account Type',
                              params: const {
                                "RefType": "BANKACCTTYPE",
                                "BitInd": null
                              },
                              initialValue:
                                  formNewValue['BankAcctType'].toString()),
                          const FbText(
                            name: 'BankAcctNo',
                             label: 'Bank Account Number',
                          ),
                         const FbText(
                            name: 'AcctHolderName',
                              label: 'Account Holder Name',
                          ),
                         const Row(
                            children: [
                              Expanded(
                                child: FbText(
                                  name: 'PayeeCd',
                                    label: 'Payee Code'
                                ),
                              ),
                              fbFieldGap, Expanded(
                                child: FbText(
                                  name: 'PayeeRef',
                                  label: 'Payee Reference'
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      AcxSaveButtonManual(
                        confirmSave: false,
                        onSave: () {
                                 if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          billingAccautopKey.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(billingAccautopKey.currentState!.value),
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql:
                                  '/sp/ApiEnrlCustAutoPymtSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              ref.invalidate(ReturndatafreezedProvider(query));
                            }
                          });
                        },
                      ),
                    AcxAuditLogReqBtn('ApiEnrlCustAutoPymtSave' , ettyId: prgEttyId.toString(),)
                    ]),
                  )
                ],
              ));
        } else {
          formNewValue = formNewValue;
          return Container();
        }
      },
    );
  }
}
