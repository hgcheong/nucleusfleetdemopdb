import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/base_screen.dart';

const int wid=272;

@RoutePage()
class CustEnrollBillingDetailLanding extends BaseScreen {
  const CustEnrollBillingDetailLanding(
      {super.key, @PathParam('custEttyId') this.custEttyId});

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
    return provideSideBar("custenroll/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custenroll/main");
  }

  @override
  Widget sideTab() {
    return provideSideTab("custenroll", id: custEttyId.toString());
  }

  Widget buildView(bool isMobile) {
    return const AutoRouter();
  }
}
