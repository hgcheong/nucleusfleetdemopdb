import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final masschangeTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/masschange",
    page: MassChangeContainer.page,
    children: [
      AutoRoute(path: 'main', page: MassChangeMain.page),
      AutoRoute(
          path: 'changecreexp',
          page: MassChangeCreditExpiryList.page,
          children: [
            AutoRoute(
                path: 'changecreexpdtl', page: MassChangeCreditExpiry.page),
          ]),
    ]);
