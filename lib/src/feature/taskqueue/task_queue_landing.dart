import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/base_screen.dart';

const int wid=200;

@RoutePage()
class TaskQueueListLanding extends BaseScreen {
  const TaskQueueListLanding({
    super.key,
  }) : super(
          includeMainDrawer: true,
        );

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
    return provideSideBar("taskqueue");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("taskqueue");
  }

  @override
  Widget sideTab() {
    return provideSideTab("taskqueue");
  }
}

Widget buildView(bool isMobile) {
  return Scaffold(
      appBar: AppBar(
        title: const SelectableText('Task Queue List'),
        automaticallyImplyLeading: false, centerTitle: false,
      ),
      body: const AutoRouter());
}
