import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';


const int wid=884;

@RoutePage()
class PukalListLanding extends BaseScreen {
  const PukalListLanding({super.key});

  // static const List<PageRouteInfo> routes = [PrgmgmtmainTabRouter()];

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(context);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(
      context,
    );
  }

  @override
  Widget sideTab() {
    return provideSideTab("");
  }

  @override
  Widget sideBar() {
    return provideSideBar("pukal/onscreen");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("pukal/onscreen");
  }
}

Widget buildView(
  BuildContext context,
) {
  return   AcxTabView(align: Alignment.centerLeft, routes: [
    PukalListOutbound(),
    PukalListInbound(),
  ], tabs: [
    Tab(
      text: S.current.sbOutbound,
    ),
     Tab(
      text: S.current.sbInbound,
    ),
  ]);
}