import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=364;

@RoutePage()
class MchtEnrlMerchantScreen extends BaseScreen {
  const MchtEnrlMerchantScreen(
      {super.key, @PathParam('mchtEttyId') this.mchtEttyId})
      : super(
          includeMainDrawer: true,
        );
  final String? mchtEttyId;
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView2(false, ref);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView2(true, ref);
  }

  @override
  Widget sideBar() {
    return provideSideBar("mcenroll/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("mcenroll");
  }

  @override
  Widget sideTab() {
    return provideSideTab("mcenroll", id: mchtEttyId.toString());
  }

  Widget buildView2(bool isMobile, WidgetRef ref) {
    return AcxTabView(
      routes: [
         MchtEnrlQuickInfoLanding(),
        MchtEnrlProfileLanding(),
        MchtEnrlDocLanding(),
      ],
      tabs: [
        Tab(
          text: S.current.tabQuickInfo,
        ),
        Tab(
          text: S.current.tabProfile,
        ),
        Tab(
          text: S.current.tabDocuments,
        ),
      ],
    );
  }
}
