import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

import 'package:nucleusv2/src/core/app_router.dart';

const int wid=830;

@RoutePage()
class CustEnrollProgramFeeTrans extends ConsumerWidget {
  const CustEnrollProgramFeeTrans({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('prgEttyId') this.prgEttyId,
    @PathParam('feeId') this.feeId,
    @PathParam.inherit('billingEttyType') this.billingEttyType,
  });

  final String? custEttyId;
  final String? prgEttyId;
  final String? feeId;
  final String? billingEttyType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Center(
      child: CustEnrollProgramFeeTransForm(
        prgEttyId: prgEttyId,
        custEttyId: custEttyId,
        feeId: convStrNewOrNullToNull(feeId),
        billingEttyType: billingEttyType,
      ),
    );
  }
}

class CustEnrollProgramFeeTransForm extends ConsumerWidget {
  const CustEnrollProgramFeeTransForm(
      {super.key,
      this.prgEttyId,
      this.custEttyId,
      this.feeId,
      this.billingEttyType});
  final String? prgEttyId;
  final String? custEttyId;
  final String? feeId;
  final String? billingEttyType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();
  //  final openDropDownProgKey = GlobalKey<DropdownSearchState<dynamic>>();
    final query = QueryObject(
        querysql: '/sp/ApiEnrlCustTxnFee/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "FeeId": feeId
        },
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
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
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
                  FormBuilderField(
                    name: 'MdfDate',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  FormBuilderField(
                    name: 'PrgEttyId',
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
                  FormBuilderField(
                    name: 'CustEttyId',
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
                                          field.didChange(val['MediaType']);
                                        },
                                        // openDropDownProgKey:
                                        //     openDropDownProgKey,
                                        selectedRef: {
                                          'MediaType': formNewValue['MediaType']
                                              .toString()
                                        },
                                        inputText:
                                            'Apply to the following Media Type',
                                        inputIcon: const Icon(Icons.search),
                                        querysql:
                                            '/sp/ApiEnrlCustMediaTypeList/queryasync',
                                        searchText: 'MediaTypeDscp',
                                        keyField: 'MediaType',
                                        params: {
                                          "PrgEttyId": prgEttyId,
                                          "CustEttyId": custEttyId
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
                                              .toString()
                                        },
                                        inputText: 'Transaction Category',
                                        inputIcon: const Icon(Icons.search),
                                        querysql: '/view/async/VwLibTxnCtgry',
                                        searchText: 'Dscp',
                                        keyField: 'TxnCtgry',
                                        params: const {});
                                  })),

                          //VwFeeCtgry

                          Flexible(
                              flex: 2,
                              child: FormBuilderField(
                                  name: 'FeeCtgry',
                                  builder: (field) {
                                    return AcxSearchBoxMap(
                                        returnSelectedRef: (dynamic val) {
                                          field.didChange(val['FeeCtgry']);
                                        },
                                        selectedRef: {
                                          'FeeCtgry': formNewValue['FeeCtgry']
                                              .toString()
                                        },
                                        inputText: 'Fee Category',
                                        inputIcon: const Icon(Icons.search),
                                        querysql: '/view/async/VwFeeCtgry',
                                        searchText: 'Dscp',
                                        keyField: 'FeeCtgry',
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
                          const SelectableText("Fee Plan"),
                          feeId == null || feeId!.isEmpty
                              ? const SelectableText('No Fee Id found')
                              : Flexible(
                                  flex: 4,
                                  child: CustEnrollProgramFeeTxnFeePlanList(
                                    feeId: feeId,
                                    custEttyId: custEttyId,
                                    prgEttyId: prgEttyId,
                                    feeCtgry:
                                        formNewValue['FeeCtgry'].toString(),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      ElevatedButton(
                        onPressed: () async {
                          formKey.currentState!.save();

                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(formKey.currentState!.value),
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiEnrlCustTxnFeeSave/queryasync',
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
                        child: const Icon(Icons.save),
                      ),
                      sbh10,
                      AcxBackToList(
                          listUrl:
                              '/custenroll/custprg/$custEttyId/$prgEttyId/$billingEttyType/fees/trans')
                    ]),
                  )
                ],
              ));
        });
  }
}

class CustEnrollProgramFeeTxnFeePlanList extends ConsumerWidget {
  const CustEnrollProgramFeeTxnFeePlanList({
    super.key,
    this.feeId,
    this.custEttyId,
    this.prgEttyId,
    this.feeCtgry,
  });

  final String? feeId;
  final String? custEttyId;
  final String? prgEttyId;
  final String? feeCtgry;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiEnrlCustTxnFeePlanList/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "FeeId": feeId
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
                        CustEnrollProgramFeeTxnFeePlanForm(
                          prgEttyId: prgEttyId.toString(),
                          feeId: feeId.toString(),
                          planId: null,
                          custEttyId: custEttyId,
                          feeCtgry: feeCtgry,
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
                      CustEnrollProgramFeeTxnFeePlanForm(
                        prgEttyId: prgEttyId.toString(),
                        custEttyId: custEttyId,
                        feeId: feeId.toString(),
                        planId: null,
                        feeCtgry: feeCtgry,
                      ));

                  ref.invalidate(ReturndatafreezedProvider(query));
                },
                child: const Icon(Icons.post_add)),
          ),
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
                        CustEnrollProgramFeeTxnFeePlanForm(
                          prgEttyId: prgEttyId.toString(),
                          custEttyId: custEttyId,
                          feeId: feeId.toString(),
                          planId: currentData['PlanId'].toString(),
                          feeCtgry: feeCtgry,
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
                            querysql: '/sp/ApiEnrlCustTxnFeePlanDel/queryasync',
                            params: {
                              "PrgEttyId": currentData['PrgEttyId'],
                              "CustEttyId": currentData['CustEttyId'],
                              "FeeId": currentData['FeeId'],
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

class CustEnrollProgramFeeTxnFeePlanForm extends ConsumerWidget {
  const CustEnrollProgramFeeTxnFeePlanForm(
      {super.key,
      required this.prgEttyId,
      required this.custEttyId,
      required this.planId,
      required this.feeId,
      required this.feeCtgry});
  final String? prgEttyId;
  final String? custEttyId;
  final String? feeId;
  final String? planId;
  final String? feeCtgry;

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
      "FeeId": feeId,
      "PlanId": planId
    };

    final queryFeeForm = QueryObject(
        querysql: '/sp/ApiEnrlCustTxnFeePlan/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "FeeId": feeId,
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
                          name: 'FeeId'),
                      FormBuilderField(
                          builder: (field) {
                            return Container();
                          },
                          name: 'PlanId'),
                      //
                      FbLibView(
                        name: 'TxnPlan',
                        label: 'Fee Plan',
                        querySql: '/sp/ApiPlanList/queryasync',
                        params: {"TxnType": feeCtgry},
                        keyField: 'TxnPlan',
                        searchText: 'TxnPlanDscp',
                      ),
                      const Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                                child: FbDateTimePicker(
                                    name: 'FromDate', label: 'From Date')),
                            fbFieldGap,
                            Expanded(
                                child: FbDateTimePicker(
                                    name: 'ToDate', label: 'To Date'))
                          ],
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                      height: 300,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
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
                                      '/sp/ApiEnrlCustTxnFeePlanSave/queryasync',
                                  params: toPost,
                                  showMsg: false);

                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((value) {
                                if (context.mounted) {
                                  Toast.showresult(value);
                                  context.maybePop();
                                  ref.invalidate(
                                      ReturndatafreezedProvider(queryFeeForm));
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
        });
  }
}
