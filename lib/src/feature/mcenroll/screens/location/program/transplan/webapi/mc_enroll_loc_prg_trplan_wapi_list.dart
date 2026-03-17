import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrapext.dart';
import 'package:nucleusv2/src/feature/mcenroll/screens/location/program/transplan/transplanmock.dart';

const int wid=859;

@RoutePage()
class MchtEnrlLocPrgTranPlanWebAPIList extends ConsumerWidget {
  const MchtEnrlLocPrgTranPlanWebAPIList(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});
//ApiPrgMchtTadFeeList
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return AcxListButtonNavWrapExt(
        returnData: mcenrolltransplanlist,
        filterField: 'Poe',
        filterValue: 'WEB',
        addNew: () {
          singleton<AppRouter>().navigatePath('./dtl/new');
        },
        returnSelectedRef: (va) {
          singleton<AppRouter>().navigatePath('./dtl/${va['MsgTypePlanId']}');
        },
        displayfield: const ['PoeDscp', 'MsgTypeDscp'],
        keyField: 'MsgTypePlanId');
  }
}
