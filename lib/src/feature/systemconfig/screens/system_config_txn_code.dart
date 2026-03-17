import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=245;

@RoutePage()
class SystemConfigTxnCode extends StatelessWidget {
  const SystemConfigTxnCode({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return AcxTabView(
      routes: [PrgMgmtSetupGenInfo()],
      tabs: const [
        Tab(
          text: 'General Info',
        )
      ],
    );
    // return AutoTabsRouter.tabBar(routes: const [PrgMgmtSetupGenInfoRoute()], builder: (context, child, tabController) {
    //   return Column(children: [
    //     Expna
    //   ],)
    // },);
  }
}
