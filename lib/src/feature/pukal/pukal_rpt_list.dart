import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/app/env.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_dtp_year.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/pukal/pukal_controller.dart';
import 'package:nucleusv2/src/feature/pukal/pukal_rpt_src.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=885;

@RoutePage()
class PukalRptList extends BaseScreen {
  const PukalRptList({super.key});

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
    return provideSideBar("pukal/onscreen");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("pukal/onscreen");
  }
}

Widget buildView(
  BuildContext context,
) {
  return const Scaffold(
    body:  PukalAutoGenSearchSliver(),
    // appBar: AppBar(
    //   title: const SelectableText('Schedule Report'),
    //   automaticallyImplyLeading: false, centerTitle: false,
    // ),
  );
}
class PukalAutoGenSearchSliver extends ConsumerWidget {
  const PukalAutoGenSearchSliver(
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final pukalSearchFormKey = GlobalKey<FormBuilderState>();
    final pukalParam = ref.read(rptpukalSearchContorllerProvider);
    Map<String, dynamic> formNewValue = {
      "Yr": pukalParam['Yr'],
      "Mn": pukalParam['Mn'],
      "RptType":pukalParam['RptType']
    };
 return CustomScrollView(
    slivers: <Widget>[
      const SliverAppBar(  title:  Text('Pukal Reports'),
      automaticallyImplyLeading: false, centerTitle: false,
       
      ),
      //2
      SliverToBoxAdapter(child: Column(
        mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            FormBuilder(
              key: pukalSearchFormKey,
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

                  Row(
                    children: [
                      const FbHiddenText(name: 'RptType'),
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
                                                  params:  const {"RefType": "Month", "BitInd": null},
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
                            pukalSearchFormKey.currentState!.save();
                            Map<String, dynamic> toPost =
                                convertFormDateValue(
                                    pukalSearchFormKey.currentState!.value,
                                    ['FromDate', 'ToDate']);
                            ref
                                .read(rptpukalSearchContorllerProvider.notifier)
                                .state = toPost;
                          },
                          icon: const Icon(Icons.search)),
                            IconButton(
                                 tooltip: 'Show Source Inbound Pukal Files',
                          onPressed: () async {
                            pukalSearchFormKey.currentState!.save();
                            Map<String, dynamic> toPost =
                                convertFormDateValue(
                                    pukalSearchFormKey.currentState!.value,
                                    ['FromDate', 'ToDate']);
                            await showAcxDialog(
                              context,
                              PukalFileS3Src(
                                moduleName: "${Env.awspukalFolder}/INBOUND",
                                rpstryType: "${toPost['Yr']}/${toPost['Mn']}/",
                              ),
                            );
                          },
                          icon:  Icon(Icons.inbox)),
                             IconButton(
                              tooltip: 'Show Source Outbound Pukal Files',
                          onPressed: () async {
                            pukalSearchFormKey.currentState!.save();
                            Map<String, dynamic> toPost =
                                convertFormDateValue(
                                    pukalSearchFormKey.currentState!.value,
                                    ['FromDate', 'ToDate']);
                              await showAcxDialog(
                              context,
                              PukalFileS3Src(
                                moduleName: "${Env.awspukalFolder}/OUTBOUND",
                                rpstryType: "${toPost['Yr']}/${toPost['Mn']}/",
                              ),
                            );
                          },
                          icon:  Icon(Icons.outbox)),
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
     const SliverFillRemaining(child: TxnRptPukalGridSearch(),)
    ],
  );

  }
}




class TxnRptPukalGridSearch extends ConsumerWidget {
  const TxnRptPukalGridSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(rptpukalSearchContorllerProvider);
    // final query = QueryObject(
    //     querysql: '/sp/ApiRptFileList/queryasync',
    //     params: toPost,
    //     showMsg: false);
          final data = ref.watch(ReturndataProvider(querysql: '/sp/ApiRptFileList/queryasync', params: toPost));
 //   final data = ref.watch(ReturndatafreezedProvider(query));
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
 
