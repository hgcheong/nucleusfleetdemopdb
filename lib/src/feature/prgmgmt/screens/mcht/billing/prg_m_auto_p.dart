import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/prgmgmt/screens/mcht/billing/prg_m_auto_p_ctrl.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=131;
@RoutePage()
class PrgMgmtMchtBillAutoPay extends StatelessWidget {
  const PrgMgmtMchtBillAutoPay(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}

        if (isNewId(prgEttyId)) {
        singleton<AppRouter>().back();
      }
      return MerchantSetupBankForm(
        prgEttyId: prgEttyId,
      );
    // if (isAllowTabAccess(defaultTabAccess, wid)) {
    //   if (isNewId(prgEttyId)) {
    //     singleton<AppRouter>().back();
    //   }
    //   return MerchantSetupBankForm(
    //     prgEttyId: prgEttyId,
    //   );
    // } else {
    //   return const Center(
    //     child: Text('Not Authorised'),
    //   );
    // }
  }
}

class MerchantSetupBankForm extends ConsumerWidget {
  const MerchantSetupBankForm({
    super.key,
    this.prgEttyId,
  });

  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final pmbillingautopKey = GlobalKey<FormBuilderState>();
    //   final isLoaindg = ref.watch(loadingProvider);
    final query = QueryObject(
        querysql: '/sp/ApiPrgMchtAutoPymt/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "DrAutoPymtInd": null,
      "DrAutoExecDays": null,
      "DrPymtType": null,
      "DrBank": null,
      "DrBranchCd": null,
      "DrBankAcctNo": null,
      "DrBankAcctType": null,
      "DrAcctHolderName": null,
      "DrPayeeCd": null,
      "DrPayeeRef": null,
      "DrBankAcctId": null,
      "CrAutoPymtInd": false,
      "CrAutoExecDays": null,
      "CrPymtType": null,
      "CrBank": null,
      "CrBranchCd": null,
      "CrBankAcctNo":  null,
      "CrBankAcctType":  null,
      "CrAcctHolderName": null,
      "CrPayeeCd": null,
      "CrPayeeRef": null,
      "CrBankAcctId": null,
      "PrgEttyId": prgEttyId
    };
    //final formValue = useState<Map<String, dynamic>>(formNewValue);

    final formData = ref.watch(PrgmautopFormDataProvider(query));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          return FormBuilder(
              key: pmbillingautopKey,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                pmbillingautopKey.currentState!.save();
              },
              child: Row(
                children: [
                  FormBuilderField(
                    name: 'PrgEttyId',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormBuilderField(
                            name: 'CrPymtType',
                            builder: (FormFieldState f) {
                              return Container();
                            },
                          ),
                          FbSwitch(
                            name: 'CrAutoPymtInd',
                            label: 'Auto Credit',
                            initialValue: formNewValue['CrAutoPymtInd'],
                          ),
                          FbLibView(
                              name: 'CrAutoExecDays',
                              label: 'Cr Merchant x day after Settlement',
                              params: const {
                                "RefType": "AUTOEXECDAY",
                                "BitInd": null
                              },
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/sp/GetLibRef/queryasyncnouser',
                              initialValue:
                                  formNewValue['CrAutoExecDays'].toString()),
                          const SelectableText('Payment Bank Details'),
                          FbLibView(
                              name: 'CrBank',
                              label: 'Bank',
                              params: const {},
                              keyField: 'Bank',
                              searchText: 'BankName',
                              querySql: '/view/async/VwBank',
                              initialValue: formNewValue['Bank'].toString()),
                          FbLibView(
                              name: 'CrBankAcctType',
                              label: 'Bank Account Type',
                              params: const {
                                "RefType": "BANKACCTTYPE",
                                "BitInd": null
                              },
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/sp/GetLibRef/queryasyncnouser',
                              initialValue:
                                  formNewValue['CrBankAcctType'].toString()),
                          const FbText(
                            name: 'CrBankAcctNo',
                            label: 'Bank Account Number',
                          ),
                          const FbText(
                            name: 'CrAcctHolderName',
                             label: 'Account Holder Name',
             
                          ),
                        const  Row(
                            children:  [
                              Expanded(
                                child: FbText(
                                  name: 'CrPayeeCd',
                                    label: 'Payee Code',

                                ),
                              ),
                              Expanded(
                                child: FbText(
                                  name: 'CrPayeeRef',
                                   label: 'Payee Reference',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormBuilderSwitch(
                            name: 'DrAutoPymtInd',
                            title: const SelectableText('Auto Debit'),
                            valueTransformer: (value) {
                              return value == false ? 'N' : 'Y';
                            },
                          ),
                          FormBuilderField(
                            name: 'DrPymtType',
                            builder: (FormFieldState f) {
                              return Container();
                            },
                          ),
                          FbLibView(
                              name: 'DrAutoExecDays',
                              label: 'Dr Merchant x day after Settlement',
                              params: const {
                                "RefType": "AUTOEXECDAY",
                                "BitInd": null
                              },
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/sp/GetLibRef/queryasyncnouser',
                              initialValue:
                                  formNewValue['DrAutoExecDays'].toString()),
                          const SelectableText('Payment Bank Details'),
                          FbLibView(
                              name: 'DrBank',
                              label: 'Bank',
                              params: const {},
                              keyField: 'Bank',
                              searchText: 'BankName',
                              querySql: '/view/async/VwBank',
                              initialValue: formNewValue['Bank'].toString()),
                          FbLibView(
                              name: 'DrBankAcctType',
                              label: 'Bank Account Type',
                              params: const {
                                "RefType": "BANKACCTTYPE",
                                "BitInd": null
                              },
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/sp/GetLibRef/queryasyncnouser',
                              initialValue:
                                  formNewValue['DrBankAcctType'].toString()),
                          const FbText(
                            name: 'DrBankAcctNo',
                              label: 'Bank Account Number',
                          ),
                          const FbText(
                            name: 'DrAcctHolderName',
                             label: 'Account Holder Name',
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: FbText(
                                  name: 'DrPayeeCd',
                                  label: 'Payee Code',
                                ),
                              ),
                              Expanded(
                                child: FbText(
                                  name: 'DrPayeeRef',
                                  label: 'Payee Reference',
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
                          pmbillingautopKey.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              pmbillingautopKey.currentState!.value,
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiPrgMchtAutoPymtSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              ref.invalidate(PrgmautopFormDataProvider(query));
                            }
                          });
                        },
                      ),
                      sbh10,
                      AcxAuditLogReqBtn('ApiPrgMchtAutoPymtSave',ettyId: prgEttyId.toString(),)
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
