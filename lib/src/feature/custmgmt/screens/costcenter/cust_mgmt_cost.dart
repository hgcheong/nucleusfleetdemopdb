import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/base_screen.dart';

const int wid=311;

@RoutePage()
class CustMgmtCostCenter extends BaseScreen {
  const CustMgmtCostCenter(
      {super.key, @PathParam('custEttyId') this.custEttyId})
      : super(
          includeMainDrawer: true,
        );
  final String? custEttyId;
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(false, custEttyId.toString());
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(true, custEttyId.toString());
  }

  @override
  Widget sideBar() {
    return provideSideBar("custmgmt/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custmgmt/main", id: custEttyId.toString());
  }

  @override
  Widget sideTab() {
    return provideSideTab("custmgmt", id: custEttyId.toString());
  }
}

Widget buildView(bool isMobile, String custEttyId) {
  final tabCM = useTabController(initialLength: 1);
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              labelColor: tabBarColor,
              dividerColor: Colors.transparent,
              isScrollable: true,
              controller: tabCM,
              tabs: const [
                Tab(
                  text: 'Cost Center',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1200,
            child:
                TabBarView(controller: tabCM, children: const [AutoRouter()]),
          )
        ],
      ),
    ),
  );
}
