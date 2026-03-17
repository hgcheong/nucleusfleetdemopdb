import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/feature/custenroll/screens/member/mbrinfo/cust_enroll_mbr_info.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=298;

@RoutePage()
class CustEnrollMemberList extends ConsumerWidget {
  const CustEnrollMemberList(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    //  return const SelectableText('Cust Enroll Member List');

    return ListView(children: [
      AcxTrinaGridWithColumn(
        querysql: '/sp/ApiEnrlMbrList/queryasync',
        spName: 'ApiEnrlMbrList',
        params: {"CustEttyId": custEttyId},
        idField: 'MbrEttyId',
        navPrefix: '',
        onNew: () {
            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          ref.read(mbrCostCenterProvider.notifier).state = {
            "CustEttyId": custEttyId,
            "CmpyEttyId": null
          };
          singleton<AppRouter>().navigatePath(
              '/custenroll/member/$custEttyId/detail/new/memberinfo/membership');
        },
        onSelectedTap: (TrinaRow val) {
          getTitle(
                  ref,
                  {"CustEttyId": val.cells["CustEttyId"]!.value.toString()},
                  AppBarTitleType.enroll)
              .then((value) {
            ref.read(appBarTitleProvider.notifier).state = value.toString();
            ref.read(mbrCostCenterProvider.notifier).state = {
              "CustEttyId": val.cells["CustEttyId"]!.value.toString(),
              "CmpyEttyId": val.cells["CmpyEttyId"]!.value.toString()
            };
            singleton<AppRouter>().navigatePath(
                '/custenroll/member/$custEttyId/detail/${val.cells['MbrEttyId']!.value.toString()}/memberinfo/membership');
          });
        },
        useNav: false,
      ),
    ]);
  }
}
