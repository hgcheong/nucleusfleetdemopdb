import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=340;

@RoutePage()
class DataEntryManualTxn extends ConsumerWidget {
  const DataEntryManualTxn(
      {super.key,
      @PathParam('txnId') this.txnId,
      @PathParam.inherit('txnType') this.txnType});

  final String? txnId;
  final String? txnType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, centerTitle: false,
          title: SelectableText('$txnType Transaction'),
        ),
        body: dataEntryForm(context, ref));
  }

  Widget dataEntryForm(BuildContext context, WidgetRef ref) {
    final dataEntryManualFormKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formNewValue = {
      "AuthCd": null,
      "AuthMediaNo": null,
      "BillAmt": null,
      "CrExpDate": null,
      "DocNo": null,
      "Dscp": null,
      "LocNo": null,
      "MediaNo": null,
      "OdmReading": null,
      "RcptNo": null,
      "Rrn": null,
      "Stan": null,
      "TadNo": null,
      "TxnAmt": null,
      "TxnDate": null,
      "TxnId": convStrNewOrNullToNull(txnId),
      "TxnPlan": null,
      "TxnSts": null,
      "TxnTime": null
    };

    final querySql = QueryObject(
        querysql: '/sp/ApiMnlTxn/queryasync',
        params: {
          "TxnId": convStrNewOrNullToNull(txnId),
        },
        showMsg: false);

    final formData = ref.watch(ReturndatafreezedProvider(querySql));

    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: dataEntryManualFormKey,
            initialValue: formNewValue,
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText('Transaction Info'),
                          FbLibView(
                            keyField: "TxnPlan",
                            searchText: 'TxnPlanDscp',
                            name: 'TxnPlan',
                            label: 'Transaction Plan',
                            params: {"TxnType": txnType},
                            querySql: '/sp/ApiMnlTxnTypePlanList/queryasync',
                          ),
                          const FbNumber(name: 'MediaNo', label: 'Media No.'),
                          const FbNumber(
                              name: 'AuthMediaNo', label: 'Auth Media No.'),
                          const FbText(name: 'AuthCd', label: 'Auth Code'),
                                     const FbHiddenText(name: 'LocNo'),
                          const FbText(name: 'TadNo', label: 'TAD Number'),
                          const Row(
                            children: [
                              Expanded(
                                  child: FbDateTimePicker(
                                      name: 'TxnDate', label: 'TxnDate')),
                            ],
                          ),
                          const FbText(name: 'DocNo', label: 'Ref Doc No.'),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           SelectableText(' '),
                          FbHiddenText(name: 'TxnId'),
                          FbNumber(name: 'TxnAmt', label: 'Transaction Amount'),
                          FbText(
                              name: 'Dscp', label: 'Transaction Description'),
                          //  FbText(name: 'TxnSts', label: 'Transaction Status'),
                          FbLibView(
                              name: 'TxnSts',
                              label: 'Trnsaction Status',
                              params: {},
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/view/async/VwTxnSts'),
                          FbNumber(name: 'RcptNo', label: 'Receipt No.'),
                          FbNumber(name: 'OdmReading', label: 'Odm Reading'),
                          FbNumber(name: 'Stan', label: 'Stan'),
                          FbText(
                              name: 'Rrn', label: 'Retrieval Reference Number'),
                          Row(
                            children: [
                              Expanded(
                                  child: FbTimePicker(
                                      name: 'TxnTime',
                                      label: 'Transaction Time')),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      AcxSaveButtonManual(
                        onSave: () {
                            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          dataEntryManualFormKey.currentState!.save();

                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(
                                  dataEntryManualFormKey.currentState!.value),
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiMnlTxnSave/queryasync',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((Returndata value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              final outTxnId =
                                  getOutputValue(value.output, '@TxnId');
                              singleton<AppRouter>().navigatePath(
                                '/dataentry/manual/$txnType/dtl/$outTxnId',
                              );
                            }
                          });
                        },
                      ),
                      sbh10,
                      AcxBackToList(listUrl: '/dataentry/manual/$txnType/list'),
                                      sbh10,
                      AcxAuditLogReqBtn('ApiMnlTxnPymtSave',)
                    ]),
                  )
                ],
              ),
            ));
      },
    );
  }
}
