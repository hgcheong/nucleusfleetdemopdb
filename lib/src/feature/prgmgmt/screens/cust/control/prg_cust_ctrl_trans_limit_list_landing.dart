import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=154;
@RoutePage()
class PrgCustCtrlTransLimitListLanding extends StatelessWidget {
  const PrgCustCtrlTransLimitListLanding({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return AcxTabView(align: Alignment.centerLeft, routes: [
      PrgCustCtrlTransLimitList(),
    ], tabs: [
      Tab(
        text: S.current.tabTransactionLimits,
      ),
    ]);
  }
}
