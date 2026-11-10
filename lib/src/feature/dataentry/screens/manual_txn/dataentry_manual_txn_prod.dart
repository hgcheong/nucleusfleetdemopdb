import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=345;

@RoutePage()
class DataEntryManualTxnDtlProd extends ConsumerWidget {
  const DataEntryManualTxnDtlProd({
    super.key,
    @PathParam('txnId') this.txnId,
    @PathParam('prdId') this.prdId,
  });

  final String? txnId;
  final String? prdId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, centerTitle: false,
          title: const SelectableText('Product Details'),
        ),
        body: dataEntryForm(context, ref));
  }

  Widget dataEntryForm(BuildContext context, WidgetRef ref) {
    final dataEntryManualFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formNewValue = {
      "PrdCd": null,
      "TxnAmt": null,
      "BillAmt": null,
      "TaxAmt": null,
      "TaxCd": null,
      "Dscp": null,
      "Qty": null,
      "UnitPrice": null,
      "TxnId": convStrNewOrNullToNull(txnId),
      "PrdId": convStrNewOrNullToNull(prdId)
    };

    final querySql = QueryObject(
        querysql: '/sp/ApiMnlTxnItem/queryasync',
        params: {
          "PrdId": convStrNewOrNullToNull(prdId),
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
                  const Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText('Product Info'),
                          // FbLibView(
                          //   keyField: "TxnPlan",
                          //   searchText: 'TxnPlanDscp',
                          //   name: 'TxnPlan',
                          //   label: 'Transaction Type',
                          //   params: {},
                          //   querySql: '/view/async/VwProduct',
                          // ),
                          FbHiddenText(name: 'TxnId'),
                          FbHiddenText(name: 'PrdId'),
                          FbLibView(
                              name: 'PrdCd',
                              label: 'Product Code',
                              params: {},
                              keyField: 'PrdCd',
                              searchText: 'PrdDscp',
                              querySql: '/view/async/vwlibprd'),
                          FbText(name: 'TxnAmt', label: 'Transaction Amount'),
                          FbText(name: 'BillAmt', label: 'Bill Amount'),
                          FbText(name: 'TaxAmt', label: 'Tax Amt'),
                          FbLibView(
                              name: 'TaxCd',
                              label: 'Tax Code',
                              params: {},
                              keyField: 'TaxCd',
                              searchText: 'Dscp',
                              querySql: '/view/async/vwtaxcd'),
                          FbText(name: 'Dscp', label: 'Description'),
                          // Row(
                          //   children: [
                          //     Expanded(child: FbDateTimePicker(name: 'TxnDate', label: 'TxnDate')),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // FbText(name: 'TxnId', label: 'Transaction ID'),
                          SelectableText(''),
                          FbNumber(name: 'Qty', label: 'Qty'),
                          FbText(name: 'UnitPrice', label: 'Unit Price'),
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
                              dataEntryManualFormKey.currentState!.value,
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiMnlTxnItemSave/queryasync',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);

                          saveResult.then((Returndata value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              ///custenroll/cmpy/16/detail/36/profile/geninfo
                              ///
                              // final outTxnId = getOutputValue(value.output, '@PrdId');

                              // singleton<AppRouter>().navigatePath(
                              //   '/dataentry/manual/dtl/$outTxnId',
                              // );
                            }
                          });
                        },
                      ),
                      AcxBackToList(
                          listUrl:
                              '/dataentry/manual/item/${txnId.toString()}'),
                      AcxAuditLogReqBtn('ApiMnlTxnItemSave')
                      //dataentry/manual/item/100
                    ]),
                  )
                ],
              ),
            ));
      },
    );
  }
}
