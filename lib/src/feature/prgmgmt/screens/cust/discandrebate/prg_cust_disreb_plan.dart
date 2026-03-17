import 'package:auto_route/auto_route.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatauniquekey.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=161;
@RoutePage()
class PrgCustDiscRebPlan extends ConsumerWidget {
  const PrgCustDiscRebPlan(
      {super.key,
      @PathParam('rebateId') this.rebateId,
      @PathParam.inherit('prgEttyId') this.prgEttyId});
  final String? prgEttyId;
  final String? rebateId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Center(
      child: PrgCustDisRebTransForm(
        prgEttyId: convStrNewOrNullToNull(prgEttyId),
        rebateId: convStrNewOrNullToNull(rebateId),
      ),
    );
  }
}

class PrgCustDisRebTransForm extends ConsumerWidget {
  const PrgCustDisRebTransForm({
    super.key,
    this.prgEttyId,
    this.rebateId,
  });
  final String? prgEttyId;
  final String? rebateId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiPrgCustRebate/queryasync',
        params: {"PrgEttyId": prgEttyId, "RebateId": rebateId},
        showMsg: false);
    final queryPrdList = QueryObject(
        querysql: '/sp/ApiPrgCustRebatePrdList/queryasync',
        params: {
          //"RebateId": rebateId,
          "PrgEttyId": prgEttyId,
          "FeeId": rebateId
        },
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "Dscp": null,
      "TxnCtgry": null,
      "SchdId": null,
      "AggateCd": null,
      "BillingValue": null,
      "FromDate": null,
      "ToDate": null,
      "PrgEttyId": prgEttyId,
      "RebateId": rebateId,
      "Sts": "A"
    };

    Map<String, dynamic> formSwitchValue = {};

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            if (rebateId != null) {
              formNewValue = convertFormValueToDisplay(
                  theData.data![0] as Map<String, dynamic>, theData.columnInfo);
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
                  FormBuilderField(
                    name: 'PrgEttyId',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  FormBuilderField(
                    name: 'RebateId',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  FormBuilderField(
                    name: 'Sts',
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
                          const FbText(
                            name: 'Dscp',
                            label: 'Description',
                          ),
                          Flexible(
                              flex: 2,
                              child: FormBuilderField(
                                  name: 'TxnCtgry',
                                  builder: (field) {
                                    return AcxSearchBoxMap(
                                        returnSelectedRef: (dynamic val) {
                                          field.didChange(val['TxnCtgry']);
                                        },
                                        selectedRef: {
                                          'TxnCtgry': formNewValue['TxnCtgry']
                                              .toString()
                                        },
                                        inputText: 'Transaction Category',
                                        inputIcon: const Icon(Icons.search),
                                        querysql: '/view/async/VwLibTxnCtgry',
                                        searchText: 'Dscp',
                                        keyField: 'TxnCtgry',
                                        params: const {});
                                  })),
                          Flexible(
                              flex: 2,
                              child: FormBuilderField(
                                  name: 'SchdId',
                                  builder: (field) {
                                    return AcxSearchBoxMap(
                                        returnSelectedRef: (dynamic val) {
                                          field.didChange(val['Id']);
                                        },
                                        selectedRef: {
                                          'Id':
                                              formNewValue['SchdId'].toString(),
                                        },
                                        inputText: 'Billing Frequency',
                                        inputIcon: const Icon(Icons.search),
                                        querysql:
                                            '/view/async/VwSchdBillingRebate',
                                        searchText: 'Dscp',
                                        keyField: 'Id',
                                        params: const {});
                                  })),
                          Flexible(
                              flex: 2,
                              child: FormBuilderField(
                                  name: 'AggateCd',
                                  builder: (field) {
                                    return AcxSearchBoxMap(
                                        returnSelectedRef: (dynamic val) {
                                          field.didChange(val['RefCd']);
                                        },
                                        selectedRef: {
                                          'RefCd': formNewValue['AggateCd']
                                              .toString()
                                        },
                                        inputText: 'Aggregate',
                                        inputIcon: const Icon(Icons.search),
                                        querysql: '/view/async/VwAggateCd',
                                        searchText: 'Dscp',
                                        keyField: 'RefCd',
                                        params: const {});
                                  })),
                          Flexible(
                              flex: 2,
                              child: FormBuilderField(
                                  name: 'BillingValue',
                                  builder: (field) {
                                    return AcxSearchBoxMap(
                                        returnSelectedRef: (dynamic val) {
                                          field.didChange(val['RefCd']);
                                        },
                                        selectedRef: {
                                          'RefCd': formNewValue['BillingValue']
                                              .toString()
                                        },
                                        inputText: 'Billing Value',
                                        inputIcon: const Icon(Icons.search),
                                        querysql: '/view/async/VwBillingValue',
                                        searchText: 'Dscp',
                                        keyField: 'RefCd',
                                        params: const {});
                                  })),
                          Flexible(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: FormBuilderDateTimePicker(
                                    valueTransformer: (v) {
                                      // return v!.toIso8601String();
                                      if (v != null) {
                                        return DateFormat('yMMMEd').format(v);
                                      }
                                    },
                                    name: 'FromDate',
                                    format: DateFormat.yMMMEd(),
                                    initialEntryMode:
                                        DatePickerEntryMode.calendar,
                                    inputType: InputType.date,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'FromDate',
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          //     ?.didChange(null);
                                        },
                                      ),
                                    ),
                                    initialTime:
                                        const TimeOfDay(hour: 8, minute: 0),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: FormBuilderDateTimePicker(
                                    valueTransformer: (v) {
                                      if (v != null) {
                                        return DateFormat('yMMMEd').format(v);
                                      }
                                    },
                                    name: 'ToDate',
                                    format: DateFormat.yMMMEd(),
                                    initialEntryMode:
                                        DatePickerEntryMode.calendar,
                                    inputType: InputType.date,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'To Date',
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {},
                                      ),
                                    ),
                                    initialTime:
                                        const TimeOfDay(hour: 8, minute: 0),
                                  ),
                                )
                              ],
                            ),
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
                          const SelectableText("Rebate Location List"),
                          rebateId == null || rebateId!.isEmpty
                              ? const SelectableText('No Fee Id found')
                              : Flexible(
                                  flex: 4,
                                  child: PrgCustFeeTxnLocList(
                                    rebateId: rebateId,
                                    prgEttyId: prgEttyId,
                                  ),
                                ),
                          sbh10,
                          const Flexible(
                            flex: 1,
                            child: SelectableText(
                                'Apply settings to transactions from the following . If no product is selected the setting will apply to all products'),
                          ),
                          sbh10,
                          Flexible(
                            flex: 4,
                            child: rebateId == null
                                ? const SelectableText('No Record')
                                : PrgCustDisRebprdList(
                                    rebateId: rebateId,
                                    prgEttyId: prgEttyId,
                                    switchValue: formSwitchValue,
                                    query: queryPrdList,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      // ElevatedButton(
                      //   onPressed: () async {

                      //     Toast.message(formSwitchValue.toString());
                      //     Debugger.log(formKey.currentState!.value);
                      //   },
                      //   child: const Icon(Icons.save),
                      // ),
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
                              querysql: '/sp/ApiPrgCustRebateSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              if (context.mounted) {
                                saveProdList(
                                    formSwitchValue,
                                    ref,
                                    rebateId.toString(),
                                    prgEttyId.toString(),
                                    queryPrdList);
                                singleton<AppRouter>()
                                    .navigatePath(getAfterSavePath(
                                        context, value.output, '@RebateId'))
                                    .then((val) {
                                  ref.invalidate(
                                      ReturndatafreezedProvider(query));
                                });
                              }
                            }
                          });
                        },
                      ),
                      sbh10,
                      AcxBackToList(
                        listUrl: '/prgmgmt/custsetup/$prgEttyId/pcdislanding',
                      ),
                      sbh10,
                      AcxAuditLogReqBtn('ApiPrgCustRebateSave',ettyId: prgEttyId.toString(),)
                    ]),
                  ),
                ],
              ));
        });
  }
}

void saveProdList(Map<String, dynamic> src, WidgetRef ref, String feeId,
    String prgEttyId, QueryObject query) async {
  var futures = <Future>[];
  for (var element in src.entries) {
    if (element.value['Mdf']) {
      final curPrdSts = element.value['Sts'];
      final queryDel = QueryObject(
          querysql: '/sp/ApiPrgCustRebatePrdSave/queryasync',
          params: {
            "PrgEttyId": prgEttyId,
            "FeeId": feeId,
            "Sts": curPrdSts,
            "PrdCd": element.key
          },
          showMsg: false);
      final resultDel = ref.read(ReturndatafreezedProvider(queryDel).future);
      futures.add(resultDel);
    }
  }

  await Future.wait(futures).then((value) {
    ref.invalidate(ReturndatafreezedProvider(query));
  });
}

class PrgCustDisRebprdList extends ConsumerWidget {
  const PrgCustDisRebprdList(
      {super.key,
      this.rebateId,
      this.custEttyId,
      this.prgEttyId,
      this.switchValue,
      required this.query});

  final String? rebateId;
  final String? custEttyId;
  final String? prgEttyId;
  final Map<String, dynamic>? switchValue;
  final QueryObject query;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeySwitch = GlobalKey<FormBuilderState>();
//    Map<String, dynamic> formKeySwitchValue = {'0000': true};
    // final query = QueryObject(querysql: '/sp/ApiPrgCustRebatePrdList/queryasync', params: {"PrgEttyId": prgEttyId, "CustEttyId": custEttyId, "RebateId": rebateId}, showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
        data: (rValue) {
          var data = rValue.data;

          Set<String> theValue = <String>{};
          data!.asMap().entries.forEach((ele) {
            theValue.add(ele.value['PrdCtgryDscp'].toString());
          });

          var identifier = {};
          for (var item in theValue) {
            List<dynamic> toAdd = [];
            data.asMap().entries.forEach((ele) {
              if (ele.value['PrdCtgryDscp'].toString() == item) {
                toAdd.add(ele.value);
              }
            });
            identifier[item] = toAdd;
          }
          //  Column toReturnWidget = const Column(children: [SelectableText('Start')]);
          List<Widget> categoryItem = [];

          for (var val in identifier.entries) {
            // myOne.children.add(SelectableText(val.key));

            List<Widget> rowItems = [];

            List<dynamic> toVV = val.value;
            for (var item in toVV) {
              switchValue![item['PrdCd']] = {"Sts": item['Sts'], "Mdf": false};
            }

            for (var item in toVV) {
              //   formKeySwitchValue[item['PrdCd']] = item['PrdSts'] == 'N' ? false : true;
              rowItems.add(Row(
                children: [
                  //  Expanded(flex: 1, child: SelectableText(item['PrdDscp'])),
                  Expanded(
                    flex: 1,
                    child: FormBuilderSwitch(
                      initialValue: item['Sts'] == 'N' || item['Sts'] == null
                          ? false
                          : true,
                      name: item['PrdCd'],
                      title: SelectableText(item['PrdDscp']),
                      onChanged: (value) {
                        switchValue![item['PrdCd']] = value == false
                            ? {"Sts": 'N', "Mdf": true}
                            : {"Sts": 'Y', "Mdf": true};
                      },
                      valueTransformer: (value) {
                        return value == false ? 'N' : 'Y';
                      },
                    ),
                  )
                ],
              ));
            }

            categoryItem.add(Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SelectableText(val.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ...rowItems
                ],
              ),
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
          //    return ;
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()),);
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

class PrgCustFeeTxnLocList extends ConsumerWidget {
  const PrgCustFeeTxnLocList({
    super.key,
    this.rebateId,
    this.custEttyId,
    this.prgEttyId,
  });

  final String? rebateId;
  final String? custEttyId;
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustRebateLocList/queryasync',
        params: {"PrgEttyId": prgEttyId, "RebateId": rebateId},
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          return const SizedBox(
              height: 300,
              child: Expanded(child: SelectableText('No Record ')));
        }
        if (returnData.data![0]['LocateId'] == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    Set<TrinaRow> selectedItems = await showAcxDialog(
                        context,
                        PopUpSearchLocForm(
                            prgEttyId: prgEttyId.toString(),
                            custEttyId: custEttyId,
                            rebateId: rebateId.toString()));

                    for (TrinaRow element in selectedItems) {
                      Debugger.log(element);
                      final locno = element.cells['LocNo']!.value.toString();
                      final queryDel = QueryObject(
                          querysql: '/sp/ApiPrgCustRebateLocSave/queryasync',
                          params: {
                            "PrgEttyId": prgEttyId,
                            "RebateId": rebateId,
                            "LocNo": locno,
                          },
                          showMsg: false);
                      final resultDel =
                          ref.read(ReturndatafreezedProvider(queryDel).future);
                      resultDel.then((value) {
                        //  ref.invalidate(ReturndatafreezedProvider(query));
                        //  Toast.showresult(value);
                      });
                    }
                    //  Toast.showresult(value);
                    ref.invalidate(ReturndatafreezedProvider(query));
                    Debugger.log(selectedItems);
                  },
                  child: const Icon(Icons.post_add)),
              const SelectableText('No Location Setup'),
              Expanded(
                  child: ListView(
                children: const [SelectableText('No Record')],
              ))
            ],
          );
        }

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
            flex: 1,
            child: ElevatedButton(
                onPressed: () async {
                  Set<TrinaRow> selectedItems = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          backgroundColor: bgColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: PopUpSearchLocForm(
                              prgEttyId: prgEttyId.toString(),
                              custEttyId: custEttyId,
                              rebateId: rebateId.toString()));
                    },
                  );

                  if (selectedItems.isEmpty) return;

                  for (TrinaRow element in selectedItems) {
                    Debugger.log(element);
                    final locno = element.cells['LocNo']!.value.toString();
                    final queryDel = QueryObject(
                        querysql: '/sp/ApiPrgCustRebateLocSave/queryasync',
                        params: {
                          "PrgEttyId": prgEttyId,
                          "RebateId": rebateId,
                          "LocNo": locno,
                        },
                        showMsg: false);
                    final resultDel =
                        ref.read(ReturndatafreezedProvider(queryDel).future);
                    resultDel.then((value) {});
                  }
                  //  Toast.showresult(value);
                  ref.invalidate(ReturndatafreezedProvider(query));
                },
                child: const Icon(Icons.post_add)),
          ),
          // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: returnData.rowcount!,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                final currentData = returnData.data![index];
                return ListTile(
                  title: SelectableText(
                      '${currentData['LocName']} ${currentData['LocNo']}'),
                  trailing: IconButton(
                      onPressed: () async {
                        bool confirmed = await ConfirmDialog.show(
                          title: "Delete?",
                          body: "Are you sure you want to Delete?",
                          destructive: true,
                          confirmText: "Yes",
                          cancelText: "Cancel",
                        );

                        if (!confirmed) {
                          return;
                        }

                        final queryDel = QueryObject(
                            querysql: '/sp/ApiPrgCustRebateLocDel/queryasync',
                            params: {
                              "PrgEttyId": prgEttyId,
                              "LocNo": "${currentData['LocNo']}",
                              "LocateId": "${currentData['LocateId']}",
                              "FeeId": convStrNewOrNullToNull(
                                  "${currentData['FeeId']}")
                            },
                            showMsg: false);
                        final resultDel = ref
                            .read(ReturndatafreezedProvider(queryDel).future);
                        resultDel.then((value) {
                          ref.invalidate(ReturndatafreezedProvider(query));
                          Toast.showresult(value);
                        });
                      },
                      icon: const Icon(Icons.delete)),
                );
              },
            ),
          ),
        ]);
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()),);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class PrgCustFeeTxnFeeLocForm extends ConsumerWidget {
  const PrgCustFeeTxnFeeLocForm({
    super.key,
    required this.prgEttyId,
    required this.custEttyId,
    required this.rebateId,
  });
  final String? prgEttyId;
  final String? custEttyId;
  final String? rebateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyLocPlan = GlobalKey<FormBuilderState>();
    //  final formValue = {"FromDate": "", "ToDate": "", "TxnPlan": "", "PrgEttyId": prgEttyId, "RebateId": rebateId, "FeeLocId": feeLocId};

    Map<String, dynamic> searchParam = {
      "PrgEttyId": prgEttyId,
      "RebateId": rebateId,
      "LocName": "",
      "LocNo": ""
    };
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustRebateLocSearch/queryasync',
        params: searchParam,
        showMsg: false);
    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
        error: (error, stackTrace) => Center(child: Text(error.toString()),),
        loading: () => const CircularProgressIndicator(),
        data: (d) {
          return FormBuilder(
            initialValue: searchParam,
            key: formKeyLocPlan,
            child: ListView(
              children: [
                const FbHiddenText(name: 'PrgEttyId'),
                const FbHiddenText(name: 'RebateId'),
                FbText(
                  name: 'LocName',
                  label: 'Search Text',
                  onChanged: (p0) {
                    formKeyLocPlan.currentState!.save();
                    EasyDebounce.debounce(
                        'locSearch', const Duration(milliseconds: 1000), () {
                      Debugger.log(p0);
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      searchParam = formKeyLocPlan.currentState!.value;
                      ref.invalidate(ReturndatafreezedProvider(QueryObject(
                          querysql: '/sp/ApiPrgCustRebateLocSearch/queryasync',
                          params: searchParam,
                          showMsg: false)));
                    },
                    child: const SelectableText('Search')),
                AcxTrinaGridWithColumn(
                    idField: 'LocNo',
                    spName: 'ApiPrgCustRebateLocSearch',
                    params: searchParam,
                    querysql: '/sp/ApiPrgCustRebateLocSearch/queryasync'),
              ],
            ),
          );
        });
  }
}

class PopUpSearchLocForm extends HookWidget {
  const PopUpSearchLocForm({
    super.key,
    this.prgEttyId,
    this.custEttyId,
    this.rebateId,
  });

  final String? prgEttyId;
  final String? custEttyId;
  final String? rebateId;
  @override
  Widget build(BuildContext context) {
    final dv = useState<Returndata>(Returndata());
    final searchLocName = useTextEditingController(text: '');
    final searchLocNo = useTextEditingController(text: '');
    final searchCity = useTextEditingController(text: '');
    final checkedItem = useState<Set<TrinaRow>>(<TrinaRow>{});

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: searchLocName,
                  onChanged: (val) {
                    searchLocNo.clear();
                    searchCity.clear();
                  },
                  decoration: const InputDecoration(hintText: 'Location Name'),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: searchLocNo,
                  onChanged: (val) {
                    searchLocName.clear();
                    searchCity.clear();
                  },
                  decoration: const InputDecoration(hintText: 'Location No'),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: searchCity,
                  onChanged: (val) {
                    searchLocNo.clear();
                    searchLocName.clear();
                  },
                  decoration: const InputDecoration(hintText: 'City'),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final dda = await AcxReturnDataService().retrieve(
                        '/sp/ApiPrgCustRebateLocSearch/queryasync',
                        {
                          "PrgEttyId": prgEttyId,
                          "RebateId": rebateId,
                          "LocName": searchLocName.value.text == ''
                              ? null
                              : searchLocName.value.text,
                          "LocNo": searchLocNo.value.text == ''
                              ? null
                              : searchLocNo.value.text,
                          "City": searchCity.value.text == ''
                              ? null
                              : searchCity.value.text
                        },
                        showMsg: false);

                    dv.value = Returndata(
                        output: dda.output,
                        data: dda.data,
                        columnInfo: dda.columnInfo);

                    //  return;
                  },
                  child: const SelectableText(
                    'Search',
                  )),
              const Spacer(
                flex: 1,
              ),
              IconButton(
                  onPressed: () {
                    singleton<AppRouter>().maybePop(checkedItem.value);
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
          sbh20,
          SingleChildScrollView(
            child: SizedBox(
              height: 500,
              child: AcxTrinaGridExtDataUniqueKey(
                idField: 'LocNo',
                spName: 'ApiEnrlCustRebateLocSearch',
                extData: dv.value,
                useCheckBox: true,
                onCheckedAll: (TrinaGridOnRowCheckedEvent v) {
                  if (v.isAll) {
                    if (v.isChecked!) {
                      if (dv.value.data != null) {
                        final theD = dv.value;
                        checkedItem.value.addAll(getRows(theD.data!,
                            theD.columnInfo!, theD.columnInfo!.length, null));
                      }
                    } else {
                      checkedItem.value.clear();
                    }
                  }
                },
                onChecked: (TrinaRow? rw) {
                  if (rw!.checked!) {
                    checkedItem.value.add(rw);
                  } else {
                    checkedItem.value.remove(rw);
                  }
                },
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                singleton<AppRouter>().maybePop(checkedItem.value);
              },
              icon: const Icon(Icons.save)),
        ],
      ),
    );
  }
}

class PrgCustDiscRebatePlanList extends ConsumerWidget {
  const PrgCustDiscRebatePlanList(
      {super.key, required this.srcData, this.prgEttyId, this.rebateId});

  final Returndata srcData;

  final String? prgEttyId;
  final String? rebateId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    if (srcData.data == null) {
      return const SizedBox(
          height: 300, child: Expanded(child: SelectableText('No Record ')));
    }
    if (srcData.data![0]['PlanId'] == null) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          child: PrgCustDiscRebatePlanListForm(
                        prgEttyId: prgEttyId.toString(),
                        rebateId: rebateId,
                        planId: null,
                      ));
                    },
                  );
                  //     ref.invalidate(ReturndatafreezedProvider(query));
                },
                child: const Icon(Icons.post_add)),
            const SelectableText('No Transaction Plan'),
            SizedBox(
                height: 100,
                child: ListView(
                  children: const [SelectableText('No Record')],
                ))
          ],
        ),
      );
    }

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          child: PrgCustDiscRebatePlanListForm(
                        planId: convStrNewOrNullToNull(
                            srcData.data![0]['PlanId'].toString()),
                        prgEttyId: prgEttyId.toString(),
                      ));
                    },
                  );
                  //   ref.invalidate(ReturndatafreezedProvider(query));
                },
                child: const Icon(Icons.post_add)),
          ),
          // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
          SizedBox(
            height: 300,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: srcData.rowcount!,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                final currentData = srcData.data![index];
                return ListTile(
                  onTap: () async {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                            child: PrgCustDiscRebatePlanListForm(
                          prgEttyId: prgEttyId,
                          rebateId: rebateId,
                          planId: currentData['PlanId'].toString(),
                        ));
                      },
                    );
                  },
                  title: SelectableText(
                      '${currentData['TxnPlanDscp']} (${fmtDateStr(currentData['FromDate'].toString())} to ${fmtDateStr(currentData['ToDate'].toString())})'),
                );
              },
            ),
          ),
        ]);
  }
}

class PrgCustDiscRebatePlanListForm extends ConsumerWidget {
  const PrgCustDiscRebatePlanListForm({
    super.key,
    required this.prgEttyId,
    this.txnPlan,
    this.rebateId,
    this.fromDate,
    this.toDate,
    this.planId,
  });

  final String? rebateId;
  final String? prgEttyId;
  final String? txnPlan;
  final String? fromDate;
  final String? toDate;
  final String? planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "TxnPlan": null,
      "FromDate": null,
      "ToDate": null,
      "PrgEttyId": prgEttyId,
      "RebateId": rebateId,
      "PlanId": null
    };

    final queryPlanListForm = QueryObject(
        querysql: '/sp/ApiPrgCustRebatePlan/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "RebateId": rebateId,
          "PlanId": planId,
        },
        showMsg: false);

    final formDataPlanListForm =
        ref.watch(ReturndatafreezedProvider(queryPlanListForm));

    return AsyncValueWidget<Returndata>(
      value: formDataPlanListForm,
      data: (theData) {
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        } else {}

        return FormBuilder(
          key: formKeyPlan,
          initialValue: formValue,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 10,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'CustEttyId'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'PrgEttyId'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'FeeId'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'PlanId'),
                    Flexible(
                        flex: 2,
                        child: FormBuilderField(
                            name: 'TxnPlan',
                            builder: (field) {
                              return AcxSearchBoxMap(
                                  returnSelectedRef: (dynamic val) {
                                    field.didChange(val['TxnPlan']);
                                  },
                                  selectedRef: {
                                    'TxnPlan':
                                        formValue['TxnPlan'].toString()
                                  },
                                  inputText: 'Fee Plan',
                                  inputIcon: const Icon(Icons.search),
                                  querysql: '/view/async/VwTxnPlan',
                                  searchText: 'TxnPlanDscp',
                                  keyField: 'TxnPlan',
                                  params: const {});
                            })),
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              valueTransformer: (v) {
                                // return v!.toIso8601String();
                                if (v != null) {
                                  return DateFormat('yMMMEd').format(v);
                                }
                              },
                              name: 'FromDate',
                              format: DateFormat.yMMMEd(),
                              initialEntryMode: DatePickerEntryMode.calendar,
                              inputType: InputType.date,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'FromDate',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    // _formKey.currentState!
                                    //     .fields['FromDate']
                                    //     ?.didChange(null);
                                  },
                                ),
                              ),
                              initialTime: const TimeOfDay(hour: 8, minute: 0),
                              // locale: const Locale.fromSubtags(languageCode: 'fr'),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              valueTransformer: (v) {
                                // return v!.toIso8601String();
                                if (v != null) {
                                  return DateFormat('yMMMEd').format(v);
                                }
                              },
                              name: 'ToDate',
                              format: DateFormat.yMMMEd(),
                              initialEntryMode: DatePickerEntryMode.calendar,
                              inputType: InputType.date,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'To Date',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    // _formKey.currentState!
                                    //     .fields['ToDate']
                                    //     ?.didChange(null);
                                  },
                                ),
                              ),
                              initialTime: const TimeOfDay(hour: 8, minute: 0),
                              // locale: const Locale.fromSubtags(languageCode: 'fr'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        AcxSaveButtonManual(
                          onSave: () async {
                              if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                            formKeyPlan.currentState!.save();
                            final planId =
                                formKeyPlan.currentState!.value['PlanId'];
                            formKeyPlan.currentState!.patchValue(
                                {'PlanId': planId == '' ? null : planId});
                            Map<String, dynamic> toPost =
                                convertFormValueToSave(
                                    formKeyPlan.currentState!.value,
                                    theData.columnInfo);
                            final querySave = QueryObject(
                                querysql:
                                    '/sp/ApiPrgCustRebatePlanSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                                params: toPost,
                                showMsg: false);

                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((value) {
                              if (context.mounted) {
                                Toast.showresult(value);

                                context.maybePop();
                                singleton<AppRouter>()
                                    .navigatePath(
                                        '/prgmgmt/custsetup/$prgEttyId/pcfeelanding/pcfeemlist')
                                    .then((val) {
                                  ref.invalidate(ReturndatafreezedProvider(
                                      queryPlanListForm));
                                });
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AcxAuditLogReqBtn('ApiPrgCustRebatePlanSave',ettyId: prgEttyId.toString(),),
                        sbh10,
                        ElevatedButton(
                          onPressed: () {
                            context.maybePop();
                          },
                          child: const RotationTransition(
                            turns: AlwaysStoppedAnimation(180 / 360),
                            child: Icon(
                              Icons.exit_to_app,
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
