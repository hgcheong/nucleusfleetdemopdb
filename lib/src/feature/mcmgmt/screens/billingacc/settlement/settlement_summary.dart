import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/mcmgmt/screens/billingacc/settlement/settlement_controller.dart';

import 'package:trina_grid/trina_grid.dart';

const int wid=708;

@RoutePage()
class MchtMgmtSettlementSummary extends ConsumerWidget {
  const MchtMgmtSettlementSummary({
    super.key,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
    @PathParam.inherit('prgEttyId') this.prgEttyId,
    @PathParam.inherit('ettyId') this.ettyId,
    @PathParam.inherit('acctId') this.acctId,
  });

  final String? mchtEttyId;
  final String? prgEttyId;
  final String? ettyId;
  final String? acctId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final settleFormKey = GlobalKey<FormBuilderState>();

    // final query = QueryObject(querysql:'/sp/ApiMgmtLocList/queryasync' , params: {"MchtEttyId": mchtEttyId}, showMsg: false);
    // final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return SingleChildScrollView(
      child: SizedBox(
        height: 1280,
        child: ListView(children: [
          const SelectableText(
            "Settlement Search",
          ),
          sbh10,
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: settleFormKey,
                initialValue: {
                  "MchtEttyId": mchtEttyId,
                  "PrgEttyId": prgEttyId,
                  "EttyId": ettyId,
                  "AcctId": acctId
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: FbLibView(
                            inputIcon: const Icon(Icons.store),
                            params: {'MchtEttyId': mchtEttyId.toString()},
                            name: 'LocEttyId',
                            label: 'Location',
                            searchText: 'LocName',
                            keyField: 'LocEttyId',
                            querySql: spStr('ApiMgmtLocList')),
                      ),
                    ),
                    sbw10,
                    Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                sbw10,
                                const Flexible(
                                    child: FbDateTimePicker(
                                        name: 'FromDate', label: 'From Date')),
                                fbFieldGap,
                                const Flexible(
                                    child: FbDateTimePicker(
                                        name: 'ToDate', label: 'To Date')),
                                sbw20,
                                IconButton(
                                    onPressed: () {
                                      settleFormKey.currentState!.save();
                                      Map<String, dynamic> toPost =
                                          convertFormDateValue(
                                              settleFormKey.currentState!.value,
                                              ['FromDate', 'ToDate']);

                                      ref
                                          .read(
                                              settlementSearchContorllerProvider
                                                  .notifier)
                                          .state = toPost;
                                    },
                                    icon: const Icon(Icons.search))
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
          // const SelectableText(
          //   'Settlements',
          // ),
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                  height: 1280,
                  child:  SettlementGridPage(mchtEttyId:  mchtEttyId)))
        ]),
      ),
    );
  }
}

class SettlementGridPage extends ConsumerWidget {
   const SettlementGridPage( {super.key, this.mchtEttyId,});

final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final toPost = ref.watch(settlementSearchContorllerProvider);
    toPost["MchtEttyId"] = mchtEttyId;
    final query = QueryObject(
        querysql: 'ApiMgmtMchtAcctSttlmtList', params: toPost, showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          return SingleChildScrollView(
              child: SizedBox(
                  height: 1280,
                  child: AcxTrinaGridExtDatawExport(
                      gridTitle: 'Settlement',
                      extData: theData,
                      idField: 'BatchNo',
                      onSelected: (TrinaRow val) async {
                       //    await showAcxDialog(context,  ApiMgmtMchtAcctSttlmtTxnListGrid(val));
                       // Toast.message('Not Authorised to View Settlement');
                      })));
        });
  }
}


class ApiMgmtMchtAcctSttlmtTxnListGrid extends ConsumerWidget{
  const ApiMgmtMchtAcctSttlmtTxnListGrid(this.curRow,  {super.key});


  final TrinaRow curRow;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qo = QueryObject(querysql: '/sp/ApiMgmtMchtAcctSttlmtTxnList/queryasync', params: {
  "TadNo": curRow.cells["TadNo"]!.value,
  "SttlmtDate": curRow.cells["SttlmtDate"]!.value,
  "LocEttyId":curRow.cells["LocEttyId"]!.value,
  "MchtEttyId":curRow.cells["MchtEttyId"]!.value,
  "SttlmtBatchNo": curRow.cells["SttlmtBatchNo"]!.value,
  "PrgEttyId": curRow.cells["PrgEttyId"]!.value,
  "FromDate": curRow.cells["FromDate"]!.value,
  "ToDate": curRow.cells["ToDate"]!.value
    }, showMsg: false);
//     {
//   "TadNo": "10000002",
//   "SttlmtDate": "2025-06-05T00:00:00",
//   "LocEttyId": 712,
//   "MchtEttyId": 55,
//   "SttlmtBatchNo": 10,
//   "FromDate": 20250101,
//   "ToDate": 20250625
// }
  final queryRes = ref.watch(ReturndatafreezedProvider(qo));
   return AsyncValueWidget(
    value: queryRes,
     data: (theData) { return Column(
       children: [
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(flex: 11,),
              Flexible(
                flex: 1,
                child: ElevatedButton(
                            onPressed: () {
                              singleton<AppRouter>().maybePop();
                            },
                            child: const Icon(Icons.close)),
              )
        ],)),
         Expanded(
          flex: 11,
           child: AcxTrinaGridExtDatawExport(
                              gridTitle: 'Settlement Transaction List ',
                              extData: theData,
                              idField: 'TxnId',
                              onSelected: (TrinaRow val) async {
                                  await showAcxDialog(context,  ApiMgmtMchtAcctSttlmtTxnPrdList(val,
                                  curRow.cells["PrgId"]!.value.toString(),
                                  curRow.cells["MchtEttyId"]!.value.toString(),))
                             ;
                               // Toast.message('Not Authorised to View Settlement');
                              }),
         ),
       ],
     );
                        }, 
   );
  }

}





class ApiMgmtMchtAcctSttlmtTxnPrdList extends ConsumerWidget{
  const ApiMgmtMchtAcctSttlmtTxnPrdList(this.curRow, this.prgEttyId, this.mchtEttyId,  {super.key});


  final TrinaRow curRow;
  final String? prgEttyId;
  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qo = QueryObject(querysql: '/sp/ApiMgmtMchtAcctSttlmtTxnPrdList/queryasync', params: {
  "TxnId": curRow.cells["TxnId"]!.value,
  "LocEttyId":null,
  "PrgEttyId":prgEttyId,
  "MchtEttyId":mchtEttyId,
    }, showMsg: false);
//     {
//   "TadNo": "10000002",
//   "SttlmtDate": "2025-06-05T00:00:00",
//   "LocEttyId": 712,
//   "MchtEttyId": 55,
//   "SttlmtBatchNo": 10,
//   "FromDate": 20250101,
//   "ToDate": 20250625
// }
  final queryRes = ref.watch(ReturndatafreezedProvider(qo));
   return AsyncValueWidget(
    value: queryRes,
     data: (theData) { return Column(
       children: [
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(flex: 11,),
              Flexible(
                flex: 1,
                child: ElevatedButton(
                            onPressed: () {
                              singleton<AppRouter>().maybePop();
                            },
                            child: const Icon(Icons.close)),
              )
        ],)),
         Expanded(
          flex: 11,
           child: AcxTrinaGridExtDatawExport(
                              gridTitle: 'Product List',
                              extData: theData,
                              idField: 'Seq',
                            ),
         ),
       ],
     );
                        }, 
   );
  }

}

