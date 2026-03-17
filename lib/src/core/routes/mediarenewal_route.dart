import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final mediaRenewalRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/renewal",
    page: MediarenewalContainer.page,
    children: [
      AutoRoute(path: 'main', page: MediarenewalLanding.page, children: [
              AutoRoute(
            path: 'reissuerplc',
            page: MediaReissueRplcList.page,
            usesPathAsKey: true,
            maintainState: false,
            initial: true),
        AutoRoute(
            path: 'renewlist',
            page: MediaRenewalList.page,
            usesPathAsKey: true,
            maintainState: false,
            initial: false),
        AutoRoute(
            path: 'renewsearch',
            page: MediaRenewalSearch.page,
            usesPathAsKey: true,
            maintainState: false)
      ])
    ]);
