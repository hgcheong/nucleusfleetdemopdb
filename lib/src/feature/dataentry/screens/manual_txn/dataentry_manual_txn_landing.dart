import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/drawers/acx_side_tab.dart';
import 'package:nucleusv2/src/core/models/drawer_item.dart';
import 'package:nucleusv2/src/feature/dataentry/screens/manual_txn/dataentry_manual_provider.dart';

const int wid=343;

@RoutePage()
class DataEntryManualTxnLanding extends BaseScreen {
  const DataEntryManualTxnLanding({
    super.key,
  });

  // @override
  // Widget sideTab() {
  //   return const DataEntrySideTab();
  // }

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return const AutoRouter();
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return const AutoRouter();
  }
}

class DataEntrySideTab extends ConsumerWidget {
  const DataEntrySideTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final theId = ref.watch(dataentryTxnIdProvider);
    switch (theId) {
      case "new":
        return AcxSideTab([
          DrawerItem(
              wid: 115,
              title: S.current.tabMerchant,
              tooltipMessage: S.current.tabMerchant,
              svgSrc: 'assets/icons/tabCustomer.svg',
              route: '/dataentry/manual/dtl/$theId'),
        ]);
      case "":
        return Container();
      default:
        return AcxSideTab([
          DrawerItem(
              wid: 116,
              title: S.current.tabMerchant,
              tooltipMessage: S.current.tabMerchant,
              svgSrc: 'assets/icons/tabCustomer.svg',
              route: '/dataentry/manual/dtl/$theId'),
          DrawerItem(
              wid: 117,
              title: S.current.tabMerchant,
              tooltipMessage: S.current.tabMerchant,
              svgSrc: 'assets/icons/tabCustomer.svg',
              theIcon: Icons.abc_rounded,
              route: '/dataentry/manual/item/$theId'),
        ]);
    }
  }
}
