import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';

import 'package:trina_grid/trina_grid.dart';

const int wid=371;

@RoutePage()
class MchtMgmtOnlineAccessList extends ConsumerWidget {
  const MchtMgmtOnlineAccessList(
      {super.key, @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return SingleChildScrollView(
      child: AcxTrinaGridWithColumn(
        querysql: '/sp/ApiMgmtMchtUserList/queryasync',
        spName: 'ApiMgmtMchtUserList',
        params: {"MchtEttyId": mchtEttyId},
        idField: 'WebId',
        useNav: false,
        onSelectedTap: (TrinaRow val) {
          singleton<AppRouter>().navigatePath(
              '/mcmgmt/mcht/${val.cells['MchtEttyId']!.value}/quickinfo/overview');
        },
        onNew: () {
            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          // singleton<AppRouter>().navigatePath('./new/main');
        },
      ),
    );
  }
}
