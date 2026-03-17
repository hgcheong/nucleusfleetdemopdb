import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=652;

@RoutePage()
class MchtEnrlBusinessUnitGenInfoLanding extends BaseScreen {
  const MchtEnrlBusinessUnitGenInfoLanding(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam('busnUnitEttyId') this.busnUnitEttyId});

  final String? busnUnitEttyId;
  final String? mchtEttyId;
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(false, context);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(true, context);
  }

  @override
  Widget sideBar() {
    return provideSideBar("home");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("mcenroll");
  }

  @override
  Widget sideTab() {
    return provideSideTab("mcenroll", id: mchtEttyId.toString());
  }

  Widget buildView(bool isMobile, BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1280,
          child: AcxTabView(align: Alignment.centerLeft, routes: [
            MchtEnrlBusinessUnitGenInfo(),
          ], tabs: [
            Tab(text: S.current.lblGeneralInfo),
          ]),
        ),
      ),
    );
  }
}
