import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';

const int wid=173;

@RoutePage()
class MassChangeMain extends BaseScreen {
  const MassChangeMain({super.key});

  // static const List<PageRouteInfo> routes = [PrgmgmtmainTabRouter()];

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
  Widget sideBar() {
    return provideSideBar("masschange/main");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("masschange/main");
  }

  Widget buildView() {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sbh20,
            SelectableText('Customer Module'),
            sbh20,
            Wrap(runSpacing: 10, children: [
              AcxNavButton(listOfContent: [
                SelectableText('Cahnge Top-up'),
                SelectableText('Credit Expirty by'),
                SelectableText('Bulk Production'),
                SelectableText('Batch')
              ], listOfButton: []),
              sbw10,
            ]),
            sbh20,
            SelectableText('Merchant Module'),
            sbh20,
            Wrap(runSpacing: 10, children: []),
          ],
        ),
      ),
      appBar: AppBar(
        title: const SelectableText('Mass Change'),
        automaticallyImplyLeading: false, centerTitle: false,
      ),
    );
  }
}
