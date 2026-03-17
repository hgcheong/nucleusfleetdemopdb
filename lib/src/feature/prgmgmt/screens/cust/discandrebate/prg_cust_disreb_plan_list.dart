import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=160;
@RoutePage()
class PrgCustDiscRebPlanList extends StatelessWidget {
  const PrgCustDiscRebPlanList(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
// return Column(
    //   children: [
    //     Expanded(
    //       flex: 12,
    //       child: AcxTabView(align: Alignment.centerLeft, routes:  [
    //         PrgCustDiscRebPlanList(),
    //       ], tabs: [
    //         Tab(
    //           text: S.current.tabPlan,
    //         ),
    //       ]),
    //     ),
    //   ],
    // );
    return AcxTrinaGridWithColumn(
      useNav: false,
      querysql: '/sp/ApiPrgCustRebateList/queryasync',
      params: {
        "PrgEttyId": prgEttyId,
      },
      idField: 'RebateId',
      navPrefix: '',
      spName: 'ApiPrgCustRebateList',
      onSelectedTap: (TrinaRow val) {
        //prgmgmt/custsetup/4/pcdislanding/pcdisplanlist
        singleton<AppRouter>().navigatePath(
            '/prgmgmt/custsetup/$prgEttyId/pcdislanding/pcdisplan/${val.cells['RebateId']!.value.toString()}');
      },
      onNew: () {
          if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
        singleton<AppRouter>().navigatePath(
            '/prgmgmt/custsetup/$prgEttyId/pcdislanding/pcdisplan/new');
      },
    );
  }
}
