import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=825;

@RoutePage()
class CustEnrollProgramDisRebPlanList extends ConsumerWidget {
  const CustEnrollProgramDisRebPlanList(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('billingEttyType') this.billingEttyType});

  final String? prgEttyId;
  final String? custEttyId;
  final String? billingEttyType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiEnrlCustRebateList/queryasync',
        params: {"PrgEttyId": prgEttyId, "CustEttyId": custEttyId},
        showMsg: false));
    final listData = ref.watch(listQuery);
    final toNavUrl =
        '/custenroll/custprg/$custEttyId/$prgEttyId/$billingEttyType/discandreb';

    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          var initialVal = 'N';
          if (dv.data != null && dv.data!.isNotEmpty) {
            initialVal = dv.data![0]['FeeInd'].toString();
          }
          return Column(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                 
                    Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FbSwitch(
                            name: 'handleMe',
                            initialValue: initialVal,
                            label: 'Handle Transaction Fees at Customer Level',
                            onChanged: (val) async {
                              final queryDel = QueryObject(
                                  querysql:
                                      '/sp/ApiEnrlCustRebateFeeIndSave/queryasync',
                                  params: {
                                    "PrgEttyId": prgEttyId,
                                    "CustEttyId": custEttyId,
                                    "FeeInd": val == true ? 'Y' : 'N'
                                  },
                                  showMsg: false);
                              final resultDel = ref.read(
                                  ReturndatafreezedProvider(queryDel).future);
                              resultDel.then((value) {
                                ref.invalidate(listQuery);
                                Toast.showresult(value);
                              });
                            },
                          ),
                        )),
                    const Spacer(
                      flex: 5,
                    )
                  ],
                ),
              ),
               Expanded(
                flex: 11,
                 child: AcxTrinaGridExtDataCheckBox(
                  gridLabel:
                      'Define the Discount & Rebate Plan Setup at Customer Level',
                  idField: 'RebateId',
                  spName: 'ApiEnrlCustRebateList',
                  extData: dv,
                  iconButtons: const [
                    //   IconWithFunction(icon: const Icon(Icons.abc), func: (Set<TrinaRow> val){
                               
                    // })
                  ],
                  isMultiSelect: true,
                  onDelete: (Set<TrinaRow> rows) async {
                      if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                    bool confirmed = await ConfirmDialog.show(
                        title: 'Are you sure you want to delete the record?');
                    if (confirmed) {
                      var futures = <Future>[];
                      for (var i = 0; i < rows.length; i++) {
                        final currentRowCell = rows.elementAt(i).cells;
                        final queryDel = QueryObject(
                            querysql: '/sp/ApiEnrlCustRebateDel/queryasync',
                            params: {
                              "PrgEttyId": prgEttyId,
                              "CustEttyId": custEttyId,
                              "RebateId":
                                  currentRowCell["RebateId"]!.value.toString(),
                              "MediaType":
                                  currentRowCell["MediaType"]!.value.toString(),
                              "TxnCtgry":
                                  currentRowCell["TxnCtgry"]!.value.toString(),
                            },
                            showMsg: false);
                        final resultDel =
                            ref.read(ReturndatafreezedProvider(queryDel).future);
                        futures.add(resultDel);
                      }
                      await Future.wait(futures).then((value) {
                        ref.invalidate(listQuery);
                      });
                    }
                  },
                  onRefresh: () async {},
                  onNew: () {
                      if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                    singleton<AppRouter>()
                        .navigatePath('$toNavUrl/dtl/new/new/new');
                  },
                  onSelectedTap: (TrinaRow val) {
                    final currentCell = val.cells;
                    singleton<AppRouter>().navigatePath(
                        '$toNavUrl/dtl/${currentCell["TxnCtgry"]!.value}/${currentCell["MediaType"]!.value}/${currentCell["RebateId"]!.value}');
                  },
                               ),
               ),
            ],
          );
        });
  }
}
