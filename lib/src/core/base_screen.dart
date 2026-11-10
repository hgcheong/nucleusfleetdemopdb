import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/config/seo/seo.dart';
import 'package:nucleusv2/src/core/app/session_provider.dart';
import 'package:nucleusv2/src/core/components/acx_app_bar_title.dart';
import 'package:nucleusv2/src/core/components/acx_breadcrumb.dart';
import 'package:nucleusv2/src/core/drawers/acx_side_drawer.dart';
import 'package:nucleusv2/src/core/drawers/acx_side_tab.dart';
import 'package:nucleusv2/src/core/drawers/side_drawer.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/core/models/drawer_item.dart';
import 'package:nucleusv2/src/feature/auth/components/auth_button.dart';
import 'package:nucleusv2/src/feature/auth/components/login_form.dart';
import 'package:nucleusv2/src/feature/home/home_screen.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';

abstract class BaseScreen extends HookConsumerWidget {
  const BaseScreen({
    super.key,
    this.verticalPadding = 8.0,
    this.horizontalPadding = 8.0,
    this.includeMainDrawer = true,
    this.seoPage,
  });

  final double verticalPadding;
  final double horizontalPadding;
  final bool includeMainDrawer;
  final SeoPage? seoPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuOpenClose = ref.watch(menuShowSideBarProvider);
    // final strSideBar = ref.watch(menuMainDrawerSelectProvider);
    //  final isLoading = ref.watch(uiIsLoadingProvider);
    final sessionProvider = ref.watch(sessionStateNotifierProvider);
    final isAuthenticated =
        sessionProvider.isAuthenticated && sessionProvider.user != null;
    if (isAuthenticated) {
      return Scaffold(
        appBar: menuOpenClose
                  ? AppBar(
            automaticallyImplyLeading: false, centerTitle: false,
            
            title: Row(
              children: [
                       SizedBox(
                    // Add the line below
                    height: 30,
                    child: Image.asset('assets/images/logologinpdb.png',
                        fit: BoxFit.fill)),
                mainTitle()
   
              ],
            ),
            bottom: breadCrumb(),
            actions:const [AuthButton()]):breadCrumb(),
        drawer: sideBar(),
        endDrawer: const Drawer(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: VwAttrForm(),
        )),
        // floatingActionButton: floatingActionButton(context, ref),
        body: DefaultTextStyle.merge(
          style: const TextStyle(
            fontSize: defaultFontSize,
            //  fontWeight: FontWeight.bold,
          ),
          child: Row(
            children: [
              menuOpenClose
                  ? SizedBox(width: 180, child: sideBar())
                  : Container(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Row(
                    //    children: [
                    //      Expanded(
                    //        child: Text(
                    //              theTitle ?? '',
                    //                   style: const TextStyle(
                    //                  fontSize: defaultFontSize,
                    //                  fontFamily: defaultFontFamily,
                    //                  fontWeight: FontWeight.bold,
                    //                  color: Colors.lightBlue),
                    //            ),
                    //      ),
                    //      Expanded(child: Text('...'),)
                    //    ],
                    //  ),
                    AcxAppBarTitle(),
                    Expanded(
                      flex: 11,
                      child: withTab(desktopBody(context, ref))),
                  ],
                )
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(body: Center(child: LoginForm()));
    }
  }


  Widget withTab(Widget child) {
    return Row(
      children: [
        SizedBox(width: 50, child: sideTab()),
        Expanded(flex: 12, child: child),
        //    Positioned(top:0, left:100, width: 500,height: 500, child: child),
      ],
    );
  }

  Widget mainTitle() {
    return provideTitle("");
  }

  Widget sideTab() {
    return provideSideTab("");
  }

  Widget sideBar() {
    return provideSideBar("");
  }

  Widget actionBar() {
    return Container();
  }

  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("");
  }

  AppBar? appBar(BuildContext context, WidgetRef ref) {
//    return AppBar();
    return AppBar(
        automaticallyImplyLeading: false, centerTitle: false);
  }

  FloatingActionButton? floatingActionButton(
      BuildContext context, WidgetRef ref) {
    return null;
  }

  Widget body(BuildContext context, WidgetRef ref) {
    return Container();
  }

  Widget desktopBody(BuildContext context, WidgetRef ref) {
    // defaults to using standard body if not overridden
    return body(context, ref);
  }
}

abstract class BaseStatefulScreen extends ConsumerStatefulWidget {
  const BaseStatefulScreen({
    super.key,
    this.verticalPadding = 8.0,
    this.horizontalPadding = 8.0,
    this.includeMainDrawer = false,
  });

  final double verticalPadding;
  final double horizontalPadding;
  final bool includeMainDrawer;

  @override
  BaseScreenState createState() => BaseScreenState();
}

 class OpenDialogIntent extends Intent {}

class BaseScreenState<T extends BaseStatefulScreen> extends ConsumerState<T> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: floatingActionButton(context),
        body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.horizontalPadding,
              vertical: widget.verticalPadding,
            ),
            // child: BreakPoints.useMobileLayout(context) ? body(context) : desktopBody(context)));
            child: desktopBody(context)));
  }

  AppBar? appBar(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false, centerTitle: false, 
        
        title: const AcxAppBarTitle());
  }

  FloatingActionButton? floatingActionButton(BuildContext context) {
    return null;
  }

  Widget body(BuildContext context) {
    return Container();
  }

  Widget desktopBody(BuildContext context) {
    // defaults to using standard body if not overridden
    return body(context);
  }
}

Widget provideTitle(String title) {
  return SizedBox(
    height: 50,
    width: 50,
    child: SvgPicture.asset(
      'assets/images/shelllogo.svg',
      colorFilter: const ColorFilter.mode(DbColors.primary, BlendMode.srcIn),
      height: 50,
      width: 50,
      allowDrawingOutsideViewBox: true,
    ),
  );
}

PreferredSizeWidget provideBreadCrumb(String breadcrumbId, {String id = ""}) {
  switch (breadcrumbId) {
    case "mcmgmt/tadstatus":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 118,
            title: S.current.sbUserManagement,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 119,
            title: S.current.sbNucleusUsers,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/usermgmgt/nucleususer')
      ]);
    case "usermgmt/nucleususer":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 1,
            title: S.current.sbUserManagement,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 2,
            title: S.current.sbNucleusUsers,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/usermgmt/nucleususer/accessrightslist/1')
      ]);
    case "usermgmt/webportaluser":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 3,
            title: S.current.sbUserManagement,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 4,
            title: S.current.sbNucleusUsers,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/usermgmt/nucleususer/accessrightslist/1')
      ]);
    case "masschange/main":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 5,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 6,
            title: S.current.sbMassChange,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/masschange/main')
      ]);
    case "report/onscreen":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 7,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 8,
            title: S.current.sbReportViewer,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/report/onscreen')
      ]);
    case "bulkmedia/main":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 9,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 10,
            title: S.current.sbBulkMediaProduction,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/bulkmedia'),
        DrawerItem(
            wid: 11,
            title: S.current.lblPendingBulkOrder,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/bulkmedia/pending')
      ]);
    case "dataentry/main":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 12,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 13,
            title: S.current.sbDataEntry,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/dataentry'),
        DrawerItem(
            wid: 14,
            title: S.current.sbMain,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/dataentry/main')
      ]);
    case "custenroll/main":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 15,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 16,
            title: S.current.sbCustomerEnrolment,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/custenroll/main')
      ]);
    case "custenroll/prgsetup":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 17,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 18,
            title: S.current.sbCustomerEnrolment,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/custenroll/main'),
        DrawerItem(
            wid: 19,
            title: S.current.lblProgramSetup,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/custenroll/cust/$id/program/list')
      ]);
    case "custmgmt/main":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 20,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 21,
            title: S.current.sbCustomerMangement,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/custmgmt/cust/$id/dashboard')
      ]);
    case "custmgmt/prgsetup":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 22,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 23,
            title: S.current.sbCustomerMangement,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/custmgmt/cust/$id/dashboard'),
        DrawerItem(
            wid: 24,
            title: S.current.lblProgramSetup,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/custmgmt/cust/$id/program/list')
      ]);
       
    case "mcenroll":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 25,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 26,
            title: S.current.sbMerchantEnrolment,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/mcenroll/main')
      ]);
    case "mcmgmt":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 27,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 28,
            title: S.current.sbMerchantManagement,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/mcmgmt/main')
      ]);
    case "taskqueue/summary":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 29,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 30,
            title: S.current.sbTaskQueue,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/dashboard/home')
      ]);
    case "Transaction":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 31,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 32,
            title: S.current.sbTransaction,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/dashboard/home')
      ]);
    case "prgmgmt/mchtsetup":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 33,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 34,
            title: S.current.sbMain,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/prgmgmt/main'),
        DrawerItem(
            wid: 35,
            title: S.current.lblMchtSetup,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/prgmgmt/main')
      ]);
    //prgmgmt/setup
    case "prgmgmt/setup":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 36,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 37,
            title: S.current.sbMain,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/prgmgmt/main'),
        DrawerItem(
            wid: 38,
            title: S.current.lblProgramSetup,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/prgmgmt/main')
      ]);
    case "prgmgmt/custsetup":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 39,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 40,
            title: S.current.sbMain,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/prgmgmt/main'),
        DrawerItem(
            wid: 41,
            title: S.current.lblCustSetup,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/prgmgmt/main')
      ]);
    case "prgmgmt/main":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 42,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 43,
            title: S.current.sbMain,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/prgmgmt/main')
      ]);
    case "subsidy/setup":
      return AcxBreadcrumb([
        DrawerItem(
            wid: 44,
            title: S.current.sbMain,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
        DrawerItem(
            wid: 45,
            title: S.current.lblSubPrgMgmt,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/subsidy/main')
      ]);
    default:
      return AcxBreadcrumb([
        DrawerItem(
            wid: 46,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
      ]);
  }
}

Widget provideSideTab(String sideTab, {String id = ""}) {
  switch (sideTab) {
    //custenroll/prgsetup
    case "mcmgmt":
      return AcxSideTab([
        DrawerItem(
            wid: 47,
            titleParam: {"MchtEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabMerchant,
            tooltipMessage: S.current.tabMerchant,
            theIcon: Icons.domain_outlined,
            route: '/mcmgmt/mcht/$id/quickinfo/overview'),
        DrawerItem(
            wid: 48,
            titleParam: {"MchtEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabBusinessUnit,
            tooltipMessage: S.current.tabBusinessUnit,
            theIcon: Icons.business_center_rounded,
            route: '/mcmgmt/bu/$id/list'),
        DrawerItem(
            wid: 49,
            titleParam: {"MchtEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabLocation,
            tooltipMessage: S.current.tabLocation,
            theIcon: Icons.store,
            route: '/mcmgmt/loc/$id/list'),
        DrawerItem(
            wid: 50,
            titleParam: {"MchtEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabTAD,
            tooltipMessage: S.current.tabTAD,
            theIcon: Icons.point_of_sale,
            route: '/mcmgmt/tad/$id/list'),
        DrawerItem(
            wid: 51,
            title: '',
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.enroll,
            tooltipMessage: '',
            svgSrc: '',
            route: ''),
        DrawerItem(
            wid: 52,
            titleParam: {"MchtEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabBillingAccount,
            tooltipMessage: S.current.tabBillingAccount,
            theIcon: Icons.request_quote,
            route: '/mcmgmt/billingAccount/$id/list'),
        // DrawerItem(
        //     wid: 53,
        //     titleParam: {"MchtEttyId": id},
        //     titleType: AppBarTitleType.management,
        //     title: S.current.tabReimburseMent,
        //     tooltipMessage: S.current.tabReimburseMent,
        //     theIcon: Icons.currency_exchange,
        //     route: '/mcmgmt/reimburse/$id/list'),
        // DrawerItem(
        //     wid: 54,
        //     title: S.current.tabApplication,
        //     tooltipMessage: S.current.tabApplication,
        //     theIcon: Icons.settings,
        //     route: '/mcmgmt/appuser/$id/list'),
      ]);
    case "mcenroll":
      return AcxSideTab([
        DrawerItem(
            wid: 55,
            titleParam: {"MchtEttyId": id},
            titleType: AppBarTitleType.enroll,
            title: S.current.tabMerchant,
            tooltipMessage: S.current.tabMerchant,
            theIcon: Icons.domain_outlined,
            route: '/mcenroll/mcht/$id/quickinfo/overview'),
        DrawerItem(
            wid: 56,
            titleParam: {"MchtEttyId": id},
            titleType: AppBarTitleType.enroll,
            title: S.current.tabBusinessUnit,
            tooltipMessage: S.current.tabBusinessUnit,
            theIcon: Icons.business_center_rounded,
            route: '/mcenroll/bu/$id/list'),
        DrawerItem(
            wid: 57,
            titleParam: {"MchtEttyId": id},
            titleType: AppBarTitleType.enroll,
            title: S.current.tabLocation,
            tooltipMessage: S.current.tabLocation,
            theIcon: Icons.store,
            route: '/mcenroll/loc/$id/list'),
        DrawerItem(
            wid: 58,
            titleParam: {"MchtEttyId": id},
            titleType: AppBarTitleType.enroll,
            title: S.current.tabTAD,
            tooltipMessage: S.current.tabTAD,
            theIcon: Icons.point_of_sale,
            route: '/mcenroll/tad/$id/list'),
        DrawerItem(
            wid: 59,
            title: '',
            titleParam: {"MchtEttyId": id},
            titleType: AppBarTitleType.enroll,
            tooltipMessage: '',
            svgSrc: '',
            route: ''),
        DrawerItem(
            wid: 60,
            titleParam: {"MchtEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabBillingAccount,
            tooltipMessage: S.current.tabBillingAccount,
            theIcon: Icons.request_quote,
            route: '/mcenroll/billingAccount/$id/list'),
      ]);
    case "custenroll/prgsetup":
      return AcxSideTab([
        DrawerItem(
            wid: 61,
            title: S.current.tabCustomer,
            tooltipMessage: S.current.tabCustomer,
            svgSrc: 'assets/icons/tabCustomer.svg',
            route: '/custenroll/cust/$id/program/list'),
      ]);
    case "custenroll":
      return AcxSideTab([
        DrawerItem(
            wid: 62,
            title: S.current.tabCustomer,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.enroll,
            tooltipMessage: S.current.tabCustomer,
            svgSrc: 'assets/icons/tabCustomer.svg',
            route: '/custenroll/cust/$id'),
        DrawerItem(
            wid: 63,
            title: S.current.tabCompany,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.enroll,
            tooltipMessage: S.current.tabCompany,
            svgSrc: 'assets/icons/tabCompany.svg',
            route: '/custenroll/cmpy/$id'),
        DrawerItem(
            wid: 64,
            title: S.current.tabCostCenter,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.enroll,
            tooltipMessage: S.current.tabCostCenter,
            svgSrc: 'assets/icons/tabCostCenter.svg',
            route: '/custenroll/costcen/$id'),
        DrawerItem(
            wid: 65,
            title: S.current.tabMember,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.enroll,
            tooltipMessage: S.current.tabMember,
            svgSrc: 'assets/icons/tabMember.svg',
            route: '/custenroll/member/$id/list'),
        DrawerItem(
            wid: 66,
            title: S.current.tabMedia,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.enroll,
            tooltipMessage: S.current.tabMedia,
            svgSrc: 'assets/icons/tabMedia.svg',
            route: '/custenroll/media/$id/list'),
        DrawerItem(
            wid: 67,
            title: '',
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.enroll,
            tooltipMessage: '',
            svgSrc: '',
            route: ''),
        DrawerItem(
            wid: 68,
            title: S.current.tabBillingAccount,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.enroll,
            tooltipMessage: S.current.tabBillingAccount,
            svgSrc: 'assets/icons/tabBillingAccount.svg',
            route: '/custenroll/billingAccount/$id/list'),
      ]);
    case "custmgmt":
      return AcxSideTab([
        DrawerItem(
            wid: 69,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabCustomer,
            tooltipMessage: S.current.tabCustomer,
            svgSrc: 'assets/icons/tabCustomer.svg',
            route: '/custmgmt/cust/$id'),
        DrawerItem(
            wid: 70,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabCompany,
            tooltipMessage: S.current.tabCompany,
            svgSrc: 'assets/icons/tabCompany.svg',
            route: '/custmgmt/cmpy/$id'),
        DrawerItem(
            wid: 71,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabCostCenter,
            tooltipMessage: S.current.tabCostCenter,
            svgSrc: 'assets/icons/tabCostCenter.svg',
            route: '/custmgmt/costcen/$id'),
        DrawerItem(
            wid: 72,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabMember,
            tooltipMessage: S.current.tabMember,
            svgSrc: 'assets/icons/tabMember.svg',
            route: '/custmgmt/member/$id/list'),
        DrawerItem(
            wid: 73,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabMedia,
            tooltipMessage: S.current.tabMedia,
            svgSrc: 'assets/icons/tabMedia.svg',
            route: '/custmgmt/media/$id/list'),
        DrawerItem(
            wid: 74,
            title: '',
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.management,
            tooltipMessage: '',
            svgSrc: '',
            route: ''),
        DrawerItem(
            wid: 75,
            titleParam: {"CustEttyId": id},
            titleType: AppBarTitleType.management,
            title: S.current.tabBillingAccount,
            tooltipMessage: S.current.tabBillingAccount,
            svgSrc: 'assets/icons/tabBillingAccount.svg',
            route: '/custmgmt/billingAccount/$id/list'),
      ]);
    case "prgmgmt/main":
      return Container();
    case "prgmgmt/custsetup":
      return AcxSideTab([
        DrawerItem(
            wid: 76,
            title: S.current.sbProgramGeneralSettings,
            tooltipMessage: S.current.sbProgramGeneralSettings,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/prgmgmt/setup/$id'),
        DrawerItem(
            wid: 77,
            title: S.current.sbMerchantLocSettings,
            tooltipMessage: S.current.sbMerchantLocSettings,
            svgSrc: 'assets/icons/business_black_24dp.svg',
            route: '/prgmgmt/mchtsetup/$id'),
        DrawerItem(
            wid: 78,
            title: S.current.sbCustMedSettings,
            tooltipMessage: S.current.sbCustMedSettings,
            svgSrc: 'assets/icons/person_black_24dp.svg',
            route: '/prgmgmt/custsetup/$id'),
      ]);
    case "prgmgmt/mchtsetup":
      return AcxSideTab([
        DrawerItem(
            wid: 79,
            title: S.current.sbProgramGeneralSettings,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/prgmgmt/setup/$id'),
        DrawerItem(
            wid: 80,
            title: S.current.sbMerchantLocSettings,
            svgSrc: 'assets/icons/business_black_24dp.svg',
            route: '/prgmgmt/mchtsetup/$id'),
        DrawerItem(
            wid: 81,
            title: S.current.sbCustMedSettings,
            svgSrc: 'assets/icons/person_black_24dp.svg',
            route: '/prgmgmt/custsetup/$id'),
      ]);
    case "prgmgmt/setup":
      return AcxSideTab([
        DrawerItem(
            wid: 82,
            title: S.current.sbProgramGeneralSettings,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/prgmgmt/setup/$id'),
        DrawerItem(
            wid: 83,
            title: S.current.sbMerchantLocSettings,
            svgSrc: 'assets/icons/business_black_24dp.svg',
            route: '/prgmgmt/mchtsetup/$id'),
        DrawerItem(
            wid: 84,
            title: S.current.sbCustMedSettings,
            svgSrc: 'assets/icons/person_black_24dp.svg',
            route: '/prgmgmt/custsetup/$id'),
      ]);
    case "Home":
      return const SideDrawer();
    case "Transaction":
      return AcxSideTab([
        DrawerItem(
            wid: 85,
            title: S.current.homeScreenTitle,
            tooltipMessage: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/'),
        DrawerItem(
            wid: 86,
            title: S.current.sbTransaction,
            tooltipMessage: S.current.sbTransaction,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/')
      ]);
    case "usermgmt/webportaluser":
      return AcxSideTab([
        DrawerItem(
            wid: 87,
            title: S.current.homeScreenTitle,
            tooltipMessage: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/person_black_24dp.svg',
            route: '/'),
        DrawerItem(
            wid: 88,
            title: S.current.sbTransaction,
            tooltipMessage: S.current.sbTransaction,
            svgSrc: 'assets/icons/shield.svg',
            route: '/usermgmt/webportaluser/accessrightslist/$id')
      ]);
    case "usermgmt/nucleusaccessrights":
      return AcxSideTab([
        DrawerItem(
            wid: 89,
            title: S.current.sbTransaction,
            tooltipMessage: S.current.sbTransaction,
            svgSrc: 'assets/icons/shield.svg',
            route: '/usermgmt/webportaluser/accessrightslist/$id')
      ]);
    case "subsidy/detail":
      return AcxSideTab([
        DrawerItem(
            wid: 90,
            title: S.current.sbProgramGeneralSettings,
            tooltipMessage: S.current.sbProgramGeneralSettings,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/subsidy/program/$id'),
        DrawerItem(
            wid: 91,
            title: S.current.sbMerchantLocSettings,
            tooltipMessage: S.current.tabPlan,
            svgSrc: 'assets/icons/business_black_24dp.svg',
            route: '/subsidy/planlist/$id'),
      ]);
    case "":
      return Container();
    default:
      return Container();
  }
}

Widget provideSideBar(String sideBar) {

  switch (sideBar) {
    case "usermgmt/nucleususer":
      return AcxSideDrawer([
        DrawerItem(
            wid: 120,
            title: S.current.sbWebGroup,
            svgSrc: 'assets/icons/cube.svg',
            route: '/usermgmt/webgroup'),
        DrawerItem(
            wid: 92,
            title: S.current.sbNucleusUsers,
            svgSrc: 'assets/icons/home.svg',
            route: '/usermgmt/nucleususer'),
        DrawerItem(
            wid: 93,
            title: S.current.sbWebPortalUsers,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/usermgmt/webportaluser'),
        // DrawerItem(
        //     wid: 94,
        //     title: S.current.sbNucleusAccessControl,
        //     svgSrc: 'assets/icons/cube.svg',
        //     route: '/usermgmt/nucleususer/accessrightslist/1'),
      ]);
    case "usermgmt/webportaluser":
      return AcxSideDrawer([
        DrawerItem(
            wid: 95,
            title: S.current.sbNucleusUsers,
            svgSrc: 'assets/icons/home.svg',
            route: '/usermgmt/nucleususer'),
        DrawerItem(
            wid: 96,
            title: S.current.sbWebPortalUsers,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/usermgmt/webportaluser'),
        // DrawerItem(
        //     wid: 97,
        //     title: S.current.sbNucleusAccessControl,
        //     svgSrc: 'assets/icons/cube.svg',
        //     route: '/usermgmt/nucleususer/accessrightslist/1'),
        //  DrawerItem(wid:98,title: S.current.screenList, svgSrc: 'assets/icons/cube.svg', route: '/unauthorised'),
      ]);
    case "masschange/main":
      return AcxSideDrawer([
        DrawerItem(
            wid: 99,
            title: S.current.sbMain,
            svgSrc: 'assets/icons/home.svg',
            route: '/masschange/main'),
        DrawerItem(
            wid: 100,
            title: S.current.changeCreditLimit,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/masschange/changecreexp')
      ]);
    case "report/onscreen":
      return AcxSideDrawer([
        DrawerItem(
            wid: 101,
            title: S.current.onScreenReports,
            svgSrc: 'assets/icons/home.svg',
            route: '/report/onscreen'),
        DrawerItem(
            wid: 102,
            title: S.current.scheduledReports,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/report/scheduled'),
              DrawerItem(
            wid: 102,
            title: S.current.menuQueryOLTP,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/report/query'),
        // DrawerItem(wid:103,title: S.current.auditLog, svgSrc: 'assets/icons/cube.svg', route: '/report/onscreen'),
        // DrawerItem(wid:104,title: S.current.pageTracking, svgSrc: 'assets/icons/cube.svg', route: '/report/onscreen'),
      ]);
    case "bulkmedia/main":
      return AcxSideDrawer([
        DrawerItem(
            wid: 105,
            title: S.current.lblPendingBulkOrder,
            svgSrc: 'assets/icons/home.svg',
            route: '/bulkmedia/pending'),
        DrawerItem(
            wid: 106,
            title: S.current.bulkOrderHistory,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/bulkmedia/his'),
        DrawerItem(
            wid: 107,
            title: S.current.newBulkOrder,
            svgSrc: 'assets/icons/cube.svg',
            route: '/bulkmedia/new'),
      ]);
    case "Home":
      return const SideDrawer();
    case "custenroll/setup":
      return AcxSideDrawer([
        DrawerItem(
            wid: 108,
            title: S.current.lblPendingEnrolment,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/custenroll/main'),
        DrawerItem(
            wid: 109,
            title: S.current.newB2BEnrollMent,
            svgSrc: 'assets/icons/cube.svg',
            route: '/custenroll/cust/new'),
      ]);
    case "custmgmt/setup":
      return AcxSideDrawer([
        DrawerItem(
            wid: 20,
            title: S.current.homeScreenTitle,
            svgSrc: 'assets/icons/home.svg',
            route: '/dashboard/home'),
      ]);
    case "subsidy/setup":
      return AcxSideDrawer([
//DrawerItem(title: 'Home', svgSrc: 'assets/icons/home.svg', route: '/dashboard/home'),
        DrawerItem(
            wid: 110,
            title: S.current.newSubsidyProgram,
            svgSrc: 'assets/icons/cube.svg',
            route: '/subsidy/main'),
      ]);
          case "pukal/webportaluser":
      return AcxSideDrawer([
        DrawerItem(
            wid: 95,
            title: S.current.sbNucleusUsers,
            svgSrc: 'assets/icons/home.svg',
            route: '/usermgmt/nucleususer'),
        DrawerItem(
            wid: 96,
            title: S.current.sbWebPortalUsers,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/usermgmt/webportaluser'),
        // DrawerItem(
        //     wid: 97,
        //     title: S.current.sbNucleusAccessControl,
        //     svgSrc: 'assets/icons/cube.svg',
        //     route: '/usermgmt/nucleususer/accessrightslist/1'),
        //  DrawerItem(wid:98,title: S.current.screenList, svgSrc: 'assets/icons/cube.svg', route: '/unauthorised'),
      ]);
    case "prgmgmt/setup":
      return AcxSideDrawer([
        DrawerItem(
            wid: 111,
            title: S.current.sbMain,
            svgSrc: 'assets/icons/boxes.svg',
            route: '/prgmgmt/main'),
        DrawerItem(
            wid: 112,
            title: S.current.newProgram,
            svgSrc: 'assets/icons/cube.svg',
            route: '/prgmgmt/setup/new'),
      ]);
    case "Transaction":
      return AcxSideDrawer([
        DrawerItem(
            wid: 113,
            title: S.current.sbTransaction,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/'),
        DrawerItem(
            wid: 114,
            title: S.current.sbMerchantEnrolment,
            svgSrc: 'assets/icons/menu_tran.svg',
            // ignore: prefer_const_constructors
            route: '/mcenroll/pending/list')
      ]);
       case "pukal/onscreen":
      return AcxSideDrawer([
        DrawerItem(
            wid: 886,
            title: S.current.sbPukalBillingProcess,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/pukal/billing'),
        DrawerItem(
            wid: 887,
            title: S.current.sbPukalReport,
            svgSrc: 'assets/icons/menu_tran.svg',
            // ignore: prefer_const_constructors
            route: '/pukal/report')
      ]);
         case "systemconfig":
      return AcxSideDrawer([
        DrawerItem(
            wid: 888,
            title: S.current.sbSiteSettings,
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/systemconfig/site'),
                DrawerItem(
            wid: 888,
            title: 'Log Req SP',
            svgSrc: 'assets/icons/menu_tran.svg',
            route: '/systemconfig/logreq'),

      ]);
    default:
      return const SideDrawer();
  }
}



