import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=755;

@RoutePage()
class MchtMgmtTADProfileStatusLanding extends BaseScreen {
  const MchtMgmtTADProfileStatusLanding(
      {super.key,
      @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? locEttyId;
  final String? mchtEttyId;
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(false, ref);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(true, ref);
  }

  @override
  Widget sideBar() {
    return provideSideBar("mcmgmt");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("mcmgmt/tadstatus");
  }

  @override
  Widget sideTab() {
    return provideSideTab("mcmgmt", id: mchtEttyId.toString());
  }

  Widget buildView(bool isMobile, WidgetRef ref) {
    return AcxTabView(
      routes: [
        MchtMgmtTADProfileStatus(),
      ],
      tabs: [
        Tab(
          text: S.current.tabTAD,
        ),
      ],
    );
  }
}
