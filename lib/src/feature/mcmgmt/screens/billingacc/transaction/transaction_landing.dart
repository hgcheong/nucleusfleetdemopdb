import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=711;

@RoutePage()
class MchtMgmtTxnLanding extends StatelessWidget {
  const MchtMgmtTxnLanding({super.key});

  @override
    Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return AcxTabView(routes: [
      // MchtMgmtTxnRecentLanding(),
      MchtMgmtTxnPostedLanding(),
  //    const MchtMgmtTxnOltpLanding(),
    ], tabs: const [
      // Tab(text: 'Recent'),
      Tab(text: 'Posted'),
     // Tab(text: 'OLTP'),
    ]);
    //return const Center(child: SelectableText('Text'));
    //return const AutoRouter();
  }
}
