import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=891;

@RoutePage()
class MediaReissueRplcList extends ConsumerWidget {
  const MediaReissueRplcList(
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    //  return const SelectableText('Cust Enroll Member List');
    final query = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtMediaReissueRplcList/queryasync',
        params: {},
        showMsg: false));
    final data = ref.watch(query);

     return AsyncValueWidget(
        value: data,
        data: (theData) {
          return AcxTrinaGridExtDataCheckBox(
            appButtons: [
              AppButtonWithFunction(       
                btn: AppButton(
                  tooltip: 'Please check item and click Start Reissue/Replacement Process.\nOnce done you can get the Embosssing file in \nReport Viewer->Schedule Report->Perso and Emboss File',
                  icon:Icons.library_add,
                  label: 'Start Reissue/Replacement Process'), func: (ValueNotifier<Set<TrinaRow>> val) async {
                      var rows = val.value;
                                if (rows.isEmpty) {
                                  Toast.message('Please check item to process');
                                  return;
                                }
                      bool confirmed = await ConfirmDialog.show(
                          title: 'Process Checked cards?');
            
                      if (confirmed) {
                        var rows = val.value;
                        {
                        List<Map<String,dynamic>> cardList = [];
                        for (var i = 0; i < rows.length; i++) {
                            var currRow = rows.elementAt(i);
                            cardList.add({
                                "TrackId":currRow
                                    .cells["TrackId"]!
                                    .value
                                    .toString(),
                                "IssueType":currRow
                                    .cells["IssueType"]!
                                    .value
                                    .toString(),
                                "MediaId":currRow
                                    .cells["MediaId"]!
                                    .value
                                    .toString()
                            });

                        }
                  var toPost = {
                    "data":cardList,
                    "input":[],
                    "udtparamname":"InputTbl",
                    "udttype":"tbMediaIssue"
                  };
        
                  final queryPost = QueryObject(querysql: '/sp/ApiMgmtMediaReissueRplcSave/tvp', 
                  params: toPost, showMsg: false);
                  final resultPost = ref.read(ReturndatafreezedProvider(queryPost).future);
                  resultPost.then((va){
                     Toast.showresult(va);
                     if(isSuccess(va.message)){
                      ref.invalidate(query);
                     }
                  });

                      }}})
            ],
             
            spName: 'ApiMgmtMediaReissueRplcList', 
          extData: theData, idField: 'TrackId',);
        });
   
  }
}
