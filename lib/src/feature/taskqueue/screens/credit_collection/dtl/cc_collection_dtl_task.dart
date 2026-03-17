import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdata_actionitems.dart';
import 'package:nucleusv2/src/core/components/shared/acx_event_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/taskqueue/screens/credit_collection/cc_collection_mock.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';
import 'package:nucleusv2/src/utils/helpers.dart';

const int wid=786;

@RoutePage()
class CreditCollectionDtlTask extends ConsumerWidget {
  const CreditCollectionDtlTask({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    setTitle("Task Page", ref);
    return  Row(
      children: [
        Expanded(
          flex: 11,
          child: Column(children: [
              //   Expanded(child: Card(child: ListView(children:const [
              //          Padding(
              //                       padding: EdgeInsets.all(8.0),
              //                       child:  SelectableText(
              //                         'Case Info',
              //                         //       style: hdrStyle,
              //                       ),
              //                     ),
              //         ListTile(leading: Text('Date'),)
              // ],)),),
              Expanded(child: Card(child: ListView(children:const [
                       Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child:  SelectableText(
                                      'Event History',
                                      //       style: hdrStyle,
                                    ),
                                  ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TaskEventHistory(),
                      )
              ],)),)
          ],),
        ),
        Expanded(flex: 1,child: Column(children: [
          ElevatedButton(onPressed: (){
                    singleton<AppRouter>()
                  .navigatePath('/taskqueue/creditcollection');
          }, child: const Icon(Icons.arrow_back))
        ],),)
      ],
    );
  }
}

class TaskEventHistory extends ConsumerWidget {
  const TaskEventHistory( {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
      final query = QueryObject(querysql: '/sp/ApiTaskCollEventList/queryasync', params: {
    "EttyId":null,
    "TaskId":null,
    "AcctId":null,
    "StmtId":null
}, showMsg: false);
     final data = ref.watch(ReturndatafreezedProvider(query));
     return AsyncValueWidget(value: data, data: (extdata){
       return SizedBox(
        height: 1280,
         child: AcxTrinaGridExtDataActionItems(
                onNew: () async{
                    if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                     await showAcxDialog(
                  context,
                  const EventDialog(
                    ettyId: null,
                    eventId: null,
                    // refType: refType,
                    //  refId: refId
                  )).then(
                (val) {
                  ref.invalidate(ReturndatafreezedProvider(query));
                },
              );
                },
                popupIcon: const Icon(Icons.chevron_right),
                   popMenuItems: const [
                  {"value": "reassign", "text": "Task Reassign"}
                ],
                onPopUp: (Map<String, dynamic> popVal) async {
               
                  switch (popVal['value']) {
                    case 'reassign':
                                   await showAcxDialog(
                  context,
                  const EventDialog(
                    ettyId: null,
                    eventId: null,
                    // refType: refType,
                    //  refId: refId
                  )).then(
                (val) {
                  ref.invalidate(ReturndatafreezedProvider(query));
                });
                      break;
                    default:
                  }
                },
                spName: 'ApiTaskCollEventList',
                extData: apiTaskCollEventListMock,
                idField: 'EventId',
             ),
       );
     });
  }
}

