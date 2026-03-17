import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_dtp_year.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/reportviewer/report_viewer_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=191;

@RoutePage()
class ReportViewerSchdList extends BaseScreen {
  const ReportViewerSchdList({super.key});

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
  return const Scaffold(
    body:  RptRptAutoGenSearchSliver(),
    // appBar: AppBar(
    //   title: const SelectableText('Schedule Report'),
    //   automaticallyImplyLeading: false, centerTitle: false,
    // ),
  );
}
class RptRptAutoGenSearchSliver extends ConsumerWidget {
  const RptRptAutoGenSearchSliver(
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final rptSearchFormKey = GlobalKey<FormBuilderState>();
    final rptParam = ref.read(rptSearchContorllerProvider);
    Map<String, dynamic> formNewValue = {
      "Yr": rptParam['Yr'],
      "Mn": rptParam['Mn'],
      "RptType":rptParam['RptType']
    };
 return CustomScrollView(
    slivers: <Widget>[
      const SliverAppBar(  title:  Text('Schedule Report'),
      automaticallyImplyLeading: false, centerTitle: false,
       
      ),
      //2
      SliverToBoxAdapter(child: Column(
        mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            FormBuilder(
              key: rptSearchFormKey,
              initialValue: formNewValue,
              child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: FbLibView(
                            inputIcon: Icon(Icons.list),
                            name: 'RptType',              
                            label: 'Report Type',
                            searchText: 'Dscp',
                            keyField: 'RefCd',
                            params: {'RefType':'RPSTRYTYPE'},
                            querySql: '/view/async/vwlibref ',
                          ),
                        ),
                      ),
                    ],
                  ),
      
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.calendar_month),
                      ),
                      sbw20,
                      Expanded(child: FbDateTimePickerYear(label: 'Year', name: 'Yr',initialValue: DateTime.now(),),),
                      sbw10,
                         Expanded(
                           child: FbLibView(
                                                   name: 'Mn',
                                                   label: 'Month',
                                                  params: const {"RefType": "Month", "BitInd": null},
                                                   keyField: 'SortSeq',
                                                   searchText: 'Dscp',
                                                  querySql: '/sp/GetLibRef/queryasyncnouser',
                                                   initialValue: formNewValue['Mn'],
                                                 ),
                         ),     
                    ],
                  ),
                ],
              ),
            ),
            sbw10,
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            rptSearchFormKey.currentState!.save();
                            Map<String, dynamic> toPost =
                                convertFormDateValue(
                                    rptSearchFormKey.currentState!.value,
                                    ['FromDate', 'ToDate']);
                            ref
                                .read(rptSearchContorllerProvider.notifier)
                                .state = toPost;
                          },
                          icon: const Icon(Icons.search)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
              ),
            )
          ]),),
     const SliverFillRemaining(child: TxnRptGridSearch(),)
    ],
  );

  }
}

class TxnRptGridSearch extends ConsumerWidget {
  const TxnRptGridSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(rptSearchContorllerProvider);
    // final query = QueryObject(
    //     querysql: '/sp/ApiRptFileList/queryasync',
    //     params: toPost,
    //     showMsg: false);
    final data = ref.watch(ReturndataProvider(querysql: '/sp/ApiRptFileList/queryasync', params: toPost));
    return AsyncValueWidget(
        value: data,
        data: (theData) {
          return AcxTrinaGridExtDatawExport(
              gridTitle: 'Report Download',
              extData: theData,
              idField: 'Id',
              onSelected: (TrinaRow val) async {
                  bool confirmed = await ConfirmDialog.show(
                  title: "Download?",
                  body: "Are you sure you want to download ?",
                  destructive: true,
                  confirmText: "Yes",
                  cancelText: "Cancel", 
                );
                    
                if (!confirmed) {
                  return;
                } 
            var urlDownload = val.cells["Url"]!.value;
                   if(urlDownload!=null){
                     try {
          await ApiService().postDownload(
            '/s3/download',
            params: {'key': urlDownload},
          ).then((v){
                       Toast.message('Downloaded');
          });
  
                      } catch (ex) {
          Toast.error(ex.toString());
                      } finally {
             
              }
          } else{
            Toast.message("Not Downloaded");
          }
              // await showAcxDialog(
              //       context,
              //       TransactionDtl(
              //         val: val,
              //       ));
              });
        });
  }
}
 
