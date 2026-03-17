import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final subsidymgmtTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/subsidy",
    page: SubsidyMgmtContainer.page,
    children: [
      AutoRoute(path: 'main', page: SubsidyList.page),
      AutoRoute(
          path: 'program/:subsId',
          page: SubsidymgmtProgramLanding.page,
          maintainState: false,
          usesPathAsKey: true,
          children: [
            AutoRoute(
              path: 'program',
              page: SubsidymgmtProgram.page,
              maintainState: false,
            ),
          ]),
      AutoRoute(
          path: 'planlist/:subsId',
          page: SubsidymgmtPlanListLanding.page,
          usesPathAsKey: true,
          children: [
            AutoRoute(path: '', page: SubsidymgmtPlanList.page, initial: true),
          ]),
      AutoRoute(
          path: 'plan/:subsId/:subsLocateId',
          page: SubsidymgmtPlanLanding.page,
          maintainState: false,
          usesPathAsKey: true,
          children: [
            AutoRoute(
                path: 'detail',
                page: SubsidymgmtPlan.page,
                initial: true,
                maintainState: false),
            // AutoRoute(path: 'ratelist', page: SubsidymgmtRateList.page)
          ]),
      AutoRoute(
          path: 'rate/:subsId/:subsLocateId:/rateId',
          page: SubsidymgmtRateLanding.page,
          maintainState: false,
          usesPathAsKey: true,
          children: [
            AutoRoute(
                path: 'detail',
                page: SubsidymgmtRate.page,
                maintainState: false,
                initial: true),
          ]),
    ]);
