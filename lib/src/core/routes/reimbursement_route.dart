import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final reimbursementTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/reimburse",
    page: ReimbursementContainer.page,
    children: [
      AutoRoute(path: 'main', page: ReimbuseManualTxnLanding.page, children: [
        AutoRoute(
            path: 'out',
            page: ReimbursementFileLanding.page,
            usesPathAsKey: true,
            maintainState: false,children: [
              AutoRoute(path:'', page: ReimbursementFileOut.page, usesPathAsKey: true, initial: true),
              AutoRoute(path:'email', page: ReimbursementFileOutEmail.page, usesPathAsKey: true, ),
              AutoRoute(path:'signatory', page: ReimbursementSignatory.page, usesPathAsKey: true, ),
            ]
            )
      ])
    ]);
