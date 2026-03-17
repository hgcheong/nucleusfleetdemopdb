import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=282;

@RoutePage()
class CustEnrollCustPrgDetailScreen extends BaseScreen {
  const CustEnrollCustPrgDetailScreen(
      {super.key,
      @PathParam('custEttyId') this.custEttyId,
      @PathParam('prgEttyId') this.prgEttyId,
      @PathParam('CustEnrollCustPrgDetailRoute') this.billingEttyType})
      : super(
          includeMainDrawer: true,
        );
  final String? custEttyId;
  final String? prgEttyId;
  final String? billingEttyType;
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

  //custenroll/prgsetup
  @override
  Widget sideTab() {
    return provideSideTab("custenroll", id: custEttyId.toString());
  }

  @override
  Widget sideBar() {
    return provideSideBar("custenroll/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custenroll/prgsetup");
  }
}

Widget buildView2(bool isMobile) {
  return AcxTabView(routes: [
    CustEnrollBillingEntityLanding(),
    CustEnrollProgramFeeMediaLanding(),
    CustEnrollProgramDisRebLanding()
  ], tabs: [
    Tab(
      text: S.current.tabBilling,
    ),
    Tab(
      text: S.current.tabFees,
    ),
    Tab(
      text: S.current.tabDiscRebate,
    ),
  ]);
}
