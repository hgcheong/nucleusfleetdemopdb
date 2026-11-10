import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_hiddenswitch.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=702;

@RoutePage()
class MchtMgmtBillingAutoPay extends StatelessWidget {
  const MchtMgmtBillingAutoPay(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('ettyId') this.ettyId,
      @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? mchtEttyId;
  final String? ettyId;
  final String? prgEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return MerchantMgmtSetupBankForm(
        mchtEttyId: mchtEttyId, ettyId: ettyId, prgEttyId: prgEttyId);
  }
}

class MerchantMgmtSetupBankForm extends ConsumerWidget {
  const MerchantMgmtSetupBankForm({
    super.key,
    this.mchtEttyId,
    this.ettyId,
    this.prgEttyId,
  });

  final String? mchtEttyId;
  final String? ettyId;
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mcMgmtautopKey = GlobalKey<FormBuilderState>();
    //   final isLoaindg = ref.watch(loadingProvider);
    final query = QueryObject(
        querysql: '/sp/ApiMgmtMchtLocAutoPymt/queryasync',
        params: {
          "MchtEttyId": mchtEttyId,
          "EttyId": ettyId,
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
      "CrBankAcctNo": null,
      "CrBankAcctType": null,
      "CrAcctHolderName": null,
      "CrPayeeCd": null,
      "CrPayeeRef": null,
      "CrBankAcctId": null,
      "PrgEttyId": null
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
              key: mcMgmtautopKey,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                mcMgmtautopKey.currentState!.save();
              },
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 1.2,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                 // FbHiddenText(name: 'AutoPymtInd'),
                         //        FbSwitch(name: 'AutoPymtInd', initialValue: formNewValue['AutoPymtInd'],label: 'Auto',),
                         FbSwitch(
                            name: 'AutoPymtInd',
                            label: 'Enable Auto Payment',
                            initialValue: formNewValue['AutoPymtInd'],
                          ),
                                          FbHiddenSwitch(name: 'CrAutoPymtInd',initialValue: formNewValue['CrAutoPymntInd'],),
                                          FbHiddenSwitch(name: 'DrAutoPymtInd', initialValue: formNewValue['DrAutoPymtInd'],),
                            // FormBuilderSwitch(
                            //        decoration: InputDecoration(border: InputBorder.none),
                            //                           name: 'AutoPymtInd',
                            //                           title: const SelectableText('Enable Auto Payment'),
                            //                           valueTransformer: (value) {
                            //                             return value == false ? 'N' : 'Y';
                            //                           },
                            //                         ),     
                                                    FbLibView(
                                                                                        name: 'PymtMethod',
                                                                                        label: 'Payment Method',
                                                                                        params: const {
                                                     
                                                                                        },
                                                                                        keyField: 'RefCd',
                                                                                        searchText: 'Dscp',
                                                                                        querySql: '/view/async/VwPymtMethod',
                                                                                        initialValue: formNewValue['PymtMethod']),
                                                                                        sbh20,         
                            FormBuilderField(
                              name: 'PrgEttyId',
                              builder: (FormFieldState f) {
                                return Container();
                              },
                            ),
                            FormBuilderField(
                              name: 'MchtEttyId',
                              builder: (FormFieldState f) {
                                return Container();
                              },
                            ),
                            FormBuilderField(
                              name: 'EttyId',
                              builder: (FormFieldState f) {
                                return Container();
                              },
                            ),
                  
                   FormBuilderField(
                                          name: 'CrPymtType',
                                          builder: (FormFieldState f) {
                                            return Container();
                                          },
                                        ),
                                        // FormBuilderSwitch(
                                        //   name: 'CrAutoPymtInd',
                                        //   title: const SelectableText('Auto Credit'),
                                        //   valueTransformer: (value) {
                                        //     return value == false ? 'N' : 'Y';
                                        //   },
                                        // ),
                             
                                    //    FbHiddenText(name: 'CrAutoExecDays'),
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
                                            initialValue: formNewValue['CrAutoExecDays']),
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
                                        const Row(
                                          children: [
                                            Expanded(
                                              child: FbText(
                                                name: 'CrPayeeCd',
                                                label: 'Payee Code',
                                              ),
                                            ),
                                            fbFieldGap,
                                            Expanded(
                                              child: FbText(
                                                name: 'CrPayeeRef',
                                                label: 'Payee Reference',
                                              ),
                                            ),
                                          ],
                                        ),
                  
                                
                                    FbHiddenText(name: 'DrAutoExecDays'),
                                    FbHiddenText(name: 'DrPymtType'),
                                    FbHiddenText(name: 'DrBank'),
                                    FbHiddenText(name: 'DrBankAcctType'),
                                    FbHiddenText(name: 'DrBankAcctNo'),
                                    FbHiddenText(name: 'DrAcctHolderName'),
                                    FbHiddenText(name: 'DrPayeeCd'),
                                    FbHiddenText(name: 'DrPayeeRef'),
                              
                          ],
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
                                    mcMgmtautopKey.currentState!.save();
                                    Map<String, dynamic> toPost = convertFormValueToSave(
                                        mcMgmtautopKey.currentState!.value,
                                        theData.columnInfo);
                                    final querySave = QueryObject(
                                        querysql:
                                            '/sp/ApiMgmtMchtLocAutoPymtSave/queryasync?logId=${ettyId.toString()}',
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
                                AcxBackToList(
                              listUrl: './list',
                                ),
                                AcxAuditLogReqBtn('ApiMgmtMchtLocAutoPymtSave', ettyId: ettyId.toString(),)
                              ]),
                            )
                    ],
                  ),
                ),
              ));
        } else {
          formNewValue = formNewValue;
          return Container();
        }
      },
    );
  }
}
