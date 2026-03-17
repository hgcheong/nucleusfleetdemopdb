import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/routes/bulkmedia_route.dart';
import 'package:nucleusv2/src/core/routes/cclickcms_route.dart';
import 'package:nucleusv2/src/core/routes/custenroll_route.dart';
import 'package:nucleusv2/src/core/routes/custmgmt_route.dart';
import 'package:nucleusv2/src/core/routes/dataentry_route.dart';
import 'package:nucleusv2/src/core/routes/masschange_route.dart';
import 'package:nucleusv2/src/core/routes/mcenroll_route.dart';
import 'package:nucleusv2/src/core/routes/mcmgmt_route.dart';
import 'package:nucleusv2/src/core/routes/mediarenewal_route.dart';
import 'package:nucleusv2/src/core/routes/prgmgmt_route.dart';
import 'package:nucleusv2/src/core/routes/pukal_route.dart';
import 'package:nucleusv2/src/core/routes/reimbursement_route.dart';
import 'package:nucleusv2/src/core/routes/reportviewer_route.dart';
import 'package:nucleusv2/src/core/routes/subsidyprgmgmt_route.dart';
import 'package:nucleusv2/src/core/routes/systemconfig_route.dart';
import 'package:nucleusv2/src/core/routes/taskqueue_route.dart';
import 'package:nucleusv2/src/core/routes/usermgmt_route.dart';
import 'app_router.gr.dart';

//@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  late final List<AutoRouteGuard> guards = [
    AutoRouteGuard.simple(
      (resolver, router) {
        if(router.current.meta.containsKey("SetupId")){
    // if(router.current.meta["SetupId"]==6000){
    //      Toast.error("Not ALlowed");
    //      return; 
    //     }
        }

        resolver.next();
        
        // if(isAuthenticated || resolver.routeName == LoginRoute.name) {
        //   // we continue navigation
        //   resolver.next();
        // } else {
        //   // else we navigate to the Login page so we get authenticated

        //   // tip: use resolver.redirect to have the redirected route
        //   // automatically removed from the stack when the resolver is completed
        //   resolver.redirect(LoginRoute(onResult: (didLogin) => resolver.next(didLogin)));
        // }
      },
    ),
    // add more guards here
  ];

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        // AutoRoute( path: '/', page: AuthLandingRoute.page),
        AutoRoute(initial: true, path: '/', page: LoginRoute.page),
        AutoRoute(path: '/landing', page: AuthLandingRoute.page),
        //   AutoRoute( path: '/auth/login', page: LoginRoute.page),
        RedirectRoute(path: '/auth/login', redirectTo: '/'),
        //  AutoRoute(  path: '/auth/login', page: LoginRoute.page),
        AutoRoute(path: '/auth/register', page: RegisterRoute.page),
        AutoRoute(
            path: '/auth/confirm/phone-number',
            page: TwoFactorConfirmationRoute.page),
        AutoRoute(path: '/style-guide', page: StyleguideRoute.page),
        AutoRoute(path: '/settings', page: SettingsRoute.page),
        AutoRoute(path: '/settings/profile', page: EditProfileRoute.page),
        AutoRoute(
            path: '/update-password/:token', page: UpdatePasswordRoute.page),
        AutoRoute(
            path: '/email-change/:token',
            page: EmailChangeConfirmationRoute.page),
        dashboardTabRouter,
        taskqueyTabRouter,
        custenrollTabRouter,
        custmgmtTabRouter,
        mcenrollTabRouter,
        mcmgmtTabRouter,
        dataentryTabRouter,
        mediaRenewalRouter,
        masschangeTabRouter,
        bulkemediaTabRouter,
        rptViewerTabRouter,
        subsidymgmtTabRouter,
        // onlinemtrTabRouter,
        prgmgmtTabRouter,
        // workflowmgmtTabRouter,
        usermgmtTabRouter,
        systemconfigTabRouter,
        testTabRouter,
        reimbursementTabRouter,
        pukaltabRouter,
        cclickCMStabRouter,
      //  AutoRoute(path: '/unauthorised', page: NotAuthorised.page),
        // RedirectRoute(path: '*', redirectTo: '/'),
        RedirectRoute(path: '*', redirectTo: '/')
      ];
}

final testTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    duration: Duration(milliseconds: defaultTransTime),
    path: "/testing",
    page: TestingMain.page,
    children: [
      AutoRoute(page: RowandColumn.page, usesPathAsKey: true),
      AutoRoute(page: RowandColumn2.page, usesPathAsKey: true),
    ]);

final onlinemtrTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    duration: Duration(milliseconds: defaultTransTime),
    path: "/onlinemtr",
    page: OnlineNetworkMtrContainer.page,
    children: const []);

final workflowmgmtTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
     duration: Duration(milliseconds: defaultTransTime),
    path: "/workflowmgmt",
    page: WorkFlowContainer.page,
    children: const []);

final dashboardTabRouter = CustomRoute(
  transitionsBuilder: defaultTrans,
      duration: Duration(milliseconds: defaultTransTime),
  path: "/dashboard",
  page: DashboardContainer.page,
  children: [
    RedirectRoute(path: "", redirectTo: "/home"),
    AutoRoute(
      path: 'home',
      page: HomeEmptyPage.page,
      children: [
        AutoRoute(path: "", page: HomeRoute.page),
        AutoRoute(path: "placeholder", page: PlaceholderRoute.page),
      ],
    ),

  ],
);
