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
import 'package:nucleusv2/src/feature/custenroll/screens/billingacc/cust_enroll_billing_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=429;

@RoutePage()
class CustEnrollBillingAccPostPaid extends ConsumerWidget {
  const CustEnrollBillingAccPostPaid(
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
    final params = ref.watch(billingAccDetailProvider);
    if (params['CustEttyId'] == null) {
      singleton<AppRouter>().navigatePath('././././list');
    }
    Map<String, dynamic> formNewValue = {
      "CustEttyId": params['CustEttyId'],
      "PrgEttyId": params['PrgEttyId'],
      "EttyId": params['EttyId'],
      "AcctId": params['AcctId'],
      "AcctType": acctType,
      "SchdId": null,
      "DunningCd":null
    };
    final qryObj = QueryObject(
        querysql: '/sp/ApiEnrlCustBillingAcctPostpaid/queryasync',
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
            child: SizedBox(
                height: 1280,
                child: Row(children: [
                  const FbHiddenText(name: 'CustEttyId'),
                  const FbHiddenText(name: 'PrgEttyId'),
                  const FbHiddenText(name: 'EttyId'),
                  const FbHiddenText(name: 'AcctId'),
                  const FbHiddenText(name: 'AcctType'),
                  const FbHiddenDateTime(name: 'MdfDate'),
                  Flexible(
                    flex: 4,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText('Credit Exposure'),
                          const FbText(name: 'CrLimit', label: 'Credit Limit'),
                          const FbText(
                              name: 'MaxCrBal', label: 'Max Credit Balance'),
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
                          const SelectableText('Billing Settings'),
                          FbHiddenText(name: 'BillingType'),
                          // Flexible(
                          //   child: FbLibViewMultiDisplay(
                          //     listsearchText: const ['Dscp'],
                          //     name: 'BillingType',
                          //     label: 'Type of Billing',
                          //     params: const {},
                          //     keyField: 'RefCd',
                          //     querySql: '/view/async/vwcustbillingtype',
                          //     returnSelectedRef: (val) {
                          //       ref
                          //           .read(billingAcctModelIdProvider.notifier)
                          //           .state = {
                          //         "PrgEttyId": formNewValue['PrgEttyId'] ?? '',
                          //         "BillingType": val["RefCd"]
                          //       };
                          //     },
                          //   ),
                          // ),
                          const Flexible(child: DynamicBillingModel()),
                          FbText(
                              name: 'PymtTerm ',
                              label: 'Payment Terms(Days)',
                              initialValue: formNewValue['PymtTerm']),
                                 const Flexible(
                            child: FbLibView(
                              searchText: 'Dscp',
                              name: 'DunningCd',
                              label: 'Dunning',
                              params:  {},
                              keyField: 'DunningCd',
                              querySql: '/view/async/vwlibdunningcd',
                            
                            ),
                          ),
                        ]),
                  ),
                  const Spacer(flex: 1),
                  Flexible(
                      flex: 4,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SelectableText('Charges'),
                            FbSwitch(
                              name: 'FncChrgInd',
                              label: 'Finance Charge',
                              initialValue: formNewValue['FncChrgInd'],
                            ),
                            sbh10,
                            FbSwitch(
                                name: 'LpcChrgInd',
                                label: 'Late Payment Charge',
                                initialValue: formNewValue['LpcChrgInd']),
                            sbh10,
                            const Divider(),
                            const SelectableText('Statement Option'),
                            sbh10,
                            FbSwitch(
                                name: 'StmtOptHardcopy',
                                label: 'Send Hardcopy',
                                initialValue: formNewValue['StmtOptHardcopy']),
                          ])),
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
                                '/sp/ApiEnrlCustBillingAcctPostpaidSave/queryasync?logId=${formNewValue['AcctId']}',
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
                      const AcxBackToList(
                        listUrl: '././././list',
                      ),
                    AcxAuditLogReqBtn('ApiEnrlCustBillingAcctPostpaidSave', ettyId: formNewValue['AcctId'],)
                    ],
                  ))
                ])),
          );
        });
  }
}

class DynamicBillingModel extends ConsumerWidget {
  const DynamicBillingModel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final val = ref.watch(billingAcctModelIdProvider);
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
