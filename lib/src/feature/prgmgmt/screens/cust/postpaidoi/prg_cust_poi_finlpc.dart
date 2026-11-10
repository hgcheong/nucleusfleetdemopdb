import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';

//This one is hardcoded do not change this
const fncChrgTxnPlanRefNo = "8";
const lpcTxnPlanRefNo = "16";

const int wid=778;

@RoutePage()
class PrgCustPOIFinLpc extends ConsumerWidget {
  const PrgCustPOIFinLpc(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Center(
      child: PrgCustPOILpcForm(
        prgEttyId: prgEttyId,
      ),
    );
  }
}

class PrgCustPOILpcForm extends ConsumerWidget {
  const PrgCustPOILpcForm({
    super.key,
    this.prgEttyId,
  });
  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiPrgCustPostpaidOIChrg/queryasync',
        params: {"PrgEttyId": prgEttyId},
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "PrgEttyId": prgEttyId.toString(),
      "ChrgId": null,
      "FncChrgInd": null,
      "FncChrgTxnPlanRefNo": null,
      "FncChrgFreeThsld": null,
      "FncCalcMethod": null,
      "LpcChrgInd": null,
      "LpcTxnPlanRefNo": lpcTxnPlanRefNo,
      "LpcFreeThsld": null
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));

    final queryOptions = QueryObject(
        querysql: '/view/async/VwFncChrgCalc', params: {}, showMsg: false);

    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        final queryOptionValue =
            ref.watch(ReturndatafreezedProvider(queryOptions));
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          formNewValue = convertFormTrueFalseValue(
              formNewValue, ['FncChrgInd', 'LpcChrgInd']);
          final chrgIdVal =
              convStrNewOrNullToNull(formNewValue['ChrgId'].toString());

          return queryOptionValue.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Center(child: Text(error.toString()),),
              data: (afterOptionData) {
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
                          name: 'ChrgId',
                          builder: (FormFieldState f) {
                            return Container();
                          },
                        ),
                        FormBuilderField(
                          name: 'FncChrgTxnPlanRefNo',
                          builder: (FormFieldState f) {
                            return Container();
                          },
                        ),
                        FormBuilderField(
                          name: 'LpcTxnPlanRefNo',
                          builder: (FormFieldState f) {
                            return Container();
                          },
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormBuilderSwitch(
                                  name: 'FncChrgInd',
                                  title: const SelectableText('Finance Charge'),
                                  valueTransformer: (value) {
                                    return value == false ? 'N' : 'Y';
                                  },
                                ),
                               const FbText(
                                  name: 'FncChrgFreeThsld',
                                   label: 'Interest Free Threshold',
  
                                ),
                                const SelectableText(
                                    'Finance Charge will be impose after the interest free period, calculate based on'),
                                FormBuilderRadioGroup<dynamic>(
                                  decoration: const InputDecoration(
                                    labelText: '',
                                  ),
                                  // initialValue: 'LASTDAY',
                                  name: 'FncCalcMethod',
                                  activeColor: DbColors.primary,
                                  options: afterOptionData.data!
                                      .toList()
                                      .map((lang) => FormBuilderFieldOption(
                                            value: lang['RefCd'],
                                            child: SelectableText(lang['Dscp']),
                                          ))
                                      .toList(growable: false),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SelectableText("Finance Charge Plan"),
                                Expanded(
                                  flex: 3,
                                  child: PrgCustPOIFinLpcFinChargePlanList(
                                    chrgId: chrgIdVal,
                                    prgEttyId: prgEttyId,
                                    fncChrgTxnPlanRefNo: fncChrgTxnPlanRefNo,
                                    lpcTxnPlanRefNo: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: FormBuilderSwitch(
                                    name: 'LpcChrgInd',
                                    title: const SelectableText(
                                        'Late Payment Charge'),
                                    valueTransformer: (value) {
                                      return value == false ? 'N' : 'Y';
                                    },
                                  ),
                                ),
                                const Flexible(
                                  flex: 1,
                                  child: FbText(
                                    name: 'LpcFreeThsld',
                                     label: 'LPC Free Threshold',
                            
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SelectableText("LPC Plan"),
                                Flexible(
                                  flex: 4,
                                  child: PrgCustPOIFinLpcFinChargePlanList(
                                    chrgId: chrgIdVal,
                                    prgEttyId: prgEttyId,
                                    fncChrgTxnPlanRefNo: null,
                                    lpcTxnPlanRefNo: lpcTxnPlanRefNo,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SelectableText(
                                    'Transaction Category subjected to Finance Charge'),
                                const SelectableText(
                                    'Apply settings to the following Transaction Category'),
                                const SelectableText(
                                    '(Settings will be apply to all category if no entry in the list)'),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SelectableText('Transaction Category'),
                                Flexible(
                                    flex: 4,
                                    child: PrgCustPOIFinLpcTxnCtgryList(
                                      chrgId: chrgIdVal,
                                      prgEttyId: prgEttyId,
                                    )),
                              ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(children: [
                            AcxSaveButtonManual(onSave: () {
                                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                              formKey.currentState!.save();
                              Map<String, dynamic> toPost =
                                  convertFormValueToSave(
                                      formKey.currentState!.value,
                                      theData.columnInfo);
                              final querySave = QueryObject(
                                  querysql:
                                      '/sp/ApiPrgCustPostpaidOIChrgSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                                  params: toPost,
                                  showMsg: false);
                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((Returndata value) {
                                Toast.showresult(value);
                                if (isSuccess(value.message)) {
                                  ref.invalidate(
                                      ReturndatafreezedProvider(query));
                                }
                              });
                            }),
                            AcxAuditLogReqBtn('ApiPrgCustPostpaidOIChrgSave',ettyId: prgEttyId.toString(),)
                          ]),
                        )
                      ],
                    ));
              });
        } else {
          formNewValue = formNewValue;
          return Container();
        }
      },
    );
  }
}

class PrgCustPOIFinLpcTxnCtgryList extends ConsumerWidget {
  const PrgCustPOIFinLpcTxnCtgryList({
    super.key,
    this.chrgId,
    this.prgEttyId,
  });

  final String? chrgId;
  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustPostpaidOITxnCtgryList/queryasync',
        params: {'PrgEttyId': prgEttyId, 'ChrgId': chrgId},
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          return const SizedBox(
              height: 300,
              child: Expanded(child: SelectableText('No Record ')));
        }
        if (chrgId == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectableText('No Fee Plan'),
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
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          child: PrgCustPOIFinLpcTxnCtgryForm(
                        prgEttyId: prgEttyId.toString(),
                        chrgId: chrgId.toString(),
                      ));
                    },
                  );
                  ref.invalidate(ReturndatafreezedProvider(QueryObject(
                      querysql:
                          '/sp/ApiPrgCustPostpaidOITxnCtgryList/queryasync',
                      params: {'PrgEttyId': prgEttyId, 'ChrgId': chrgId},
                      showMsg: false)));
                },
                child: const Icon(Icons.post_add)),
          ),
          // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
          returnData.data![0]["CtgryId"] == null
              ? const SelectableText('No Record')
              : Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: returnData.rowcount!,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      final currentData = returnData.data![index];
                      return ListTile(
                        title: SelectableText('${currentData['TxnCtgryDscp']}'),
                        //  leading: SelectableText('${currentData['SchdDscp']}'),
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
                                      '/sp/ApiPrgCustPostpaidOITxnCtgryDel/queryasync',
                                  params: {
                                    "PrgEttyId": currentData['PrgEttyId'],
                                    "ChrgId": currentData['ChrgId'],
                                    "CtgryId": currentData['CtgryId'],
                                    "TxnCtgry": currentData['TxnCtgry'],
                                  },
                                  showMsg: false);
                              final resultDel = ref.read(
                                  ReturndatafreezedProvider(queryDel).future);
                              resultDel.then((value) {
                                ref.invalidate(ReturndatafreezedProvider(
                                    QueryObject(
                                        querysql:
                                            '/sp/ApiPrgCustPostpaidOITxnCtgryList/queryasync',
                                        params: {
                                          'PrgEttyId': prgEttyId,
                                          'ChrgId': chrgId
                                        },
                                        showMsg: false)));
                                Toast.showresult(value);
                              });
                            },
                            icon: const Icon(Icons.delete)),
                      ); // return const SelectableText('Test 123');
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

class PrgCustPOIFinLpcTxnCtgryForm extends ConsumerWidget {
  const PrgCustPOIFinLpcTxnCtgryForm(
      {super.key,
      required this.prgEttyId,
      this.chrgId,
      this.ctgryId,
      this.txnCtgry});
  final String? prgEttyId;
  final String? chrgId;
  final String? ctgryId;
  final String? txnCtgry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    final formValue = {
      'PrgEttyId': prgEttyId,
      'ChrgId': chrgId,
      'CtgryId': ctgryId,
      'TxnCtgry': txnCtgry
    };
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
              child: Column(children: [
                FormBuilderField(
                    builder: (field) {
                      return Container();
                    },
                    name: 'PrgEttyId'),
                FormBuilderField(
                    builder: (field) {
                      return Container();
                    },
                    name: 'ChrgId'),
                Flexible(
                    flex: 2,
                    child: FormBuilderField(
                        name: 'TxnCtgry',
                        builder: (field) {
                          return AcxSearchBoxMap(
                              returnSelectedRef: (dynamic val) {
                                field.didChange(val['TxnCtgry']);
                              },
                              selectedRef: {'TxnCtgry': field},
                              inputText: 'Transaction Category',
                              inputIcon: const Icon(Icons.search),
                              querysql: '/view/async/VwLibTxnCtgry',
                              searchText: 'Dscp',
                              keyField: 'TxnCtgry',
                              params: const {});
                        })),
              ]),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        formKeyPlan.currentState!.save();
                        final querySave = QueryObject(
                            querysql:
                                '/sp/ApiPrgCustPostpaidOITxnCtgrySave/queryasync',
                            params: formKeyPlan.currentState!.value,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
                          if (context.mounted) {
                            Toast.showresult(value);
                            context.maybePop();
                          }
                        });
                      },
                      child: const Icon(Icons.save),
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
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class PrgCustPOIFinLpcFinChargePlanList extends ConsumerWidget {
  const PrgCustPOIFinLpcFinChargePlanList({
    super.key,
    this.chrgId,
    this.prgEttyId,
    this.fncChrgTxnPlanRefNo,
    this.lpcTxnPlanRefNo,
  });

  final String? chrgId;
  final String? prgEttyId;
  final String? fncChrgTxnPlanRefNo;
  final String? lpcTxnPlanRefNo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustPostpaidOITxnPlanList/queryasync',
        params: {
          'PrgEttyId': prgEttyId,
          'ChrgId': chrgId,
          "FncChrgTxnPlanRefNo": fncChrgTxnPlanRefNo,
          "LpcTxnPlanRefNo": lpcTxnPlanRefNo,
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
        if (chrgId == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      PrgCustPOIFinLpcFinChargePlanForm(
                        prgEttyId: prgEttyId.toString(),
                        chrgId: convStrNewOrNullToNull(chrgId.toString()),
                        txnPlanRefNo: fncChrgTxnPlanRefNo ?? lpcTxnPlanRefNo,
                        planId: null,
                      ));

                  ref.invalidate(ReturndatafreezedProvider(query));
                },
                child: const Icon(Icons.post_add)),
          ),
          // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
          returnData.data![0]['PlanId'] == null
              ? const SelectableText('No Plan')
              : Expanded(
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
                            '${currentData['TxnPlanDscp']} (${fmtDateStrShort(currentData['FromDate'].toString())} to ${fmtDateStrShort(currentData['ToDate'].toString())})'),
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
                                      '/sp/ApiPrgCustPostpaidOITxnPlanDel/queryasync',
                                  params: {
                                    "PrgEttyId": currentData['PrgEttyId'],
                                    "ChrgId": chrgId,
                                    "PlanId": currentData['PlanId'],
                                    "TxnPlanRefNo":
                                        fncChrgTxnPlanRefNo ?? lpcTxnPlanRefNo,
                                  },
                                  showMsg: false);
                              final resultDel = ref.read(
                                  ReturndatafreezedProvider(queryDel).future);
                              resultDel.then((value) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                                Toast.showresult(value);
                              });
                            },
                            icon: const Icon(Icons.delete)),
                      ); // return const SelectableText('Test 123');
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

class PrgCustPOIFinLpcFinChargePlanForm extends ConsumerWidget {
  const PrgCustPOIFinLpcFinChargePlanForm({
    super.key,
    required this.prgEttyId,
    required this.planId,
    this.chrgId,
    this.txnPlanRefNo,
  });
  final String? prgEttyId;
  final String? chrgId;
  final String? planId;
  final String? txnPlanRefNo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    final formValue = {
      "PrgEttyId": prgEttyId,
      "ChrgId": chrgId,
      "PlanId": planId,
      "TxnPlan": null,
      "TxnPlanRefNo": txnPlanRefNo,
      "FromDate": null,
      "ToDate": null,
    };
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
              child: Column(children: [
                FormBuilderField(
                    builder: (field) {
                      return Container();
                    },
                    name: 'PrgEttyId'),
                FormBuilderField(
                    builder: (field) {
                      return Container();
                    },
                    name: 'ChrgId'),
                FormBuilderField(
                    builder: (field) {
                      return Container();
                    },
                    name: 'PlanId'),
                FormBuilderField(
                    builder: (field) {
                      return Container();
                    },
                    name: 'TxnPlanRefNo'),
                Flexible(
                    flex: 2,
                    child: FormBuilderField(
                        name: 'TxnPlan',
                        builder: (field) {
                          return AcxSearchBoxMap(
                              returnSelectedRef: (dynamic val) {
                                field.didChange(val['TxnPlan']);
                              },
                              // selectedRef:  {'TxnPlan': txn},
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
                            return DateFormat('yMMMEd').format(v!);
                          },
                          name: 'FromDate',
                          format: DateFormat.yMMMEd(),
                          initialEntryMode: DatePickerEntryMode.calendar,
                          inputType: InputType.date,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                            return DateFormat('yMMMEd').format(v!);
                          },
                          name: 'ToDate',
                          format: DateFormat.yMMMEd(),
                          initialEntryMode: DatePickerEntryMode.calendar,
                          inputType: InputType.date,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                    ElevatedButton(
                      onPressed: () async {
                        formKeyPlan.currentState!.save();
                        final planId =
                            formKeyPlan.currentState!.value['PlanId'];
                        formKeyPlan.currentState!.patchValue(
                            {'PlanId': planId == '' ? null : planId});
                        // Toast.success(_formKeyPlan.currentState!.value.toString());},
                        // const SnackBar(content: SelectableText('tes'));
                        Map<String, dynamic> toPost = convertFormDateValue(
                            formKeyPlan.currentState!.value,
                            ['FromDate', 'ToDate']);

                        final querySave = QueryObject(
                            querysql:
                                '/sp/ApiPrgCustPostpaidOITxnPlanSave/queryasync',
                            params: toPost,
                            showMsg: false);

                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
                          Toast.showresult(value);

                          ref.invalidate(ReturndatafreezedProvider(QueryObject(
                              querysql:
                                  '/sp/ApiPrgCustPostpaidOITxnPlanList/queryasync',
                              params: {
                                'PrgEttyId': prgEttyId,
                                'ChrgId': chrgId,
                                "FncChrgTxnPlanRefNo": 16,
                                "LpcTxnPlanRefNo": null,
                              },
                              showMsg: false)));
                          if (context.mounted) {
                            context.maybePop();
                          }
                        });
                      },
                      child: const Icon(Icons.save),
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
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
