import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/base_screen.dart';

const int wid=374;

@RoutePage()
class MchtMgmtBillingLanding extends BaseScreen {
  const MchtMgmtBillingLanding(
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
  return const AutoRouter();
}
