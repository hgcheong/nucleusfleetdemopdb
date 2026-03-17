import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=314;

@RoutePage()
class CustMgmtCustPrgDetailScreen extends BaseScreen {
  const CustMgmtCustPrgDetailScreen(
      {super.key,
      @PathParam('custEttyId') this.custEttyId,
      @PathParam('prgEttyId') this.prgEttyId,
      @PathParam('CustMgmtCustPrgDetailRoute') this.billingEttyType})
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

  //custmgmt/prgsetup
  @override
  Widget sideTab() {
    return provideSideTab("custmgmt", id: custEttyId.toString());
  }

  @override
  Widget sideBar() {
    return provideSideBar("custmgmt/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custmgmt/prgsetup");
  }
}

Widget buildView2(bool isMobile) {
  return Scaffold(
    body: AcxTabView(routes: [
      CustMgmtBillingEntityLanding(),
      CustMgmtProgramFeeMediaLanding(),
      CustMgmtProgramDisRebLanding()
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
    ]),
  );
}
