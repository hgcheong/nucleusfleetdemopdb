import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/generated/l10n.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/custmgmt_controller.dart';

const int wid=547;

@RoutePage()
class CustMgmtCmpyCtrlTxn extends ConsumerWidget {
  const CustMgmtCmpyCtrlTxn(
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
    final prgSelected = ref.watch(custMgmtCmpyCtrlTxnPrgSelectProvider);
    if (prgEttyId == null && prgSelected.isEmpty) {
      // singleton<AppRouter>().navigatePath('/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/control/translimt');
      singleton<AppRouter>().navigatePath(
          '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/control/translimt');
    }
    return CustMgmtCmpyTxnLimitForm(
      custEttyId: custEttyId,
      cmpyEttyId: cmpyEttyId,
      prgEttyId: prgEttyId,
      limitId: limitId,
      prgSelected: prgSelected,
    );
  }
}

class CustMgmtCmpyTxnLimitForm extends ConsumerWidget {
  const CustMgmtCmpyTxnLimitForm(
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
        querysql: '/sp/ApiMgmtCmpyTxnLimit/queryasync',
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
    // final queryPrdList = QueryObject(
    //     querysql: '/sp/ApiMgmtCmpyTxnLimitPrdList/queryasync',
    //     params: {
    //       "PrgEttyId": prgEttyId,
    //       "CmpyEttyId": cmpyEttyId,
    //       "CustEttyId": custEttyId,
    //       "LimitId": convStrNewOrNullToNull(limitId)
    //     },
    //     showMsg: false);

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
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  const FbHiddenText(name: 'PrgEttyId'),
                  const FbHiddenText(name: 'CmpyEttyId'),
                  const FbHiddenText(name: 'CustEttyId'),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Flexible(
                          //     child: FbDateTimeSelectableText(
                          //   initialValue: formNewValue['MdfDate'],
                          //   name: 'MdfDate',
                          //   label: 'MdfDate',

                          const FbHiddenText(name: 'Sts'),
                          const SelectableText(
                              'Transaction Category and Spending Limit at Company level'),
                          Container(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              child: SelectableText(
                                  'Program selected for Limit Setting :${prgSelected['Program'].toString()}')),
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
                          const FbHiddenText(name: 'LimitId'),
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
                              fbFieldGap, Expanded(
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
                          //  const FbDateTimePickerWithTime(name: 'MdfDate', label: 'Modified Date')
                          // )),
                          // FbDateTimeSelectableText(
                          //   name: 'MdfDate',
                          //   label: 'MdfDate',
                          //   initialValue: formNewValue['MdfDate'],
                          //  ),
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
                          //   child: SelectableText('Apply settings to transactions from the following . If no product is selected the setting will apply to all products'),
                          // ),
                          // sbh10,
                          // Flexible(
                          //   flex: 4,
                          //   child: limitId == null
                          //       ? const SelectableText('No Record')
                          //       : CustMgmtCmpyCtrlTxnprdList(
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
                                  '/sp/ApiMgmtCmpyTxnLimitSave/queryasync?logId=${convStrNewOrNullToNull(limitId) ?? 0}',
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
                              '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/control/translimt'),
                              AcxAuditLogReqBtn('ApiMgmtCmpyTxnLimitSave',ettyId: formNewValue["LimitId"].toString(),)
                    ]),
                  )
                ],
              ));
        });
  }
}

class CustMgmtCmpyCtrlTxnprdList extends ConsumerWidget {
  const CustMgmtCmpyCtrlTxnprdList({
    super.key,
    this.custEttyId,
    this.prgEttyId,
    this.cmpyEttyId,
    this.limitId,
    this.switchValue,
    required this.query,
  });

  final String? custEttyId;
  final String? prgEttyId;
  final String? cmpyEttyId;
  final String? limitId;
  final Map<String, dynamic>? switchValue;
  final QueryObject query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeySwitch = GlobalKey<FormBuilderState>();
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
                    child: FbField(child: FormBuilderSwitch(
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
                    )),
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
            key: formKeySwitch,
            child: toReturn,
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()),);
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

void saveProdList(
    Map<String, dynamic> src,
    WidgetRef ref,
    String limitId,
    String prgEttyId,
    String custEttyId,
    String cmpyEttyId,
    QueryObject query) async {
  var futures = <Future>[];
  for (var element in src.entries) {
    final queryDel = QueryObject(
        querysql: '/sp/ApiMgmtCmpyTxnLimitPrdSave/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "CmpyEttyId": cmpyEttyId,
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
