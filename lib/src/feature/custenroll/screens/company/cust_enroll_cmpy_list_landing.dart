import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=278;

@RoutePage()
class CustEnrollCmpyListLanding extends BaseScreen {
  const CustEnrollCmpyListLanding(
      {super.key, @PathParam('custEttyId') this.custEttyId})
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
    return provideSideBar("custenroll/main");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custenroll/main");
  }

  @override
  Widget sideTab() {
    return provideSideTab("custenroll", id: custEttyId.toString());
  }
}

Widget buildView(bool isMobile) {
  return Scaffold(
    body: AcxTabView(
      routes: [
        CustEnrollCompanyList(),
      ],
      tabs: [
        Tab(
          text: S.current.tabCompany,
        ),
      ],
    ),
  );
}
