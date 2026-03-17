import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/base_screen.dart';

const int wid=304;

@RoutePage()
class CustMgmtBillingLanding extends BaseScreen {
  const CustMgmtBillingLanding(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId})
      : super(
          includeMainDrawer: true,
        );
  final String? custEttyId;
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
    return provideSideBar("custmgmt");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custmgmt/main",id: custEttyId.toString());
  }

  @override
  Widget sideTab() {
    return provideSideTab("custmgmt", id: custEttyId.toString());
  }
}

Widget buildView(bool isMobile) {
  return const AutoRouter();
}
