import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=540;

@RoutePage()
class CustMgmtBillingAcctStatusLanding extends ConsumerWidget {
  const CustMgmtBillingAcctStatusLanding(
      {super.key,
      @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam.inherit('custEttyId') this.custEttyId});

  final String? locEttyId;
  final String? custEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return AcxTabView(
      routes: [
        CustMgmtBillingAcctStatus(),
      ],
      tabs: [
        Tab(
          text: S.current.tabAccount,
        ),
      ],
    );
  }
}
//   @override
//   Widget desktopBody(BuildContext context, WidgetRef ref) {
//     return buildView(false, ref);
//   }

//   @override
//   Widget body(BuildContext context, WidgetRef ref) {
//     return buildView(true, ref);
//   }

//   @override
//   Widget sideBar() {
//     return provideSideBar("custmgmt");
//   }

//   @override
//   PreferredSizeWidget breadCrumb() {
//     // return provideBreadCrumb("custmgmt");
//     return AcxBreadcrumb([DrawerItem(title: S.current.sbUserManagement, svgSrc: 'assets/icons/home.svg', route: '/dashboard/home'), DrawerItem(title: S.current.sbNucleusUsers, svgSrc: 'assets/icons/menu_tran.svg', route: '/usermgmgt/nucleususer')]);
//   }

//   @override
//   Widget sideTab() {
//     return provideSideTab("custmgmt", id: custEttyId.toString());
//   }

//   Widget buildView(bool isMobile, WidgetRef ref) {

//     return appTitleWidget(
//       ref,
//       {"LocEttyId": locEttyId},
//       const AutoRouter()
//       // AcxTabView(
//       //   routes: [
//       //     CustMgmtBillingAcctStatus(),
//       //   ],
//       //   tabs: [
//       //     Tab(
//       //       text: S.current.tabLocation,
//       //     ),
//       //   ],
//       // ),
//     );
//   }

// }
