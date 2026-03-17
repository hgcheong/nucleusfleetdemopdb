import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrapext.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=797;

@RoutePage()
class MchtEnrlLocPrgControlList extends ConsumerWidget {
  const MchtEnrlLocPrgControlList(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId});

  final String? locEttyId;
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: 'ApiEnrlLocTxnAccptList',
        params: {"PrgEttyId": prgEttyId, "LocEttyId": locEttyId},
        showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          return SingleChildScrollView(
            child: SizedBox(
              height: 1280,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SelectableText(
                      'Type of transaction allow to perform by this Location. If no transaction type being add means Location will accept all transaction'),
                  AcxListButtonNavWrapExt(
                    editIcon: Icons.delete,
                    keyField: 'TxnCtgry',
                    filterField: 'StsDscp',
                    filterValue: 'ACCEPTED',
                    returnData: theData,
                    displayfield: const ['TxnCtgryDscp', 'StsDscp'],
                    returnSelectedRef: (val) async {
                      //String prgEttyId,String locEttyId,String accptId, String txnCtgry,
                      final theResult = await ConfirmDialog.show(
                          title: 'Remove transaction type?');
                      if (theResult == true) {
                        updateData({
                          "PrgEttyId": prgEttyId,
                          "LocEttyId": locEttyId,
                          "AccptId": val["AccptId"],
                          "TxnCtgry": val["TxnCtgry"],
                        }, ref);
                        ref.invalidate(ReturndatafreezedProvider(query));
                      }
                    },
                  ),
                  sbh10,
                  const SelectableText('Select a transaction type to add'),
                  sbh10,
                  AcxListButtonNavWrapExt(
                      editIcon: Icons.add,
                      keyField: 'TxnCtgry',
                      filterField: 'StsDscp',
                      filterValue: 'UNACCEPTED',
                      returnData: theData,
                      displayfield: const ['TxnCtgryDscp', 'StsDscp'],
                      returnSelectedRef: (val) async {
                        {
                          // ref.read(mchtEnrollLocCtrlSelectProvider.notifier).state = val;
                          // singleton<AppRouter>().navigatePath('././select/${val["TxnCtgry"]}/new');

                          final theResult = await ConfirmDialog.show(
                              title: 'Add Transaction Type?');
                          if (theResult) {
                            final querySave = QueryObject(
                                querysql:
                                    '/sp/ApiEnrlLocTxnAccptSave/queryasync',
                                params: {
                                  "PrgEttyId": prgEttyId,
                                  "AccptId": null,
                                  "TxnCtgry": val["TxnCtgry"],
                                  "LocEttyId": locEttyId
                                },
                                showMsg: false);
                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((value) {
                              Toast.showresult(value);
                              if (isSuccess(value.message)) {
                                //  singleton<AppRouter>().navigatePath('/mcenroll/loc/$mchtEttyId/detail/$locEttyId/program');
                                //  singleton<AppRouter>().navigatePath('/mcenroll/loc/40/prgdtl/46/1/13/22/control/list');
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                                //    singleton<AppRouter>().navigatePath('./list');
                              }
                            });
                          }
                        }
                      }),
                ],
              ),
            ),
          );
        });
  }
}

void updateData(Map<String, dynamic> param, WidgetRef ref) {
  final querySave = QueryObject(
      querysql: '/sp/ApiEnrlLocTxnAccptDel/queryasync',
      params: param,
      showMsg: false);
  final results = ref.read(ReturndatafreezedProvider(querySave).future);
  results.then((value) {
    Toast.showresult(value);
    if (isSuccess(value.message)) {
      singleton<AppRouter>().navigatePath('.');
    }
  });
}
