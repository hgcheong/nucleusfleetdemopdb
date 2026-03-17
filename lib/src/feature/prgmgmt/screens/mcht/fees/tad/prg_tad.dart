import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/feature/prgmgmt/components/plan_fee_form.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';

const int wid=138;
@RoutePage()
class PrgMgmtMchtFeesTad extends ConsumerWidget {
  const PrgMgmtMchtFeesTad({
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
    return PrgMgmtMchtFeesTadForm(
        prgId: prgEttyId, feeId: feeId == 'new' ? null : feeId);
  }
}

class PrgMgmtMchtFeesTadForm extends HookConsumerWidget {
  const PrgMgmtMchtFeesTadForm({super.key, this.prgId, this.feeId});

  final String? prgId;
  final String? feeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();
    //final prgId = singleton<AppRouter>().current.parent!.parent!.parent!.pathParams.get("prgEttyId");
    // final feeId = singleton<AppRouter>().current.pathParams.get("feeId") == 'new' ? '' : singleton<AppRouter>().current.pathParams.get("feeId");
    final query = QueryObject(
        querysql: '/sp/ApiPrgMchtTadFee/queryasync',
        params: {
          "PrgEttyId": prgId,
          "FeeId": feeId,
        },
        showMsg: false);

    final formNewValue = {
      "PrgEttyId": prgId,
      "FeeId": feeId,
      "PlanId": null,
      "TxnPlan": null,
      "MnM": null,
      "Vendor": null,
      "SchdId": null,
      "Dscp": null,
      "FromDate": null,
      "ToDate": null,
      "Sts": "A",
    };
    final formValue = useState<Map<String, dynamic>>(formNewValue);
    final formData = ref.watch(ReturndatafreezedProvider(query));
    return formData.when(
        data: (theData) {
          if (theData.data != null) {
            formValue.value = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
            formValue.value['PrgEttyId'] = prgId;
            formValue.value['FeeId'] = feeId;
          } else {
            formValue.value = formNewValue;
          }
          return FormBuilder(
              initialValue: formValue.value,
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
                            FormBuilderField(
                              name: 'PrgEttyId',
                              initialValue: prgId,
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
                              name: 'MdfDate',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SelectableText(
                                        'TAD Fee at Program Level'),
                                    FbLibView(
                                      name: 'MnM',
                                      label: 'Make & Model',
                                      initialValue: formValue
                                          .value['MnM']
                                          .toString(),
                                      keyField: 'RefCd',
                                      params: const {
                                        "RefType": "TADMNM",
                                        "BitInd": null
                                      },
                                      searchText: 'Dscp',
                                      querySql:
                                          '/sp/GetLibRef/queryasyncnouser',
                                    ),
                                    FbLibView(
                                      name: 'Vendor',
                                      label: 'Vendor',
                                      initialValue: formValue
                                          .value['Vendor']
                                          .toString(),
                                      keyField: 'RefCd',
                                      params: const {
                                        "RefType": "TADVENDOR",
                                        "BitInd": null
                                      },
                                      searchText: 'Dscp',
                                      querySql:
                                          '/sp/GetLibRef/queryasyncnouser',
                                    ),
                                    FbLibView(
                                      name: 'SchdId',
                                      label: 'Billing Frequency',
                                      initialValue:
                                          formValue.value["SchdId"],
                                      keyField: 'Id',
                                      params: const {},
                                      searchText: 'Dscp',
                                      querySql: '/view/async/VwSchdBilling',
                                    ),
                                    FbLibView(
                                      name: 'Sts',
                                      label: 'TAD Status',
                                      initialValue: formValue
                                          .value['Sts']
                                          .toString(),
                                      keyField: 'RefCd',
                                      params: const {
                                        "RefType": "TADSTS",
                                        "BitInd": null
                                      },
                                      searchText: 'Dscp',
                                      querySql:
                                          '/sp/GetLibRef/queryasyncnouser',
                                    ),
                                    const FbText(
                                      name: 'Dscp',
                                      label: 'Description',
      
                                    ),
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
                          flex: 5,
                          child: SizedBox(
                            height: 300,
                            child: SelectableText('No Fee Plan'),
                          ))
                      : Flexible(
                          flex: 5,
                          child: SizedBox(
                            height: 1000,
                            child: FeePlanList(
                              prgEttyId: prgId,
                              feeId: feeId,
                            ),
                          )),
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        AcxSaveButtonManual(onSave: () {
                            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          formKey.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(formKey.currentState!.value),
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiPrgMchtTadFeeSave/queryasync',
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
                        sbh10,
                        const AcxBackToList(listUrl: '././pmfeetadlist'),
                             sbh10,
                    AcxAuditLogReqBtn('ApiPrgMchtTadFeeSave',)
                      ],
                    ),
                  )
                ],
              ));
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
        querysql: '/sp/ApiPrgMchtTadFeePlanList/queryasync',
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    // await showDialog(
                    //   barrierDismissible: false,
                    //   context: context,
                    //   builder: (context) {
                    //     return Dialog(child: PlanFeeForm(prgEttyId: prgEttyId.toString(), feeId: feeId.toString(), planId: ''));
                    //   },
                    // );

                    await showAcxDialog(
                        context,
                        PlanFeeForm(
                            querySql: '/sp/ApiPrgMchtTadFeePlan/queryasync',
                            saveSql: '/sp/ApiPrgMchtTadFeePlanSave/queryasync',
                            prgEttyId: prgEttyId.toString(),
                            feeId: feeId.toString(),
                            planId: ''));

                    ref.invalidate(ReturndatafreezedProvider(QueryObject(
                        querysql: '/sp/ApiPrgMchtTadFeePlanList/queryasync',
                        params: {'PrgEttyId': prgEttyId, 'FeeId': feeId},
                        showMsg: false)));
                    // ref.read(needRefreshTadProvider.notifier).state = DateTime.now();
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
                          querySql: '/sp/ApiPrgMchtTadFeePlan/queryasync',
                          saveSql: '/sp/ApiPrgMchtTadFeePlanSave/queryasync',
                          prgEttyId: prgEttyId.toString(),
                          feeId: feeId.toString(),
                          planId: ''));

                  ref.invalidate(ReturndatafreezedProvider(QueryObject(
                      querysql: '/sp/ApiPrgMchtTadFeePlanList/queryasync',
                      params: {'PrgEttyId': prgEttyId, 'FeeId': feeId},
                      showMsg: false)));
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
                    await showAcxDialog(
                        context,
                        PlanFeeForm(
                            querySql: '/sp/ApiPrgMchtTadFeePlan/queryasync',
                            saveSql: '/sp/ApiPrgMchtTadFeePlanSave/queryasync',
                            prgEttyId: prgEttyId.toString(),
                            feeId: feeId.toString(),
                            planId: currentData['PlanId'].toString()));
                    ref.invalidate(ReturndatafreezedProvider(QueryObject(
                        querysql: '/sp/ApiPrgMchtTadFeePlanList/queryasync',
                        params: {'PrgEttyId': prgEttyId, 'FeeId': feeId},
                        showMsg: false)));
                  },
                  title: SelectableText(currentData['TxnPlanDscp'].toString()),
                  leading: SelectableText(
                      '${fmtDateStrShort(currentData['FromDate'])} to ${fmtDateStrShort(currentData['ToDate'])}'),
                  trailing: IconButton(
                      onPressed: () async {
                        if (!await ConfirmDialog.delete()) {
                          return;
                        }
                        final queryDel = QueryObject(
                            querysql: '/sp/ApiPrgMchtTadFeePlanDel/queryasync',
                            params: {
                              "PrgEttyId": currentData['PrgEttyId'],
                              "FeeId": currentData['FeeId'],
                              "PlanId": currentData['PlanId'],
                            },
                            showMsg: false);
                        await ref
                            .read(ReturndatafreezedProvider(queryDel).future)
                            .then((value) {
                          Toast.showresult(value);
                          ref.invalidate(ReturndatafreezedProvider(QueryObject(
                              querysql:
                                  '/sp/ApiPrgMchtTadFeePlanList/queryasync',
                              params: {'PrgEttyId': prgEttyId, 'FeeId': feeId},
                              showMsg: false)));
                          // return Toast.message(value.toString());
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
