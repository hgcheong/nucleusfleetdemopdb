import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=886;

@RoutePage()
class SystemConfigSiteLanding extends BaseScreen {
  const SystemConfigSiteLanding({super.key});

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
    return provideSideBar("systemconfig");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("systemconfig");
  }
}

Widget buildView(
  BuildContext context,
) {
  return Scaffold(
    appBar: AppBar(title: const Text('Site Settings'),
    automaticallyImplyLeading: false,
    leadingWidth: 0,
    centerTitle: false,
    ),
    body:  const AutoRouter(),
  );
}