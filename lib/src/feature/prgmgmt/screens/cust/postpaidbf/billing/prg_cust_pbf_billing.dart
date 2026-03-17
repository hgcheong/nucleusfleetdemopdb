import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart' as myroute;
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';

const int wid=818;

@RoutePage()
class PrgCustPbfBilling extends StatelessWidget {
  const PrgCustPbfBilling(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam('billingId') this.billingId});

  final String? billingId;
  final String? prgEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return PrgCustPbfBillingForm(
      billingId: billingId == 'new' || billingId == 'null' ? null : billingId,
      prgEttyId: prgEttyId,
    );
  }
}

class PrgCustPbfBillingForm extends ConsumerWidget {
  const PrgCustPbfBillingForm({
    super.key,
    this.billingId,
    this.prgEttyId,
  });
  final String? billingId;
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();
    final listUrl = '/prgmgmt/custsetup/$prgEttyId/pppbflanding/pppbfbilllist';
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustPostpaidBFCycle/queryasync',
        params: {"PrgEttyId": prgEttyId, "BillingId": billingId},
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "Dscp": "",
      "DueDays": "0",
      "GracePeriod": "0",
      "MinRepymtRate": "0.00",
      "MinRepymtAmt": "1.00",
      "InterestFreePeriod": "0",
      "DelqcBlockDays": "0",
      "BillingId": billingId.toString(),
      "PrgEttyId": prgEttyId.toString()
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
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
                    name: 'BillingId',
                    builder: (FormFieldState f) {
                      return Container();
                    },
                  ),
                  const Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         FbText(
                            name: 'Dscp',
                             label: 'Description',
                          ),
                          Row(
                            children: [
                              Expanded(
                                child:  FbText(
                                  name: 'MinRepymtRate',
                                  label: 'Min. Repayment %',
                             
                                ),
                              ),
                              Expanded(
                                child: FbText(
                                  name: 'MinRepymtAmt',
                                  label: 'Or (whichever is higher)',
                      
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FbText(
                                  name: 'DueDays',
                                   label: 'Statement due days',
                                ),
                              ),
                               Expanded(
                                child: FbText(
                                  name: 'GracePeriod',
                                  label: 'Overdue Grace Period',
                           
                                ),
                              ),
                            ],
                          ),
                          FbText(
                            name: 'InterestFreePeriod',
                             label:
                                  'Statement Interest free period (days)',
                          
                          ),
                          FbText(
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
                          const SelectableText('Statement Cycle Date'),
                          SizedBox(
                              height: 300,
                              child: PrgCustPbfBillingCycleList(
                                billingId: billingId,
                                prgEttyId: prgEttyId,
                              ))
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
                        formKey.currentState!.save();
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            formKey.currentState!.value, theData.columnInfo);
                        final querySave = QueryObject(
                            querysql:
                                '/sp/ApiPrgCustPostpaidBFCycleSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                            params: toPost,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((Returndata value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            var billingId =
                                getOutputValue(value.output, "@BillingId");

                            ref.invalidate(ReturndatafreezedProvider(query));
                            singleton<AppRouter>().navigate(
                                myroute.PrgCustPbfBilling(
                                    billingId: billingId.toString()));
                          }
                        });
                      }),

                      IconButton(
                          onPressed: () {
                            singleton<AppRouter>().navigatePath(listUrl);
                          },
                          icon: const Icon(Icons.arrow_back)),
                          sbh10,
                          AcxAuditLogReqBtn('ApiPrgCustPostpaidBFCycleSave',ettyId: prgEttyId.toString(),)
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

class PrgCustPbfBillingCycleList extends ConsumerWidget {
  const PrgCustPbfBillingCycleList({
    super.key,
    this.billingId,
    this.prgEttyId,
  });

  final String? billingId;
  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustPostpaidBFCycleDateList/queryasync',
        params: {'PrgEttyId': prgEttyId, 'BillingId': billingId},
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          return const SizedBox(
              height: 300,
              child: Expanded(child: SelectableText('No Record ')));
        }
        if (returnData.data![0]['BillingId'] == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ElevatedButton(
              //     onPressed: () async {
              //       await showDialog(
              //         barrierDismissible: false,
              //         context: context,
              //         builder: (context) {
              //           return Dialog(
              //               child: BiillingCycleDateForm(
              //             prgEttyId: prgEttyId.toString(),
              //             billingId: billingId.toString(),
              //           ));
              //         },
              //       );
              //       ref.invalidate(ReturndatafreezedProvider(QueryObject(querysql: '/sp/ApiPrgCustPostpaidBFCycleDateList/queryasync', params: {'PrgEttyId': prgEttyId, 'BillingId': billingId}, showMsg: false)));
              //     },
              //     child: const Icon(Icons.post_add)),
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
                      final currentData = returnData.data![0];
                      Debugger.log(currentData);
                      return Dialog(
                          child: BiillingCycleDateForm(
                        prgEttyId: prgEttyId.toString(),
                        billingId: billingId.toString(),
                      ));
                    },
                  );
                  ref.invalidate(ReturndatafreezedProvider(QueryObject(
                      querysql:
                          '/sp/ApiPrgCustPostpaidBFCycleDateList/queryasync',
                      params: {'PrgEttyId': prgEttyId, 'BillingId': billingId},
                      showMsg: false)));
                },
                child: const Icon(Icons.post_add)),
          ),
          // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
          Expanded(
            child: returnData.data![0]['SchdId'] == null
                ? const SelectableText("No Record")
                : ListView.separated(
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
                                      '/sp/ApiPrgCustPostpaidBFCycleDateDel/queryasync',
                                  params: {
                                    "PrgEttyId": currentData['PrgEttyId'],
                                    "BillingId": currentData['BillingId'],
                                    "SchdId": currentData['SchdId'],
                                  },
                                  showMsg: false);
                              final resultDel = ref.read(
                                  ReturndatafreezedProvider(queryDel).future);
                              resultDel.then((value) {
                                ref.invalidate(ReturndatafreezedProvider(
                                    QueryObject(
                                        querysql:
                                            '/sp/ApiPrgCustPostpaidBFCycleDateList/queryasync',
                                        params: {
                                          'PrgEttyId': prgEttyId,
                                          'BillingId': billingId
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

class BiillingCycleDateForm extends ConsumerWidget {
  const BiillingCycleDateForm({
    super.key,
    required this.prgEttyId,
    this.billingId,
    this.schdId,
  });
  final String? prgEttyId;
  final String? billingId;
  final String? schdId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    final formValue = {
      'PrgEttyId': prgEttyId,
      'BillingId': billingId,
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
                                '/sp/ApiPrgCustPostpaidBFCycleDateSave/queryasync',
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
