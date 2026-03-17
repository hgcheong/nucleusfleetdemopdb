import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=308;

@RoutePage()
class CustMgmtCustCmpyLanding extends BaseScreen {
  const CustMgmtCustCmpyLanding(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam('cmpyEttyId') this.cmpyEttyId})
      : super(
          includeMainDrawer: true,
        );
  final String? custEttyId;
  final String? cmpyEttyId;

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(false, cmpyEttyId);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(true, cmpyEttyId);
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

Widget buildView(bool isMobile, String? cmpyEttyId) {
  return AcxTabView(
    routes: [
      CustMgmtCmpyProfileLanding(),
      const CustMgmtCmpyProgramLanding(),
      CustMgmtCmpySubsidyLanding(),
      CustMgmtCmpyCtrlLanding(),
      CustMgmtCmpyCtrlCrEvaLanding(),
      CustMgmtCmpySecurityDepLanding()
    ],
    tabs: [
      Tab(
        text: S.current.tabProfile,
      ),
      (cmpyEttyId == null || cmpyEttyId == 'new')
          ? const Tab(
              text: '',
              height: 0,
            )
          : Tab(
              text: S.current.tabProgramAcceptance,
            ),
      (cmpyEttyId == null || cmpyEttyId == 'new')
          ? const Tab(
              text: '',
              height: 0,
            )
          : Tab(
              text: S.current.tabSubsidyQuota,
            ),
      (cmpyEttyId == null || cmpyEttyId == 'new')
          ? const Tab(
              text: '',
              height: 0,
            )
          : Tab(
              text: S.current.tabControl,
            ),
      (cmpyEttyId == null || cmpyEttyId == 'new')
          ? const Tab(
              text: '',
              height: 0,
            )
          : Tab(
              text: S.current.tabCreditRiskControl,
            ),
      (cmpyEttyId == null || cmpyEttyId == 'new')
          ? const Tab(
              text: '',
              height: 0,
            )
          : Tab(
              text: S.current.tabSecurityDeposit,
            ),
    ],
  );
}
