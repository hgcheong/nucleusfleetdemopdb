
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/components/shared/acx_audit_log_req_dialog.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

class AcxAuditLogReqList extends HookConsumerWidget{
  const AcxAuditLogReqList( {super.key,required this.spName, this.ettyId = "0"});

  final String spName;
  final String ettyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var toUseSp = "";
    if(spName.contains('/')){
      List<String> sp = spName.split('/');
      for (var element in sp) {

        if(element.toUpperCase().contains('SAVE')){
          toUseSp = element;
          break;
        }
        }
      }else{
        toUseSp = spName;
      }

    
    final ValueNotifier<Map<String,dynamic>> myParam = useState(
      { 'SPName':toUseSp,
        'FromDate':null,
        'SrcReq': 'nucleus'
      });
      //Convert this because easy to split later.
      //Problem with display dio and save format for datetime
       Map<String, dynamic> toPost = convertFormDateValue(myParam.value, ['FromDate']);
     final query = QueryObject(querysql: 'ApiLogReqList', params:{
      'SPName':toUseSp,
      'EttyId':ettyId == "null" || ettyId == "new" ? "0":ettyId,
      'FromDate': toPost['FromDate'] == null? null: toPost['FromDate'].split(' ').first,
      'SrcReq':'nucleus'
     }, showMsg: false);
     toPost['FromDate'] =toPost['FromDate'] == null? null: DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(toPost['FromDate']);
     final data = ref.watch(ReturndatafreezedProvider(query));
      final formKeyAcxAuditLogReqList = GlobalKey<FormBuilderState>();
      return AsyncValueWidget(value: data, data: (theData){
 return SingleChildScrollView(
       child: SizedBox(
        height: 1280,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding: const EdgeInsets.only(left: 20.0),
                 child: Text('Audit Log'),
               ),
               FormBuilder(
                key: formKeyAcxAuditLogReqList,
                initialValue: toPost,
                child: Row(
                 children: [
                    FbHiddenText(name: 'SPName'),
                    FbHiddenText(name: 'SrcReq'),
                    sbw20,
                   Expanded(child: FbDateTimePicker(name: 'FromDate',label: 'Month to date')),
                   sbw10,
                   Expanded(
                     child: ElevatedButton(onPressed: (){
                      formKeyAcxAuditLogReqList.currentState!.save();
                    myParam.value =  formKeyAcxAuditLogReqList.currentState!.value;
                              
                     }, child: Text('Query')),
                     
                   ),
                        IconButton(
                        onPressed: () {
                          singleton<AppRouter>().maybePop();
                        },
                        icon: const Icon(Icons.close)),
                 ],
               )),
               SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                 child: AcxTrinaGridExtDatawExport(
                  extData: theData,
                  idField: 'Id',
                  onSelected: (TrinaRow val) async {
                    await showAcxAlertDialog(context, 
                    AcxAuditLogReqDialog(val.cells['spName']!.value.toString(),ettyId, val.cells['Id']!.value.toString(), val.cells['User']!.value ?? '', val.cells['Date']!.value ?? '', val.cells['Time']!.value ?? '', ));
            
                  //    JsonEncoder encoder = JsonEncoder.withIndent(' ');
                  //  String prettyJson = encoder.convert(val.toJson()).replaceAll('\\"', ' ');
         
                  //   await showAcxDialog(context, Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Card(child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Column(
                  //         children: [
                  //           Row(children: [
                  //             Expanded(child: Text('Audit Log Details')),
                  //              IconButton(
                  //           onPressed: () {
                  //             singleton<AppRouter>().maybePop();
                  //           },
                  //           icon: const Icon(Icons.close)),
                  //             ],),
                  //           SelectableText(prettyJson),
                  //         ],
                  //       ),
                  //     )),
                  //   ));
                  },
                 ),
               ),
             ],
           ),
         ),
       ),
     );
      });
    
  }

}


// final acxAuditLog =
//     StateProvider<Map<String, dynamic>>((ref) {
//   return {
//     "CustEttyId": null,
//     "EttyId": null,
//     "AcctId": null,
//     "LocNo": null,
//     "MediaNo": null,
//     "TxnInd": "0",
//     "TadNo": null,
//     "TxnDate": null
//   };
// });