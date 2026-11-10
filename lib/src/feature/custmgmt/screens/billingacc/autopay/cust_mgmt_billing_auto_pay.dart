import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/cust_mgmt_billing_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=533;

@RoutePage()
class CustMgmtBillingAutoPay extends StatelessWidget {
  const CustMgmtBillingAutoPay(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('ettyId') this.ettyId,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      //acctId
      @PathParam.inherit('acctId') this.acctId,
      @PathParam.inherit('acctType') this.acctType});

  final String? custEttyId;
  final String? ettyId;
  final String? prgEttyId;
  final String? acctId;
  final String? acctType;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return CustomerEnrollSetupBankForm(
      custEttyId: custEttyId,
      ettyId: ettyId,
      prgEttyId: prgEttyId,
      acctId: acctId,
      acctType: acctType,
    );
  }
}

class CustomerEnrollSetupBankForm extends ConsumerWidget {
  const CustomerEnrollSetupBankForm(
      {super.key,
      this.custEttyId,
      this.ettyId,
      this.prgEttyId,
      this.acctId,
      this.acctType});

  final String? custEttyId;
  final String? ettyId;
  final String? prgEttyId;
  final String? acctId;
  final String? acctType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mcenrlautopKey = GlobalKey<FormBuilderState>();
    final params = ref.watch(billingCustMgmtAccDetailProvider);
    final query = QueryObject(
        querysql: '/sp/ApiMgmtCustAutoPymt/queryasync',
        params: params,
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "AutoPymtInd": null,
      "AutoExecDays": null,
      "PymtType": null,
      "Bank": null,
      "BranchCd": null,
      "BankAcctNo": null,
      "BankAcctType": null,
      "AcctHolderName": null,
      "PayeeCd": null,
      "PayeeRef": null,
      "BankAcctId": null,
      "PrgEttyId": prgEttyId,
      "CustEttyId": custEttyId,
      "BillingType": null,
      "EttyId": ettyId,
    };
    //final formValue = useState<Map<String, dynamic>>(formNewValue);

    final formData = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          return FormBuilder(
              key: mcenrlautopKey,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                mcenrlautopKey.currentState!.save();
              },
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  FormBuilderField(
                    name: 'PrgEttyId',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  const FbHiddenText(name: 'CustEttyId'),
                  const FbHiddenText(name: 'EttyId'),
                  //            const FbHiddenText(name: 'BillingType'),
                  //  const FbHiddenText(name: 'PymtType'),
                  const FbHiddenText(name: 'AcctType'),
                  const FbHiddenText(name: 'AcctId'),
                  const FbHiddenText(name: 'BankAcctId'),
                  const FbHiddenDateTime(name: 'MdfDate'),
                  Expanded(
                    flex: 5,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FbField(child: FormBuilderSwitch(
                              name: 'AutoPymtInd',
                              title: const SelectableText('Auto Debit'),
                              valueTransformer: (value) {
                                return value == false ? 'N' : 'Y';
                              },
                            )),
                            FormBuilderField(
                              name: 'PymtType',
                              builder: (FormFieldState f) {
                                return Container();
                              },
                            ),
                            FbLibView(
                                name: 'AutoExecDays',
                                label: 'Db Customer x day after Settlement',
                                params: const {
                                  "RefType": "AUTOEXECDAY",
                                  "BitInd": null
                                },
                                keyField: 'RefCd',
                                searchText: 'Dscp',
                                querySql: '/sp/GetLibRef/queryasyncnouser',
                                initialValue: formNewValue['AutoExecDays']),
                            const SelectableText('Payment Bank Details'),
                            FbLibView(
                                name: 'Bank',
                                label: 'Bank',
                                params: const {},
                                keyField: 'Bank',
                                searchText: 'BankName',
                                querySql: '/view/async/VwBank',
                                initialValue: formNewValue['Bank'].toString()),
                            const FbText(
                              name: 'BranchCd',
                               label: 'Branch Code',
                         
                            ),
                            FbLibView(
                                name: 'BankAcctType',
                                label: 'Bank Account Type',
                                params: const {
                                  "RefType": "BANKACCTTYPE",
                                  "BitInd": null
                                },
                                keyField: 'RefCd',
                                searchText: 'Dscp',
                                querySql: '/sp/GetLibRef/queryasyncnouser',
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
                                    label: 'Payee Code',
                                
                                  ),
                                ),
                                fbFieldGap, Expanded(
                                  child: FbText(
                                    name: 'PayeeRef',
                                    label: 'Payee Reference',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                          mcenrlautopKey.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              mcenrlautopKey.currentState!.value,
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql:
                                  '/sp/ApiMgmtCustAutoPymtSave/queryasync?logId=${convStrNewOrNullToNull(acctId) ?? 0}',
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
                      const AcxBackToList(
                        listUrl: './list',
                      ),
                      AcxAuditLogReqBtn('ApiMgmtCustAutoPymtSave',ettyId: formNewValue["AcctId"].toString(),),
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
