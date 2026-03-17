import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final cclickCMStabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
    duration: Duration(milliseconds: defaultTransTime),
    path: "/cclickcms",
    page: CClickCmsContainer.page,
    children: [
      AutoRoute(path: '', page: CClickCmsLanding.page, children: [
        AutoRoute(
            path: 'upload',
            page: CClickCmsUpload.page,
            initial: true,
            usesPathAsKey: true,
            maintainState: false),
                AutoRoute(
            path: 'uploadcarousel',
            page: CClickCmsUploadCarousel.page,
            usesPathAsKey: true,
            maintainState: false)
      ])
    ]);
// final reimbursementTabRouter = CustomRoute(
//     transitionsBuilder: defaultTrans,
//     usesPathAsKey: true,
//       duration: Duration(milliseconds: defaultTransTime),
//     path: "/reimburse",
//     page: ReimbursementContainer.page,
//     children: [
//       AutoRoute(path: 'main', page: ReimbuseManualTxnLanding.page, children: [
//         AutoRoute(
//             path: 'out',
//             page: ReimbursementFileOut.page,
//             usesPathAsKey: true,
//             maintainState: false)
//       ])
//     ]);
