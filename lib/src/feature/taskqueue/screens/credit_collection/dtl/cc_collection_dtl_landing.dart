import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tab.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';

const int wid=785;

@RoutePage()
class CreditCollectionDtlLanding extends BaseScreen {
  const CreditCollectionDtlLanding({super.key});
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
        setTitle("Collection Main", ref);
    return buildView(true);
  }

  Widget buildView(bool isMobile) {

    return const Scaffold(
      body: AcxTabView(routes: [
//        CreditCollectionEventList(),
        CreditCollectionDtlTask(),
        CreditCollectionDtlAcct(),
        CreditCollectionDtlAcctContact(),
        CreditCollectionDtlAcctOverDue(),
      ], tabs: [
        AcxTab(wid: '923', text: 'Task'),
        AcxTab(wid: '923', text: 'Account'),
        AcxTab(wid: '923', text: 'Contact'),
        AcxTab(wid: '923', text: 'Overdue'),
      ]),
    );
  }
}
