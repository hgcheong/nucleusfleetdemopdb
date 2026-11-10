import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custenroll/custenroll_controller.dart';

const int wid=439;

@RoutePage()
class CustEnrollCmpyCtrlTxn extends ConsumerWidget {
  const CustEnrollCmpyCtrlTxn(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
      @PathParam('prgEttyId') this.prgEttyId,
      @PathParam('limitId') this.limitId});

  final String? custEttyId;
  final String? cmpyEttyId;
  final String? prgEttyId;
  final String? limitId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final prgSelected = ref.watch(custEnrollCmpyCtrlTxnPrgSelectProvider);
    if (prgEttyId == null && prgSelected.isEmpty) {
      // singleton<AppRouter>().navigatePath('/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/control/translimt');
      singleton<AppRouter>().navigatePath(
          '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/control/translimt');
    }
    return CustEnrollCmpyTxnLimitForm(
      custEttyId: custEttyId,
      cmpyEttyId: cmpyEttyId,
      prgEttyId: prgEttyId,
      limitId: limitId,
      prgSelected: prgSelected,
    );
  }
}

class CustEnrollCmpyTxnLimitForm extends ConsumerWidget {
  const CustEnrollCmpyTxnLimitForm(
      {super.key,
      this.prgEttyId,
      this.custEttyId,
      this.limitId,
      this.cmpyEttyId,
      required this.prgSelected});
  final String? prgEttyId;
  final String? custEttyId;
  final String? limitId;
  final String? cmpyEttyId;
  final Map<String, dynamic> prgSelected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiEnrlCmpyTxnLimit/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "CmpyEttyId": cmpyEttyId,
          "PrgEttyId": prgEttyId,
          "LimitId": convStrNewOrNullToNull(limitId)
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "CmpyEttyId": cmpyEttyId,
      "PrgEttyId": prgEttyId,
      "LimitId": convStrNewOrNullToNull(limitId),
      "TxnCtgry": null,
      "LimitType": null,
      "LimitMsuremt": null,
      "MinThsld": null,
      "MaxThsld": null,
      "CntThsld": null,
      "Sts": "A",
      "MdfDate": null
    };
    // Map<String, dynamic> formSwitchValue = {};
    // final queryPrdList = QueryObject(querysql: '/sp/ApiEnrlCmpyTxnLimitPrdList/queryasync', params: {"PrgEttyId": prgEttyId, "CmpyEttyId": cmpyEttyId, "CustEttyId": custEttyId, "LimitId": convStrNewOrNullToNull(limitId)}, showMsg: false);

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
            if (formNewValue['Sts'] == null) {
              formNewValue['Sts'] = 'A';
            }
          }
          return FormBuilder(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                formKey.currentState!.save();
              },
              child: Row(
                children: [
                  const FbHiddenText(name: 'PrgEttyId'),
                  const FbHiddenText(name: 'CmpyEttyId'),
                  const FbHiddenText(name: 'CustEttyId'),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FbHiddenText(name: 'Sts'),
                          const SelectableText(
                              'Transaction Category and Spending Limit at Company level'),
                          Container(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              child: SelectableText(
                                  'Program selected for Limit Setting :${prgSelected['Program'].toString()}')),
                          const FbText(
                            name: 'Dscp',
                            label: 'Description',
                          ),
                          FbLibView(
                            name: 'TxnCtgry',
                            initialValue: formNewValue["TxnCtgry"],
                            label: S.of(context).lblApplyTransCat,
                            params: const {},
                            keyField: 'TxnCtgry',
                            searchText: 'Dscp',
                            querySql: '/view/async/VwLibTxnCtgry',
                          ),
                          const FbHiddenText(name: 'LimitId'),
                          const FbLibView(
                              name: 'PrdCtgry',
                              label: 'Product Category',
                              params: {},
                              keyField: 'PrdCtgry',
                              searchText: 'Dscp',
                              querySql: '/view/async/VwPrdCtgry'),
                          FbLibView(
                            name: 'LimitType',
                            initialValue: formNewValue["RefCd"],
                            label: S.of(context).lblTypeOfLimit,
                            params: const {},
                            keyField: 'RefCd',
                            searchText: 'Dscp',
                            querySql: '/view/async/VwLimitType',
                          ),
                          FbOption(
                            querysql: '/view/async/VwApplyOn',
                            name: 'LimitMsuremt',
                            label: S.of(context).lblLimitMeaApplyTo,
                            params: const {},
                            orientation: OptionsOrientation.wrap,
                          ),
                          SelectableText(S.of(context).tabTransactionLimits),
                          Row(
                            children: [
                              Expanded(
                                child: FbText(
                                    name: 'MinThsld',
                                    label: S.of(context).lblMin),
                              ),
                              Expanded(
                                child: FbText(
                                    name: 'MaxThsld',
                                    label: S.of(context).lblMax),
                              )
                            ],
                          ),
                          FbText(
                              name: 'CntThsld', label: S.of(context).lblCount),
                          const SizedBox(
                            width: 30,
                          ),
                          const FbHiddenDateTime(name: 'MdfDate')
                          // const FbDateTimePickerWithTime(name: 'MdfDate', label: 'Modified Date')
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Flexible(
                          //   flex: 1,
                          //   child: SelectableText(
                          //       'Apply settings to transactions from the following . If no product is selected the setting will apply to all products'),
                          // ),
                          // sbh10,
                          // Flexible(
                          //   flex: 4,
                          //   child: limitId == null
                          //       ? const SelectableText('No Record')
                          //       : CustEnrollCmpyCtrlTxnprdList(
                          //           limitId: limitId,
                          //           custEttyId: custEttyId,
                          //           prgEttyId: prgEttyId,
                          //           switchValue: formSwitchValue,
                          //           query: queryPrdList,
                          //         ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      AcxSaveButtonManual(
                        onSave: () {
                                 if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          formKey.currentState!.save();
                          // Map<String, dynamic> toSave = formKey.currentState!.value;
                          //    toSave = convertFormDateTimeValue(toSave, ['MdfDate']);
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(formKey.currentState!.value),
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql:
                                  '/sp/ApiEnrlCmpyTxnLimitSave/queryasync?logId=${convStrNewOrNullToNull(limitId) ?? 0}',
                              params: toPost,
                              showMsg: false);

                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              // saveProdList(formSwitchValue, ref, limitId.toString(), prgEttyId.toString(), custEttyId.toString(), cmpyEttyId.toString(), queryPrdList);
                              if (context.mounted) {
                                singleton<AppRouter>()
                                    .navigatePath(getAfterSavePath(
                                        context, value.output, '@LimitId'))
                                    .then((val) {
                                  ref.invalidate(
                                      ReturndatafreezedProvider(query));
                                });
                              }
                            }
                          });
                        },
                      ),
                      AcxBackToList(
                          listUrl:
                              '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/control/translimt'),
                    AcxAuditLogReqBtn('ApiEnrlCmpyTxnLimitSave',ettyId: formNewValue["LimitId"].toString(),)
                              
                    ]),
                  )
                ],
              ));
        });
  }
}
