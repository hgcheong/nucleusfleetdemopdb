import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/utils/strings.dart';

const int wid=759;

@RoutePage()
class PrgCustFeeTrans extends ConsumerWidget {
  const PrgCustFeeTrans(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam('feeId') this.feeId});

  final String? prgEttyId;
  final String? feeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Center(
      child: PrgCustFeeTransForm(
        prgEttyId: prgEttyId,
        feeId: convStrNewOrNullToNull(feeId),
      ),
    );
  }
}

class PrgCustFeeTransForm extends ConsumerWidget {
  const PrgCustFeeTransForm({super.key, this.prgEttyId, this.feeId});
  final String? prgEttyId;
  final String? feeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiPrgCustTxnFee/queryasync',
        params: {"PrgEttyId": prgEttyId, "FeeId": feeId},
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "MediaType": null,
      "TxnCtgry": "",
      "Dscp": "",
      "SchdId": "",
      "AggateCd": "",
      "BillingValue": "",
      "Sts": "A",
      "PrgEttyId": prgEttyId,
      "FeeId": feeId
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            if (feeId != null) {
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
                    name: 'Sts',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  FormBuilderField(
                    name: 'FeeId',
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
                          const SelectableText(
                              'Transaction Fees at Program Level'),
                          const FbText(
                            name: 'Dscp',
                            label: 'Description',
                          ),
                          Flexible(
                              flex: 2,
                              child: FormBuilderField(
                                  name: 'MediaType',
                                  builder: (field) {
                                    return AcxSearchBoxMap(
                                        returnSelectedRef: (dynamic val) {
                                          field.didChange(val['RefCd']);
                                        },
                                        selectedRef: {
                                          'RefCd': formNewValue['MediaType']
                                        },
                                        inputText:
                                            'Apply to the following Media Type',
                                        inputIcon: const Icon(Icons.search),
                                        querysql:
                                            '/sp/ApiPrgCustMediaTypeList/queryasync',
                                        searchText: 'MediaTypeDscp',
                                        keyField: 'RefCd',
                                        params: {
                                          "PrgEttyId": prgEttyId,
                                        });
                                  })),
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
                                          'Id': formNewValue['SchdId']
                                        },
                                        inputText: 'Billing Frequency',
                                        inputIcon: const Icon(Icons.search),
                                        querysql: '/view/async/VwSchdBilling',
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
                                        },
                                        inputText: 'Billing Value',
                                        inputIcon: const Icon(Icons.search),
                                        querysql: '/view/async/VwBillingValue',
                                        searchText: 'Dscp',
                                        keyField: 'RefCd',
                                        params: const {});
                                  })),
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
                          const SelectableText("Finance Plan"),
                          feeId == null || feeId!.isEmpty
                              ? const SelectableText('No Fee Id found')
                              : Flexible(
                                  flex: 4,
                                  child: PrgCustTxnFeePlanList(
                                    feeId: feeId,
                                    prgEttyId: prgEttyId,
                                  ),
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
                          formKey.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              formKey.currentState!.value, theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiPrgCustTxnFeeSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              if (context.mounted) {
                                singleton<AppRouter>()
                                    .navigatePath(getAfterSavePath(
                                        context, value.output, '@FeeId'))
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
                              '/prgmgmt/custsetup/$prgEttyId/pcfeelanding/pcfeemtranslist'),
                      AcxAuditLogReqBtn('ApiPrgCustTxnFeeSave',ettyId: prgEttyId.toString(),)
                    ]),
                  )
                ],
              ));
        });
  }
}

class PrgCustTxnFeePlanList extends ConsumerWidget {
  const PrgCustTxnFeePlanList({
    super.key,
    this.feeId,
    this.prgEttyId,
  });

  final String? feeId;
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustTxnFeePlanList/queryasync',
        params: {"PrgEttyId": prgEttyId, "FeeId": feeId},
        showMsg: false);

    // var initalValue = {"FromDate": "", "ToDate": "", "TxnPlan": "", "PrgEttyId": prgEttyId, "FeeId": feeId, "PlanId": null};

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          return const SizedBox(
              height: 300,
              child: Expanded(child: SelectableText('No Record ')));
        }
        if (returnData.data![0]['PlanId'] == null) {
          return Column(
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
                            child: PrgCustTxnFeePlanForm(
                                prgEttyId: prgEttyId.toString(),
                                feeId: feeId.toString(),
                                planId: null));
                      },
                    );
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
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          child: PrgCustTxnFeePlanForm(
                              prgEttyId: prgEttyId.toString(),
                              feeId: feeId.toString(),
                              planId: null));
                    },
                  );
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
                      '${currentData['TxnPlanDscp']} (${fmtDateStr(currentData['FromDate'].toString())} to ${fmtDateStr(currentData['ToDate'].toString())})'),
                  onTap: () async {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                            child: PrgCustTxnFeePlanForm(
                          prgEttyId: prgEttyId.toString(),
                          feeId: currentData['FeeId'].toString(),
                          planId: currentData['PlanId'].toString(),
                        ));
                      },
                    );
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
                            querysql: '/sp/ApiPrgCustTxnFeePlanDel/queryasync',
                            params: {
                              "PrgEttyId": prgEttyId,
                              "FeeId": feeId,
                              "PlanId": currentData['PlanId']
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

class PrgCustTxnFeePlanForm extends ConsumerWidget {
  const PrgCustTxnFeePlanForm({
    super.key,
    required this.prgEttyId,
    required this.planId,
    required this.feeId,
  });
  final String? prgEttyId;
  final String? feeId;
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
      "PrgEttyId": prgEttyId,
      "FeeId": feeId,
      "PlanId": planId,
    };
    final queryFeeForm = QueryObject(
        querysql: '/sp/ApiPrgCustTxnFeePlan/queryasync',
        params: {"PrgEttyId": prgEttyId, "FeeId": feeId, "PlanId": planId},
        showMsg: false);

    final formDataFeeForm = ref.watch(ReturndatafreezedProvider(queryFeeForm));

    return AsyncValueWidget<Returndata>(
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
                    child: Column(children: [
                      FormBuilderField(
                          builder: (field) {
                            return Container();
                          },
                          name: 'PrgEttyId'),
                      const FbHiddenDateTime(
                        name: 'MdfDate',
                      ),
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
                                  return DateFormat('yMMMEd').format(v!);
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
                                initialTime:
                                    const TimeOfDay(hour: 8, minute: 0),
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
                                initialTime:
                                    const TimeOfDay(hour: 8, minute: 0),
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
                              Map<String, dynamic> toPost =
                                  convertFormValueToSave(
                                      Map.from(formKeyPlan.currentState!.value),
                                      theData.columnInfo);
                              final querySave = QueryObject(
                                  querysql:
                                      '/sp/ApiPrgCustTxnFeePlanSave/queryasync',
                                  params: toPost,
                                  showMsg: false);

                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((value) {
                                singleton<AppRouter>().maybePop();
                                Toast.showresult(value);
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
        });
  }
}
