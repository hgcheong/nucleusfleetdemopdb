import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_libviewmultidisp.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=348;

@RoutePage()
class DataEntryPaymentTxn extends ConsumerWidget {
  const DataEntryPaymentTxn(
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
          title: const SelectableText('Payment  Transaction'),
        ),
        body: dataEntryForm(context, ref));
  }

  Widget dataEntryForm(BuildContext context, WidgetRef ref) {
    final dataEntryManualFormKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formNewValue = {
      "AcctId": null,
      "BillAmt": null,
      "DocNo": null,
      "Dscp": null,
      "LocNo": null,
      "RcptNo": null,
      "TxnAmt": null,
      "TxnDate": null,
      "TxnId": null,
      "TxnPlan": null,
      "TxnType": txnType
    };

    final querySql = QueryObject(
        querysql: '/sp/ApiMnlTxnPymt/queryasync',
        params: {"TxnId": convStrNewOrNullToNull(txnId), "TxnType": txnType},
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
                          const FbHiddenText(name: 'TxnId'),
                          const SelectableText('Transaction Info'),
                          FbLibViewMultiDisplay(
                            keyField: "AcctId",
                             params: {},
                            listsearchText: ['AcctNo', 'AcctHolder'],
                            name: 'AcctId',
                            label: 'Account',
                            querySql: '/sp/ApiAcctList/queryasync',
                            onClearPress: (){
                                  dataEntryManualFormKey.currentState!.save();
                                 dataEntryManualFormKey.currentState!.patchValue({
                                  "TxnPlan":null
                                 });
                                   ref.read(paymentAcctIdProvider.notifier).state = "";
                            },
                            returnSelectedRef: (val){
                                 dataEntryManualFormKey.currentState!.save();
                                 dataEntryManualFormKey.currentState!.patchValue({
                                  "TxnPlan":null
                                 });
                              ref.read(paymentAcctIdProvider.notifier).state = val["AcctId"].toString();
                            },
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                            var dacctId =   ref.watch(paymentAcctIdProvider);
                              if(dacctId == "null" || dacctId == ""  ){
    return Container();
   }
                           return   FbLibView(
                              keyField: "TxnPlan",
                              searchText: 'TxnPlanDscp',
                              name: 'TxnPlan',
                              label: 'Transaction Plan',
                              params: {"TxnType": txnType, "AcctId":dacctId.toString()},
                              querySql: '/sp/ApiMnlTxnTypePlanList/queryasync',
                            );
                            }
                          ),
                          const FbHiddenText(name: 'TxnType'),
                                    const FbHiddenText(name: 'LocNo'),
                                           FbText(
                              maxLines: 3,
                              name: 'Dscp', label: 'Transaction Description'),
                
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
                          FbHiddenText(name: 'BillAmt'),
                          FbNumber(name: 'TxnAmt', label: 'Transaction Amount'),
                                     Row(
                            children: [
                              Expanded(
                                  child: FbDateTimePicker(
                                      name: 'TxnDate', label: 'Date')),
                            ],
                          ),
                           FbText(name: 'DocNo', label: 'Ref Doc No.'),
            
                          FbNumber(name: 'RcptNo', label: 'Receipt No.'),
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
                              querysql: '/sp/ApiMnlTxnPymtSave/queryasync',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((Returndata value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              final outTxnId =
                                  getOutputValue(value.output, '@TxnId');
                              singleton<AppRouter>()
                                  .navigatePath(
                                '/dataentry/manual/$txnType/payment/$outTxnId',
                              )
                                  .then((val) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(querySql));
                              });
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


final paymentAcctIdProvider = StateProvider<String?>((ref) {
  return "";
});