import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=661;

@RoutePage()
class MchtEnrlocPrgDetailLanding extends BaseScreen {
  const MchtEnrlocPrgDetailLanding({
    super.key,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
  });

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
    return provideSideBar("mcenroll");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("mcenroll");
  }

  @override
  Widget sideTab() {
    return provideSideTab("mcenroll", id: mchtEttyId.toString());
  }

  Widget buildView(bool isMobile) {
    return Scaffold(
      appBar: AppBar(
        title: const SelectableText("Location Program Setup"),
        automaticallyImplyLeading: false, centerTitle: false,
      ),
      body: AcxTabView(
        routes: const [
         // MchtEnrlLocPrgFeesLanding(),
          MchtEnrlLocPrgTranPlanLanding(),
       //   MchtEnrlLocPrgControlLanding()
        ],
        tabs: [
          // Tab(
          //   text: S.current.tabFees,
          // ),
          Tab(
            text: S.current.tabTransactionPlan,
          ),
          // Tab(
          //   text: S.current.tabControl,
          // ),
        ],
      ),
    );
  }
}
