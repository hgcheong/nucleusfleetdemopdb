import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrapext.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/mcenroll/mc_enroll_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=663;

@RoutePage()
class MchtEnrlocPrgList extends ConsumerWidget {
  const MchtEnrlocPrgList(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId});
  // "PrgDscp": "Xfleet Postpaid",
  //   "StsDscp": "UNACCEPTED",
  //   "PrgEttyId": 1,
  //   "MchtEttyId": 100,
  //   "LocEttyId": 102,
  //   "AccptId": null,
  //   "Sts": "X"
  final String? locEttyId;
  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiEnrlLocPrgList/queryasync',
        params: {"MchtEttyId": mchtEttyId, "LocEttyId": locEttyId},
        showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          return ListView(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SelectableText(
                  'Merchant have signed up for the following program'),
              AcxListButtonNavWrapExt(
                  returnData: theData,
                  keyField: 'PrgEttyId',
                  filterField: 'StsDscp',
                  filterValue: 'ACCEPTED',
                  // querysql: '/sp/ApiEnrlLocPrgList/queryasync',
                  // params: {"MchtEttyId": mchtEttyId, "LocEttyId": locEttyId},
                  displayfield: const ['PrgDscp', 'StsDscp'],
                  deleteSelectedRef: (val) {
                    //   final theResult = await ConfirmDialog.show(title: 'Remove program?');
                    // theResult == true ?

                    updateData({
                      "LocEttyId": locEttyId,
                      "PrgEttyId": val['PrgEttyId'],
                      "AccptId": val['AccptId']
                    }, mchtEttyId.toString(), locEttyId.toString(), ref, query);
                    //       ref.invalidate(ReturndatafreezedProvider(query));
                  },
                  returnSelectedRef: (val) async {
                    {
                      ///mcenroll/loc/97/prgdtl/99/1/1/fees
                      ref.read(mchtEnrollPrgSelectProvider.notifier).state =
                          val;

                      singleton<AppRouter>().navigatePath(
                          '/mcenroll/loc/$mchtEttyId/prgdtl/$locEttyId/${val["PrgEttyId"]}/${val["BillingEttyType"]}/${val["AccptId"]}/fees/tad/list');
                    }
                  }),
              const SelectableText('Available program for sign up'),
              AcxListButtonNavWrapExt(
                  keyField: 'PrgEttyId',
                  filterField: 'StsDscp',
                  filterValue: 'UNACCEPTED',
                  returnData: theData,
                  // querysql: '/sp/ApiEnrlLocPrgList/queryasync',
                  // params: {"MchtEttyId": mchtEttyId, "LocEttyId": locEttyId},
                  displayfield: const ['PrgDscp', 'StsDscp'],
                  editIcon: Icons.add,
                  returnSelectedRef: (val) async {
                    {
                      final theResult =
                          await ConfirmDialog.show(title: 'Add program?');
                      if (theResult) {
                        final querySave = QueryObject(
                            querysql: '/sp/ApiEnrlLocPrgSave/queryasync',
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
                                    '/mcenroll/loc/$mchtEttyId/detail/$locEttyId/program')
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
      querysql: '/sp/ApiEnrlLocPrgDel/queryasync',
      params: param,
      showMsg: false);
  final results = ref.read(ReturndatafreezedProvider(querySave).future);
  results.then((value) {
    Toast.showresult(value);
    if (isSuccess(value.message)) {
      singleton<AppRouter>()
          .navigatePath('/mcenroll/loc/$mchtEttyId/detail/$locEttyId/program')
          .then((val) {
        ref.invalidate(ReturndatafreezedProvider(query));
      });
    }
  });
}
