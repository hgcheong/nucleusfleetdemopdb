import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/member/mbrinfo/cust_mgmt_mbr_info.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=333;

@RoutePage()
class CustMgmtMemberList extends ConsumerWidget {
  const CustMgmtMemberList(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    //  return const SelectableText('Cust Mgmt Member List');
    return ListView(children: [
      AcxTrinaGridWithColumn(
        querysql: '/sp/ApiMgmtMbrList/queryasync',
        spName: 'ApiMgmtMbrList',
        params: {"CustEttyId": custEttyId},
        idField: 'MbrEttyId',
        navPrefix: '',
        onNew: () {
            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          ref.read(mbrMgmtCostCenterProvider.notifier).state = {
            "CustEttyId": custEttyId,
            "CmpyEttyId": null
          };
          singleton<AppRouter>().navigatePath(
              '/custmgmt/member/$custEttyId/detail/new/memberinfo/membership');
        },
        onSelectedTap: (TrinaRow val) {
          // ref.read(mbrCostCenterProvider.notifier).state = {"CustEttyId": val.cells["CustEttyId"]!.value.toString(), "MbrEttyId": val.cells["MbrEttyId"]!.value.toString()};
          ref.read(mbrMgmtCostCenterProvider.notifier).state = {
            "CustEttyId": val.cells["CustEttyId"]!.value.toString(),
            "CmpyEttyId": val.cells["CmpyEttyId"]!.value.toString()
          };
          singleton<AppRouter>().navigatePath(
              '/custmgmt/member/$custEttyId/detail/${val.cells['MbrEttyId']!.value.toString()}/quickinfo');
        },
        useNav: false,
      ),
    ]);
  }
}
