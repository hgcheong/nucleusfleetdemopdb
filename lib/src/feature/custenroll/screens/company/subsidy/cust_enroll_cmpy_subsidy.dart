import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/helpers.dart';

const int wid=461;

@RoutePage()
class CustEnrollCmpySubsidy extends StatelessWidget {
  const CustEnrollCmpySubsidy(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
      @PathParam('quoId') this.quoId});

  final String? custEttyId;
  final String? cmpyEttyId;
  final String? quoId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return CustEnrollCompanySubsidyForm(
      cmpyEttyId: cmpyEttyId,
      custEttyId: custEttyId,
      quoId: quoId,
    );
  }
}

class CustEnrollCompanySubsidyForm extends ConsumerWidget {
  const CustEnrollCompanySubsidyForm({
    super.key,
    this.custEttyId,
    this.cmpyEttyId,
    this.quoId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;
  final String? quoId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final subVechFormKey = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiEnrlCmpySubs/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "CmpyEttyId": cmpyEttyId,
          "QuoId": convStrNewOrNullToNull(quoId),
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "CmpyEttyId": cmpyEttyId,
      "CustEttyId": custEttyId,
      "QuoId": convStrNewOrNullToNull(quoId),
      "SubsId": null,
      "SubsRefNo": null,
      "FromDate": null,
      "ToDate": null,
      "QuotaLimit": null,
      "RefreshCycle": null,
      "AllocationMethod": null,
      "Note": null,
      "MdfDate": null
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
            key: subVechFormKey,
            initialValue: formNewValue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbw54,
                Expanded(
                    flex: 5,
                    child: ListView(
                      children: [
                        const FbHiddenText(name: 'CmpyEttyId'),
                        const FbHiddenText(name: 'CustEttyId'),
                        const FbHiddenText(name: 'QuoId'),
                        const FbHiddenDateTime(name: 'MdfDate'),
                        // SizedBox(
                        //   height: 50,
                        //   child: FbLibView(
                        //     name: 'SubsId',
                        //     initialValue: formNewValue["SubsId"],
                        //     label: 'Subsidy Program',
                        //     params: const {},
                        //     keyField: 'SubsId',
                        //     searchText: 'Dscp',
                        //     querySql: '/view/async/VwSubsSubsidy',
                        //   ),
                        // ),
                        const FbText(
                            name: 'SubsRefNo', label: 'Subsidy Number'),
                        const FbText(
                          name: 'Note',
                          label: 'Note',
                          maxLines: 5,
                        ),
                        const Row(
                          children: [
                            Flexible(
                                child: FbDateTimePicker(
                                    name: 'FromDate', label: 'FromDate')),
                            Flexible(
                              child: FbDateTimePicker(
                                name: 'ToDate',
                                label: 'To Date',
                              ),
                            )
                          ],
                        ),
                        const FbText(name: 'QuotaLimit', label: 'Quota Limit'),
                        FbLibref(
                            name: 'RefreshCycle',
                            initialValue: formNewValue["QUOTACYCLE"],
                            label: 'Quota Refresh Period',
                            params: const {
                              "RefType": "QUOTACYCLE",
                              "BitInd": null
                            }),
                        const FbOption(
                            name: 'AllocationMethod',
                            label: 'Quota Allocation',
                            params: {
                              "RefType": "QUOTAALLOCATE",
                              "BitInd": null
                            })
                      ],
                    )),
                Expanded(
                    flex: 5,
                    child: CustEnrollCmpySubsidyVehcList(
                      custEttyId: custEttyId,
                      cmpyEttyId: cmpyEttyId,
                      quoId: quoId,
                    )),
                Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        AcxSaveButtonManual(
                          onSave: () {
                                   if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                            subVechFormKey.currentState!.save();
                            final quoId =
                                subVechFormKey.currentState!.value['QuoId'];
                            subVechFormKey.currentState!.patchValue(
                                {'QuoId': quoId == '' ? null : quoId});
                            Map<String, dynamic> toPost =
                                convertFormValueToSave(
                                    subVechFormKey.currentState!.value,
                                    theData.columnInfo);
                            final querySave = QueryObject(
                                querysql: '/sp/ApiEnrlCmpySubsSave/queryasync?logId=${convStrNewOrNullToNull(cmpyEttyId) ?? 0}',
                                params: toPost,
                                showMsg: false);

                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((value) {
                              Toast.showresult(value);
                              if (isSuccess(value.message)) {
                                String theNewId =
                                    getOutputValue(value.output, '@QuoId')
                                        .toString();
                                singleton<AppRouter>()
                                    .navigatePath(
                                        '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/subsidy/quotadtl/$theNewId')
                                    .then((val) {
                                  ref.invalidate(
                                      ReturndatafreezedProvider(query));
                                });
                              }
                            });
                          },
                        ),
                        AcxBackToList(
                            listUrl:
                                '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/subsidy/quota'),
                                AcxAuditLogReqBtn('ApiEnrlCmpySubsSave',ettyId: cmpyEttyId.toString(),)
                      ],
                    ))
              ],
            ),
          );
        });
  }
}

class CustEnrollCmpySubsidyVehcList extends ConsumerWidget {
  const CustEnrollCmpySubsidyVehcList({
    super.key,
    this.custEttyId,
    this.cmpyEttyId,
    this.quoId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;
  final String? quoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiEnrlCmpySubsVhcList/queryasync',
        params: {
          'CustEttyId': custEttyId,
          'CmpyEttyId': cmpyEttyId,
          'QuoId': convStrNewOrNullToNull(quoId)
        },
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));
    const hdrText = SelectableText('List of Vehicle entitled for Subsidy');

    return AsyncValueWidget(
        value: listData,
        data: (srcData) {
          if (srcData.data == null) {
            return const SizedBox(
                height: 300,
                child: Expanded(child: SelectableText('No Record ')));
          }
          if (srcData.data![0]['QuoId'] == null) {
            return ListView(
              children: [
                hdrText,
                sbh20,
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          //   await showVehcForm(context, srcData.data![0], quoId);
                          //     ref.invalidate(ReturndatafreezedProvider(query));
                          // },
                          await showAcxDialog(
                            context,
                            CustEnrollCmpySubsidyVehcForm(
                              quotaLimit:
                                  srcData.data![0]['QuotaLimit'].toString(),
                              custEttyId: custEttyId.toString(),
                              cmpyEttyId: cmpyEttyId.toString(),
                              mbrEttyId: convStrNewOrNullToNull(
                                  srcData.data![0]['MbrEttyId'].toString()),
                              quoId: quoId,
                              vhcRgsNo: convStrNewOrNullToNull(
                                  srcData.data![0]['VhcRgsNo'].toString()),
                              vhcId: convStrNewOrNullToNull(
                                  srcData.data![0]['VhcId'].toString()),
                            ),
                          );
                        },
                        child: const Icon(Icons.post_add)),
                  ],
                ),
                const SelectableText('No Vehicle setup'),
                // SizedBox(
                //     height: 100,
                //     child: ListView(
                //       children: const [SelectableText('No Record')],
                //     ))
              ],
            );
          }

          return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hdrText,

                ElevatedButton(
                    onPressed: () async {
                      //   await showVehcForm(context, {'CustEttyId': custEttyId, 'CmpyEttyId': cmpyEttyId, 'QuoId': convStrNewOrNullToNull(quoId)}, quoId);
                      await showAcxDialog(
                          context,
                          CustEnrollCmpySubsidyVehcForm(
                            custEttyId: custEttyId.toString(),
                            cmpyEttyId: cmpyEttyId.toString(),
                            quoId: convStrNewOrNullToNull(
                                srcData.data![0]['QuoId'].toString()),
                            vhcId: null,
                            quotaLimit: null,
                          ));
                      ref.invalidate(ReturndatafreezedProvider(query));
                    },
                    child: const Icon(Icons.post_add)),
                // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
                const Divider(),
                const Row(
                  children: [
                    Expanded(child: SelectableText("Vehicle Reg. Number")),
                    Expanded(child: SelectableText("Quota Limit")),
                    Spacer()
                  ],
                ),
                const Divider(),
                SizedBox(
                  height: 300,
                  child: srcData.data![0]['VehicleRegisteredNo'] == null
                      ? const SelectableText('No record')
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: srcData.rowcount!,
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemBuilder: (context, index) {
                            final currentData = srcData.data![index];
                            return ListTile(
                              //         onTap: () async {
                              // //          await showAcxDialog(context, CustEnrollCmpySubsidyVehcForm(
                              // //   quotaLimit: currentData['QuotaLimit'].toString(),
                              // //   custEttyId: custEttyId.toString(),
                              // //   cmpyEttyId: cmpyEttyId.toString(),
                              // //   mbrEttyId: convStrNewOrNullToNull(currentData['MbrEttyId'].toString()),
                              // //   quoId: quoId,
                              // //   vhcRgsNo: convStrNewOrNullToNull(currentData['VhcRgsNo'].toString()),
                              // //   vhcId: convStrNewOrNullToNull(currentData['VhcId'].toString()),
                              // // ) );
                              //         },
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: SelectableText(
                                          '${currentData['VehicleRegisteredNo']}')),
                                  Expanded(
                                      child: SelectableText(
                                          '${currentData['QuotaLimit']} ')),
                                  Expanded(
                                      child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      bool confirmed = await ConfirmDialog.show(
                                          title:
                                              'Are you Sure to delete the record?');

                                      if (confirmed) {
                                        final queryDel = QueryObject(
                                            querysql:
                                                '/sp/ApiEnrlCmpySubsVhcDel/queryasync',
                                            params: {
                                              "CustEttyId": custEttyId,
                                              "CmpyEttyId": cmpyEttyId,
                                              "QuoId": quoId,
                                              "VhcRgsNo": currentData[
                                                  'VehicleRegisteredNo']
                                            },
                                            showMsg: false);
                                        final resultDel = ref.read(
                                            ReturndatafreezedProvider(queryDel)
                                                .future);
                                        resultDel.then((value) {
                                          ref.invalidate(
                                              ReturndatafreezedProvider(query));
                                          Toast.showresult(value);
                                        });
                                      }
                                    },
                                  )),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ]);
        });
  }
}

class CustEnrollCmpySubsidyVehcForm extends ConsumerWidget {
  const CustEnrollCmpySubsidyVehcForm({
    super.key,
    this.custEttyId,
    this.cmpyEttyId,
    this.quoId,
    this.quotaLimit,
    this.vhcRgsNo,
    this.vhcId,
    this.mbrEttyId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;
  final String? quoId;
  final String? quotaLimit;
  final String? vhcRgsNo;
  final String? vhcId;
  final String? mbrEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "CustEttyId": custEttyId,
      "CmpyEttyId": cmpyEttyId,
      "MbrEttyId": mbrEttyId,
      "QuoId": quoId,
      "VhcId": vhcId,
      "VhcRgsNo": vhcRgsNo,
      "QuotaLimit": quotaLimit,
      "VhcSts": "A",
    };

    final queryPlanListForm = QueryObject(
        querysql: '/sp/ApiEnrlCmpySubsVhc/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "CmpyEttyId": cmpyEttyId,
          "QuoId": quoId,
          "VhcRgsNo": vhcRgsNo,
          "MbrEttyId": mbrEttyId
        },
        showMsg: false);

    final formDataPlanListForm =
        ref.watch(ReturndatafreezedProvider(queryPlanListForm));

    final queryVehcSearch = QueryObject(
        querysql: '/sp/ApiEnrlCmpySubsVhcSearch/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "CmpyEttyId": cmpyEttyId,
          "QuoId": quoId
        },
        showMsg: false);

    final queryVehcsSDsrc =
        ref.watch(returndatafreezedProvider(queryVehcSearch));

    return AsyncValueWidget<Returndata>(
        value: formDataPlanListForm,
        data: (theData) {
          return AsyncValueWidget(
            value: queryVehcsSDsrc,
            data: (listData) {
              if (theData.data != null) {
                formValue = convertFormValueToDisplay(
                    theData.data![0] as Map<String, dynamic>,
                    theData.columnInfo);
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FbHiddenText(name: 'CustEttyId'),
                            const FbHiddenText(name: 'CmpyEttyId'),
                            const FbHiddenText(name: 'VhcSts'),
                            const FbHiddenText(name: 'QuoId'),
                            const FbHiddenText(name: 'MbrEttyId'),
                            FbLibViewExt(
                              name: 'VhcRgsNo',
                              label: 'Vehicle Registration Number',
                              keyField: 'VhcRgsNo',
                              searchText: 'VhcDscp',
                              initialValue: vhcRgsNo,
                              returnSelectedRef: (Map<String, dynamic> rev) {
                                formKeyPlan.currentState!.patchValue(
                                    {'MbrEttyId': rev['MbrEttyId'].toString()});
                              },
                              datasrc: listData,
                            ),
                            // FbText(name: 'VhcRgsNo', label: 'Vehicle Registration Number'),
                            const FbNumber(
                                name: 'QuotaLimit', label: 'Quota Limit'),
                          ],
                        ),
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
                                  final quoId =
                                      formKeyPlan.currentState!.value['quoId'];
                                  formKeyPlan.currentState!.patchValue(
                                      {'QuoId': quoId == '' ? null : quoId});

                                  final querySave = QueryObject(
                                      querysql:
                                          '/sp/ApiEnrlCmpySubsVhcSave/queryasync?logId=${convStrNewOrNullToNull(cmpyEttyId) ?? 0}',
                                      params: formKeyPlan.currentState!.value,
                                      showMsg: false);

                                  final saveResult = ref.read(
                                      ReturndatafreezedProvider(querySave)
                                          .future);
                                  saveResult.then((value1) {
                                    Toast.showresult(value1);
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
                              ),
                                   sbh10,
                              AcxAuditLogReqBtn('ApiEnrlCmpySubsVhcSave', ettyId: cmpyEttyId.toString(),)
                              
                            ],
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
