import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/shared/acx_txn_plan_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=143;
@RoutePage()
class PrgMgmtMchtTpTrans extends ConsumerWidget {
  const PrgMgmtMchtTpTrans({
    super.key,
    @PathParam('msgTypePlanId') this.msgTypePlanId,
    @PathParam('txnMsgCd') this.txnMsgCd,
    @PathParam('poe') this.poe,
    @PathParam.inherit('locEttyId') this.locEttyId,
    @PathParam.inherit('prgEttyId') this.prgEttyId,
  });

  final String? msgTypePlanId;
  final String? txnMsgCd;
  final String? poe;
  final String? locEttyId;
  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return McMgmtLocPrgTpForm(
        prgEttyId: prgEttyId,
        locEttyId: locEttyId,
        poe: convStrNewOrNullToNull(poe),
        txnMsgCd: convStrNewOrNullToNull(txnMsgCd),
        msgTypePlanId: convStrNewOrNullToNull(msgTypePlanId));
  }
}

class McMgmtLocPrgTpForm extends ConsumerWidget {
  const McMgmtLocPrgTpForm({
    super.key,
    this.prgEttyId,
    this.msgTypePlanId,
    this.locEttyId,
    this.poe,
    this.txnMsgCd,
  });

  final String? prgEttyId;
  final String? msgTypePlanId;
  final String? locEttyId;
  final String? poe;
  final String? txnMsgCd;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mcMgmtprgtxnTp = GlobalKey<FormBuilderState>();
    final query = QueryObject(
        querysql: '/sp/ApiPrgMchtTxnPlan/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "MsgTypePlanId": msgTypePlanId,
          "TxnMsgCd": txnMsgCd,
          "Poe": poe,
          "SrcPrvder": null
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
              key: mcMgmtprgtxnTp,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            FbHiddenText(name: 'PrgEttyId'),
                            FbHiddenText(name: 'Poe'),
                            FbHiddenDateTime(name: 'MdfDate'),
                            FbHiddenText(name: 'TxnType'),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectableText('Txn Plan'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const FbLibView(
                          name: 'TxnMsgCd',
                          label: 'Message Type',
                          params: {},
                          keyField: 'TxnMsgCd',
                          searchText: 'Dscp',
                          querySql: '/view/async/VwTxnMsgType',
                        ),
                        FbLibView(
                          name: 'SrcPrvder',
                          label: 'Source Provider',
                          params: const {},
                          keyField: 'RefCd',
                          searchText: 'Dscp',
                          querySql: '/view/async/VwSrcPrvder',
                          returnSelectedRef: (val) {
                            mcMgmtprgtxnTp.currentState!
                                .patchValue({"Poe": val['Poe'].toString()});
                          },
                        ),
                        FbLibView(
                          name: 'DealerType',
                          label: 'Dealer Type',
                          params: const {},
                          keyField: 'RefCd',
                          searchText: 'Dscp',
                          querySql: '/view/async/VwDealerType',
                          initialValue: formNewValue['DealerType'],
                        )
                      ],
                    ),
                  ),
                  msgTypePlanId == null
                      ? const Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: 300,
                            child: SelectableText('No Fee Plan'),
                          ))
                      : Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: 300,
                            child: AcxTxnPlanList(
                              feeCtgry: formNewValue['TxnType'],
                              listTitlefield: 'TxnPlanDscp',
                              diaLoghiddenFields: const {
                                "PrgEttyId": null,
                                "MsgTypePlanId": null,
                                "Poe": null
                              },
                              diaLogquerySaveSql:
                                  '/sp/ApiPrgMchtTxnPlanFeeSave/queryasync',
                              dialogqueryRetrieveSql:
                                  '/sp/ApiPrgMchtTxnPlanFee/queryasync',
                              dialogParams: {
                                "PrgEttyId": prgEttyId,
                                "MsgTypePlanId": msgTypePlanId,
                                "Poe": poe,
                                "PlanId": null
                              },
                              listquery: QueryObject(
                                  querysql:
                                      '/sp/ApiPrgMchtTxnPlanFeeList/queryasync',
                                  params: {
                                    'MsgTypePlanId': msgTypePlanId,
                                    'PrgEttyId': prgEttyId,
                                  },
                                  showMsg: false),
                            ),
                          )),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        AcxSaveButtonManual(onSave: () {
                            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          mcMgmtprgtxnTp.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(mcMgmtprgtxnTp.currentState!.value),
                              theData.columnInfo);
                          toPost.remove('TxnType');
                          final saveResult = ref.read(ReturndatafreezedProvider(
                                  QueryObject(
                                      querysql:
                                          '/sp/ApiPrgMchtTxnPlanSave/queryasync?logId=${convStrNewOrNullToNull(locEttyId) ?? 0}',
                                      params: toPost,
                                      showMsg: false))
                              .future);
                          saveResult.then((Returndata value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              var omsgTypePlanId = getOutputValue(
                                  value.output, '@MsgTypePlanId');
                              var otxnMsgCd =
                                  getOutputValue(value.output, '@TxnMsgCd');
                              var oPoe =
                                  getOutputValueStr(value.output, '@Poe');

                              singleton<AppRouter>()
                                  .navigatePath(
                                      '/prgmgmt/mchtsetup/$prgEttyId/tranplan/tp/dtl/$oPoe/$otxnMsgCd/$omsgTypePlanId')
                                  .then((val) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                              });
                            }
                          });
                        }),
                        AcxBackToList(
                          listUrl:
                              '/prgmgmt/mchtsetup/$prgEttyId/tranplan/tp/list',
                        ),
                    AcxAuditLogReqBtn('ApiPrgMchtTxnPlanSave',ettyId: locEttyId.toString(),)
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
