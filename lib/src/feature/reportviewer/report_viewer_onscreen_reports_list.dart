import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/feature/reportviewer/report_viewer_onscreen_reports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=188;

@RoutePage()
class ReportViewerOnScrnReportsList extends BaseScreen {
  const ReportViewerOnScrnReportsList({super.key});

  // static const List<PageRouteInfo> routes = [PrgmgmtmainTabRouter()];

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(context);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(
      context,
    );
  }

  @override
  Widget sideTab() {
    return provideSideTab("");
  }

  @override
  Widget sideBar() {
    return provideSideBar("report/onscreen");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("report/onscreen");
  }
}

Widget buildView(
  BuildContext context,
) {
  return Scaffold(
    body: SingleChildScrollView(
      child: AcxTrinaGridWithColumn(
        onSelectedTap: (TrinaRow val) async {
          // final Uri _url = Uri.parse('http://13.229.188.57/ReportServer?/NewMerchant&PrcsDate=6/24/2024&rs:Format=PDF');
          //   // singleton<AppRouter>().navigatePath('/report/view/val.cells["RptId"]');
          //  launchInBrowser(_url);

          await showAcxDialog(
              context,
              SizedBox(
                width: 600,
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(val.cells["Description"]!.value.toString()),
                      ReportViewerOnScrnReports(
                          url:
                              'http://13.229.188.57/ReportServer?/NewMerchant&PrcsDate=6/24/2024&rs:Format=PDF',
                          rptname: val.cells["RptName"]!.value.toString(),
                          filename:
                              val.cells["SaveFileName"]!.value.toString()),
                    ],
                  ),
                ),
              ));
        },
        querysql: '/sp/rprptlist/queryasync',
        spName: 'rprptlist',
        params: const {},
        idField: 'RptId',
        useNav: false,
      ),
    ),
    appBar: AppBar(
      title: const SelectableText('On-Screen Reports'),
      automaticallyImplyLeading: false, centerTitle: false,
      
    ),
  );
}
