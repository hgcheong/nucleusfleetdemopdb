import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=703;

@RoutePage()
class MchtMgmtBillingAutoPayLanding extends StatelessWidget {
  const MchtMgmtBillingAutoPayLanding({
    super.key,
  });

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return AcxTabView(
      routes: [MchtMgmtBillingAutoPay()],
      tabs: [Tab(text: S.current.tabAutoPayment)],
    );
  }
}
