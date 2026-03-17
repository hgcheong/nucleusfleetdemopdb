import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/feature/mcmgmt/screens/tad/geninfo/mc_mgmt_tad_geninfo.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=386;

@RoutePage()
class MchtMgmtTadList extends ConsumerWidget {
  const MchtMgmtTadList({
    super.key,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
  });

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return ListView(children: [
      AcxTrinaGridWithColumn(
        querysql: '/sp/ApiMgmtMchtTadList/queryasync',
        spName: 'ApiMgmtMchtTadList',
        params: {"MchtEttyId": mchtEttyId},
        idField: 'TadEttyId',
        navPrefix: '',
        onNew: () {
            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          singleton<AppRouter>().navigatePath('./geninfo/new/new/main');
        },
        onSelectedTap: (TrinaRow val) {
          final theTitle = getTitle(
              ref,
              {
                "TadEttyId": val.cells["TadEttyId"]!.value.toString(),
              },
              AppBarTitleType.management);
          theTitle.then((value) {
            ref.read(ettyIdMgmtDynamicChildProvider.notifier).state = {
              "EttyId": val.cells["BusnUnitEttyId"]!.value
            };
            singleton<AppRouter>().navigatePath(
                './geninfo/${val.cells['TadEttyId']!.value}/${val.cells['TadId']!.value}');
            ref.read(appBarTitleProvider.notifier).state = value.toString();
          });
        },
        useNav: false,
      ),
    ]);
  }
}
