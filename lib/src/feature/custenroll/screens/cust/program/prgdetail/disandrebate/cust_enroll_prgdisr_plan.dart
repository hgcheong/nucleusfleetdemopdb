import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';

import 'package:trina_grid/trina_grid.dart';

const int wid=824;

@RoutePage()
class CustEnrollProgramDisRebPlan extends ConsumerWidget {
  const CustEnrollProgramDisRebPlan(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('billingEttyType') this.billingEttyType,
      @PathParam('rebateId') this.rebateId,
      @PathParam('txnCtgry') this.txnCtgry,
      @PathParam('mediaType') this.mediaType});

  final String? custEttyId;
  final String? prgEttyId;
  final String? billingEttyType;
  final String? rebateId;
  final String? mediaType;
  final String? txnCtgry;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return CustEnrollProgramDisRebTransForm(
      prgEttyId: prgEttyId,
      custEttyId: custEttyId,
      rebateId: convStrNewOrNullToNull(rebateId),
      txnCtgry: convStrNewOrNullToNull(txnCtgry),
      billingEttyType: convStrNewOrNullToNull(billingEttyType),
    );
  }
}

class CustEnrollProgramDisRebTransForm extends ConsumerWidget {
  const CustEnrollProgramDisRebTransForm(
      {super.key,
      this.prgEttyId,
      this.custEttyId,
      this.rebateId,
      this.txnCtgry,
      this.billingEttyType,
      this.mediaType});
  final String? prgEttyId;
  final String? custEttyId;
  final String? rebateId;
  final String? txnCtgry;
  final String? mediaType;
  final String? billingEttyType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyCustEnrollDisReb = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiEnrlCustRebate/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "MediaType": mediaType,
          //    "TxnCtgry": txnCtgry,
          "RebateId": rebateId,
        },
        showMsg: false);
    final queryPrdList = QueryObject(
        querysql: '/sp/ApiEnrlCustRebatePrdList/queryasync',
        params: {
          "RebateId": rebateId,
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId
        },
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "Dscp": null,
      "MediaType": null,
      "TxnCtgry": null,
      "SchdId": null,
      "AggateCd": null,
      "BillingValue": null,
      "FromDate": null,
      "ToDate": null,
      "TxnPlan": null,
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      "RebateId": rebateId,
      "MdfDate": null
    };

    Map<String, dynamic> formSwitchValue = {};

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
              key: formKeyCustEnrollDisReb,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                formKeyCustEnrollDisReb.currentState!.save();
              },
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  FormBuilderField(
                    name: 'PrgEttyId',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  FormBuilderField(
                    name: 'MdfDate',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  FormBuilderField(
                    name: 'CustEttyId',
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
                    name: 'MediaType',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FbHiddenDateTime(name: 'FromDate'),
                          const FbHiddenDateTime(name: 'ToDate'),
                          const FbText(
                            name: 'Dscp',
                            label: 'Description',
                          ),
                          FormBuilderField(
                              name: 'TxnCtgry',
                              builder: (field) {
                                return AcxSearchBoxMap(
                                    returnSelectedRef: (dynamic val) {
                                      field.didChange(val['TxnCtgry']);
                                    },
                                    selectedRef: {
                                      'TxnCtgry':
                                          formNewValue['TxnCtgry'].toString()
                                    },
                                    inputText: 'Transaction Category',
                                    inputIcon: const Icon(Icons.search),
                                    querysql: '/view/async/VwLibTxnCtgry',
                                    searchText: 'Dscp',
                                    keyField: 'TxnCtgry',
                                    params: const {});
                              }),
                          FormBuilderField(
                              name: 'SchdId',
                              builder: (field) {
                                return AcxSearchBoxMap(
                                    returnSelectedRef: (dynamic val) {
                                      field.didChange(val['Id']);
                                    },
                                    selectedRef: {
                                      'Id': formNewValue['SchdId'].toString(),
                                    },
                                    inputText: 'Schedule Billing Rebate',
                                    inputIcon: const Icon(Icons.search),
                                    querysql: '/view/async/VwSchdBillingRebate',
                                    searchText: 'Dscp',
                                    keyField: 'Id',
                                    params: const {});
                              }),
                          FormBuilderField(
                              name: 'AggateCd',
                              builder: (field) {
                                return AcxSearchBoxMap(
                                    returnSelectedRef: (dynamic val) {
                                      field.didChange(val['RefCd']);
                                    },
                                    selectedRef: {
                                      'RefCd':
                                          formNewValue['AggateCd'].toString()
                                    },
                                    inputText: 'Aggregate',
                                    inputIcon: const Icon(Icons.search),
                                    querysql: '/view/async/VwAggateCd',
                                    searchText: 'Dscp',
                                    keyField: 'RefCd',
                                    params: const {});
                              }),
                          const FbHiddenText(name: 'BillingValue'),
                          const SelectableText('Fee Plan'),
                          rebateId == null || rebateId!.isEmpty
                              ? const SelectableText('No Fee Id found')
                              : SizedBox(
                                  height: 1280,
                                  child:
                                      CustEnrollProgramFeeDiscRebateFeePlanList(
                                          rebateId: rebateId,
                                          custEttyId: custEttyId,
                                          prgEttyId: prgEttyId,
                                          txnType: formNewValue['TxnType']),
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
                                  flex: 6,
                                  child: CustEnrollProgramFeeTxnLocList(
                                    rebateId: rebateId,
                                    custEttyId: custEttyId,
                                    prgEttyId: prgEttyId,
                                  ),
                                ),
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
                                : CustEnrollProgramDisRebprdList(
                                    rebateId: rebateId,
                                    custEttyId: custEttyId,
                                    prgEttyId: prgEttyId,
                                    switchValue: formSwitchValue,
                                    query: queryPrdList),
                          ),
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
                          formKeyCustEnrollDisReb.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(
                                  formKeyCustEnrollDisReb.currentState!.value),
                              theData.columnInfo);
                          toPost.remove('TxnType');
                          final querySave = QueryObject(
                              querysql: '/sp/ApiEnrlCustRebateSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              final rebateId =
                                  getOutputValue(value.output, '@RebateId');
                              final txnCtgry = toPost["TxnCtgry"];
                              final mediaType = toPost["MediaType"];
                              saveProdList(
                                  formSwitchValue,
                                  ref,
                                  rebateId.toString(),
                                  prgEttyId.toString(),
                                  custEttyId.toString(),
                                  queryPrdList);
                              ref.invalidate(ReturndatafreezedProvider(query));
                              singleton<AppRouter>().navigatePath(
                                  '/custenroll/custprg/$custEttyId/$prgEttyId/$billingEttyType/discandreb/dtl/$txnCtgry/$mediaType/$rebateId');
                            }
                          });
                        },
                      ),
                      AcxBackToList(
                        listUrl:
                            '/custenroll/custprg/$custEttyId/$prgEttyId/$billingEttyType/discandreb/list',
                      ),
                      AcxAuditLogReqBtn('ApiEnrlCustRebateSave',ettyId: custEttyId.toString(),)
                    ]),
                  )
                ],
              ));
        });
  }
}

class CustEnrollProgramDisRebprdList extends ConsumerWidget {
  const CustEnrollProgramDisRebprdList(
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

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
        data: (rValue) {
          var data = rValue.data;

          Set<String> theValue = <String>{};
          data!.asMap().entries.forEach((ele) {
            theValue.add(ele.value['PrdCtgryDscp'] ?? "");
          });

          var identifier = {};
          for (var item in theValue) {
            List<dynamic> toAdd = [];
            data.asMap().entries.forEach((ele) {
              // if (ele.value['PrdCtgryDscp'].toString() == item) {
              //   toAdd.add(ele.value);
              // }
              toAdd.add(ele.value);
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
              switchValue![item['PrdCd']] = {
                "PrdSts": item['PrdSts'],
                "Mdf": false
              };
            }

            for (var item in toVV) {
              rowItems.add(Row(
                children: [
                  //  Expanded(flex: 1, child: SelectableText(item['PrdDscp'])),
                  Expanded(
                    flex: 1,
                    child: FbField(child: FormBuilderSwitch(
                      initialValue: item['PrdSts'] == 'N' ? false : true,
                      name: item['PrdCd'],
                      title: SelectableText(item['PrdDscp']),
                      onChanged: (value) {
                        switchValue![item['PrdCd']] = value == false
                            ? {"PrdSts": 'N', "Mdf": true}
                            : {"PrdSts": 'Y', "Mdf": true};
                      },
                      valueTransformer: (value) {
                        return value == false ? 'N' : 'Y';
                      },
                    )),
                  )
                ],
              ));
            }

            categoryItem.add(Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(val.key,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
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

class CustEnrollProgramFeeTxnLocList extends ConsumerWidget {
  const CustEnrollProgramFeeTxnLocList({
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
        querysql: '/sp/ApiEnrlCustRebateLocList/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "RebateId": rebateId
        },
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          return const SizedBox(
              height: 300,
              child: Expanded(child: SelectableText('No Record ')));
        }
        if (returnData.data![0]['FeeLocId'] == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    Set<TrinaRow> selectedItems = await showAcxDialog(
                        context,
                        PopUpSearchLocFormNew(
                            prgEttyId: prgEttyId.toString(),
                            custEttyId: custEttyId,
                            rebateId: rebateId.toString()));

                    if (selectedItems.isEmpty) {
                      return;
                    }
                    for (TrinaRow element in selectedItems) {
                      final locno = element.cells['LocNo']!.value.toString();
                      final queryDel = QueryObject(
                          querysql: '/sp/ApiEnrlCustRebateLocSave/queryasync',
                          params: {
                            "CustEttyId": custEttyId,
                            "PrgEttyId": prgEttyId,
                            "RebateId": rebateId,
                            "LocNo": locno,
                          },
                          showMsg: false);
                      final resultDel =
                          ref.read(ReturndatafreezedProvider(queryDel).future);
                      resultDel.then((value) {
                        ref.invalidate(ReturndatafreezedProvider(query));
                        //  Toast.showresult(value);
                      });
                    }
                    //  Toast.showresult(value);
                    ref.invalidate(ReturndatafreezedProvider(query));
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
                  Set<TrinaRow> selectedItems = await showAcxDialog(
                      context,
                      PopUpSearchLocFormNew(
                          prgEttyId: prgEttyId.toString(),
                          custEttyId: custEttyId,
                          rebateId: rebateId.toString()));

                  if (selectedItems.isEmpty) return;

                  for (TrinaRow element in selectedItems) {
                    final locno = element.cells['LocNo']!.value.toString();
                    final queryDel = QueryObject(
                        querysql: '/sp/ApiEnrlCustRebateLocSave/queryasync',
                        params: {
                          "CustEttyId": custEttyId,
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
                            querysql: '/sp/ApiEnrlCustRebateLocDel/queryasync',
                            params: {
                              "CustEttyId": custEttyId,
                              "PrgEttyId": prgEttyId,
                              "RebateId": rebateId,
                              "LocNo": "${currentData['LocNo']}",
                              "FeeLocId": "${currentData['FeeLocId']}"
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

class CustEnrollProgramFeeTxnFeeLocForm extends ConsumerWidget {
  const CustEnrollProgramFeeTxnFeeLocForm({
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
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      "RebateId": rebateId,
      "LocName": "",
      "LocNo": ""
    };
    final query = QueryObject(
        querysql: '/sp/ApiEnrlCustRebateLocSearch/queryasync',
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
                const FbHiddenText(name: 'CustEttyId'),
                const FbHiddenText(name: 'PrgEttyId'),
                const FbHiddenText(name: 'RebateId'),
                FbText(
                  name: 'LocName',
                  label: 'Search Text',
                  onChanged: (p0) {
                    formKeyLocPlan.currentState!.save();
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      searchParam = formKeyLocPlan.currentState!.value;
                      ref.invalidate(ReturndatafreezedProvider(QueryObject(
                          querysql: '/sp/ApiEnrlCustRebateLocSearch/queryasync',
                          params: searchParam,
                          showMsg: false)));
                    },
                    child: const SelectableText('Search')),
                AcxTrinaGridWithColumn(
                    idField: 'LocNo',
                    spName: 'ApiEnrlCustRebateLocSearch',
                    params: searchParam,
                    querysql: '/sp/ApiEnrlCustRebateLocSearch/queryasync'),
              ],
            ),
          );
        });
  }
}

class PopUpSearchLocFormNew extends ConsumerWidget {
  const PopUpSearchLocFormNew({
    super.key,
    this.custEttyId,
    this.prgEttyId,
    this.rebateId,
    this.searcLoc,
    this.searchLocNo,
  });

  final String? custEttyId;
  final String? prgEttyId;
  final String? rebateId;
  final String? searcLoc;
  final String? searchLocNo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiEnrlCustRebateLocSearch/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "PrgEttyId": prgEttyId,
          "RebateId": rebateId,
          "LocName": searcLoc,
          "LocNo": searchLocNo,
          "StateCd": null
        },
        showMsg: false);

    final rtn = ReturndatafreezedProvider(query);

    final resultsRtn = ref.watch(rtn);

    return AsyncValueWidget<Returndata>(
      value: resultsRtn,
      data: (theData) {
        final theWidget = AcxTrinaGridExtDataCheckBox(
          //  gridLabel: 'Add Location',
          extData: theData,
          idField: 'LocNo',
          spName: 'ApiEnrlCustRebateLocSearch',
        );

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(flex: 10, child: theWidget),
                    Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  singleton<AppRouter>()
                                      .maybePop(theWidget.checkedItem.value);
                                },
                                child: const Icon(Icons.save)),
                            sbh10,
                            ElevatedButton(
                              onPressed: () {
                                theWidget.checkedItem.value.clear();
                                singleton<AppRouter>()
                                    .maybePop(theWidget.checkedItem.value);
                              },
                              child: const Icon(
                                Icons.exit_to_app,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void saveProdList(Map<String, dynamic> src, WidgetRef ref, String rebateId,
    String prgEttyId, String custEttyId, QueryObject query) async {
  var futures = <Future>[];
  for (var element in src.entries) {
    if (element.value['Mdf']) {
      final curPrdSts = element.value['PrdSts'];
      final queryDel = QueryObject(
          querysql: '/sp/ApiEnrlCustRebatePrdSave/queryasync',
          params: {
            "PrgEttyId": prgEttyId,
            "RebateId": rebateId,
            "CustEttyId": custEttyId,
            "PrdSts": curPrdSts,
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

class CustEnrollProgramFeeDiscRebateFeePlanList extends ConsumerWidget {
  const CustEnrollProgramFeeDiscRebateFeePlanList({
    super.key,
    this.rebateId,
    this.custEttyId,
    this.prgEttyId,
    this.txnType,
  });

  final String? rebateId;
  final String? custEttyId;
  final String? prgEttyId;
  final String? txnType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiEnrlCustRebateFeePlanList/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "RebateId": rebateId
        },
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          return const SizedBox(
              height: 300, child: SelectableText('No Record '));
        }
        if (returnData.data![0]['PlanId'] == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await showAcxDialog(
                        context,
                        CustEnrollProgramFeeDiscRebateFeePlanForm(
                          prgEttyId: prgEttyId.toString(),
                          rebateId: rebateId.toString(),
                          planId: null,
                          custEttyId: custEttyId,
                          txnType: txnType,
                        ));

                    ref.invalidate(ReturndatafreezedProvider(query));
                  },
                  child: const Icon(Icons.post_add)),
              const SelectableText('No Txn Plan'),
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
                  await showAcxDialog(
                      context,
                      CustEnrollProgramFeeDiscRebateFeePlanForm(
                        prgEttyId: prgEttyId.toString(),
                        rebateId: rebateId.toString(),
                        planId: null,
                        custEttyId: custEttyId,
                        txnType: txnType,
                      ));

                  ref.invalidate(ReturndatafreezedProvider(query));
                },
                child: const Icon(Icons.post_add)),
          ),
          // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
          ListView.separated(
            shrinkWrap: true,
            itemCount: returnData.rowcount!,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              final currentData = returnData.data![index];
              return ListTile(
                  title: SelectableText(
                      '${currentData['TxnPlanDscp']} (${fmtDateStr(currentData['FromDate'].toString())} to ${fmtDateStr(currentData['ToDate'].toString())})'),
                  onTap: () async {
                    await showAcxDialog(
                        context,
                        CustEnrollProgramFeeDiscRebateFeePlanForm(
                          prgEttyId: prgEttyId.toString(),
                          rebateId: rebateId.toString(),
                          planId: currentData['PlanId'].toString(),
                          custEttyId: custEttyId,
                          txnType: txnType,
                        ));
                  },
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
                            querysql:
                                '/sp/ApiEnrlCustRebateFeePlanDel/queryasync',
                            params: {
                              "PrgEttyId": currentData['PrgEttyId'],
                              "CustEttyId": currentData['CustEttyId'],
                              "RebateId": currentData['RebateId'],
                              "PlanId": currentData['PlanId'],
                              "TxnPlan": currentData['TxnPlan'],
                            },
                            showMsg: false);
                        final resultDel = ref
                            .read(ReturndatafreezedProvider(queryDel).future);
                        resultDel.then((value) {
                          ref.invalidate(ReturndatafreezedProvider(query));
                          Toast.showresult(value);
                        });
                      },
                      icon: const Icon(Icons
                          .delete))); // return const SelectableText('Test 123');
            },
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

class CustEnrollProgramFeeDiscRebateFeePlanForm extends ConsumerWidget {
  const CustEnrollProgramFeeDiscRebateFeePlanForm(
      {super.key,
      required this.prgEttyId,
      required this.custEttyId,
      required this.planId,
      required this.rebateId,
      required this.txnType});
  final String? prgEttyId;
  final String? custEttyId;
  final String? rebateId;
  final String? planId;
  final String? txnType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "FromDate": null,
      "ToDate": null,
      "TxnPlan": null,
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      "RebateId": rebateId,
      "PlanId": planId
    };

    final queryFeeForm = QueryObject(
        querysql: '/sp/ApiEnrlCustRebateFeePlan/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "RebateId": rebateId,
          "PlanId": planId
        },
        showMsg: false);

    final formDataFeeForm = ref.watch(ReturndatafreezedProvider(queryFeeForm));

    return AsyncValueWidget(
        value: formDataFeeForm,
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
                  Expanded(
                    flex: 10,
                    child: Column(children: [
                      FormBuilderField(
                          builder: (field) {
                            return Container();
                          },
                          name: 'MdfDate'),
                      FormBuilderField(
                          builder: (field) {
                            return Container();
                          },
                          name: 'PrgEttyId'),
                      FormBuilderField(
                          builder: (field) {
                            return Container();
                          },
                          name: 'CustEttyId'),
                      FormBuilderField(
                          builder: (field) {
                            return Container();
                          },
                          name: 'RebateId'),
                      FormBuilderField(
                          builder: (field) {
                            return Container();
                          },
                          name: 'PlanId'),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: FbLibView(
                              name: 'TxnPlan',
                              label: 'Fee Plan',
                              querySql: '/sp/ApiPlanList/queryasync',
                              params: {"TxnType": txnType},
                              keyField: 'TxnPlan',
                              searchText: 'TxnPlanDscp',
                            ),
                          ),
                        ],
                      ),
                      fbFieldBottomGap,
                      const Row(
                        children: [
                          Expanded(
                              child: FbDateTimePicker(
                                  name: 'FromDate', label: 'From Date')),
                          fbFieldGap,
                          Expanded(
                            child: FbDateTimePicker(
                                name: 'ToDate', label: 'To Date'),
                          )
                        ],
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
                                      Map.from(formKeyPlan.currentState!.value),
                                      theData.columnInfo);

                              final querySave = QueryObject(
                                  querysql:
                                      '/sp/ApiEnrlCustRebateFeePlanSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
                                  params: toPost,
                                  showMsg: false);

                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((value) {
                                //  context.maybePop();
                                Toast.showresult(value);

                                ref.invalidate(
                                    ReturndatafreezedProvider(queryFeeForm));
                              });
                            },
                          ),
                          AcxAuditLogReqBtn('ApiEnrlCustRebateFeePlanSave',ettyId: custEttyId.toString(),),
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
        });
  }
}
