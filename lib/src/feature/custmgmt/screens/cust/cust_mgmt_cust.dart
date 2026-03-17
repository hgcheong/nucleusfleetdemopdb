import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=313;

@RoutePage()
class CustMgmtCustScreen extends BaseScreen {
  const CustMgmtCustScreen(
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
    return buildView2(false);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView2(true);
  }

  @override
  Widget sideBar() {
    return provideSideBar("custmgmt/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custmgmt/main", id: custEttyId.toString());
  }

  @override
  Widget sideTab() {
    return provideSideTab("custmgmt", id: custEttyId.toString());
  }
}

Widget buildView2(bool isMobile) {
  return Scaffold(
    body: AcxTabView(
      routes: [
        const CustMgmtDashBoard(),
        CustMgmtQuickInfoLanding(),
        CustMgmtProfileLanding(),
        const CustMgmtProgramLanding(),
        CustMgmtSubsidyLanding(),
        CustMgmtDocLanding(),
        CustMgmtEventLanding()
      ],
      tabs: [
        Tab(
          text: S.current.sbDashboard,
        ),
        Tab(
          text: S.current.tabQuickInfo,
        ),
        Tab(
          text: S.current.tabProfile,
        ),
        Tab(
          text: S.current.tabProgramSetting,
        ),
           Tab(
          text: S.current.tabSubsidyQuota,
        ),
        Tab(
          text: S.current.tabDocuments,
        ),
        Tab(
          text: S.current.tabEventAndNotes,
        ),
      ],
    ),
  );
}
