import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_dtp.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/feature/mcenroll/screens/location/program/transplan/transplanmock.dart';
import 'package:nucleusv2/src/utils/strings.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';

class McEnrollTransPlanCommonFormMock extends ConsumerWidget {
  const McEnrollTransPlanCommonFormMock(
      {super.key,
      required this.prgEttyId,
      required this.poe,
      required this.msgTypePlanId,
      required this.title});

  final String? prgEttyId;
  final String? poe;
  final String? msgTypePlanId;
  final String? title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrgMgmtMchtFepTransForm(
        prgId: prgEttyId,
        poe: poe,
        msgTypePlanId: msgTypePlanId == 'new' || msgTypePlanId == 'null'
            ? null
            : msgTypePlanId,
        title: title);
  }
}

class PrgMgmtMchtFepTransForm extends HookConsumerWidget {
  const PrgMgmtMchtFepTransForm(
      {super.key, this.prgId, this.poe, this.msgTypePlanId, this.title});

  final String? prgId;
  final String? msgTypePlanId;
  final String? poe;
  final String? title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    final formNewValue = {
      "Poe": poe,
      "SrcPrvder": null,
      "DealerType": null,
      "TxnPlan": 0,
      "MsgTypeId": null,
      "PrgEttyId": prgId,
      "MsgTypePlanId": msgTypePlanId
    };
    final formValue = useState<Map<String, dynamic>>(formNewValue);

    Returndata theData = mcenrolltransplan;

    if (theData.data != null) {
      formValue.value = convertFormValueToDisplay(
          theData.data![0] as Map<String, dynamic>, theData.columnInfo);

      formValue.value['PrgEttyId'] = prgId;
      formValue.value['MsgTypePlanId'] = msgTypePlanId;
    } else {
      formValue.value = formNewValue;
    }
    return FormBuilder(
        initialValue: formValue.value,
        key: formKey,
        onChanged: () {
          formKey.currentState!.save();
        },
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Flexible(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    children: [
                      FormBuilderField(
                        name: 'PrgEttyId',
                        initialValue: prgId,
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
                              SelectableText(title.toString()),
                              FormBuilderField(
                                name: 'Poe',
                                initialValue: poe,
                                builder: (FormFieldState f) {
                                  return Container();
                                },
                              ),
                              FormBuilderField(
                                  name: 'MsgTypeId',
                                  builder: (field) {
                                    return AcxSearchBoxMap(
                                        returnSelectedRef: (dynamic val) {
                                          field.didChange(val['MsgTypeId']);
                                        },
                                        selectedRef: {'MsgTypeId': field.value},
                                        inputText: 'Message Type',
                                        inputIcon: const Icon(Icons.search),
                                        querysql: '/view/async/VwTxnMsgType',
                                        searchText: 'Dscp',
                                        keyField: 'MsgTypeId',
                                        params: const {});
                                  }),
                              FormBuilderField(
                                  name: 'DealerType',
                                  builder: (field) {
                                    return AcxSearchBoxMap(
                                        returnSelectedRef: (dynamic val) {
                                          field.didChange(val['RefCd']);
                                        },
                                        selectedRef: {'RefCd': field.value},
                                        inputText: 'Dealer Type',
                                        inputIcon: const Icon(Icons.search),
                                        querysql: '/view/async/VwDealerType',
                                        searchText: 'Dscp',
                                        keyField: 'RefCd',
                                        params: const {});
                                  }),
                              FormBuilderField(
                                  name: 'SrcPrvder',
                                  builder: (field) {
                                    return AcxSearchBoxMap(
                                        returnSelectedRef: (dynamic val) {
                                          field.didChange(val['RefCd']);
                                        },
                                        selectedRef: {'RefCd': field.value},
                                        inputText: 'Dealer',
                                        inputIcon: const Icon(Icons.search),
                                        querysql: '/view/async/VwSrcPrvder',
                                        searchText: 'Dscp',
                                        keyField: 'RefCd',
                                        filterField: 'Poe',
                                        filterValue: poe,
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
            msgTypePlanId == null
                ? const Flexible(
                    flex: 5,
                    child: SizedBox(
                      height: 300,
                      child: SelectableText('No Fee Plan'),
                    ))
                : Flexible(
                    flex: 5,
                    child: FeePlanList(
                        prgEttyId: prgId,
                        poe: poe,
                        msgTypePlanId: msgTypePlanId,
                        msgTypeId: theData.data![0]['MsgTypeId'].toString()),
                  ),
            Flexible(
              flex: 2,
              child: Column(children: [
                AcxSaveButtonManual(onSave: () {
                  
                  formKey.currentState!.save();
                  Map<String, dynamic> toPost = convertFormValueToSave(
                      formKey.currentState!.value, theData.columnInfo);
                  final querySave = QueryObject(
                      querysql: '/sp/ApiPrgMchtTxnSave/queryasync?logId=${convStrNewOrNullToNull(prgId) ?? 0}',
                      params: toPost,
                      showMsg: false);
                  final saveResult =
                      ref.read(ReturndatafreezedProvider(querySave).future);
                  saveResult.then((Returndata value) {
                    Toast.showresult(value);
                    if (isSuccess(value.message)) {
                      if (context.mounted) {
                        String afterSavedPath = getAfterSavePath(
                            context, value.output, '@MsgTypePlanId');
                        singleton<AppRouter>()
                            .navigatePath(afterSavedPath)
                            .then((val) {});
                      }

                      //ref.invalidate(ReturndatafreezedProvider(query));
                    }
                  });
                }),
                AcxAuditLogReqBtn('ApiPrgMchtTxnSave',ettyId: prgId.toString(),),
                sbh10,
                IconButton(
                    onPressed: () {
                      //  singleton<AppRouter>().back()                            singleton<AppRouter>().navigatePath(listUrl);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ]),
            )
          ],
        ));
  }
}

class FeePlanList extends ConsumerWidget {
  const FeePlanList({
    super.key,
    this.prgEttyId,
    this.msgTypePlanId,
    this.poe,
    this.srcPrvder,
    this.msgTypeId,
  });

  final String? poe;
  final String? srcPrvder;
  final String? msgTypeId;
  final String? msgTypePlanId;
  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = QueryObject(
        querysql: '/sp/ApiPrgMchtTxnPlanList/queryasync',
        params: {'PrgEttyId': prgEttyId, 'MsgTypePlanId': msgTypePlanId},
        showMsg: false);
    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        List<dynamic> theFilteredDta = returnData.data!;
        if (theFilteredDta.isEmpty) {
          return const SizedBox(
              height: 300, child: SelectableText('No Record'));
        }
        if (theFilteredDta[0]['MsgTypePlanId'] == null) {
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
                            child: PlanFeeFormPrgFeeTrans(
                          poe: poe.toString(),
                          srcPrvder: srcPrvder.toString(),
                          msgTypePlanId: msgTypePlanId.toString(),
                          prgEttyId: prgEttyId.toString(),
                          planId: '',
                        ));
                      },
                    ).then((value) {
                      ref.invalidate(ReturndatafreezedProvider(query));
                    });

                    // ref.read(needRefreshTadProvider.notifier).state = DateTime.now();
                  },
                  child: const Icon(Icons.post_add)),
              const SelectableText('No Record')
            ],
          );
        }

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SelectableText('Fee Plan'),
          Flexible(
            flex: 1,
            child: ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          child: PlanFeeFormPrgFeeTrans(
                              prgEttyId: prgEttyId.toString(),
                              poe: poe.toString(),
                              msgTypePlanId: msgTypePlanId.toString(),
                              srcPrvder: srcPrvder.toString(),
                              planId: ''));
                    },
                  ).then((value) {
                    ref.invalidate(ReturndatafreezedProvider(query));
                  });
                },
                child: const Icon(Icons.post_add)),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: returnData.rowcount!,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                final currentData = returnData.data![index];
                if (currentData['PlanId'] == null) {
                  return const SelectableText('No plan');
                }
                return ListTile(
                  title: SelectableText(currentData['TxnPlanDscp'].toString()),
                  leading: SelectableText(
                      '${fmtDateStr(currentData['FromDate'])} to ${fmtDateStr(currentData['ToDate'])}'),
                  trailing: IconButton(
                      onPressed: () async {
                        bool confirmed = await ConfirmDialog.show(
                            title: 'Are you sure to delete ?');

                        if (confirmed) {
                          final queryDel = QueryObject(
                              querysql: '/sp/ApiPrgMchtTxnPlanDel/queryasync',
                              params: {
                                "PrgEttyId": currentData['PrgEttyId'],
                                "MsgTypePlanId": currentData['MsgTypePlanId'],
                                "PlanId": currentData['PlanId'],
                              },
                              showMsg: false);
                          await ref
                              .read(ReturndatafreezedProvider(queryDel).future)
                              .then((value) {
                            if (isSuccess(value.message)) {
                              ref.invalidate(ReturndatafreezedProvider(
                                  QueryObject(
                                      querysql:
                                          '/sp/ApiPrgMchtTxnPlanList/queryasync',
                                      params: {
                                        'PrgEttyId': prgEttyId,
                                        'MsgTypePlanId': msgTypePlanId
                                      },
                                      showMsg: false)));
                            }

                            return Toast.showresult(value);
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

class PlanFeeFormPrgFeeTrans extends ConsumerWidget {
  const PlanFeeFormPrgFeeTrans(
      {super.key,
      required this.prgEttyId,
      required this.msgTypePlanId,
      required this.planId,
      required this.srcPrvder,
      required this.poe});
  final String? prgEttyId;
  final String msgTypePlanId;
  final String planId;
  final String srcPrvder;
  final String poe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKeyPlan = GlobalKey<FormBuilderState>();
    final formValue = {
      'PrgEttyId': prgEttyId,
      'MsgTypePlanId': msgTypePlanId,
      'Poe': poe,
      'PlanId': null,
      'TxnPlan': null,
      'FromDate': null,
      'ToDate': null
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
                    name: 'Poe'),
                FormBuilderField(
                    builder: (field) {
                      return Container();
                    },
                    name: 'MsgTypePlanId'),
                Flexible(
                    flex: 2,
                    child: FbField(child: FormBuilderField(
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
                        }))),
                const Flexible(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                          child: FbDateTimePicker(
                        name: 'FromDate',
                        label: 'From Date',
                      )),
                      fbFieldGap,
                      Expanded(
                          child: FbDateTimePicker(
                        name: 'ToDate',
                        label: 'To Date',
                      )),
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
                        
                        formKeyPlan.currentState!.save();
                        final planId =
                            formKeyPlan.currentState!.value['PlanId'];
                        formKeyPlan.currentState!.patchValue(
                            {'PlanId': planId == '' ? null : planId});
                        Map<String, dynamic> toPost =
                            formKeyPlan.currentState!.value;

                        final querySave = QueryObject(
                            querysql: '/sp/ApiPrgMchtTxnPlanSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                            params: toPost,
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
                    ),
                    AcxAuditLogReqBtn('ApiPrgMchtTxnPlanSave', ettyId: prgEttyId.toString(),),
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
  }
}
