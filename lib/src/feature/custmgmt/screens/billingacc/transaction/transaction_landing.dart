import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=541;

@RoutePage()
class CustMgmtTxnLanding extends StatelessWidget {
  const CustMgmtTxnLanding({super.key});

  @override
  Widget build(Object context) {
   

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return AcxTabView(routes: [
    //  CustMgmtTxnOltpLanding(),
    //   CustMgmtTxnPostedLanding(),
      CustMgmtTxnBilledLanding(),
      CustMgmtTxnUnBilledLanding()
      // CustMgmtTxnRecentLanding(),
    ], tabs: const [
      // Tab(text: 'OLTP'),
      // Tab(text: 'Posted'),
      Tab(text: 'Billed'),
      Tab(text: 'UnBilled'),
  
    ]);
    //return const Center(child: SelectableText('Text'));
    //return const AutoRouter();
  }
}
