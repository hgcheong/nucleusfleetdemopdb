import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/feature/custmgmt/custmgmt_controller.dart';

import '../../../../../core/components/formbuilder/fb_imports.dart';

const int wid=631;

@RoutePage()
class CustMgmtMemberCtrlTrans extends StatelessWidget {
  const CustMgmtMemberCtrlTrans(
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
      child: CustMgmtMbrTxnLimitForm(
        prgEttyId: prgEttyId,
        custEttyId: custEttyId,
        limitId: limitId,
        mbrEttyId: mbrEttyId,
      ),
    );
  }
}

class CustMgmtMbrTxnLimitForm extends ConsumerWidget {
  const CustMgmtMbrTxnLimitForm({
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
    final prgSelected = ref.watch(custMgmtMbrCtrlTxnPrgSelectProvider);
    if (prgEttyId == null && prgSelected.isEmpty) {
      singleton<AppRouter>().navigatePath('././list');
    }
    final formKeyCustMgmtMbrCtrlTxn = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiMgmtMbrTxnLimit/queryasync',
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

    Map<String, dynamic> formSwitchValue = {};

    final queryPrdList = QueryObject(
        querysql: '/sp/ApiMgmtMbrTxnLimitPrdList/queryasync',
        params: {
          "MbrEttyId": mbrEttyId,
          "CustEttyId": custEttyId,
          "LimitId": convStrNewOrNullToNull(limitId)
        },
        showMsg: false);

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
              key: formKeyCustMgmtMbrCtrlTxn,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                formKeyCustMgmtMbrCtrlTxn.currentState!.save();
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
                              color: Colors.blue,
                              child: SelectableText(
                                  'Program selected for Limit Setting :${formNewValue['PrgDscp'].toString()}')),
                          FbText(
                            name: 'Dscp',
                            initialValue: formNewValue["Dscp"],
                            label: S.of(context).lblDescription,
                          ),
                          const FbHiddenText(name: 'Sts'),
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
                              params: const {}),
                          //      Expanded(
                          //   child: FbText(name: 'LimitMsuremt', label: S.of(context).lblLimitValue),
                          // ),
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
                          //LimitMsuremt

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
                          //   const Flexible(
                          //     flex: 1,
                          //     child: SelectableText('Apply settings to transactions from the following . If no product is selected the setting will apply to all products'),
                          //   ),
                          //   sbh10,
                          //   Flexible(
                          //     flex: 4,
                          //     child: convStrNewOrNullToNull(limitId) == null
                          //         ? const SelectableText("No Record")
                          //         : CustMgmtMbrCtrlTxnprdList(
                          //             switchValue: formSwitchValue,
                          //             query: queryPrdList,
                          //           ),
                          //   ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
     
                      ElevatedButton(
                        onPressed: () async {
                            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          formKeyCustMgmtMbrCtrlTxn.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(formKeyCustMgmtMbrCtrlTxn
                                  .currentState!.value),
                              theData.columnInfo);
                          //    toPost.remove('Dscp');
                          final querySave = QueryObject(
                              querysql: '/sp/ApiMgmtMbrTxnLimitSave/queryasync',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              saveProdList(
                                  formSwitchValue,
                                  ref,
                                  limitId.toString(),
                                  mbrEttyId.toString(),
                                  custEttyId.toString(),
                                  queryPrdList);
                              final outLimitId =
                                  getOutputValue(value.output, '@LimitId');
                              singleton<AppRouter>().navigatePath(
                                  '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/translimt/detail/$prgEttyId/$outLimitId');
                              ref.invalidate(ReturndatafreezedProvider(query));
                            }
                          });
                        },
                        child: const Icon(Icons.save),
                      ),
                      sbh10,
                      AcxBackToList(
                          listUrl:
                              '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/translimt'),
                                                           sbh10,
                        AcxAuditLogReqBtn('ApiMgmtMbrTxnLimitSave,ApiMgmtLocAccptLocSave,ApiMgmtLocAccptLocDel',ettyId: formNewValue["LimitId"].toString(),)
                    ]),
                  )
                ],
              ));
        });
  }
}

class CustMgmtMbrCtrlTxnprdList extends ConsumerWidget {
  const CustMgmtMbrCtrlTxnprdList({
    super.key,
    this.switchValue,
    required this.query,
  });

  final Map<String, dynamic>? switchValue;
  final QueryObject query;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyCustMgmtMbrCtrlTxnSwitch = GlobalKey<FormBuilderState>();
    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
        data: (rValue) {
          var data = rValue.data;

          Set<String> theValue = <String>{};
          data!.asMap().entries.forEach((ele) {
            theValue.add(ele.value['PrdDscp'].toString());
          });

          var identifier = {};
          for (var item in theValue) {
            List<dynamic> toAdd = [];
            data.asMap().entries.forEach((ele) {
              if (ele.value['PrdDscp'].toString() == item) {
                toAdd.add(ele.value);
              }
            });
            identifier[item] = toAdd;
          }
          List<Widget> categoryItem = [];

          for (var val in identifier.entries) {
            List<Widget> rowItems = [];

            List<dynamic> toVV = val.value;
            for (var item in toVV) {
              switchValue![item['PrdCd']] = item['PrdSts'];
            }

            for (var item in toVV) {
              rowItems.add(Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FormBuilderSwitch(
                      initialValue: item['PrdSts'] == 'N' ? false : true,
                      name: item['PrdCd'],
                      title: SelectableText(item['PrdDscp']),
                      onChanged: (value) {
                        switchValue![item['PrdCd']] =
                            value == false ? 'N' : 'Y';
                      },
                      valueTransformer: (value) {
                        return value == false ? 'N' : 'Y';
                      },
                    ),
                  )
                ],
              ));
            }

            categoryItem.add(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [...rowItems],
            ));
          }

          ListView toReturn = ListView(
            children: categoryItem,
          );

          return FormBuilder(
            initialValue: switchValue!,
            key: formKeyCustMgmtMbrCtrlTxnSwitch,
            child: toReturn,
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()),);
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}


void saveProdList(Map<String, dynamic> src, WidgetRef ref, String limitId,
    String mbrEttyId, String custEttyId, QueryObject query) async {
  var futures = <Future>[];

  for (var element in src.entries) {
    final queryDel = QueryObject(
        querysql: '/sp/ApiMgmtMbrTxnLimitPrdSave/queryasync',
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
