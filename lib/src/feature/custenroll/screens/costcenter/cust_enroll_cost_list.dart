import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridv2.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=280;

@RoutePage()
class CustEnrollCostCenterList extends ConsumerWidget {
  const CustEnrollCostCenterList(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});
  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }

    final listQuery = ReturndataProvider(querysql: '/sp/ApiEnrlCostCtrList/queryasync',
        params: {"CustEttyId": custEttyId},
        showMsg: false);

          return AcxTrinaGridv2(
            idField: 'CostCtrEttyId',
            query: listQuery,
            onRefresh: () {
              ref.invalidate(listQuery);
            },
            onNew: () {
                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                Toast.message("Action Not Authorised");
                                return;
                              }
              singleton<AppRouter>().navigatePath(
                  '/custenroll/costcen/$custEttyId/profile/new');
            },
            onSelected: (TrinaRow val) {
              singleton<AppRouter>().navigatePath(
                  '/custenroll/costcen/$custEttyId/profile/${val.cells['CostCtrEttyId']!.value.toString()}');
            },
          );
  
    // return AsyncValueWidget(
    //     value: listData,
    //     data: (dv) {
    //       return AcxTrinaGridExtv2(
    //         idField: 'CostCtrEttyId',
    //         extData: dv,
    //         onRefresh: () {
    //           ref.invalidate(listQuery);
    //         },
    //         onNew: () {
    //             if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
    //                             Toast.message("Action Not Authorised");
    //                             return;
    //                           }
    //           singleton<AppRouter>().navigatePath(
    //               '/custenroll/costcen/$custEttyId/profile/new');
    //         },
    //         onSelected: (TrinaRow val) {
    //           singleton<AppRouter>().navigatePath(
    //               '/custenroll/costcen/$custEttyId/profile/${val.cells['CostCtrEttyId']!.value.toString()}');
    //         },
    //       );
    //     });
  }
}
