import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrapext.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/mcmgmt/mc_mgmt_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=724;

@RoutePage()
class MchtMgmtocPrgList extends ConsumerWidget {
  const MchtMgmtocPrgList(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId});

  final String? locEttyId;
  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtLocPrgList/queryasync',
        params: {"MchtEttyId": mchtEttyId, "LocEttyId": locEttyId},
        showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          return ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SelectableText(
                  'Merchant have signed up for the following program'),
              AcxListButtonNavWrapExt(
                  returnData: theData,
                  keyField: 'PrgEttyId',
                  filterField: 'StsDscp',
                  filterValue: 'ACCEPTED',
                  // querysql: '/sp/ApiMgmtLocPrgList/queryasync',
                  // params: {"MchtEttyId": mchtEttyId, "LocEttyId": locEttyId},
                  displayfield: const ['PrgDscp', 'StsDscp'],
                  deleteSelectedRef: (val) {
                    Toast.message("Access Denied");
                    //   updateData({"LocEttyId": locEttyId, "PrgEttyId": val['PrgEttyId'], "AccptId": val['AccptId']}, mchtEttyId.toString(), locEttyId.toString(), ref, query);
                  },
                  returnSelectedRef: (val) async {
                    {
                      ///mcmgmt/loc/97/prgdtl/99/1/1/fees
                      ref.read(mchtMgmtPrgSelectProvider.notifier).state = val;

                      singleton<AppRouter>().navigatePath(
                          '/mcmgmt/loc/$mchtEttyId/prgdtl/$locEttyId/${val["PrgEttyId"]}/${val["BillingEttyType"]}/${val["AccptId"]}/fees/tad/list');
                    }
                  }),
              sbh10,
              const SelectableText('Available program for sign up'),
              sbh10,
              AcxListButtonNavWrapExt(
                  returnData: theData,
                  keyField: 'PrgEttyId',
                  filterField: 'StsDscp',
                  filterValue: 'UNACCEPTED',
                  // querysql: '/sp/ApiMgmtLocPrgList/queryasync',
                  // params: {"MchtEttyId": mchtEttyId, "LocEttyId": locEttyId},
                  displayfield: const ['PrgDscp', 'StsDscp'],
                  editIcon: Icons.add,
                  returnSelectedRef: (val) async {
                    {
                      final theResult = await ConfirmDialog.show(
                          title: 'Add program?',
                          body: 'Please confirm you want to add the program');
                      if (theResult) {
                        final querySave = QueryObject(
                            querysql: '/sp/ApiMgmtLocPrgSave/queryasync',
                            params: {
                              "LocEttyId": locEttyId,
                              "PrgEttyId": val["PrgEttyId"],
                              "AccptId": null,
                              "BillingEttyType": val["BillingEttyType"]
                            },
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            singleton<AppRouter>()
                                .navigatePath(
                                    '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/program')
                                .then((val) {
                              ref.invalidate(ReturndatafreezedProvider(query));
                            });
                          }
                        });
                      }
                    }
                  }),
            ],
          );
        });
  }
}

void updateData(Map<String, dynamic> param, String mchtEttyId, String locEttyId,
    WidgetRef ref, QueryObject query) {
  final querySave = QueryObject(
      querysql: '/sp/ApiMgmtLocPrgDel/queryasync',
      params: param,
      showMsg: false);
  final results = ref.read(ReturndatafreezedProvider(querySave).future);
  results.then((value) {
    Toast.showresult(value);
    if (isSuccess(value.message)) {
      singleton<AppRouter>()
          .navigatePath('/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/program')
          .then((val) {
        ref.invalidate(ReturndatafreezedProvider(query));
      });
    }
  });
}
