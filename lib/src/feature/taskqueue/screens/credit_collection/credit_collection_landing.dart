import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tab.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=415;

@RoutePage()
class CreditCollectionLanding extends BaseScreen {
  const CreditCollectionLanding({super.key});
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
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("taskqueue/summary");
  }

  Widget buildView(bool isMobile) {
    return const Scaffold(
      body: AcxTabView(routes: [
//        CreditCollectionEventList(),
        CreditCollecitonSearch()
      ], tabs: [
        // AcxTab(
        //   wid: '923',
        //   text: 'Colleciton Event List',
        // ),
        AcxTab(wid: '923', text: 'Collection Search'),
      ]),
    );
  }
}
