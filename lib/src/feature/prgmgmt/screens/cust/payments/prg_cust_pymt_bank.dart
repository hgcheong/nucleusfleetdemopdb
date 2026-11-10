import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=768;

@RoutePage()
class PrgCustPymtBank extends StatelessWidget {
  const PrgCustPymtBank(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return PrgCustPymtBankForm(prgEttyId: prgEttyId);
  }
}

class PrgCustPymtBankForm extends ConsumerWidget {
  const PrgCustPymtBankForm({super.key, this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();
    //   final isLoaindg = ref.watch(loadingProvider);
    //final prgId = singleton<AppRouter>().current.pathParams.get("prgEttyId");
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustAutoPymt/queryasync',
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
      "CrPymtType": 'DCR',
      "CrBank": 'AMBB',
      "CrBranchCd": '',
      "CrBankAcctNo": '1234567890',
      "CrBankAcctType": 'FIXED DEPOSIT',
      "CrAcctHolderName": 'AMBB',
      "CrPayeeCd": null,
      "CrPayeeRef": null,
      "CrBankAcctId": null,
      "PrgEttyId": prgEttyId
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
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                formKey.currentState!.save();
              },
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
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
                          FbSwitch(
                            name: 'DrAutoPymtInd',
                            label: 'Auto Debit',
                            initialValue: formNewValue['DrAutoPymtInd'],
                          ),
                          FormBuilderField(
                            name: 'DrPymtType',
                            builder: (FormFieldState f) {
                              return Container();
                            },
                          ),
                          FbLibView(
                              name: 'DrAutoExecDays',
                              label: "Dr Customer's Account x day before Due",
                              params: const {
                                "RefType": "AUTOEXECDAY",
                                "BitInd": null
                              },
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/sp/GetLibRef/queryasyncnouser',
                              initialValue:
                                  formNewValue['DrAutoExecDays'].toString()),
                          const SelectableText('Receiving Bank Details'),
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
                              fbFieldGap, Expanded(
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
                  const Spacer(
                    flex: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      AcxSaveButtonManual(
                        onSave: () async {
                            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          formKey.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              formKey.currentState!.value, theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiPrgCustAutoPymtSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                          });
                        },
                      ),
                      AcxAuditLogReqBtn('ApiPrgCustAutoPymtSave',ettyId: prgEttyId.toString(),)
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
