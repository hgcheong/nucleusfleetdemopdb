import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final pukaltabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/pukal",
    page: PukalContainer.page,
    children: [
      AutoRoute(
        path: 'billing',
        page: PukalListLanding.page, children:[
          AutoRoute(path: 'outbound', page: PukalListOutbound.page, initial: true),
          AutoRoute(path: 'inbound', page: PukalListInbound.page)
        ]
      ),
          AutoRoute(
        path: 'report',
        page: PukalRptList.page,
      ),

    ]);
