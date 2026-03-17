import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/dataentry/screens/manual_txn/dataentry_manual_provider.dart';
import 'package:nucleusv2/src/feature/dataentry/screens/pukal/pukal_prcs_date_dialog.dart';
import 'package:nucleusv2/src/feature/dataentry/screens/pukal/pukal_txn_detail_dialog.dart';
import 'package:nucleusv2/src/utils/helpers.dart';

import 'package:trina_grid/trina_grid.dart';

const int wid=344;

@RoutePage()
class DataEntryManualTxnList extends ConsumerWidget {
  const DataEntryManualTxnList({super.key, @PathParam('txnType') this.txnType});

//    "CId": 0,
//  "TxnPlan":0,

  final String? txnType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    switch (txnType) {
      case "PUKAL":
        final queryPukalTxn = QueryObject(
            querysql: '/sp/ApiMnlTxnPukalList/queryasync',
            params: {"TxnType": txnType},
            showMsg: false);
        final queryPukalData =
            ref.watch(ReturndatafreezedProvider(queryPukalTxn));
        return AsyncValueWidget(
            value: queryPukalData,
            data: (theData) {
              return Scaffold(
                body: Column(
                  children: [
                    Expanded(
                      child: AcxTrinaGridExtDataCheckBox(
                        spName: 'ApiMnlTxnPukalList',
                        idField: 'TxnId',
                        appButtons: [
                          // AppButtonWithFunction(
                          //     btn: const AppButton(
                          //       icon: Icons.file_copy,
                          //       label: "Show Source",
                          //     ),
                          //     func: (ValueNotifier<Set<TrinaRow>> val) {
                          //       singleton<AppRouter>().navigatePath(
                          //           '/dataentry/manual/$txnType/pukalfiles/in');
                          //     }),
                          AppButtonWithFunction(
                              btn: const AppButton(
                                icon: Icons.check_outlined,
                                label: "Process",
                              ),
                              func: (ValueNotifier<Set<TrinaRow>> val) async {
                                var rows = val.value;
                                if (rows.isEmpty) {
                                  Toast.message('Please check item to process');
                                  return;
                                }
                                if (context.mounted) {
                                  var dlgResPrcsDate = await showAcxDialog(
                                      context, const PukalProcessDateDialog());
                                  if (dlgResPrcsDate != null) {
                                    var prcDate = convertFormDateValue(
                                        dlgResPrcsDate, ['PrcsDate']);
                                    pukalSave(
                                        'A', ref, rows, prcDate, queryPukalTxn);
                                  }
                                }
                              }),
                          AppButtonWithFunction(
                              btn: const AppButton(
                                icon: Icons.cancel_outlined,
                                label: "Reject",
                              ),
                              func: (ValueNotifier<Set<TrinaRow>> val) async {
                                var rows = val.value;
                                if (rows.isEmpty) {
                                  Toast.message('Please check item to process');
                                  return;
                                }
                                bool confirmed = await ConfirmDialog.show(
                                    title:
                                        'Are you sure you want to Cancel the Pukal File');
                                if (confirmed) {
                                  pukalRej('X', ref, rows, queryPukalTxn);
                                }
                              }),
                        ],
                      
                        onSelectedTap: (TrinaRow val) {
                          // // ref.read(dataentryTxnIdProvider.notifier).state = '0';
                          // // singleton<AppRouter>().navigatePath('/dataentry/manual/$txnType/dtl/${val.cells['TxnId']!.value.toString()}');
                      
                          showAcxDialog(
                              context,
                              PukalTxnDetailDialog(
                                txnId: val.cells['TxnId']!.value.toString(),
                                acctId: val.cells['AcctId']!.value.toString(),
                              ));
                        },
                        extData: theData,

                      ),
                    )
                  ],
                ),
                appBar: AppBar(
                  actions: [
                    AcxBackToList(listUrl: '/dataentry/main')
                  ],
                  title: SelectableText(txnType.toString()),
                  automaticallyImplyLeading: true, centerTitle: false,
                ),
              );
            });

      default:
        return Scaffold(
          body: ListView(
            children: [
              AcxTrinaGridWithColumn(
                querysql: '/sp/ApiMnlTxnList/queryasync',
                spName: 'ApiMnlTxnList',
                params: {"TxnType": txnType},
                idField: 'TxnId',
                useNav: false,
                onSelectedTap: (TrinaRow val) {
                  //  ref.read(dataentryTxnIdProvider.notifier).state = '0';
                  switch (txnType) {
                    case 'PAYMENT':
                      // ref.read(dataentryTxnIdProvider.notifier).state = '0';
                      singleton<AppRouter>().navigatePath(
                          '/dataentry/manual/$txnType/payment/${val.cells['TxnId']!.value.toString()}');
                      break;
                    case 'SALE':
                      // ref.read(dataentryTxnIdProvider.notifier).state = '0';
                      singleton<AppRouter>().navigatePath(
                          '/dataentry/manual/$txnType/sale/${val.cells['TxnId']!.value.toString()}');
                      break;
                    case 'ADJUST':
                      // ref.read(dataentryTxnIdProvider.notifier).state = '0';
                      singleton<AppRouter>().navigatePath(
                          '/dataentry/manual/$txnType/adjust/${val.cells['TxnId']!.value.toString()}');
                      break;
                    case 'FEE':
                      // ref.read(dataentryTxnIdProvider.notifier).state = '0';
                      singleton<AppRouter>().navigatePath(
                          '/dataentry/manual/$txnType/fee/${val.cells['TxnId']!.value.toString()}');
                      break;
                    default:
                      singleton<AppRouter>().navigatePath(
                          '/dataentry/manual/$txnType/dtl/${val.cells['TxnId']!.value.toString()}');
                  }
                },
                onNew: () {
                    if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                  ref.read(dataentryTxnIdProvider.notifier).state = 'new';
                  switch (txnType) {
                    case 'PAYMENT':
                      singleton<AppRouter>().navigatePath(
                          '/dataentry/manual/$txnType/payment/new');
                      break;
                    case 'SALE':
                      singleton<AppRouter>()
                          .navigatePath('/dataentry/manual/$txnType/sale/new');
                      break;
                    case 'ADJUST':
                      singleton<AppRouter>().navigatePath(
                          '/dataentry/manual/$txnType/adjust/new');
                      break;
                    case 'FEE':
                      singleton<AppRouter>()
                          .navigatePath('/dataentry/manual/$txnType/fee/new');
                      break;
                    default:
                      singleton<AppRouter>()
                          .navigatePath('/dataentry/manual/$txnType/dtl/new');
                  }
                },
              )
            ],
          ),
            appBar: AppBar(
                  actions: [
                    AcxBackToList(listUrl: '/dataentry/main')
                  ],
                  title: SelectableText(txnType.toString()),
                  automaticallyImplyLeading: true, centerTitle: false,
                ),
        );
    }
  }
}

void pukalSave(String sts, WidgetRef ref, Set<TrinaRow> rows,
    Map<String, dynamic> prcsdate, QueryObject query) {
  var futures = <Future>[];
  for (var i = 0; i < rows.length; i++) {
    final queryDel = QueryObject(
        querysql: '/sp/ApiMnlTxnPukalSave/queryasync',
        params: {
          "TxnId": rows.elementAt(i).cells["TxnId"]!.value.toString(),
          "AcctId": rows.elementAt(i).cells["AcctId"]!.value.toString(),
          "PrcsDate": prcsdate['PrcsDate'],
        },
        showMsg: false);
    final resultDel = ref.read(ReturndatafreezedProvider(queryDel).future);
    futures.add(resultDel);
  }
  Future.wait(
    futures,
    eagerError: true,
  ).then((value) {
    List<dynamic> rtt = value;
    for (var element in rtt) {
      Toast.showresult(element);
    }
    ref.invalidate(ReturndatafreezedProvider(query));
  }).onError((error, stackTrace) {});
}

//       final selectedRow = ref.read(globalPlutoSelectedRow.notifier).state;
//      if(selectedRow.cells.containsKey('TxnType')){
//  if(selectedRow.cells['TxnType']==null){
//       Toast.message('Please select row');

//    }
//    Map<String, dynamic> toPost = convertFormDateValue({
//               "TxnId": selectedRow.cells['TxnId']!.value,
//               "AcctId": selectedRow.cells['AcctId']!.value,
//               "PrcsDate":  selectedRow.cells['ProcessDate']!.value,
//             },['PrcsDate'] );
//       final updateQuery  = QueryObject(querysql: 'ApiMnlTxnPukalSave ',params:  toPost, showMsg: true);
//       final queryRes = ref.watch(ReturndatafreezedProvider(updateQuery));
//       queryRes.when(data: (theData){
//           Toast.showresult(theData);

//       }, error: (error, stackTrace) => Center(child: Text(error.toString()),), loading: () => const CircularProgressIndicator());
//       } else{
//         Toast.message('Does Not Contains Key');
//       }

void pukalRej(String sts, WidgetRef ref, Set<TrinaRow> rows, QueryObject query) {
  var futures = <Future>[];
  for (var i = 0; i < rows.length; i++) {
    final queryDel = QueryObject(
        querysql: '/sp/ApiMnlTxnPukalRej/queryasync',
        params: {
          "TxnId": rows.elementAt(i).cells["TxnId"]!.value.toString(),
          "AcctId": rows.elementAt(i).cells["AcctId"]!.value.toString(),
        },
        showMsg: false);
    final resultDel = ref.read(ReturndatafreezedProvider(queryDel).future);
    futures.add(resultDel);
  }
  Future.wait(
    futures,
    eagerError: true,
  ).then((value) {
    List<dynamic> rtt = value;
    for (var element in rtt) {
      Toast.showresult(element);
    }
    ref.invalidate(ReturndatafreezedProvider(query));
  }).onError((error, stackTrace) {});
}
