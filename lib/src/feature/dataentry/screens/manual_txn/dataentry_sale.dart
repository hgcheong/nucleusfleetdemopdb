import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=353;

@RoutePage()
class DataEntrySaleTxn extends ConsumerWidget {
  const DataEntrySaleTxn(
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
          
          title: const SelectableText('Manual Sale Transaction'),
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
      "TxnId": null,
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
            child: ListView(children: [
              Row(
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
                              singleton<AppRouter>()
                                  .navigatePath(
                                      '/dataentry/manual/$txnType/sale/$outTxnId')
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
                      AcxAuditLogReqBtn('ApiMnlTxnSave',)
                    ]),
                  )
                ],
              ),
              txnId == null || txnId == 'new'
                  ? Container()
                  : AcxTrinaGridWithColumn(
                      querysql: '/sp/ApiMnlTxnItemList/queryasync',
                      spName: 'ApiMnlTxnItemList',
                      params: {"TxnId":  convStrNewOrNullToNull(txnId)},
                      idField: 'PrdId',
                      useNav: false,
                      actionItems: [
                        Row(
                          children: [
                            AppButton(
                              onPressed: () async {
                                final selectedRow = ref
                                    .read(globalPlutoSelectedRow.notifier)
                                    .state;
                                if (selectedRow.cells.containsKey('PrdId')) {
                                  if (selectedRow.cells['PrdId'] == null) {
                                    Toast.message('Please select row');
                                  }
                                  final updateQuery = QueryObject(
                                      querysql: 'ApiMnlTxnItemDel',
                                      params: {
                                        "TxnId": txnId,
                                        "PrdId":
                                            selectedRow.cells['PrdId']!.value,
                                        "PrdCd": selectedRow
                                            .cells['ProductCode']!.value,
                                      },
                                      showMsg: false);
                                  final queryRes = ref.watch(
                                      ReturndatafreezedProvider(updateQuery));
                                  queryRes.when(
                                      data: (theData) {
                                        Toast.showresult(theData);
                                      },
                                      error: (error, stackTrace) {
                                        //  Toast.error('Possible missing TxnId')
                                        Toast.error(error.toString());
                                      },
                                      loading: () =>
                                          const CircularProgressIndicator());
                                }
                              },
                              icon: Icons.delete,
                              label: "Delete",
                            ),
                          ],
                        ),
                        //   Row(children: [AppButton(
                        //         onPressed: () async {
                        //       bool confirmed = await ConfirmDialog.show(title: 'Are you sure you want to Process the Pukal File?');
                        //       if(confirmed){

                        //       }

                        //         },
                        //         icon: Icons.check_outlined,
                        //         label: "Process",

                        //       ),     AppButton(
                        //         onPressed: ()async {
                        //       bool confirmed = await ConfirmDialog.show(title: 'Are you sure you want to Cancel the Pukal File');
                        //       if(confirmed){

                        //       }
                        //         },
                        //         icon: Icons.cancel_outlined,
                        //         label: "Reject",

                        //       ),],),
                      ],
                      showActions: true,
                      onSelectedTap: (TrinaRow val) async {
                        await showAcxDialog(
                            context,
                            AddProductDialog(
                              txnId: txnId.toString(),
                              prdId: val.cells['PrdId']!.value.toString(),
                            ));
                        ref.invalidate(ReturndatafreezedProvider(querySql));
                      },
                      onNew: () async {
                          if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                        await showAcxDialog(
                            context,
                            AddProductDialog(
                              txnId: txnId.toString(),
                              prdId: null,
                            ));

                        ref.invalidate(ReturndatafreezedProvider(querySql));
                      },
                    )
            ]));
      },
    );
  }
}

class AddProductDialog extends ConsumerWidget {
  const AddProductDialog({
    super.key,
    this.prdId,
    this.txnId,
  });

  final String? prdId;
  final String? txnId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final prdAddKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "PrdCd": null,
      "TxnAmt": null,
      "BillAmt": null,
      "TaxAmt": null,
      "TaxCd": null,
      "Dscp": null,
      "Qty": null,
      "UnitPrice": null,
      "PrdId": prdId,
      "TxnId": txnId,
    };

    final query = QueryObject(
        querysql: '/sp/ApiMnlTxnItem/queryasync',
        params: {
          "PrdId": prdId,
          "TxnId": txnId,
        },
        showMsg: false);

    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          if (theData.data != null) {
            formValue =
                convertFormValueToDisplay(theData.data![0], theData.columnInfo);
          }
          return FormBuilder(
            key: prdAddKey,
            initialValue: formValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8, left: 8),
                  child: SelectableText(
                    'Product Info',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 11,
                          child: Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ListView(
                                    children: const [
                                      FbHiddenText(name: 'TxnId'),
                                      FbHiddenText(name: 'PrdId'),
                                      FbHiddenText(name: 'BillAmt'),
                                      // FbText(
                                      //   name: 'Dscp',
                                      //   label: 'Description',
                                      //   initialValue: formValue['Dscp']?? '',
                                      //   readOnly: true,
                                      // ),

                                      ListTile(
                                          title: FbLibView(
                                              name: 'PrdCd',
                                              label: 'Product',
                                              params: {},
                                              keyField: 'PrdCd',
                                              searchText: 'PrdDscp',
                                              querySql:
                                                  '/view/async/vwlibprd')),

                                      ListTile(
                                          title: FbText(
                                        name: 'Dscp',
                                        label: 'Description',
                                      )),
                                      ListTile(
                                        title:
                                            FbNumber(name: 'Qty', label: 'Qty'),
                                      ),
                                      ListTile(
                                        title: FbNumber(
                                            name: 'UnitPrice',
                                            label: 'Unit Price'),
                                      ),
                                      ListTile(
                                        title: FbLibView(
                                            name: 'TaxCd',
                                            label: 'Tax Code',
                                            params: {},
                                            keyField: 'RefCd',
                                            searchText: 'Dscp',
                                            querySql: '/view/async/vwtaxcd'),
                                      ),
                                      ListTile(
                                        title: FbNumber(
                                            name: 'TaxAmt',
                                            label: 'Tax Amount'),
                                      ),
                                      ListTile(
                                        title: FbNumber(
                                          name: 'TxnAmt',
                                          label: 'Transaction Amount',
                                          readOnly: false,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            AcxSaveButtonManual(onSave: () {
                                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                              prdAddKey.currentState!.save();
                              var toPost = prdAddKey.currentState!.value;
                              final querySave = QueryObject(
                                  querysql: '/sp/ApiMnlTxnItemSave/queryasync',
                                  params: toPost,
                                  showMsg: false);
                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((Returndata value) {
                                Toast.showresult(value);
                                if (isSuccess(value.message)) {}
                              });
                            }),
                            sbh10,
                            AcxAuditLogReqBtn('ApiMnlTxnItemSave',),
                            sbh10,
                            ElevatedButton(
                                onPressed: () {
                                  singleton<AppRouter>().maybePop();
                                },
                                child: const Icon(Icons.exit_to_app))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
