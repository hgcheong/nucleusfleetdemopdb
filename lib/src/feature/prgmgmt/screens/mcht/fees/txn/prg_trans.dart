import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/prgmgmt/components/plan_fee_form.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=135;
@RoutePage()
class PrgMgmtMchtFeesTrans extends ConsumerWidget {
  const PrgMgmtMchtFeesTrans({
    super.key,
    @PathParam.inherit('prgEttyId') this.prgEttyId,
    @PathParam('feeId') this.feeId,
  });

  final String? prgEttyId;
  final String? feeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return PrgMgmtMchtFeesTransForm(
        prgId: prgEttyId, feeId: feeId == 'new' ? null : feeId);
  }
}

class PrgMgmtMchtFeesTransForm extends ConsumerWidget {
  const PrgMgmtMchtFeesTransForm({super.key, this.prgId, this.feeId});

  final String? prgId;
  final String? feeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiPrgMchtTxnFee/queryasync',
        params: {
          "PrgEttyId": prgId,
          "FeeId": feeId,
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "MediaType": null,
      "TxnCtgry": null,
      "Dscp": null,
      "SchdId": 0,
      "AggateCd": null,
      "BillingValue": null,
      "PrgEttyId": prgId,
      "FeeId": feeId,
      "Sts": "A"
    };
    final formData = ref.watch(ReturndatafreezedProvider(query));

    return formData.when(
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
            formNewValue['PrgEttyId'] = prgId;
            formNewValue['FeeId'] = feeId;
          }

          return AsyncValueWidget(
            value: formData,
            data: (theData) {
              return FormBuilder(
                  initialValue: formNewValue,
                  key: formKey,
                  onChanged: () {
                    formKey.currentState!.save();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const FbHiddenDateTime(name: 'MdfDate'),
                                FormBuilderField(
                                  name: 'PrgEttyId',
                                  initialValue: prgId,
                                  builder: (FormFieldState f) {
                                    return Container();
                                  },
                                ),
                                FormBuilderField(
                                  name: 'FeeId',
                                  initialValue: feeId,
                                  builder: (FormFieldState f) {
                                    return Container();
                                  },
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SelectableText(
                                            'Transaction Fee at Program Level'),
                                        const FbText(
                                          name: 'Dscp',
                                           label: 'Description'
                                        ),
                                        const FbLibView(
                                            name: 'MediaType',
                                            label: 'Media Type',
                                            params: {
                                              "RefType": "MediaType",
                                              "BitInd": null
                                            },
                                            keyField: 'RefCd',
                                            searchText: 'Dscp',
                                            querySql:
                                                '/sp/GetLibRef/queryasyncnouser'),
                                        FormBuilderField(
                                            name: 'TxnCtgry',
                                            builder: (field) {
                                              return AcxSearchBoxMap(
                                                  returnSelectedRef:
                                                      (dynamic val) {
                                                    field.didChange(
                                                        val['TxnCtgry']);
                                                  },
                                                  selectedRef: {
                                                    'TxnCtgry': field.value
                                                  },
                                                  inputText:
                                                      'Transaction Category',
                                                  inputIcon:
                                                      const Icon(Icons.search),
                                                  querysql:
                                                      '/view/async/VwLibTxnCtgry',
                                                  searchText: 'Dscp',
                                                  keyField: 'TxnCtgry',
                                                  params: const {});
                                            }),
                                        FormBuilderField(
                                            name: 'FeeCtgry',
                                            builder: (field) {
                                              return AcxSearchBoxMap(
                                                  returnSelectedRef:
                                                      (dynamic val) {
                                                    field.didChange(
                                                        val['FeeCtgry']);
                                                  },
                                                  selectedRef: {
                                                    'FeeCtgry':
                                                        formNewValue['FeeCtgry']
                                                            .toString()
                                                  },
                                                  inputText: 'Fee Category',
                                                  inputIcon:
                                                      const Icon(Icons.search),
                                                  querysql:
                                                      '/view/async/VwFeeCtgry',
                                                  searchText: 'Dscp',
                                                  keyField: 'FeeCtgry',
                                                  params: const {});
                                            }),
                                        FormBuilderField(
                                            name: 'SchdId',
                                            builder: (FormFieldState<dynamic>
                                                field) {
                                              return AcxSearchBoxMap(
                                                  returnSelectedRef:
                                                      (dynamic val) {
                                                    field.didChange(val['Id']);
                                                  },
                                                  selectedRef: {
                                                    'Id': field.value,
                                                  },
                                                  inputText:
                                                      'Billing Frequency',
                                                  inputIcon:
                                                      const Icon(Icons.search),
                                                  querysql:
                                                      '/view/async/VwSchdBilling',
                                                  searchText: 'Dscp',
                                                  keyField: 'Id',
                                                  params: const {});
                                              // return AcxSearchBoxView(
                                              //     returnSelectedRef: (VwSchdBillingItem val) {
                                              //       field.didChange(val.id);
                                              //     },
                                              //     selectedRef: VwSchdBillingItem(id: formValue.value['SchdId']),
                                              //     inputText: 'Billing Frequency',
                                              //     //    inputIcon: const Icon(Icons.search),
                                              //     querysql: '/view/async/VwSchdBilling',
                                              //     params: const {});
                                            }),
                                        FormBuilderField(
                                            name: 'AggateCd',
                                            builder: (FormFieldState<dynamic>
                                                field) {
                                              return AcxSearchBoxMap(
                                                  returnSelectedRef:
                                                      (dynamic val) {
                                                    field.didChange(
                                                        val['RefCd']);
                                                  },
                                                  selectedRef: {
                                                    'RefCd': field.value
                                                  },
                                                  inputText: 'Aggregate',
                                                  inputIcon:
                                                      const Icon(Icons.search),
                                                  querysql:
                                                      '/view/async/VwAggateCd',
                                                  searchText: 'Dscp',
                                                  keyField: 'RefCd',
                                                  params: const {});
                                            }),
                                        FormBuilderField(
                                            name: 'BillingValue',
                                            builder: (field) {
                                              return AcxSearchBoxMap(
                                                  returnSelectedRef:
                                                      (dynamic val) {
                                                    field.didChange(
                                                        val['RefCd']);
                                                  },
                                                  selectedRef: {
                                                    'RefCd': field.value
                                                  },
                                                  inputText: 'Billing Value',
                                                  inputIcon:
                                                      const Icon(Icons.search),
                                                  querysql:
                                                      '/view/async/VwBillingValue',
                                                  searchText: 'Dscp',
                                                  keyField: 'RefCd',
                                                  params: const {});
                                            }),
                                        FormBuilderField(
                                            name: 'Sts',
                                            builder: (field) {
                                              return AcxSearchBoxMap(
                                                  returnSelectedRef:
                                                      (dynamic val) {
                                                    field.didChange(
                                                        val['RefCd']);
                                                  },
                                                  selectedRef: {
                                                    'RefCd': field.value
                                                  },
                                                  inputText: 'Status',
                                                  inputIcon:
                                                      const Icon(Icons.search),
                                                  querysql:
                                                      '/view/async/VwActvSuspSts',
                                                  searchText: 'Dscp',
                                                  keyField: 'RefCd',
                                                  params: const {});
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      feeId == null
                          ? const Flexible(
                              flex: 5, child: SelectableText('No Fee Plan'))
                          : Flexible(
                              flex: 5,
                              child: SizedBox(
                                height: 300,
                                child: FeePlanList(
                                  prgEttyId: prgId,
                                  feeId: feeId,
                                ),
                              )),
                      Flexible(
                        flex: 2,
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
                                querysql: '/sp/ApiPrgMchtTxnFeeSave/queryasync',
                                params: toPost,
                                showMsg: false);
                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((Returndata value) {
                              Toast.showresult(value);
                              if (isSuccess(value.message)) {
                                if (context.mounted) {
                                  String afterSavedPath = getAfterSavePath(
                                      context, value.output, '@FeeId');
                                  singleton<AppRouter>()
                                      .navigatePath(afterSavedPath)
                                      .then((val) {
                                    ref.invalidate(
                                        ReturndatafreezedProvider(query));
                                  });
                                }
                              }
                            });
                          }),
                          const AcxBackToList(listUrl: '././pmfeetranslist'),
                    AcxAuditLogReqBtn('ApiPrgMchtTxnFeeSave',)
                        ]),
                      )
                    ],
                  ));
            },
          );
        },
        error: (x, e) => Center(child: Text(e.toString()),),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

class FeePlanList extends ConsumerWidget {
  const FeePlanList({
    super.key,
    this.prgEttyId,
    this.feeId,
  });

  final String? prgEttyId;
  final String? feeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiPrgMchtTxnFeePlanList/queryasync',
        params: {'PrgEttyId': prgEttyId, 'FeeId': feeId},
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          return const SizedBox(
            height: 300,
            child: Expanded(child: SelectableText('No Record ')),
          );
        }
        if (returnData.data![0]['PlanId'] == null) {
          // return const SizedBox(
          //   height: 300,
          //   child: Flexible(flex:3,child: SelectableText('No Fee Plan Saved')),
          // );
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await showAcxDialog(
                        context,
                        PlanFeeForm(
                          querySql: '/sp/ApiPrgMchtTxnFeePlan/queryasync',
                          saveSql: '/sp/ApiPrgMchtTxnFeePlanSave/queryasync',
                          prgEttyId: prgEttyId.toString(),
                          feeId: feeId.toString(),
                          planId: '',
                        ));
                    ref.invalidate(ReturndatafreezedProvider(QueryObject(
                        querysql: '/sp/ApiPrgMchtTxnFeePlanList/queryasync',
                        params: {'PrgEttyId': prgEttyId, 'FeeId': feeId},
                        showMsg: false)));
                  },
                  child: const Icon(Icons.post_add)),
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
                  await showAcxDialog(
                      context,
                      PlanFeeForm(
                          querySql: '/sp/ApiPrgMchtTxnFeePlan/queryasync',
                          saveSql: '/sp/ApiPrgMchtTxnFeePlanSave/queryasync',
                          prgEttyId: prgEttyId.toString(),
                          feeId: feeId.toString(),
                          planId: ''));
                  ref.invalidate(ReturndatafreezedProvider(QueryObject(
                      querysql: '/sp/ApiPrgMchtTxnFeePlanList/queryasync',
                      params: {'PrgEttyId': prgEttyId, 'FeeId': feeId},
                      showMsg: false)));
                  // ref.read(needRefreshTransProvider.notifier).state = DateTime.now();
                },
                child: const Icon(Icons.post_add)),
          ),
          const Flexible(flex: 1, child: SelectableText('Fee Plan')),
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
                  onTap: () async {
                    await showAcxAlertDialog(
                        context,
                        PlanFeeForm(
                          querySql: '/sp/ApiPrgMchtTxnFeePlan/queryasync',
                          saveSql: '/sp/ApiPrgMchtTxnFeePlanSave/queryasync',
                          prgEttyId: prgEttyId.toString(),
                          feeId: feeId.toString(),
                          planId: currentData['PlanId'].toString(),
                        ));
                    ref.invalidate(ReturndatafreezedProvider(QueryObject(
                        querysql: '/sp/ApiPrgMchtTxnFeePlanList/queryasync',
                        params: {'PrgEttyId': prgEttyId, 'FeeId': feeId},
                        showMsg: false)));
                  },
                  title: SelectableText(currentData['TxnPlanDscp'].toString()),
                  leading: SelectableText(
                      '${fmtDateStrShort(currentData['FromDate'])} to ${fmtDateStrShort(currentData['ToDate'])}'),
                  trailing: IconButton(
                      onPressed: () async {
                        bool? confirmed = await ConfirmDialog.show(
                          title: "Delete?",
                          body: "Are you sure you want to Delete?",
                          destructive: true,
                          confirmText: "Yes",
                          cancelText: "Cancel",
                        );
                        if (confirmed != null) {
                          if (!confirmed) {
                            return;
                          }
                          final queryDel = QueryObject(
                              querysql:
                                  '/sp/ApiPrgMchtTxnFeePlanDel/queryasync',
                              params: {
                                "PrgEttyId": currentData['PrgEttyId'],
                                "FeeId": currentData['FeeId'],
                                "PlanId": currentData['PlanId'],
                              },
                              showMsg: false);
                          await ref
                              .read(ReturndatafreezedProvider(queryDel).future)
                              .then((value) {
                            ref.invalidate(ReturndatafreezedProvider(QueryObject(
                                querysql:
                                    '/sp/ApiPrgMchtTxnFeePlanList/queryasync',
                                params: {
                                  'PrgEttyId': prgEttyId,
                                  'FeeId': feeId
                                },
                                showMsg: false)));
                            //  return Toast.message(value.toString());
                            return null;
                          });
                        }
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

