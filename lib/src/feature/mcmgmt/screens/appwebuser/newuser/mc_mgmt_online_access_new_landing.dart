import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=694;

@RoutePage()
class MchtMgmtOnlineAccessNewLanding extends BaseScreen {
  const MchtMgmtOnlineAccessNewLanding(
      {super.key, @PathParam.inherit('mchtEttyId') this.mchtEttyId})
      : super(
          includeMainDrawer: true,
        );
  final String? mchtEttyId;
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(false);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(true);
  }

  @override
  Widget sideBar() {
    return provideSideBar("mcmgmt");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("mcmgmt");
  }

  @override
  Widget sideTab() {
    return provideSideTab("mcmgmt", id: mchtEttyId.toString());
  }
}

Widget buildView(bool isMobile) {
  return Scaffold(
    body: AcxTabView(
      routes: [MchtMgmtOnlineAccessNew()],
      tabs: [
        Tab(text: S.current.tabAppWebUsers),
      ],
    ),
  );
}
