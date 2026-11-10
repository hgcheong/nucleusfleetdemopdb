import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_dtp.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_hiddentext.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_text.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';

import 'package:trina_grid/trina_grid.dart';

const int wid=836;

@RoutePage()
class CustMgmtProgramDisRebPlan extends ConsumerWidget {
  const CustMgmtProgramDisRebPlan(
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
    return Center(
      child: CustMgmtProgramDisRebTransForm(
        prgEttyId: prgEttyId,
        custEttyId: custEttyId,
        rebateId: convStrNewOrNullToNull(rebateId),
        txnCtgry: convStrNewOrNullToNull(txnCtgry),
        billingEttyType: convStrNewOrNullToNull(billingEttyType),
      ),
    );
  }
}

class CustMgmtProgramDisRebTransForm extends ConsumerWidget {
  const CustMgmtProgramDisRebTransForm(
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
    final formKeyCustMgmtDisReb = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiMgmtCustRebate/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "MediaType": mediaType,
          //   "TxnCtgry": txnCtgry,
          "RebateId": rebateId,
        },
        showMsg: false);
    final queryPrdList = QueryObject(
        querysql: '/sp/ApiMgmtCustRebatePrdList/queryasync',
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
              key: formKeyCustMgmtDisReb,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                formKeyCustMgmtDisReb.currentState!.save();
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
                    name: 'MdfDate',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  FormBuilderField(
                    name: 'FromDate',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  FormBuilderField(
                    name: 'ToDate',
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
                      child: SizedBox(
                        height: 1280,
                        child: ListView(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      inputText: 'Billing Frequency',
                                      inputIcon: const Icon(Icons.search),
                                      querysql:
                                          '/view/async/VwSchdBillingRebate',
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
                                        CustMgmtProgramFeeDiscRebateFeePlanList(
                                      rebateId: rebateId,
                                      custEttyId: custEttyId,
                                      prgEttyId: prgEttyId,
                                    ),
                                  ),
                          ],
                        ),
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
                                  child: CustMgmtProgramFeeTxnLocList(
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
                                : CustMgmtProgramDisRebprdList(
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
                          formKeyCustMgmtDisReb.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              formKeyCustMgmtDisReb.currentState!.value,
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiMgmtCustRebateSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              //  saveProdList(formSwitchValue, ref, rebateId.toString(), prgEttyId.toString(), queryPrdList);
                              final rebateId =
                                  getOutputValue(value.output, '@RebateId');
                              final txnCtgry = toPost["TxnCtgry"];
                              final mediaType = toPost["MediaType"];
                              singleton<AppRouter>()
                                  .navigatePath(
                                      '/custmgmt/custprg/$custEttyId/$prgEttyId/$billingEttyType/discandreb/dtl/$txnCtgry/$mediaType/$rebateId')
                                  .then((vl) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                              });
                            }
                          });
                        },
                      ),
                      AcxBackToList(
                        listUrl:
                            '/custmgmt/custprg/$custEttyId/$prgEttyId/$billingEttyType/discandreb/list',
                      ),
                      AcxAuditLogReqBtn('ApiMgmtCustRebateSave', ettyId: custEttyId.toString(),)
                    ]),
                  )
                ],
              ));
        });
  }
}

class CustMgmtProgramDisRebprdList extends ConsumerWidget {
  const CustMgmtProgramDisRebprdList(
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

    Map<String, dynamic> switchValue = {};

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
              toAdd.add(ele.value);
              // }
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
              switchValue[item['PrdCd']] = {
                "PrdSts": item['PrdSts'],
                "Mdf": false
              };
            }

            for (var item in toVV) {
              //   formKeySwitchValue[item['PrdCd']] = item['PrdSts'] == 'N' ? false : true;
              rowItems.add(Row(
                children: [
                  //  Expanded(flex: 1, child: SelectableText(item['PrdDscp'])),
                  Expanded(
                    flex: 1,
                    child: FormBuilderSwitch(
                      initialValue: item['PrdSts'] == 'N' ? false : true,
                      name: item['PrdCd'],
                      title: SelectableText(item['PrdDscp']),
                      onChanged: (value) {
                        switchValue[item['PrdCd']] = value == false
                            ? {"PrdSts": 'N', "Mdf": true}
                            : {"PrdSts": 'Y', "Mdf": true};
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
                  SelectableText(
                    val.key,
                    //  style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  ...rowItems
                ],
              ),
            ));
          }

          ListView toReturn = ListView(
            children: categoryItem,
          );

          return FormBuilder(
            initialValue: switchValue,
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

class CustMgmtProgramFeeTxnLocList extends ConsumerWidget {
  const CustMgmtProgramFeeTxnLocList({
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
        querysql: '/sp/ApiMgmtCustRebateLocList/queryasync',
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
                        PopUpSearchMgmtLocFormNew(
                            prgEttyId: prgEttyId.toString(),
                            custEttyId: custEttyId,
                            rebateId: rebateId.toString()));

                    for (TrinaRow element in selectedItems) {
                      Debugger.log(element);
                      final locno = element.cells['LocNo']!.value.toString();
                      final queryDel = QueryObject(
                          querysql: '/sp/ApiMgmtCustRebateLocSave/queryasync',
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
                  Set<TrinaRow> selectedItems = await showAcxDialog(
                      context,
                      PopUpSearchMgmtLocFormNew(
                          prgEttyId: prgEttyId.toString(),
                          custEttyId: custEttyId,
                          rebateId: rebateId.toString()));

                  if (selectedItems.isEmpty) return;

                  for (TrinaRow element in selectedItems) {
                    Debugger.log(element);
                    final locno = element.cells['LocNo']!.value.toString();
                    final queryDel = QueryObject(
                        querysql: '/sp/ApiMgmtCustRebateLocSave/queryasync',
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
                            querysql: '/sp/ApiMgmtCustRebateLocDel/queryasync',
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

class CustMgmtProgramFeeDiscRebateFeePlanList extends ConsumerWidget {
  const CustMgmtProgramFeeDiscRebateFeePlanList({
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
        querysql: '/sp/ApiMgmtCustRebateFeePlanList/queryasync',
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
                        CustMgmtProgramFeeDiscRebateFeePlanForm(
                          prgEttyId: prgEttyId.toString(),
                          rebateId: rebateId.toString(),
                          planId: null,
                          custEttyId: custEttyId,
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
                      CustMgmtProgramFeeDiscRebateFeePlanForm(
                        prgEttyId: prgEttyId.toString(),
                        rebateId: rebateId.toString(),
                        planId: null,
                        custEttyId: custEttyId,
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
                        CustMgmtProgramFeeDiscRebateFeePlanList(
                          prgEttyId: prgEttyId.toString(),
                          rebateId: rebateId.toString(),
                          //     planId: currentData['PlanId'].toString(),
                          custEttyId: custEttyId,
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

class CustMgmtProgramFeeTxnFeeLocForm extends ConsumerWidget {
  const CustMgmtProgramFeeTxnFeeLocForm({
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
        querysql: '/sp/ApiMgmtCustRebateLocSearch/queryasync',
        params: searchParam,
        showMsg: false);
    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
        error: (error, stackTrace) =>Center(child: Text(error.toString()),),
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
                          querysql: '/sp/ApiMgmtCustRebateLocSearch/queryasync',
                          params: searchParam,
                          showMsg: false)));
                    },
                    child: const SelectableText('Search')),
                AcxTrinaGridWithColumn(
                    idField: 'LocNo',
                    spName: 'ApiMgmtCustRebateLocSearch',
                    params: searchParam,
                    querysql: '/sp/ApiMgmtCustRebateLocSearch/queryasync'),
              ],
            ),
          );
        });
  }
}

class PopUpSearchMgmtLocFormNew extends ConsumerWidget {
  const PopUpSearchMgmtLocFormNew({
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
        querysql: '/sp/ApiMgmtCustRebateLocSearch/queryasync',
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
          spName: 'ApiMgmtCustRebateLocSearch',
        );

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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
        );
      },
    );
  }
}

// class PopUpSearchLocForm extends HookWidget {
//   const PopUpSearchLocForm({
//     super.key,
//     this.prgEttyId,
//     this.custEttyId,
//     this.rebateId,
//   });

//   final String? prgEttyId;
//   final String? custEttyId;
//   final String? rebateId;
//   @override
//   Widget build(BuildContext context) {
//     final dv = useState<Returndata>(Returndata());
//     final searchLocName = useTextEditingController(text: '');
//     final searchLocNo = useTextEditingController(text: '');
//     final checkedItem = useState<Set<TrinaRow>>(<TrinaRow>{});

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListView(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: TextFormField(
//                   controller: searchLocName,
//                   decoration: const InputDecoration(hintText: 'Location Name'),
//                 ),
//               ),
//               const Spacer(
//                 flex: 1,
//               ),
//               Expanded(
//                 flex: 1,
//                 child: TextFormField(
//                   controller: searchLocNo,
//                   decoration: const InputDecoration(hintText: 'Location No'),
//                 ),
//               ),
//               const Spacer(
//                 flex: 1,
//               ),
//               ElevatedButton(
//                   onPressed: () async {
//                     final dda = await AcxReturnDataService().retrieve('/sp/ApiMgmtCustRebateLocSearch/queryasync', {"CustEttyId": custEttyId, "PrgEttyId": prgEttyId, "RebateId": rebateId, "LocName": searchLocName.value.text == '' ? null : searchLocName.value.text, "LocNo": searchLocNo.value.text == '' ? null : searchLocNo.value.text, "StateCd": null}, showMsg: false);

//                     dv.value = Returndata(output: dda.output, data: dda.data, columnInfo: dda.columnInfo);
//                     //  return;
//                   },
//                   child: const SelectableText(
//                     'Search',
//                   )),
//               const Spacer(
//                 flex: 1,
//               ),
//               IconButton(
//                   onPressed: () {
//                     singleton<AppRouter>().maybePop(checkedItem.value);
//                   },
//                   icon: const Icon(Icons.close)),
//             ],
//           ),
//           AcxTrinaGridExtData(
//             idField: 'LocNo',
//             spName: 'ApiMgmtCustRebateLocSearch',
//             extData: dv.value,
//             useCheckBox: true,
//             onCheckedAll: (TrinaGridOnRowCheckedEvent v) {
//               if (v.isAll) {
//                 if (v.isChecked!) {
//                   if (dv.value.data != null) {
//                     final theD = dv.value;
//                     checkedItem.value.addAll(getRows(theD.data!, theD.columnInfo!, theD.columnInfo!.length));
//                   }
//                 } else {
//                   checkedItem.value.clear();
//                 }
//               }
//             },
//             onChecked: (TrinaRow? rw) {
//               if (rw!.checked!) {
//                 checkedItem.value.add(rw);
//               } else {
//                 checkedItem.value.remove(rw);
//               }
//             },
//           ),
//           IconButton(
//               onPressed: () {
//                 singleton<AppRouter>().maybePop(checkedItem.value);
//               },
//               icon: const Icon(Icons.save)),
//         ],
//       ),
//     );
//   }
// }

void saveProdList(Map<String, dynamic> src, WidgetRef ref, String feeId,
    String prgEttyId, QueryObject query) async {
  var futures = <Future>[];
  for (var element in src.entries) {
    if (element.value['Mdf']) {
      final curPrdSts = element.value['PrdSts'];
      final queryDel = QueryObject(
          querysql: '/sp/ApiMgmtCustRebatePrdSave/queryasync',
          params: {
            "PrgEttyId": prgEttyId,
            "FeeId": feeId,
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

class CustMgmtProgramFeeDiscRebateFeePlanForm extends ConsumerWidget {
  const CustMgmtProgramFeeDiscRebateFeePlanForm({
    super.key,
    required this.prgEttyId,
    required this.custEttyId,
    required this.planId,
    required this.rebateId,
  });
  final String? prgEttyId;
  final String? custEttyId;
  final String? rebateId;
  final String? planId;

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
                  Flexible(
                    flex: 10,
                    child: ListView(children: [
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
                      FormBuilderField(
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
                          }),
                      const Row(
                        children: [
                          Expanded(
                              child: FbDateTimePicker(
                                  name: 'FromDate', label: 'From Date')),
                          SizedBox(
                            width: 30,
                          ),
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
