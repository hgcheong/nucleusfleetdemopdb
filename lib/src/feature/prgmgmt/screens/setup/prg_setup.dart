import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=149;
@RoutePage()
class PrgMgmtSetupScreen extends BaseScreen {
  const PrgMgmtSetupScreen({
    super.key,
    @PathParam('prgEttyId') this.prgEttyId,
  }) : super(
          includeMainDrawer: true,
        );
  final String? prgEttyId;
  static const spUsed = ['prgList'];
  static const spLangKeyPair = ['prgList'];

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    // return BuildView(isMobile: false, prgEttyId: prgEttyId);
    return const PrgSetupForm();
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    // return BuildView(isMobile: true, prgEttyId: prgEttyId);
    return const PrgSetupForm();
  }

  @override
  Widget sideTab() {
    return provideSideTab("prgmgmt/setup", id: prgEttyId.toString());
  }

  @override
  Widget sideBar() {
    return provideSideBar("prgmgmt/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("prgmgmt/setup");
  }
}

class PrgSetupForm extends ConsumerWidget {
  const PrgSetupForm({
    super.key,
    this.prgEttyId,
  });
  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return SingleChildScrollView(
      child: SizedBox(
        height: 1280,
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: AcxTabView(align: Alignment.centerLeft, routes: [
                PrgMgmtSetupGenInfo(),
              ], tabs: [
                Tab(
                  text: S.current.tabProgramSetting,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

