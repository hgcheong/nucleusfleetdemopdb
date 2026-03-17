import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=230;

@RoutePage()
class SubsidymgmtPlanLanding extends BaseScreen {
  const SubsidymgmtPlanLanding({
    super.key,
    @PathParam('subsId') this.subsId,
  });

  final String? subsId;
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }

  @override
  Widget sideTab() {
    return provideSideTab("subsidy/detail", id: subsId.toString());
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }

  Widget buildView() {
    return Scaffold(
      body: AcxTabView(
        routes: [SubsidymgmtPlan()],
        tabs: [
          Tab(
            text: S.current.tabPlan,
          ),
        ],
      ),
      appBar: AppBar(
        title: const SelectableText('Subsidy Plan'),
        automaticallyImplyLeading: false, centerTitle: false,
      ),
    );
  }
}
