import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=583;

@RoutePage()
class CustMgmtRiskList extends StatelessWidget {
  const CustMgmtRiskList({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  });

  final String? custEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return CustMgmtRiskListGrid(
      custEttyId: custEttyId,
    );
  }
}

class CustMgmtRiskListGrid extends ConsumerWidget {
  const CustMgmtRiskListGrid({
    super.key,
    this.custEttyId,
  });
  final String? custEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return ListView(children: [
      AcxTrinaGridWithColumn(
        querysql: '/sp/ApiMgmtCmpyList/queryasync',
        spName: 'ApiMgmtCmpyList',
        params: {"CustEttyId": custEttyId},
        idField: 'CmpyEttyId',
        navPrefix: '',
        onNew: () {
            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          singleton<AppRouter>().navigatePath(
              '/custmgmt/cmpy/$custEttyId/detail/new/profile/geninfo');
        },
        onSelectedTap: (TrinaRow val) {
          singleton<AppRouter>().navigatePath(
              '/custmgmt/cmpy/$custEttyId/detail/${val.cells['CmpyEttyId']!.value.toString()}/profile/geninfo');
        },
        useNav: false,
      ),
    ]);
  }
}
