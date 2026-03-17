import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=746;

@RoutePage()
class MchtMgmtQuickInfoLanding extends StatelessWidget {
  const MchtMgmtQuickInfoLanding({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: AcxTabView(align: Alignment.centerLeft, routes: [
            MchtMgmtQuickInfoOverView(),
            // MchtMgmtQuickInfoCheckList(),
            // MchtMgmtQuickInfoApprvHist(),
          ], tabs: [
            Tab(
              text: S.current.tabOverview,
            ),
            // Tab(
            //   text: S.current.tabCustEnrollCheckList,
            // ),
            // Tab(
            //   text: S.current.tabApprovalHistory,
            // ),
          ]),
        ),
      ],
    );
  }
}
