import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/feature/mcenroll/screens/tad/geninfo/mc_enroll_tad_geninfo.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=368;

@RoutePage()
class MchtEnrlTadList extends ConsumerWidget {
  const MchtEnrlTadList({
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
        querysql: '/sp/ApiEnrlMchtTadList/queryasync',
        spName: 'ApiEnrlMchtTadList',
        params: {"MchtEttyId": mchtEttyId},
        idField: 'TadEttyId',
        navPrefix: '',
        onNew: () {
            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          singleton<AppRouter>().navigatePath('./geninfo/new/new');
        },
        onSelectedTap: (TrinaRow val) {
          ref.read(ettyIdDynamicChildProvider.notifier).state = {
            "EttyId": val.cells["BusnUnitEttyId"]!.value
          };
          singleton<AppRouter>().navigatePath(
              './geninfo/${val.cells['TadEttyId']!.value}/${val.cells['TadId']!.value}');
        },
        useNav: false,
      ),
    ]);
  }
}
