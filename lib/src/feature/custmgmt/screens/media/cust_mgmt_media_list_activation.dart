import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=323;

@RoutePage()
class CustMgmtMediaListActivation extends StatelessWidget {
  const CustMgmtMediaListActivation(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Center(
      child: CustMgmtMediaListGrid(custEttyId: custEttyId),
    );
  }
}

class CustMgmtMediaListGrid extends HookConsumerWidget {
  const CustMgmtMediaListGrid({
    super.key,
    this.custEttyId,
  });
  final String? custEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtMediaAtvtionList/queryasync',
        params: {
          "CustEttyId": custEttyId,
        },
        showMsg: false));
    final listData = ref.watch(listQuery);
    return AsyncValueWidget<Returndata>(
        value: listData,
        data: (dv) {
              return AcxTrinaGridExtDataCheckBox(
                      onRefresh: (){
                              ref.invalidate(listQuery);
                      },
                      spName: 'ApiMgmtMediaAtvtionList',
                      idField: 'MediaEttyId',
                      appButtons: [
       
                      AppButtonWithFunction(
                            btn: const AppButton(
                              icon: Icons.power_settings_new,
                              label: "Activate Card",
                            ),
                            func: (ValueNotifier<Set<TrinaRow>> val) async {
                                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                              var rows = val.value;
                              if (rows.isEmpty) {
                                Toast.message('Please check media to activate');
                                return;
                              }
                                bool confirmed = await ConfirmDialog.show(
                  title: 'Are you sure you want to activate the checked cards?');
              // if (confirmed) {
              //   var futures = <Future>[];
              //   for (var i = 0; i < rows.length; i++) {
              //     final rowToActivate = rows.elementAt(i);
              //     final queryActivate = QueryObject(
              //         querysql: '/sp/ApiMgmtMediaAtvtionSave/queryasync',
              //         params: {
              //       "CustEttyId": rowToActivate.cells['CustEttyId']!.value.toString(),
              //       "MediaEttyId": rowToActivate.cells['MediaEttyId']!.value.toString(),
              //       "MediaIssId": rowToActivate.cells['MediaIssId']!.value.toString(),           
              //         },
              //         showMsg: false);
              //     final resultActivate =
              //         ref.read(ReturndatafreezedProvider(queryActivate).future);
              //     futures.add(resultActivate);
              //   }
              //   await Future.wait(futures).then((value) {
              //     ref.invalidate(listQuery);
              //     Toast.message('Done');
              //   });
              // }

                      if (confirmed) {
      
                for (var i = 0; i < rows.length; i++) {
                  final rowToActivate = rows.elementAt(i);
                  final queryActivate = QueryObject(
                      querysql: '/sp/ApiMgmtMediaAtvtionSave/query',
                      params: {
                    "CustEttyId": rowToActivate.cells['CustEttyId']!.value.toString(),
                    "MediaEttyId": rowToActivate.cells['MediaEttyId']!.value.toString(),
                    "MediaIssId": rowToActivate.cells['MediaIssId']!.value.toString(),           
                      },
                      showMsg: false);
                      ref.read(ReturndatafreezedProvider(queryActivate));
                }
                await InfoDialog.show(
                  title: 'Activation Completed');
               ref.invalidate(listQuery);
            
              }
                            }),
                      ],
              
                      onSelectedTap: (TrinaRow val) {
                        Toast.message('Please check which media to activate');
                      },
                      extData: dv,
        
                    );
        });
  }
}
