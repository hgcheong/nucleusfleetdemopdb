import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=261;

@RoutePage()
class UserMgmtWebPortalLanding extends BaseScreen {
  const UserMgmtWebPortalLanding({super.key});

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }

  @override
  Widget sideTab() {
    return provideSideTab("");
  }

  @override
  Widget sideBar() {
  return provideSideBar("usermgmt/nucleususer");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("usermgmt/nucleususer");
  }

  Widget buildView() {
    return Scaffold(
      body: const AutoRouter(),
      appBar: AppBar(
        centerTitle: false,
        title: const SelectableText('WebPortal user'),
      ),
    );
  }
}
  