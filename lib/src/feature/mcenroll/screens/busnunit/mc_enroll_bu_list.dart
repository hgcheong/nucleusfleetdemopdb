import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=358;

@RoutePage()
class MchtEnrlBusinessUnitList extends StatelessWidget {
  const MchtEnrlBusinessUnitList({
    super.key,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
  });

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return ListView(children: [
      AcxTrinaGridWithColumn(
        querysql: '/sp/ApiEnrlMchtBusnUnitList/queryasync',
        spName: 'ApiEnrlMchtBusnUnitList',
        params: {"MchtEttyId": mchtEttyId},
        idField: 'BusnUnitEttyId',
        navPrefix: '',
        onNew: () {
            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          singleton<AppRouter>().navigatePath('././bumain/new');
        },
        onSelectedTap: (TrinaRow val) {
          singleton<AppRouter>().navigatePath(
              '././bumain/${val.cells['BusnUnitEttyId']!.value}');
        },
        useNav: false,
      ),
    ]);
  }
}
