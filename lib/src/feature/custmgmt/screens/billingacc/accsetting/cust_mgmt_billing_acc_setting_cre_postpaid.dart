import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_libviewmultidisp.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/accsetting/cust_mgmt_billing_oltp_balance.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/cust_mgmt_billing_block_dialog.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/cust_mgmt_billing_provider.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=530;

@RoutePage()
class CustMgmtBillingAccPostPaid extends ConsumerWidget {
  const CustMgmtBillingAccPostPaid(
      {this.custEttyId,
      this.prgEttyId,
      this.acctId,
      this.ettyId,
      @PathParam.inherit('acctType') this.acctType,
      super.key});

  final String? custEttyId;
  final String? prgEttyId;
  final String? acctId;
  final String? ettyId;
  final String? acctType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final custEnrlBillAccPostFormKey = GlobalKey<FormBuilderState>();
    final params = ref.watch(billingCustMgmtAccDetailProvider);

    if (params['CustEttyId'] == null) {

      singleton<AppRouter>().navigatePath('././././list');
    }
    Map<String, dynamic> formNewValue = {
      "CustEttyId": params['CustEttyId'],
      "PrgEttyId": params['PrgEttyId'],
      "EttyId": params['EttyId'],
      "AcctId": params['AcctId'],
      "AcctType": acctType,
      "SchdId": null
    };
    final qryObj = QueryObject(
        querysql: '/sp/ApiMgmtCustBillingAcctPostpaid/queryasync',
        params: {
          "CustEttyId": params['CustEttyId'],
          "PrgEttyId": params['PrgEttyId'],
          "EttyId": params['EttyId'],
          "AcctId": params['AcctId'],
          "AcctType": acctType,
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
            child: SingleChildScrollView(
              child: SizedBox(
                height: 1280,
                child: Row(children: [
                          
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                        const FbHiddenText(name: 'CustEttyId'),
                    const FbHiddenText(name: 'PrgEttyId'),
                    const FbHiddenText(name: 'EttyId'),
                    const FbHiddenText(name: 'AcctId'),
                    const FbHiddenDateTime(name: 'MdfDate'),
                    const FbHiddenText(name: 'AvailCrBal'),
                          const SelectableText('Account Info', style: TextStyle(fontSize: defaultDropDownSize),),
                             const FbText(
                              name: 'StsDscp', label: 'Account Status', readOnly: true,),
                          const FbText(
                              name: 'AcctNo', label: 'Account Number', readOnly: true,),
                                    
                          const FbText(
                              name: 'PrgDscp', label: 'Program Description', readOnly: true),
                          const FbText(name: 'Dscp', label: 'Description', readOnly: true),
                          const FbText(name: 'BillingTo', label: 'BillingTo', readOnly: true),
                          const FbText(
                              name: 'AcctType', label: 'Account Type', readOnly: true),
                                          FbLibView(
                            name: 'AcctMgrId',
                            label: 'Account Manager',
                            params: const {},
                            keyField: 'AcctMgrId',
                            searchText: 'AcctMgrName',
                            querySql: '/view/async/VwAcctMgrCust',
                            initialValue: formNewValue['AcctMgrId'],
                          ),
                              FbLibView(
                            name: 'ColltorId',
                            label: 'Debt Caller / Collector',
                            params: const {},
                            keyField: 'ColltorId',
                            searchText: 'ColltorName',
                            querySql: '/view/async/vwColltorCust',
                            initialValue: formNewValue['ColltorId'],
                          ),
                              FbLibViewMultiDisplay(
                                                            listsearchText: ['SiteName','LocNo','TradingName',],
                                                            name: 'Referrer',
                                                            label: 'Referral (Location)',
                                                            params:  {},
                                                            keyField: 'LocEttyId',
                                                            querySql: '/view/async/VwReferrer',
                                                  
                                                          ),
                          sbh20,
                          const SelectableText('Billing Settings', style: TextStyle(fontSize: defaultDropDownSize),),
                          FbHiddenText(name: 'BillingType'),
                          // FbLibViewMultiDisplay(
                          //   listsearchText: const ['Dscp'],
                          //   name: 'BillingType',
                          //   label: 'Type of Billing',
                          //   params: const {},
                          //   keyField: 'RefCd',
                          //   querySql: '/view/async/vwcustbillingtype',
                          //   returnSelectedRef: (val) {
                          //     ref
                          //         .read(
                          //             billingAcctMgmtModelIdProvider.notifier)
                          //         .state = {
                          //       "PrgEttyId": formNewValue['PrgEttyId'] ?? '',
                          //       "BillingType": val["RefCd"]
                          //     };
                          //   },
                          // ),
                          SingleChildScrollView(
                            child: SizedBox(
                              height: 80,
                              child: const DynamicBillingMgmtModel()),
                          ),
                          FbText(
                              name: 'PymtTerm ',
                              label: 'Payment Terms(Days)',
                              initialValue: formNewValue['PymtTerm']),
                          sbh10,
                          const SelectableText('Charges', style: TextStyle(fontSize: defaultDropDownSize),),
                          FbSwitch(
                            name: 'FncChrgInd',
                            label: 'Finance Charge',
                            initialValue: formNewValue['FncChrgInd']??'N',
                          ),
                          sbh10,
                          FbSwitch(
                              name: 'LpcChrgInd',
                              label: 'Late Payment Charge',
                              initialValue: formNewValue['LpcChrgInd']??'N'),
                          sbh10,
                          const Divider(),
                          const SelectableText('Statement Option', style: TextStyle(fontSize: defaultDropDownSize),),
                          sbh10,
                          FbSwitch(
                              name: 'StmtOptHardcopy',
                              label: 'Send Hardcopy',
                              initialValue: formNewValue['StmtOptHardcopy']??'N'),
                                                   Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Flexible(child: Text(formNewValue["BlockFlag"] == "N" ? "Block Account":"UnBlock Account"),),
                         
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                        Expanded(
                    child:
                        Text(formNewValue['BlockDscp']??""
                        , textAlign: TextAlign.right)),
                    IconButton(
                                      onPressed: () async {
                                  
                                                 await showAcxDialog(
                      context,
                      CustMgmtBillingAcctBlockDialog(
                        ettyId: formNewValue['EttyId'],
                        prgEttyId: formNewValue['PrgEttyId'],
                        acctId: formNewValue['AcctId'],
                        blockFlag:  formNewValue['BlockFlag']
                      )).then(
                    (val) {
                             ref.invalidate(
                                            ReturndatafreezedProvider(qryObj));
                    },
                                  );
                               
                                      },
                                      icon: const Icon(Icons.play_arrow)),
                                  ],
                                ),
                              ),
                            ],
                        ),
                        ]),
                  ),
                  sbw10,
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                        children: [    
                     
                          CustMgmtBillingOLTPBalance(
                              custEttyId: params['CustEttyId'].toString(),
                              prgEttyId: params['PrgEttyId'].toString(),
                              acctId: params['AcctId'].toString(),
                              ettyId: params['EttyId'].toString()),
                                       FbText(
                                                     label: 'Overdue Amount',
                                                     name: 'OverdueAmt',
                                                      readOnly: true,
                                                     initialValue: formNewValue["OverdueAmt"].toString(),
                                                   ),
                                                           FbText(
                                                     label: 'Open Credit',
                                                     name: 'OpnCr',
                                                      readOnly: true,
                                                     initialValue: formNewValue["OpnCr"].toString(),
                                                   ),
                       
                        ]),
                  ),
                  sbw10,
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
                        toPost.remove('AcctNo');
                        toPost.remove('StsDscp');
                        toPost.remove('BlockAcctDscp');
                        toPost.remove('AvbleBal');
                        final querySave = QueryObject(
                            querysql:
                                '/sp/ApiMgmtCustBillingAcctPostpaidSave/queryasync?logId=${formNewValue["AcctId"].toString()}',
                            params: toPost,
                            showMsg: false);
                            
                        final saveResult = ref.read(
                            ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            ref.invalidate(ReturndatafreezedProvider(qryObj));
                          }
                        });
                      }),
                      sbh10,
                      const AcxBackToList(
                        listUrl: '././././list',
                      ),
                      sbh10,
                      AcxAuditLogReqBtn('ApiMgmtCustBillingAcctPostpaidSave',ettyId: formNewValue["AcctId"].toString(),),
                    ],
                  ))
                ]),
              ),
            ),
          );
        });
  }
}

class DynamicBillingMgmtModel extends ConsumerWidget {
  const DynamicBillingMgmtModel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final val = ref.watch(billingAcctMgmtModelIdProvider);
    final queryObject = QueryObject(
        querysql: '/sp/ApiCustBillingCycList/queryasync',
        params: val,
        showMsg: false);
    final dataSrc = ref.watch(ReturndatafreezedProvider(queryObject));
    return AsyncValueWidget(
        value: dataSrc,
        data: (re) {
          if (re.data == null || re.data![0]['BillingModelId'] == null) {
            return const Row(
              children: [
                Expanded(
                    child: SelectableText('Please Select Type of Billing')),
                Expanded(
                    child: FbHiddenText(
                  name: 'BillingModelId',
                )),
              ],
            );
          } else {
            return FbLibViewExt(
              name: 'BillingModelId',
              datasrc: re,
              initialValue: null,
              label: 'Schdule Billing',
              keyField: 'BillingModelId',
              searchText: 'CycDscp',
              returnSelectedRef: (Map<String, dynamic> val) {
                //   Toast.message(val.toString());
              },
            );
          }
        });
  }
}
