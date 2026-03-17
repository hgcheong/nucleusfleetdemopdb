import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final rptViewerTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/report",
    page: ReportViewerContainer.page,
    children: [
      // AutoRoute(path: 'view/:rptId', page: ReportViewerOnScrenReports.page),
      AutoRoute(
        path: 'onscreen',
        page: ReportViewerOnScrnReportsList.page,
      ),
      AutoRoute(
        path: 'scheduled',
        page: ReportViewerSchdList.page,
      ),
        AutoRoute(
        path: 'query',
        page: ReportViewerQueryList.page,
      ),
      // AutoRoute(path: 'scheduled', page: ReportViewerSchdList.page, children: [
      //   AutoRoute(
      //     path: 'schdrpt',
      //     page: ReportViewerSchd.page,
      //   )
      // ]),
     // AutoRoute(path: 'auditlog', page: CustEnrollQuickInfoLanding.page),
      // AutoRoute(path: 'pagetracklog', page: CustEnrollQuickInfoLanding.page),
    ]);
