import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';

const int wid=775;

@RoutePage()
class PrgCustPOIBilling extends ConsumerWidget {
  const PrgCustPOIBilling(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam('billingId') this.billingId});

  final String? billingId;
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Center(
      child: PrgCustPOIBillingForm(
        billingId: convStrNewOrNullToNull(billingId.toString()),
        prgEttyId: prgEttyId,
      ),
    );
  }
}

class PrgCustPOIBillingForm extends ConsumerWidget {
  const PrgCustPOIBillingForm({
    super.key,
    this.billingId,
    this.prgEttyId,
    this.schdType,
  });
  final String? billingId;
  final String? prgEttyId;
  final String? schdType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyCustPOI = GlobalKey<FormBuilderState>();
    final listUrl =
        '/prgmgmt/custsetup/$prgEttyId/postpaidoilanding/pppoibilllist';
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustPostpaidOICycle/queryasync',
        params: {"PrgEttyId": prgEttyId, "BillingId": billingId},
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "Dscp": "",
      "DelqcBlockDays": "0",
      "MatchPymtInvcInd": null,
      "BillingId": convStrNewOrNullToNull(billingId.toString()),
      "SchdType": schdType,
      "PrgEttyId": prgEttyId.toString()
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          if (billingId != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
            formNewValue =
                convertFormTrueFalseValue(formNewValue, ['MatchPymtInvcInd']);
            //
            formNewValue['SchdType'] = null;
            formNewValue['SchdId'] = null;
          }

          return FormBuilder(
              key: formKeyCustPOI,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  FormBuilderField(
                    name: 'PrgEttyId',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  const FbHiddenText(name: 'BillingId'),
                  const FbHiddenText(name: 'SchdId'),
                  const FbHiddenText(name: 'SchdType'),
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
                          const SelectableText(
                              'Auto knock-off open payment with same Invoice amount'),
                          FbField(child: FormBuilderSwitch(
                            name: 'MatchPymtInvcInd',
                            title: const SelectableText(
                                'Open Payment auto matching'),
                            valueTransformer: (value) {
                              return value == false ? 'N' : 'Y';
                            },
                          )),
                          const FbText(
                            name: 'DelqcBlockDays',
                            label:
                                  'Block account usage after x days overdue',
                     
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
                          const SelectableText('Invoice Cycle Date'),
                          Flexible(
                            child: PrgCustPOIBillingCycleList(
                              billingId: convStrNewOrNullToNull(billingId),
                              prgEttyId: prgEttyId,
                              schdType: null,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      AcxSaveButtonManual(onSave: () {
                          if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                        formKeyCustPOI.currentState!.save();
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            formKeyCustPOI.currentState!.value,
                            theData.columnInfo);
                        final querySave = QueryObject(
                            querysql:
                                '/sp/ApiPrgCustPostpaidOICycleSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                            params: toPost,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((Returndata value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            ref.invalidate(ReturndatafreezedProvider(query));
                          }
                        });
                      }),
                      IconButton(
                          onPressed: () {
                            singleton<AppRouter>().navigatePath(listUrl);
                          },
                          icon: const Icon(Icons.arrow_back)),
                        sbh10,
                        AcxAuditLogReqBtn('ApiPrgCustPostpaidOICycleSave',ettyId: prgEttyId.toString(),)
                    ]),
                  )
                ],
              ));
        } else {
          formNewValue = formNewValue;
          return Container();
        }
      },
    );
  }
}

class PrgCustPOIBillingCycleList extends ConsumerWidget {
  const PrgCustPOIBillingCycleList(
      {super.key, this.billingId, this.prgEttyId, this.schdType});

  final String? billingId;
  final String? prgEttyId;
  final String? schdType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustPostpaidOICycleDateList/queryasync',
        params: {
          'PrgEttyId': prgEttyId,
          'BillingId': billingId,
          'SchdType': schdType
        },
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          return const SizedBox(
              height: 300, child: SelectableText('No Record '));
        }

        if (billingId == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectableText('No Data'),
              Expanded(
                  child: ListView(
                children: const [SelectableText('No Record')],
              ))
            ],
          );
        }
        if (returnData.data![0]['SchdId'] == null) {
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
                            child: BiillingCycleDateForm(
                          prgEttyId: prgEttyId.toString(),
                          billingId: billingId,
                          schdType: schdType,
                        ));
                      },
                    );
                    ref.invalidate(ReturndatafreezedProvider(query));
                  },
                  child: const Icon(Icons.post_add)),
              const SelectableText('No Cycle Date'),
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
                          child: BiillingCycleDateForm(
                              prgEttyId: prgEttyId.toString(),
                              billingId: billingId,
                              schdType: schdType));
                    },
                  );

                  ref.invalidate(ReturndatafreezedProvider(query));
                },
                child: const Icon(Icons.post_add)),
          ),
          // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
          billingId == null
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
                        title: SelectableText('${currentData['SchdDscp']}'),
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
                                      '/sp/ApiPrgCustPostpaidOICycleDateDel/queryasync',
                                  params: {
                                    "PrgEttyId": currentData['PrgEttyId'],
                                    "BillingId": currentData['BillingId'],
                                    "SchdId": currentData['SchdId'],
                                  },
                                  showMsg: false);
                              final resultDel = ref.read(
                                  ReturndatafreezedProvider(queryDel).future);
                              resultDel.then((value) {
                                Toast.showresult(value);
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
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

class BiillingCycleDateForm extends ConsumerWidget {
  const BiillingCycleDateForm(
      {super.key,
      required this.prgEttyId,
      this.billingId,
      this.schdId,
      this.schdType});
  final String? prgEttyId;
  final String? billingId;
  final String? schdId;
  final String? schdType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    final formValue = {
      'PrgEttyId': prgEttyId,
      'BillingId': billingId,
      'SchdType': schdType,
      'SchdId': schdId
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
                    name: 'BillingId'),
                FormBuilderField(
                    builder: (field) {
                      return Container();
                    },
                    name: 'SchdType'),
                Flexible(
                    flex: 2,
                    child: FormBuilderField(
                        name: 'SchdId',
                        builder: (field) {
                          return AcxSearchBoxMap(
                              returnSelectedRef: (dynamic val) {
                                field.didChange(val['Id']);
                              },
                              selectedRef: {'Id': field},
                              inputText: 'Choose a Schdule',
                              inputIcon: const Icon(Icons.search),
                              querysql: '/view/async/VwSchdBilling',
                              searchText: 'Dscp',
                              keyField: 'Id',
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
                                '/sp/ApiPrgCustPostpaidOICycleDateSave/queryasync',
                            params: formKeyPlan.currentState!.value,
                            showMsg: true);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
                          //   Toast.message(value.toString());

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
