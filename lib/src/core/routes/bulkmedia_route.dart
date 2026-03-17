import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final bulkemediaTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
  duration: Duration(milliseconds: defaultTransTime),
    path: "/bulkmedia",
    page: BulkMediaProdContainer.page,
    children: [
      AutoRoute(path: 'pending', page: BulkMediaprodList.page),
      AutoRoute(path: 'hist', page: BulkMediaProdHistory.page),
      AutoRoute(path: 'mediaprod/:id', page: BulkMediaProdNew.page, children: [
      //  AutoRoute(path: 'wizardcust', page: CustEnrollListRoute.page),
        // AutoRoute(path: 'wizardprg', page: CustEnrollListRoute.page),
        // AutoRoute(path: 'wizarddtl', page: CustEnrollListRoute.page),
        // AutoRoute(path: 'wizardfinal', page: CustEnrollListRoute.page),
      ]),
    ]);
