import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=710;

@RoutePage()
class MchtMgmtBillingAcctStatusLanding extends ConsumerWidget {
  const MchtMgmtBillingAcctStatusLanding(
      {super.key,
      @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? locEttyId;
  final String? mchtEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return AcxTabView(
      routes: [
        MchtMgmtBillingAcctStatus(),
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
//     return provideSideBar("mcmgmt");
//   }

//   @override
//   PreferredSizeWidget breadCrumb() {
//     // return provideBreadCrumb("mcmgmt");
//     return AcxBreadcrumb([DrawerItem(title: S.current.sbUserManagement, svgSrc: 'assets/icons/home.svg', route: '/dashboard/home'), DrawerItem(title: S.current.sbNucleusUsers, svgSrc: 'assets/icons/menu_tran.svg', route: '/usermgmgt/nucleususer')]);
//   }

//   @override
//   Widget sideTab() {
//     return provideSideTab("mcmgmt", id: mchtEttyId.toString());
//   }

//   Widget buildView(bool isMobile, WidgetRef ref) {

//     return appTitleWidget(
//       ref,
//       {"LocEttyId": locEttyId},
//       const AutoRouter()
//       // AcxTabView(
//       //   routes: [
//       //     MchtMgmtBillingAcctStatus(),
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
