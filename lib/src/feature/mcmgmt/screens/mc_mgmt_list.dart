import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/feature/mcmgmt/mc_mgmt_controller.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=227;

@RoutePage()
class MchtMgmtListScreen extends BaseScreen {
  const MchtMgmtListScreen({super.key})
      : super(
          includeMainDrawer: true,
        );

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(context, ref);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(context, ref);
  }

  @override
  Widget sideBar() {
    return provideSideBar("mcmgmt/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("mcmgmt");
  }
}

Widget buildView(BuildContext context, WidgetRef ref) {
  return Scaffold(
    body: ListView(
      children: [
        AcxTrinaGridWithColumn(
          querysql: '/sp/ApiMchtMgmtList/queryasync',
          spName: 'ApiMchtMgmtList',
          params: const {},
          idField: 'MchtEttyId',
          navPrefix: 'mcmgmt/main',
          useNav: false,
          onSelectedTap: (TrinaRow val) {
            singleton<AppRouter>().navigatePath(
                '/mcmgmt/mcht/${val.cells['MchtEttyId']!.value}/quickinfo/overview');
            ref.read(mchtMgmtNameProvider.notifier).state =
                val.cells['MchtName']!.value;
            ref.read(menuMainDrawerSelectProvider.notifier).state = "Merchant";
          },
          onNew: () {
              if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
            singleton<AppRouter>().navigatePath('/mcmgmt/pending/new');
          },
        )
      ],
    ),
    appBar: AppBar(
      title: SelectableText(S.of(context).lblMerchantManagement),
      automaticallyImplyLeading: false, centerTitle: false,
    ),
  );
}
