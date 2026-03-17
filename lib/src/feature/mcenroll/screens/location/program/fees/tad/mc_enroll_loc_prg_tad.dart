import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/shared/acx_txn_plan_list.dart';
import 'package:nucleusv2/src/core/components/shared/acx_vw_txn_plan_form.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=845;

@RoutePage()
class MchtEnrlLocPrgTad extends StatelessWidget {
  const MchtEnrlLocPrgTad({
    super.key,
    @PathParam.inherit('prgEttyId') this.prgEttyId,
    @PathParam.inherit('locEttyId') this.locEttyId,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
    @PathParam('feeId') this.feeId,
  });

  final String? prgEttyId;
  final String? feeId;
  final String? mchtEttyId;
  final String? locEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return MchtEnrlLocPrgTadForm(
        prgEttyId: prgEttyId,
        locEttyId: locEttyId,
        feeId: convStrNewOrNullToNull(feeId));
  }
}

class MchtEnrlLocPrgTadForm extends ConsumerWidget {
  const MchtEnrlLocPrgTadForm(
      {super.key, this.prgEttyId, this.feeId, this.mchtEttyId, this.locEttyId});

  final String? prgEttyId;
  final String? feeId;
  final String? locEttyId;
  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mcenrllocprgtadKey = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiEnrlLocTadFee/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "LocEttyId": locEttyId,
          "FeeId": feeId,
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "MnM": null,
      "Vendor": null,
      "Dscp": null,
      "FromDate": null,
      "ToDate": null,
      "SchdId": null,
      "LocEttyId": null,
      "PrgEttyId": null,
      "FeeId": null,
      "MdfDate": null
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return formData.when(
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
              initialValue: formNewValue,
              key: mcenrllocprgtadKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            FormBuilderField(
                              name: 'PrgEttyId',
                              initialValue: formNewValue['PrgEttyId'],
                              builder: (FormFieldState f) {
                                return Container();
                              },
                            ),
                            const FbHiddenText(name: 'LocEttyId'),
                            const FbHiddenDateTime(name: 'MdfDate'),
                            const FbHiddenDateTime(name: 'FromDate'),
                            const FbHiddenDateTime(name: 'ToDate'),
                            FormBuilderField(
                              name: 'FeeId',
                              initialValue: formNewValue['FeeId'],
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
                                        'TAD Fee at Location Level'),
                                    FbLibView(
                                      name: 'MnM',
                                      label: 'Make & Model',
                                      initialValue:
                                          formNewValue['MnM'].toString(),
                                      keyField: 'RefCd',
                                      params: const {
                                        "RefType": "TADMNM",
                                        "BitInd": null
                                      },
                                      searchText: 'Dscp',
                                      querySql:
                                          '/sp/GetLibRef/queryasyncnouser',
                                    ),
                                    const SelectableText(
                                        'TAD Fee at Location Level'),
                                    FbLibView(
                                      name: 'Vendor',
                                      label: 'Vendor',
                                      initialValue:
                                          formNewValue['Vendor'].toString(),
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
                                      initialValue: formNewValue["SchdId"],
                                      keyField: 'Id',
                                      params: const {},
                                      searchText: 'Dscp',
                                      querySql: '/view/async/VwSchdBilling',
                                    ),
                                   const FbText(
                                      name: 'Dscp',
                                      label: 'Description'
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
                            height: 300,
                            child: AcxTxnPlanList(
                              listTitlefield: 'TxnPlanDscp',
                              diaLoghiddenFields: const {
                                "FeeId": null,
                                "LocEttyId": null,
                                "PrgEttyId": null
                              },
                              diaLogquerySaveSql:
                                  '/sp/ApiEnrlLocTadFeePlanSave/queryasync',
                              dialogqueryRetrieveSql:
                                  '/sp/ApiEnrlLocTadFeePlan/queryasync',
                              feeCtgry: formNewValue['TxnType'],
                              dialogParams: {
                                "PrgEttyId": prgEttyId,
                                "LocEttyId": locEttyId,
                                "FeeId": feeId,
                                "PlanId": null
                              },
                              listquery: QueryObject(
                                  querysql:
                                      '/sp/ApiEnrlLocTadFeePlanList/queryasync',
                                  params: {
                                    'PrgEttyId': prgEttyId,
                                    'FeeId': feeId,
                                    'LocEttyId': locEttyId
                                  },
                                  showMsg: false),
                              listDeleteSql:
                                  '/sp/ApiEnrlLocTadFeePlanDel/queryasync',
                              listDeleteParam: {
                                "PrgEttyId": prgEttyId,
                                "FeeId": feeId,
                                "PlanId": null,
                                "LocEttyId": null
                              },
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
                          mcenrllocprgtadKey.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(mcenrllocprgtadKey.currentState!.value),
                              theData.columnInfo);
                          final saveResult = ref.read(ReturndatafreezedProvider(
                                  QueryObject(
                                      querysql:
                                          '/sp/ApiEnrlLocTadFeeSave/queryasync?logId=${convStrNewOrNullToNull(locEttyId) ?? 0}',
                                      params: toPost,
                                      showMsg: false))
                              .future);
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
                        const AcxBackToList(
                          listUrl: '././list',
                        ),
                        sbh10,
                        AcxAuditLogReqBtn('ApiEnrlLocTadFeeSave', ettyId:  locEttyId.toString(),)
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
  const FeePlanList(
      {super.key,
      this.prgEttyId,
      this.locEttyId,
      this.feeId,
      required this.feeCtgry});

  final String? prgEttyId;
  final String? locEttyId;
  final String? feeId;
  final String feeCtgry;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiEnrlLocTadFeePlanList/queryasync',
        params: {
          'PrgEttyId': prgEttyId,
          'FeeId': feeId,
          'LocEttyId': locEttyId
        },
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
                    await showAcxDialog(
                        context,
                        AcxVwTxnPlanForm(
                          feeCtgry: feeCtgry,
                          hiddenFields: const {
                            "FeeId": null,
                            "LocEttyId": null,
                            "PrgEttyId": null
                          },
                          querySaveSql:
                              'ApiEnrlLocTadFeePlanSave',
                          query: QueryObject(
                              querysql: '/sp/ApiEnrlLocTadFeePlan/queryasync',
                              params: {
                                "PrgEttyId": prgEttyId,
                                "LocEttyId": locEttyId,
                                "FeeId": feeId,
                                "PlanId": null
                              },
                              showMsg: false),
                        ));

                    ref.invalidate(ReturndatafreezedProvider(query));
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
                      AcxVwTxnPlanForm(
                        hiddenFields: const {
                          "FeeId": null,
                          "LocEttyId": null,
                          "PrgEttyId": null
                        },
                        querySaveSql: 'ApiEnrlLocTadFeePlanSave',
                        query: QueryObject(
                            querysql: '/sp/ApiEnrlLocTadFeePlan/queryasync',
                            params: {
                              "PrgEttyId": prgEttyId,
                              "LocEttyId": locEttyId,
                              "FeeId": feeId,
                              "PlanId": null
                            },
                            showMsg: false),
                      ));

                  ref.invalidate(ReturndatafreezedProvider(query));
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
                        AcxVwTxnPlanForm(
                            hiddenFields: const {
                              "FeeId": null,
                              "LocEttyId": null,
                              "PrgEttyId": null
                            },
                            querySaveSql:
                                'ApiEnrlLocTadFeePlanSave',
                            query: QueryObject(
                                querysql: '/sp/ApiEnrlLocTadFeePlan/queryasync',
                                params: {
                                  "PrgEttyId": prgEttyId,
                                  "LocEttyId": locEttyId,
                                  "FeeId": feeId,
                                  "PlanId": currentData['PlanId'].toString()
                                },
                                showMsg: false)));
                  },
                  subtitle: SelectableText(
                      '${fmtDateStrShort(currentData['FromDate'])} to ${fmtDateStrShort(currentData['ToDate'])}'),
                  title: SelectableText(currentData['TxnPlanDscp'].toString()),
                  //  leading: ,
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
                            querysql: '/sp/ApiEnrlLocTadFeePlanDel/queryasync',
                            params: {
                              "PrgEttyId": currentData['PrgEttyId'],
                              "FeeId": currentData['FeeId'],
                              "PlanId": currentData['PlanId'],
                              "LocEttyId": currentData['LocEttyId']
                            },
                            showMsg: false);
                        await ref
                            .read(ReturndatafreezedProvider(queryDel).future)
                            .then((value) {
                          Toast.showresult(value);
                          ref.invalidate(ReturndatafreezedProvider(query));
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
