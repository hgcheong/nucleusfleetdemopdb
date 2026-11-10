import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/feature/custenroll/custenroll_controller.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import '../../../../../core/components/formbuilder/fb_imports.dart';

const int wid=517;

@RoutePage()
class CustEnrollMemberCtrlTrans extends StatelessWidget {
  const CustEnrollMemberCtrlTrans(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId,
      @PathParam('prgEttyId') this.prgEttyId,
      @PathParam('limitId') this.limitId});

  final String? mbrEttyId;
  final String? custEttyId;
  final String? prgEttyId;
  final String? limitId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Center(
      child: CustEnrollMbrTxnLimitForm(
        prgEttyId: prgEttyId,
        custEttyId: custEttyId,
        limitId: limitId,
        mbrEttyId: mbrEttyId,
      ),
    );
  }
}

class CustEnrollMbrTxnLimitForm extends ConsumerWidget {
  const CustEnrollMbrTxnLimitForm({
    super.key,
    this.prgEttyId,
    this.mbrEttyId,
    this.limitId,
    this.custEttyId,
  });
  final String? custEttyId;
  final String? prgEttyId;
  final String? mbrEttyId;
  final String? limitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final prgSelected = ref.watch(custEnrollMbrCtrlTxnPrgSelectProvider);
    if (prgEttyId == null && prgSelected.isEmpty) {
      singleton<AppRouter>().navigatePath('././list');
    }

    final formKeyCustEnrollMbrCtrlTxn = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiEnrlMbrTxnLimit/queryasync',
        params: {
          "MbrEttyId": mbrEttyId,
          "CustEttyId": custEttyId,
          "PrgEttyId": prgEttyId,
          "LimitId": convStrNewOrNullToNull(limitId)
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "TxnCtgry": null,
      "LimitType": null,
      "Dscp": null,
      "LimitMsuremt": null,
      "MinThsld": null,
      "MaxThsld": null,
      "CntThsld": null,
      "Sts": null,
      "FromDate": null,
      "ToDate": null,
      "CustEttyId": custEttyId,
      "MbrEttyId": mbrEttyId,
      "PrgEttyId": prgEttyId,
      "LimitId": convStrNewOrNullToNull(limitId)
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
              key: formKeyCustEnrollMbrCtrlTxn,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                formKeyCustEnrollMbrCtrlTxn.currentState!.save();
              },
              child: Row(
                children: [
                  const FbHiddenText(name: 'PrgEttyId'),
                  const FbHiddenText(name: 'CustEttyId'),
                  const FbHiddenText(name: 'MbrEttyId'),
                  const FbHiddenText(name: 'LimitId'),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText(
                              'Transaction Category and Spending Limit at Member level'),
                          Container(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              child: SelectableText(
                                  'Program selected for Limit Setting :${prgSelected['PrgDscp'].toString()}')),
                          FbText(
                            name: 'Dscp',
                            label: S.of(context).lblDescription,
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
                          const FbLibView(
                              name: 'PrdCtgry',
                              label: 'Type of Product',
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
                              params: const {}),
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
                          Expanded(
                            child: FbText(
                                name: 'CntThsld',
                                label: S.of(context).lblCount),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
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
                          //   child: convStrNewOrNullToNull(limitId) == null
                          //       ? const SelectableText("No Record")
                          //       : CustEnrollMbrCtrlTxnprdList(
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
                        onSave: () async {
                                 if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          formKeyCustEnrollMbrCtrlTxn.currentState!.save();
                          Map<String, dynamic> toSave = convertFormValueToSave(
                              formKeyCustEnrollMbrCtrlTxn.currentState!.value,
                              theData.columnInfo);

                          final querySave = QueryObject(
                              querysql: '/sp/ApiEnrlMbrTxnLimitSave/queryasync?logId=${convStrNewOrNullToNull(mbrEttyId) ?? 0}',
                              params: toSave,
                              showMsg: false);

                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              // saveProdList(
                              //     formSwitchValue,
                              //     ref,
                              //     limitId.toString(),
                              //     mbrEttyId.toString(),
                              //     custEttyId.toString(),
                              //     queryPrdList);
                              final outLimitId =
                                  getOutputValue(value.output, '@LimitId');
                              singleton<AppRouter>().navigatePath(
                                  '/custenroll/member/$custEttyId/detail/$mbrEttyId/control/translimt/detail/$prgEttyId/$outLimitId');
                              ref.invalidate(ReturndatafreezedProvider(query));
                            }
                          });
                        },
                      ),
                      AcxBackToList(
                          listUrl:
                              '/custenroll/member/$custEttyId/detail/$mbrEttyId/control/translimt'),
                              AcxAuditLogReqBtn('ApiEnrlMbrTxnLimitSave',ettyId: mbrEttyId.toString(),)
                    ]),
                  )
                ],
              ));
        });
  }
}

// void saveProdList(Map<String, dynamic> src, String delSql, WidgetRef ref, Map<String, dynamic> params, QueryObject query) async {
//   var futures = <Future>[];

//   for (var element in src.entries) {
//     params['PrdSts'] = element.value ?? 'N';
//     params['PrdCd'] = element.key;
//     final queryDel = QueryObject(querysql: delSql, params: params, showMsg: false);
//     final resultDel = ref.read(ReturndatafreezedProvider(queryDel).future);
//     futures.add(resultDel);
//   }

//   await Future.wait(futures, eagerError: true).then((value) {
//     ref.invalidate(ReturndatafreezedProvider(query));
//   }).onError((error, stackTrace) {
//     Toast.message(error.toString());
//   });
// }

void saveProdList(Map<String, dynamic> src, WidgetRef ref, String limitId,
    String mbrEttyId, String custEttyId, QueryObject query) async {
  var futures = <Future>[];

  for (var element in src.entries) {
    final queryDel = QueryObject(
        querysql: '/sp/ApiEnrlMbrTxnLimitPrdSave/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "MbrEttyId": mbrEttyId,
          "LimitId": limitId,
          "PrdSts": element.value ?? 'N',
          "PrdCd": element.key
        },
        showMsg: false);
    final resultDel = ref.read(ReturndatafreezedProvider(queryDel).future);
    futures.add(resultDel);
  }

  await Future.wait(futures, eagerError: true).then((value) {
    ref.invalidate(ReturndatafreezedProvider(query));
  }).onError((error, stackTrace) {
    Toast.message(error.toString());
  });
}
