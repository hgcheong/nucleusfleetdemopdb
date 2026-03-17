import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=229;

@RoutePage()
class SubsidymgmtPlan extends StatelessWidget {
  const SubsidymgmtPlan({
    super.key,
    @PathParam.inherit('subsId') this.subsId,
    @PathParam('subsLocateId') this.subsLocateId,
  });
  final String? subsId;
  final String? subsLocateId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SusidyMgmtPlan(
      subsId: subsId,
      subsLocateId: convStrNewOrNullToNull(subsLocateId),
    );
  }
}

class SusidyMgmtPlan extends ConsumerWidget {
  final String? subsId;
  final String? subsLocateId;
  const SusidyMgmtPlan({
    super.key,
    this.subsId,
    this.subsLocateId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final subsidyPlanKey = GlobalKey<FormBuilderState>();
    final query = QueryObject(
        querysql: '/sp/ApiPrgSubsLocate/queryasync',
        params: {"SubsId": subsId, "SubsLocateId": subsLocateId},
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "Dscp": null,
      "TxnSchemaRefNoOpr": null,
      "TxnSchemaRefNoLoc": null,
      "TxnSchemaRefNoMbr": null,
      "SubsId": subsId,
      "SubsLocateId": convStrNewOrNullToNull(subsLocateId),
      "PlanRateId": null
    };
    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }

          final queryVhcList = QueryObject(
              querysql: '/sp/ApiPrgSubsVhcTypeList/queryasync',
              params: {
                "SubsId": subsId,
                "SubsLocateId": convStrNewOrNullToNull(subsLocateId),
                "PlanRateId": formNewValue['PlanRateId'],
              },
              showMsg: false);
          Map<String, dynamic> formSwitchValue = {};
          final queryTxnSchemaRefNoOpr = QueryObject(
              querysql: '/sp/ApiPrgSubsPlanList/queryasync',
              params: {
                "SubsId": subsId,
                "SubsLocateId": convStrNewOrNullToNull(subsLocateId),
                "PlanRateId": formNewValue['PlanRateId'],
                "TxnPlanRefNo": formNewValue['TxnSchemaRefNoOpr']
              },
              showMsg: false);
          final queryTxnSchemaRefNoLoc = QueryObject(
              querysql: '/sp/ApiPrgSubsPlanList/queryasync',
              params: {
                "SubsId": subsId,
                "SubsLocateId": convStrNewOrNullToNull(subsLocateId),
                "PlanRateId": formNewValue['PlanRateId'],
                "TxnPlanRefNo": formNewValue['TxnSchemaRefNoLoc']
              },
              showMsg: false);
          final queryTxnSchemaRefNoMbr = QueryObject(
              querysql: '/sp/ApiPrgSubsPlanList/queryasync',
              params: {
                "SubsId": subsId,
                "SubsLocateId": convStrNewOrNullToNull(subsLocateId),
                "PlanRateId": formNewValue['PlanRateId'],
                "TxnPlanRefNo": formNewValue['TxnSchemaRefNoMbr']
              },
              showMsg: false);

          return FormBuilder(
            key: subsidyPlanKey,
            initialValue: formNewValue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const FbHiddenText(name: 'SubsId'),
                      const FbHiddenText(name: 'SubsLocateId'),
                      const FbHiddenText(name: 'PlanRateId'),
                      const SelectableText(
                          'Define the Subsidy Plan of this Program'),
                      const FbText(name: 'Dscp', label: 'Description'),
                      SizedBox(
                          height: 400,
                          child: SubsidyProgramVechList(
                            query: queryVhcList,
                            switchValue: formSwitchValue,
                          )),
                      const Row(
                        children: [
                          SelectableText(
                              'Apply settings to the following location.')
                        ],
                      ),
                      const SelectableText(
                          '(Settings will apply to all Location if no entry in the list)'),
                      SizedBox(
                        height: 1280,
                        child: convStrNewOrNullToNull(subsLocateId) == null
                            ? const SelectableText('No Record')
                            : SusbsidyPlanPrgLocList(
                                subsId: subsId,
                                subsLocateId: subsLocateId,
                                onChecked: () {},
                                toggleCheckAll: () {},
                              ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: ListView(
                    children: [
                      Card(
                        child: convStrNewOrNullToNull(subsLocateId) == null
                            ? const SelectableText('No Record')
                            : SubsRateList(
                                title: "Oil Co Schema",
                                subsId: subsId,
                                subsLocateId: subsLocateId,
                                planRateId: formNewValue['PlanRateId'],
                                txnPlanRefNo: formNewValue['TxnSchemaRefNoOpr'],
                                query: queryTxnSchemaRefNoOpr,
                              ),
                      ),
                      Card(
                        child: convStrNewOrNullToNull(subsLocateId) == null
                            ? const SelectableText('No Record')
                            : SubsRateList(
                                title: "Location Schema",
                                subsId: subsId,
                                subsLocateId: subsLocateId,
                                planRateId: formNewValue['PlanRateId'],
                                txnPlanRefNo: formNewValue['TxnSchemaRefNoLoc'],
                                query: queryTxnSchemaRefNoLoc,
                              ),
                      ),
                      Card(
                        child: convStrNewOrNullToNull(subsLocateId) == null
                            ? const SelectableText('No Record')
                            : SubsRateList(
                                title: "Member Schema",
                                subsId: subsId,
                                subsLocateId: subsLocateId,
                                planRateId: formNewValue['PlanRateId'],
                                txnPlanRefNo: formNewValue['TxnSchemaRefNoMbr'],
                                query: queryTxnSchemaRefNoMbr,
                              ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        ElevatedButton(
                          child: const Icon(Icons.save),
                          onPressed: () {
                            subsidyPlanKey.currentState!.save();

                            Map<String, dynamic> toPost =
                                convertFormValueToSave(
                                    subsidyPlanKey.currentState!.value,
                                    theData.columnInfo);
                            final querySave = QueryObject(
                                querysql: '/sp/ApiPrgSubsLocateSave/queryasync',
                                params: toPost,
                                showMsg: false);
                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((value) {
                              Toast.showresult(value);
                              if (isSuccess(value.message)) {
                                String theNewId = getOutputValue(
                                        value.output, '@SubsLocateId')
                                    .toString();
                                String planRateId =
                                    getOutputValue(value.output, '@PlanRateId')
                                        .toString();
                                saveVechList(
                                    formSwitchValue,
                                    ref,
                                    subsId.toString(),
                                    subsLocateId.toString(),
                                    planRateId,
                                    queryVhcList);
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                                singleton<AppRouter>().navigatePath(
                                    '/subsidy/plan/$subsId/$theNewId/detail');
                              }
                            });
                          },
                        ),
                        sbh10,
                        AcxBackToList(listUrl: '/subsidy/planlist/$subsId')
                      ],
                    )),
              ],
            ),
          );
        });
  }
}

class SubsRateList extends ConsumerWidget {
  const SubsRateList({
    super.key,
    required this.query,
    required this.title,
    this.subsId,
    this.subsLocateId,
    this.planRateId,
    this.txnPlanRefNo,
  });

  final QueryObject query;
  final String? subsId;
  final String? subsLocateId;
  final String? planRateId;
  final String? txnPlanRefNo;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (srcData) {
          if (srcData.data == null) {
            return const SizedBox(
                height: 300, child: SelectableText('No Record '));
          }

          if (srcData.data![0]['SchemaId'] == null) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(title),
                  sbh10,
                  ElevatedButton(
                      onPressed: () async {
                        await showAcxSimpleDialog(
                            context,
                            SubsidyRateForm(
                              subsId: srcData.data![0]['SubsId'].toString(),
                              subsLocateId:
                                  srcData.data![0]['SubsLocateId'].toString(),
                              planRateId:
                                  srcData.data![0]['PlanRateId'].toString(),
                              txnPlanRefNo:
                                  srcData.data![0]['TxnPlanRefNo'].toString(),
                              isNew: true,
                            ));

                        ref.invalidate(ReturndatafreezedProvider(query));
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
                SelectableText(
                  title,
                  //    style: boldStyle,
                ),
                sbh10,
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () async {
                        await showAcxSimpleDialog(
                            context,
                            SubsidyRateForm(
                              subsId: srcData.data![0]['SubsId'].toString(),
                              subsLocateId:
                                  srcData.data![0]['SubsLocateId'].toString(),
                              planRateId:
                                  srcData.data![0]['PlanRateId'].toString(),
                              txnPlanRefNo:
                                  srcData.data![0]['TxnPlanRefNo'].toString(),
                              isNew: true,
                            ));
                        ref.invalidate(ReturndatafreezedProvider(query));
                      },
                      child: const Icon(Icons.post_add)),
                ),
                sbh10,
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: srcData.rowcount!,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    final currentData = srcData.data![index];

                    return ListTile(
                      // onTap: () async {
                      //   showCommonDialog(
                      //       context,
                      //       SubsidyRateForm(
                      //         subsId: subsId.toString(),
                      //         subsLocateId: subsLocateId.toString(),
                      //         planRateId: currentData['PlanRateId'].toString(),
                      //         txnPlanRefNo: currentData['TxnPlanRefNo'].toString(),
                      //       ));
                      // },
                      title: SelectableText(
                          '${currentData['TxnSchemaDscp']} (${fmtDateStr(currentData['FromDate'].toString())} to ${fmtDateStr(currentData['ToDate'].toString())})'),
                    );
                  },
                ),
              ]);
        });
  }
}

class SubsidyRateForm extends ConsumerWidget {
  const SubsidyRateForm(
      {super.key,
      this.subsId,
      this.subsLocateId,
      this.planRateId,
      this.txnPlanRefNo,
      this.isNew = false});

  final String? subsId;
  final String? subsLocateId;
  final String? planRateId;
  final String? txnPlanRefNo;
  final bool isNew;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "TxnSchema": null,
      "FromDate": null,
      "ToDate": null,
      "SubsId": subsId,
      "SubsLocateId": subsLocateId,
      "PlanRateId": planRateId,
      "SchemaId": null,
      "TxnPlanRefNo": txnPlanRefNo
    };

    final queryPlanListForm = QueryObject(
        querysql: '/sp/ApiPrgSubsPlan/queryasync',
        params: {
          "SubsId": subsId,
          "SubsLocateId": subsLocateId,
          "PlanRateId": planRateId,
          "TxnPlanRefNo": txnPlanRefNo,
        },
        showMsg: false);

    final formDataPlanListForm =
        ref.watch(ReturndatafreezedProvider(queryPlanListForm));

    return AsyncValueWidget<Returndata>(
      value: formDataPlanListForm,
      data: (theData) {
        if (theData.data != null) {
          if (!isNew) {
            formValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
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
                const FbHiddenText(name: 'SubsId'),
                const FbHiddenText(name: 'SubsLocateId'),
                const FbHiddenText(name: 'PlanRateId'),
                const FbHiddenText(name: 'TxnPlanRefNo'),
                Flexible(
                  flex: 10,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Flexible(
                        flex: 2,
                        child: FormBuilderField(
                            name: 'TxnSchema',
                            builder: (field) {
                              return AcxSearchBoxMap(
                                  returnSelectedRef: (dynamic val) {
                                    field.didChange(val['TxnSchema']);
                                  },
                                  selectedRef: {
                                    'TxnSchema':
                                        formValue['TxnSchema'].toString()
                                  },
                                  inputText: 'Transaction Schema',
                                  inputIcon: const Icon(Icons.search),
                                  querysql: '/view/async/VwTxnSchema',
                                  searchText: 'TxnSchemaDscp',
                                  keyField: 'TxnSchema',
                                  params: const {});
                            })),
                    const Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                              child: FbDateTimePicker(
                            name: 'FromDate',
                            label: 'From Date',
                          )),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              child: FbDateTimePicker(
                            name: 'ToDate',
                            label: 'To Date',
                          ))
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
                            final schemaId =
                                formKeyPlan.currentState!.value['SchemaId'];
                            formKeyPlan.currentState!.patchValue(
                                {'SchemaId': schemaId == '' ? null : schemaId});
                            Map<String, dynamic> toPost =
                                convertFormValueToSave(
                                    formKeyPlan.currentState!.value,
                                    theData.columnInfo);
                            final querySave = QueryObject(
                                querysql: '/sp/ApiPrgSubsPlanSave/queryasync',
                                params: toPost,
                                showMsg: false);

                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((value) {
                              if (context.mounted) {
                                Toast.newMessage(context, value);
                              }

                              //    Toast.showresult(value);

                              //   context.maybePop();
                            }).onError((error, stackTrace) {
                              if (context.mounted) {
                                Toast.newMessageDialog(
                                    context, error.toString());
                              }

                              // Toast.error(error.toString());
                            });
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        
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
                        ) ,   sbh10,
                    AcxAuditLogReqBtn('ApiPrgSubsPlanSave',)
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

class SusbsidyPlanPrgLocList extends HookConsumerWidget {
  const SusbsidyPlanPrgLocList({
    super.key,
    this.subsId,
    this.subsLocateId,
    this.planRateId,
    required this.onChecked,
    required this.toggleCheckAll,
  });

  final String? subsId;
  final String? subsLocateId;
  final String? planRateId;

  final Function onChecked;
  final Function toggleCheckAll;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiPrgSubsLocList/queryasync',
        params: {
          "SubsId": subsId,
          "SubsLocateId": subsLocateId,
        },
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));
    //   final isAllChecked = useState<bool>(false);
    final listOfItems = useState<List<Map<String, dynamic>>>([
      {'id': 0, 'checked': false, 'value': 'abc'},
      {'id': 1, 'checked': true, 'value': 'cde'},
      {'id': 2, 'checked': false, 'value': 'fgh'}
    ]);

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          List<Widget> toAdd = [];
          toAdd.add(ElevatedButton(
              onPressed: () {
                for (var i = 0; i < listOfItems.value.length; i++) {
                  if (listOfItems.value.elementAt(i)['checked']) {
                    Toast.message(listOfItems.value.elementAt(i).toString());
                  }
                }
              },
              child: const Icon(Icons.delete)));
          toAdd.addAll(listOfItems.value
              .map((item) => ListTile(
                  leading: Checkbox(
                    value: listOfItems.value
                        .where((element) => element['id'] == item['id'])
                        .first['checked'],
                    onChanged: (va) {
                      var copiedval =
                          List<Map<String, dynamic>>.from(listOfItems.value);
                      final vv = copiedval
                          .where((element) => element['id'] == item['id'])
                          .first;
                      vv['checked'] = va;

                      listOfItems.value = copiedval;
                    },
                  ),
                  title: SelectableText(item['value'].toString())))
              .toList());
          //   toAdd.add(SelectableText('heelo'));
          return Column(
            children: toAdd,
          );
        }
        if (returnData.data![0]['LocEttyId'] == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
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
                            child: SizedBox(
                              height: 500,
                              width: 500,
                              child: PopUpSubsidyLocCtrlSearchForm(
                                subsLocateId: subsLocateId.toString(),
                                subsId: subsId,
                              ),
                            ));
                      },
                    );
                    for (TrinaRow element in selectedItems) {
                      final locno = element.cells['LocNo']!.value.toString();
                      final queryDel = QueryObject(
                          querysql: '/sp/ApiPrgSubsLocSave/queryasync',
                          params: {
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
                children: const [
                  SelectableText('No Record'),
                ],
              ))
            ],
          );
        }

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ElevatedButton(
              onPressed: () async {
                Set<TrinaRow> selectedItems = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const SizedBox(
                        height: 400,
                        width: 400,
                        child: Dialog(
                            backgroundColor: bgColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: PopUpSubsidyLocCtrlSearchForm(
                                subsLocateId: null, subsId: null)));
                  },
                );

                if (selectedItems.isEmpty) return;

                for (TrinaRow element in selectedItems) {
                  Debugger.log(element);
                  final locno = element.cells['LocNo']!.value.toString();
                  final queryDel = QueryObject(
                      querysql: '/sp/ApiPrgSubsLocSave/queryasync',
                      params: {
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
          const ListTile(
            title: SelectableText('Location ID'),
          ),
          SingleChildScrollView(
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
                            querysql: '/sp/ApiPrgSubsLocDel/queryasync',
                            params: {},
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

class PopUpSubsidyLocCtrlSearchForm extends HookWidget {
  const PopUpSubsidyLocCtrlSearchForm(
      {super.key, this.subsLocateId, this.subsId});

  final String? subsLocateId;
  final String? subsId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    final dv = useState<Returndata>(Returndata());
    final searchLocName = useTextEditingController(text: '');
    final searchLocNo = useTextEditingController(text: '');
    final checkedItem = useState<Set<TrinaRow>>(<TrinaRow>{});

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: searchLocNo,
                  decoration: const InputDecoration(hintText: 'Location No'),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: searchLocName,
                  decoration: const InputDecoration(hintText: 'Location Name'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // sbw54,
              // TextFormField(
              //   controller: searchLocNo,
              //   decoration: const InputDecoration(hintText: 'Location No'),
              // ),
              // sbw20,
              // TextFormField(
              //   controller: searchLocName,
              //   decoration: const InputDecoration(hintText: 'Location Name'),
              // ),
              ElevatedButton(
                  onPressed: () async {
                    final dda = await AcxReturnDataService().retrieve(
                        '/sp/ApiPrgSubsLocSearch/queryasync',
                        {
                          "SubsId": subsId,
                          "SubsLocateId": subsLocateId,
                          "LocName": searchLocName.value.text == ''
                              ? null
                              : searchLocName.value.text,
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
              IconButton(
                  onPressed: () {
                    singleton<AppRouter>().maybePop(checkedItem.value);
                  },
                  icon: const Icon(Icons.save)),
              IconButton(
                  onPressed: () {
                    singleton<AppRouter>().maybePop(checkedItem.value);
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
          AcxTrinaGridExtData(
            idField: 'LocEttyId',
            spName: 'ApiPrgSubsLocSearch',
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
        ],
      ),
    );
  }
}

class SubsidyProgramVechList extends ConsumerWidget {
  const SubsidyProgramVechList({
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
    final formKeySwitch = GlobalKey<FormBuilderState>();

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
        data: (rValue) {

          if(rValue.data == null){
            return const Center(child:Text('No data in Subsidy Program Vech List'));
          }

          var data = rValue.data;

          Set<String> theValue = <String>{};
          data!.asMap().entries.forEach((ele) {
            theValue.add(ele.value['VhcTypeDscp'].toString());
          });

          var identifier = {};
          for (var item in theValue) {
            List<dynamic> toAdd = [];
            data.asMap().entries.forEach((ele) {
              if (ele.value['VhcTypeDscp'].toString() == item) {
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
              //    switchValue![item['VhcType']] = item['VhcTypeSts'];
              switchValue![item['VhcType']] = {
                "VhcTypeSts": item['VhcTypeSts'],
                "Mdf": false
              };
            }

            for (var item in toVV) {
              rowItems.add(Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: FormBuilderSwitch(
                      initialValue: item['VhcTypeSts'] == 'N' ? false : true,
                      name: item['VhcType'],
                      title: Text(
                        item['VhcTypeDscp'],
                        overflow: TextOverflow.ellipsis,
                      ),
                      onChanged: (value) {
                        //  switchValue![item['VhcType']] = value == false ? 'N' : 'Y';
                        switchValue![item['VhcType']] = value == false
                            ? {"VhcTypeSts": 'N', "Mdf": true}
                            : {"VhcTypeSts": 'Y', "Mdf": true};
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
              children: [...rowItems],
            ));
          }

          GridView toReturn = GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 5,
            shrinkWrap: true,
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

void saveVechList(Map<String, dynamic> src, WidgetRef ref, String subsId,
    String subsLocateId, String planRateId, QueryObject query) async {
  var futures = <Future>[];
  for (var element in src.entries) {
    if (element.value['Mdf']) {
      final curVhcSts = element.value['VhcTypeSts'];
      final queryDel = QueryObject(
          querysql: '/sp/ApiPrgSubsVhcTypeSave/queryasync',
          params: {
            "SubsId": subsId,
            "SubsLocateId": subsLocateId,
            "PlanRateId": planRateId,
            "VhcTypeSts": curVhcSts,
            "VhcType": element.key
          },
          showMsg: false);
      final resultDel = ref.read(ReturndatafreezedProvider(queryDel).future);
      futures.add(resultDel);
    }
  }
  // "SubsLocateId": 10,
  // "PlanRateId": 15,
  await Future.wait(futures).then((value) {
    ref.invalidate(ReturndatafreezedProvider(query));
  });
}
