import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_searchbox.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/libref/libref.dart';
import 'package:nucleusv2/src/feature/mcenroll/screens/location/program/fees/trans/mc_enroll_loc_prg_fees_trans_provider.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart' as myroute;

const int wid=848;

@RoutePage()
class MchtEnrlLocPrgTrans extends ConsumerWidget {
  const MchtEnrlLocPrgTrans(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam('feeId') this.feeId});

  final String? prgEttyId;
  final String? locEttyId;
  final String? feeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final valToPass = ref.watch(mchtEnrollLocPrgFeestransProvider);

    return SizedBox(
        height: 1280,
        child: MchtEnrlLocPrgTransForm(
            prgEttyId: prgEttyId,
            locEttyId: locEttyId,
            mediaType: valToPass['MediaType'],
            txnCtgry: valToPass['TxnCtgry'],
            feeId: convStrNewOrNullToNull(feeId)));
  }
}

class MchtEnrlLocPrgTransForm extends ConsumerWidget {
  const MchtEnrlLocPrgTransForm({
    super.key,
    this.prgEttyId,
    this.feeId,
    this.locEttyId,
    this.mediaType,
    this.txnCtgry,
  });

  final String? prgEttyId;
  final String? locEttyId;
  final String? feeId;
  final String? mediaType;
  final String? txnCtgry;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiEnrlLocTxnFee/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "FeeId": feeId,
          "LocEttyId": locEttyId,
          "TxnCtgry": txnCtgry,
          "MediaType": mediaType
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "FeeId": feeId,
      "PrgEttyId": prgEttyId,
      "LocEttyId": locEttyId,
      "TxnCtgry": txnCtgry,
      "MediaType": mediaType,
      "Dscp": null,
      "SchdId": null,
      "Aggatecd": null,
      "BillingValue": null,
      "FromDate": null,
      "ToDate": null,
      "MdfDate": null
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FbHiddenDateTime(name: 'FromDate'),
                  const FbHiddenDateTime(name: 'ToDate'),
                  const FbHiddenDateTime(name: 'MdfDate'),
                  const FbHiddenText(name: 'PrgEttyId'),
                  const FbHiddenText(name: 'LocEttyId'),
                  const FbHiddenText(name: 'FeeId'),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 1280,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SelectableText(
                                'Transaction Fees at Location Level'),
                           const FbText(
                              name: 'Dscp',
                              label: 'Description',
                            ),
                            FormBuilderField(
                                name: 'MediaType',
                                builder: (FormFieldState<dynamic> field) {
                                  return AcxSearchBox(
                                      returnSelectedRef: (val) {
                                        val != null
                                            ? field.didChange(val.refCd)
                                            : field.didChange(null);
                                      },
                                      selectedRef: Libref(
                                          refCd: formNewValue['MediaType']),
                                      inputText: 'Media Type',
                                      //     inputIcon: const Icon(Icons.search),
                                      querysql: '/sp/GetLibRef/queryasyncnouser',
                                      params: const {
                                        "RefType": "MediaType",
                                        "BitInd": null
                                      });
                                }),
                            FormBuilderField(
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
                                }),
                            FormBuilderField(
                                name: 'FeeCtgry',
                                builder: (field) {
                                  return AcxSearchBoxMap(
                                      returnSelectedRef: (dynamic val) {
                                        field.didChange(val['FeeCtgry']);
                                      },
                                      selectedRef: {
                                        'FeeCtgry':
                                            formNewValue['FeeCtgry'].toString()
                                      },
                                      inputText: 'Fee Category',
                                      inputIcon: const Icon(Icons.search),
                                      querysql: '/view/async/VwFeeCtgry',
                                      searchText: 'Dscp',
                                      keyField: 'FeeCtgry',
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
                                        'Id': formNewValue['SchdId']
                                      },
                                      inputText: 'Billing Frequency',
                                      inputIcon: const Icon(Icons.search),
                                      querysql: '/view/async/VwSchdBilling',
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
                                        'RefCd': formNewValue['AggateCd']
                                      },
                                      inputText: 'Aggregate',
                                      inputIcon: const Icon(Icons.search),
                                      querysql: '/view/async/VwAggateCd',
                                      searchText: 'Dscp',
                                      keyField: 'RefCd',
                                      params: const {});
                                }),
                            FormBuilderField(
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
                                }),
                            FormBuilderField(
                                name: 'Sts',
                                builder: (field) {
                                  return AcxSearchBoxMap(
                                      returnSelectedRef: (dynamic val) {
                                        field.didChange(val['RefCd']);
                                      },
                                      selectedRef: {'RefCd': field.value},
                                      inputText: 'Status',
                                      inputIcon: const Icon(Icons.search),
                                      querysql: '/view/async/VwActvSuspSts',
                                      searchText: 'Dscp',
                                      keyField: 'RefCd',
                                      params: const {});
                                }),
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
                          const SelectableText("Finance Plan"),
                          feeId == null || feeId!.isEmpty
                              ? const SelectableText('No Fee Id found')
                              : Flexible(
                                  flex: 4,
                                  child: McEnrlLocFeePlanList(
                                    feeId: feeId,
                                    prgEttyId: prgEttyId,
                                    locEttyId: locEttyId,
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
                              formKey.currentState!.value, theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiEnrlLocTxnFeeSave/queryasync',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              var feeIdOutput =
                                  getOutputValue(value.output, '@FeeId');

                              singleton<AppRouter>()
                                  .navigate(myroute.MchtEnrlLocPrgTrans(
                                      feeId: feeIdOutput.toString()))
                                  .then(
                                (value) {
                                  // ref.invalidate(ReturndatafreezedProvider(query));

                                  ref
                                      .read(mchtEnrollLocPrgFeestransProvider
                                          .notifier)
                                      .state = {
                                    "FeeId": feeIdOutput,
                                    "MediaType": toPost['MediaType'].toString(),
                                    "TxnCtgry": toPost['TxnCtgry'].toString(),
                                  };
                                },
                              );
                            }
                          });
                        },
                        child: const Icon(Icons.save),
                      ),
                      sbh10,
                      const AcxBackToList(listUrl: '././././list')
                    ]),
                  )
                ],
              ));
        });
  }
}

class McEnrlLocFeePlanList extends ConsumerWidget {
  const McEnrlLocFeePlanList(
      {super.key,
      this.prgEttyId,
      this.feeId,
      this.locEttyId,
      required this.feeCtgry});

  final String? feeId;
  final String? prgEttyId;
  final String? locEttyId;
  final String feeCtgry;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiEnrlLocTxnFeePlanList/queryasync',
        params: {
          'PrgEttyId': prgEttyId,
          'LocEttyId': locEttyId,
          'FeeId': feeId
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
                        McEnrlLocPlanFeeForm(
                            locEttyId: locEttyId.toString(),
                            prgEttyId: prgEttyId.toString(),
                            feeId: feeId.toString(),
                            planId: '',
                            ref: context,
                            feeCtgry: feeCtgry));

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
                      McEnrlLocPlanFeeForm(
                        locEttyId: locEttyId.toString(),
                        prgEttyId: prgEttyId.toString(),
                        feeId: feeId.toString(),
                        planId: '',
                        ref: context,
                        feeCtgry: feeCtgry,
                      ));

                  ref.invalidate(ReturndatafreezedProvider(QueryObject(
                      querysql: '/sp/ApiEnrlLocTxnFeePlanList/queryasync',
                      params: {
                        'PrgEttyId': prgEttyId,
                        'FeeId': feeId,
                        'LocEttyId': locEttyId
                      },
                      showMsg: false)));
                  // ref.read(needRefreshTransProvider.notifier).state = DateTime.now();
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
                  title: SelectableText(currentData['TxnPlanDscp'].toString()),
                  subtitle: SelectableText(
                      '${fmtDateStrShort(currentData['FromDate'])} to ${fmtDateStrShort(currentData['ToDate'])}'),
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
                            querysql: '/sp/ApiEnrlLocTxnFeePlanDel/queryasync',
                            params: {
                              "PrgEttyId": currentData['PrgEttyId'],
                              "FeeId": currentData['FeeId'],
                              "PlanId": currentData['PlanId'],
                              "LocEttyId": currentData['LocEttyId']
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

class McEnrlLocPlanFeeForm extends ConsumerWidget {
  const McEnrlLocPlanFeeForm(
      {super.key,
      required this.prgEttyId,
      required this.feeId,
      required this.locEttyId,
      required this.planId,
      required this.ref,
      required this.feeCtgry});
  final String prgEttyId;
  final String feeId;
  final String planId;
  final String locEttyId;
  final String feeCtgry;
  final BuildContext ref;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    final formValue = {
      'FromDate"=': null,
      'ToDate': null,
      'PrgEttyId': prgEttyId,
      'FeeId': feeId,
      'PlanId': null,
      'TxnPlan': null,
      'LocEttyId': locEttyId
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
                const FbHiddenText(name: 'MdfDate'),
                const FbHiddenText(name: 'LocEttyId'),
                const FbHiddenText(name: 'PlanId'),
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
                      Flexible(
                          child: FbDateTimePicker(
                              label: 'From Date', name: 'FromDate')),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                          child: FbDateTimePicker(
                              label: 'To Date', name: 'ToDate')),
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
                        Map<String, dynamic> toPost = convertFormDateValue(
                            formKeyPlan.currentState!.value,
                            ['FromDate', 'ToDate']);
                        final querySave = QueryObject(
                            querysql: '/sp/ApiEnrlLocTxnFeePlanSave/queryasync',
                            params: toPost,
                            showMsg: false);

                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
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
  }
}
