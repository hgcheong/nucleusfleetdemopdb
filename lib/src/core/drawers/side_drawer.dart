import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/drawer_list_tile.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/feature/releasenote/release_note.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/user_mgmt_controller.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMenuSelected = ref.watch(menuMainDrawerSelectProvider);
    final accessCtrlProvider = ref.watch(userAccessControllerProvider);
    final toBlock = accessCtrlProvider!
        .where((c) => c.accessRightInd == "D" && c.moduleType == "sb")
        .toList();

    // return const Placeholder();
    List<DrawerListTile> defaultList = [
      // DrawerListTile(
      //   wid: 120,
      //   title: S.of(context).sbTaskQueue,
      //   svgSrc: "${svgPath}menu_tran.svg",
      //   // theIcon: Icons.list,
      //   thecolor: currentMenuSelected == S.of(context).sbTaskQueue
      //       ? tabBarColor
      //       : colorUnSelected,
      //   press: () {
      //     ref.read(menuMainDrawerSelectProvider.notifier).state =
      //         S.of(context).sbTaskQueue;
      //     ref.read(appBarTitleProvider.notifier).state = "";
      //     singleton<AppRouter>().navigatePath("/taskqueue/summary");
      //   },
      // ),
      DrawerListTile(
        wid: 121,
        title: S.of(context).sbCustomerEnrolment,
        svgSrc: "${svgPath}menu_tran.svg",
        thecolor: currentMenuSelected == S.of(context).sbCustomerEnrolment
            ? tabBarColor
            : colorUnSelected,
        press: () {
          singleton<AppRouter>().navigatePath("/custenroll/main");
          ref.read(appBarTitleProvider.notifier).state = "";
          ref.read(menuMainDrawerSelectProvider.notifier).state =
              S.of(context).sbCustomerEnrolment;
        },
      ),
      DrawerListTile(
        wid: 122,
        title: S.of(context).sbMerchantEnrolment,
        svgSrc: "${svgPath}menu_tran.svg",
        thecolor: currentMenuSelected == S.of(context).sbMerchantEnrolment
            ? tabBarColor
            : colorUnSelected,
        press: () {
          singleton<AppRouter>().navigatePath("/mcenroll/main");
          ref.read(appBarTitleProvider.notifier).state = "";
          ref.read(menuMainDrawerSelectProvider.notifier).state =
              S.of(context).sbMerchantEnrolment;
        },
      ),
      DrawerListTile(
        wid: 116,
        title: S.of(context).sbDataEntry,
        thecolor: currentMenuSelected == S.of(context).sbDataEntry
            ? tabBarColor
            : colorUnSelected,
        svgSrc: "${svgPath}menu_task.svg",
        press: () {
          ref.read(menuMainDrawerSelectProvider.notifier).state =
              S.of(context).sbDataEntry;
          ref.read(appBarTitleProvider.notifier).state = "";
          singleton<AppRouter>().navigatePath("/dataentry/main");
        },
      ),
      DrawerListTile(
        wid: 124,
        title: S.of(context).tabMediaRenewal,
        thecolor: currentMenuSelected == S.of(context).tabMediaRenewal
            ? tabBarColor
            : colorUnSelected,
        svgSrc: "${svgPath}menu_task.svg",
        press: () {
          ref.read(menuMainDrawerSelectProvider.notifier).state =
              S.of(context).tabMediaRenewal;
          ref.read(appBarTitleProvider.notifier).state = "";
          singleton<AppRouter>().navigatePath("/renewal/main");
        },
      ),
      // DrawerListTile(
      //   wid: 125,
      //   title: S.of(context).lblSubPrgMgmt,
      //   thecolor: currentMenuSelected == S.of(context).lblSubPrgMgmt
      //       ? tabBarColor
      //       : colorUnSelected,
      //   svgSrc: "${svgPath}menu_store.svg",
      //   press: () {
      //     ref.read(menuMainDrawerSelectProvider.notifier).state =
      //         S.of(context).sbReportViewer;
      //     ref.read(appBarTitleProvider.notifier).state = "";
      //     singleton<AppRouter>().navigatePath("/subsidy/main");
      //   },
      // ),
      DrawerListTile(
        wid: 126,
        title: S.of(context).sbProgramManagement,
        thecolor: currentMenuSelected == S.of(context).sbProgramManagement
            ? tabBarColor
            : colorUnSelected,
        svgSrc: "${svgPath}menu_store.svg",
        press: () {
          ref.read(appBarTitleProvider.notifier).state = "";
          ref.read(menuMainDrawerSelectProvider.notifier).state =
              S.of(context).sbProgramManagement;
          singleton<AppRouter>().navigatePath("/prgmgmt/main");
        },
      ),
      DrawerListTile(
        wid: 127,
        title: S.of(context).sbReportViewer,
        thecolor: currentMenuSelected == S.of(context).sbReportViewer
            ? tabBarColor
            : colorUnSelected,
        svgSrc: "${svgPath}menu_store.svg",
        press: () {
          ref.read(menuMainDrawerSelectProvider.notifier).state =
              S.of(context).sbReportViewer;
          ref.read(appBarTitleProvider.notifier).state = "";
          singleton<AppRouter>().navigatePath("/report/onscreen");
        },
      ),
      DrawerListTile(
        wid: 128,
        title: S.of(context).tabReimburseMent,
        thecolor: currentMenuSelected == S.of(context).tabReimburseMent
            ? tabBarColor
            : colorUnSelected,
        svgSrc: "${svgPath}menu_store.svg",
        press: () {
          ref.read(menuMainDrawerSelectProvider.notifier).state =
              S.of(context).tabReimburseMent;
          ref.read(appBarTitleProvider.notifier).state = "";
          singleton<AppRouter>().navigatePath("/reimburse/main/out");
        },
      ),
        DrawerListTile(
        wid: 885,
        title: S.of(context).sbPukalBillingProcess,
        thecolor: currentMenuSelected == S.of(context).sbPukalBillingProcess
            ? tabBarColor
            : colorUnSelected,
        svgSrc: "${svgPath}menu_store.svg",
        press: () {
          ref.read(menuMainDrawerSelectProvider.notifier).state =
              S.of(context).sbPukalBillingProcess;
          ref.read(appBarTitleProvider.notifier).state = "";
          singleton<AppRouter>().navigatePath("/pukal/billing");
        },
      ),
      
      DrawerListTile(
        wid: 129,
        title: S.of(context).sbUserManagement,
        thecolor: currentMenuSelected == S.of(context).sbUserManagement
            ? tabBarColor
            : colorUnSelected,
        svgSrc: "${svgPath}menu_store.svg",
        press: () {
          ref.read(menuMainDrawerSelectProvider.notifier).state =
              S.of(context).sbUserManagement;
          ref.read(appBarTitleProvider.notifier).state = "";
          singleton<AppRouter>().navigatePath("/usermgmt/nucleususer");
        },
      ),
      DrawerListTile(
        wid: 879,
        title: S.of(context).sbCMSUpload,
        thecolor: currentMenuSelected == S.of(context).sbCMSUpload
            ? tabBarColor
            : colorUnSelected,
        svgSrc: "${svgPath}menu_store.svg",
        press: () {
          ref.read(menuMainDrawerSelectProvider.notifier).state =
              S.of(context).sbCMSUpload;
          ref.read(appBarTitleProvider.notifier).state = "";
          singleton<AppRouter>().navigatePath("/cclickcms/upload");
        },
      ),
        DrawerListTile(
        wid: 880,
        title: S.of(context).sbSystemConfiguration,
        thecolor: currentMenuSelected == S.of(context).sbSystemConfiguration
            ? tabBarColor
            : colorUnSelected,
        svgSrc: "${svgPath}menu_store.svg",
        press: () {
          ref.read(menuMainDrawerSelectProvider.notifier).state =
              S.of(context).sbSystemConfiguration;
          ref.read(appBarTitleProvider.notifier).state = "";
          singleton<AppRouter>().navigatePath("/systemconfig/site/list");
        },
      )
    ];
    defaultList = getAccessDrawerListTile(defaultList, toBlock);
    return Drawer(
      //  backgroundColor: const Color.fromARGB(255, 189, 175, 43),
      // width: BreakPoints.useTabletLayout(context) ? 50 : 200,
      //  width:  200,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 11,
              child: ListView(
                children: [...defaultList],
              ),
            ),
            Expanded(
              flex: 1,
              child: DrawerListTile(
        wid: 0,
        title: 'Build v10618',
        thecolor: DbColors.primary,
        press: () async {
 await showAcxDialog(
                              context,
                              ReleaseNote(
                                moduleName: "ReleaseNote/Nucleus",
                                rpstryType: "BHP/UI/",
                              ),
                            );
        },
      ),),

          ],
        ),
      ),
    );
  }
}


//  PukalFileS3Src(
//                                 moduleName: "ReleaseNote",
//                                 rpstryType: "Nucleus",
//                               ),
