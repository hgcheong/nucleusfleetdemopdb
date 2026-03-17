import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=1;
@RoutePage()
class CustEnrollCustCmpyLanding extends BaseScreen {
  const CustEnrollCustCmpyLanding(
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
}

Widget buildView(bool isMobile, String? cmpyEttyId) {
  return AcxTabView(
    routes: [
      CustEnrollCmpyProfileLanding(),
       const CustEnrollCmpyProgramLanding(),
      CustEnrollCmpySubsidyLanding(),
      CustEnrollCmpyCtrlLanding(),
      CustEnrollCmpyCtrlCrEvaLanding(),
      CustEnrollCmpySecurityDepLanding()
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
              text: S.current.tabCreditAssessment,
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
