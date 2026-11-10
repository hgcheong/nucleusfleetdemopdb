import 'package:auto_route/auto_route.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_dtp_year.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/reportviewer/report_viewer_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=184;

@RoutePage()
class ReimbursementFileOut extends ConsumerWidget {
  const ReimbursementFileOut({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
 
    return buildView(context);
  }

  // static const List<PageRouteInfo> routes = [PrgmgmtmainTabRouter()];


}

Widget buildView(
  BuildContext context,
) {
  return const Scaffold(
    body:  RptReimburseAutoGenSearchSliver(),
    // appBar: AppBar(
    //   title: const SelectableText('Schedule Report'),
    //   automaticallyImplyLeading: false, centerTitle: false,
    // ),
  );
}
class RptReimburseAutoGenSearchSliver extends ConsumerWidget {
  const RptReimburseAutoGenSearchSliver(
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final rptSearchFormKey = GlobalKey<FormBuilderState>();
    final rptParam = ref.read(rptSearchReimbursementProvider);
    Map<String, dynamic> formNewValue = {
      "Yr": rptParam['Yr'],
      "Mn": rptParam['Mn'],
      "RptType":rptParam['RptType']
    };
 return CustomScrollView(
    slivers: <Widget>[
      const SliverAppBar(  title:  Text('Reimbursement Files'),
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
               FbHiddenText(name:   'RptType'),
                Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     AppButton(                        
                                icon: Icons.update,
                                label: "Run Preview",
                                onPressed: () async{
     bool confirmed = await ConfirmDialog.show(
                          title: "Please Confirm?",
                          body: "Generate Preview of Reimbursement File?",
                          destructive: true,
                          confirmText: "Yes",
                          cancelText: "Cancel",
                        );
                           if (!confirmed) {
                          return;
                        }
                  
                  final confirmRegen = ref.read(ReturndatafreezedProvider(
                      QueryObject(
                          querysql: '/sp/ApiMchtReimburseRun/queryasync',
                          params: {
   "PId": null,
  "RptInd": "PREVIEW",
                          },
                          showMsg: true))
                  .future);
                       confirmRegen.then((Returndata? value) {
                if(value==null){
                  return;
                }});
                             
                                }),sbw20,
                                  AppButton(                        
                                icon: Icons.update,
                                label: "Run Live Generation",
                                onPressed: () async{
     bool confirmed = await ConfirmDialog.show(
                          title: "Please Confirm?",
                          body: "Generate Live Reimbursement File?",
                          destructive: true,
                          confirmText: "Yes",
                          cancelText: "Cancel",
                        );
                           if (!confirmed) {
                          return;
                        }
                  
                  final confirmRegen = ref.read(ReturndatafreezedProvider(
                      QueryObject(
                          querysql: '/sp/ApiMchtReimburseRun/queryasync',
                          params: {
   "PId": null,
  "RptInd": "LIVE",
                          },
                          showMsg: true))
                  .future);
                       confirmRegen.then((Returndata? value) {
                if(value==null){
                  return;
                }});
                             
                                })
                 
    ],),
    sbh10,
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.calendar_month),
                      ),
                      sbw20,
                      Expanded(child: FbDateTimePickerYear(label: 'Year', name: 'Yr',initialValue: DateTime.now(),),),
                      fbFieldGap,
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
     const SliverFillRemaining(child: TxnReimburseGridSearch(),)
    ],
  );

  }
}

class TxnReimburseGridSearch extends ConsumerWidget {
  const TxnReimburseGridSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(rptSearchContorllerProvider);
    final data = ref.watch(ReturndataProvider(  querysql: '/sp/ApiRptFileList/queryasync',
        params: toPost,
        showMsg: false));
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
 

final rptSearchReimbursementProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "RptType": "REIMBURSE",
    "Yr":  DateFormat('yyyy').format(DateTime.now()),
    "Mn": DateFormat('M').format(DateTime.now()),
  };
});