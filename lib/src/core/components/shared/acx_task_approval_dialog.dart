import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/taskqueitems/taskqueitems.dart';
import 'package:nucleusv2/src/utils/strings.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

@RoutePage()
class AcxTaskApprovalDialog extends ConsumerWidget {
  const AcxTaskApprovalDialog(
      {super.key, this.wfCd, this.wfPrcsId, this.recId});

  final String? wfCd;
  final String? wfPrcsId;
  final String? recId;

  //  "WfCd": "CUSTCRASSESS",
  //     "WfPrcsId": 1,
  //     "UsrId": 3,
  //     "RecId": 99

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Map<String, dynamic> formValue = {
    //   "WfTaskId": null,
    //   "WfPrcsTaskDscp": null,
    //   "Note": null,
    //   "CrtionDate": null,
    //   "CrtBy": null,
    //   "ActDate": null,
    //   "ActBy": null,
    //   "TaskSts": null,
    //   "TaskId": null,
    //   "Seq": null,
    //   "WfPrcsId": wfPrcsId,
    //   "RecId": recId,
    //   "AsgnToGrp": null,
    //   "AsgnToUser": null,
    //   "Sts": "R",
    //   "WfCd": null
    // };

    final query = QueryObject(
        querysql: '/sp/ApiTaskQue/queryasync',
        params: {"WfCd": wfCd, "WfPrcsId": wfPrcsId, "RecId": recId},
        showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));
    // final queryHist =  QueryObject(querysql: '/sp/ApiMgmtStsHist/queryasync', params: {"EttyId":ettyId, "AcctNo":acctNo}, showMsg: false);
    // final queryHistRes = ref.watch(ReturndatafreezedProvider(queryHist));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          if (theData.data != null) {
            // formValue =
            //     convertFormValueToDisplay(theData.data![0], theData.columnInfo);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  'Task Info',
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                        flex: 11,
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                          
                             Expanded(
                               flex: 10,
                                child:
                                 ListView(
                                
                                  children: [
                                  Row( children: [Text("Description: ${theData.data![0]['WfPrcsDscp']}"),]),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [  Text("Refer To:${theData.data![0]['RefTo']}"), Text("Ref No:${theData.data![0]['RefNo']}")],),
                                  Row(children: [ Text("Program: ${theData.data![0]['PrgDscp']}  "),],),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [ Text("Financial Date: ${theData.data![0]['FinDate']}"),],),
                                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [ Text("Req Credit Limit: ${theData.data![0]['ReqCrLimit']}"),Text("Proposed Credit Limit: ${theData.data![0]['ProposedCrLimit']}"),
                             ],),
                                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("Created By:${theData.data![0]['CrtBy']}"), Text("Creation Date:${fmtDateStrShort(theData.data![0]['CrtionDate'])}"),
                                ],)
                               ],
                                ),
                              ),Spacer(flex: MediaQuery.of(context).size.width < 1000 ? 1:6,)
                 
                            ],
                          ),
                        ))),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          sbh10,
                          ElevatedButton(
                              onPressed: () {
                                singleton<AppRouter>().maybePop();
                              },
                              child: const Icon(Icons.exit_to_app))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                flex: 11,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8, left: 8),
                            child: Text(
                              'Task Status',
                              //   style: hdrStyle,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: AppvLineItems(
                                theData),
                          ),
                        ],
                      ),
                    ),    
                  ],
                ),
              ),const Spacer(flex: 1,)
            ],
          );
        });
  }
}

class AppvLineItems extends StatelessWidget {
  const AppvLineItems(this.tasks, {super.key});

  final Returndata tasks;
  @override
  Widget build(BuildContext context) {
        final List<Taskqueitems> listtasks =
                Taskqueitems.fromJsonList(tasks.data!);
    List<Widget> toReturn = [];
    for (var element in listtasks) {
      toReturn.add(AppvItem(element));
    }
    toReturn.add(const Divider());
    return ListView(itemExtent: 180, children: toReturn);
  }
}

// class AppvItem extends HookConsumerWidget {
//   const AppvItem(this.task, {super.key});

//   final Taskqueitems task;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final noteText = useState("");
//     return Card(
//       child: ListTile(
//         titleAlignment: ListTileTitleAlignment.top,
//          leading: CircleAvatar(
//           backgroundColor: task.actSts =="D"? Colors.blue: Colors.green,
//             child: Text(task.seq == null? " ":task.seq.toString() ),
//           ),
//         title: Text("Action Date:${task.actDate == null ? '':fmtDateStrShort(task.actDate)} Action By:${task.actBy?? ''}  Status:${task.actStsDscp ?? ''}"),
//         subtitle: Wrap(
//           children: [
//                Row(
//                  children: [
//                   Expanded(child: Text("Task Status Description: ${task.actStsDscp ?? ""}")),
                  
//                  ],
//                ),
//                Row(children: [ Expanded(
//                                     flex: 4,
//                                     child: FbText(
//                                       onChanged: (val){
//                                         noteText.value = val!;
//                                       },
//                                       readOnly: task.actSts! == "D" ? false:true,
//                                       label: 'Notes',
//                                       name: 'Notes',
//                                       initialValue:task.note ??  "",
//                                       maxLines: 3,
//                                     ),
//                                   ),],),
//               sbh10,
//                 task.actSts! == "D" ? Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                                         children: [
//                                           AppButton(
//                                             onPressed: () async {
//                                               bool confirmed = await ConfirmDialog.show(
//                                                   title: 'Approve?');
//                                               if (confirmed) {
//                                                   postTask(task,task.appvlSp ?? "", noteText.value, ref );
//                                               }
//                                             },
//                                             icon: Icons.check_outlined,
//                                             label: "Approve",
//                                           ),
//                                           sbw10,
//                                           AppButton(
//                                             onPressed: () async {
//                                               bool confirmed = await ConfirmDialog.show(
//                                                   title: 'Return');
//                                               if (confirmed) {
//                                                postTask(task,task.rtnSp, noteText.value, ref );
//                                               }
//                                             },
//                                             icon: Icons.assignment_return,
//                                             label: "Return",
//                                           ),
//                                           sbw10,
//                                              AppButton(
//                                             onPressed: () async {
//                                               bool confirmed = await ConfirmDialog.show(
//                                                   title: 'Reject');
//                                               if (confirmed) {
//                                                       postTask(task,task.rejSp??"", noteText.value, ref );
//                                               }
//                                             },
//                                             icon: Icons.cancel_outlined,
//                                             label: "Reject",
//                                           ),
//                                         ],
//                                       ),
//                 ):Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }
class AppvItem extends HookConsumerWidget {
  const AppvItem(this.task, {super.key});

  final Taskqueitems task;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteText = useState("");
    return Row(
      children: [
        Expanded(
          flex: 11,
          child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                          Expanded(
                                   flex: 10,
                                    child:
                                     Column(
                         
                                      children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                        
                        Text("Action Date:${task.actDate == null ? '':fmtDateStrShort(task.actDate)}"),Text(" Action By:${task.actBy?? ''}"),
                      ],
                    ),
                  Row(
                           children: [
                            Expanded(child: Text("Task Status: ${task.actStsDscp ?? ""}")),
                            
                           ],
                         ),
                         Row(children: [ Expanded(
                                              flex: 4,
                                              child: FbText(
                                                onChanged: (val){
                                                  noteText.value = val!;
                                                },
                                                readOnly: task.actSts! == "D" ? false:true,
                                                label: 'Notes',
                                                name: 'Notes',
                                                initialValue:task.note ??  "",
                                                maxLines: 3,
                                              ),
                                            ),],),
                        sbh10,
                         
                                   ],
                                    ),
                                  ),Expanded(
                                    flex: MediaQuery.of(context).size.width < 1000 ? 1:6,
                                    child: task.actSts! == "D" ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                            
                              crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    SizedBox(width: 130,
                                                      child: AppButton(
                                                        onPressed: () async {
                                                          bool confirmed = await ConfirmDialog.show(
                                                              title: 'Approve?');
                                                          if (confirmed) {
                                                              postTask(task,task.appvlSp ?? "", noteText.value, ref );
                                                          }
                                                        },
                                                        icon: Icons.check_outlined,
                                                        label: "Approve",
                                                      ),
                                                    ),
                                                    sbh10,
                                                    SizedBox(
                                                      width: 130,
                                                      child: AppButton(
                                                        onPressed: () async {
                                                          bool confirmed = await ConfirmDialog.show(
                                                              title: 'Return');
                                                          if (confirmed) {
                                                           postTask(task,task.rtnSp, noteText.value, ref );
                                                          }
                                                        },
                                                        icon: Icons.assignment_return,
                                                        label: "Return",
                                                      ),
                                                    ),
                                                    sbh10,
                                                       SizedBox(
                                                        width: 130,
                                                         child: AppButton(
                                                                                                               onPressed: () async {
                                                          bool confirmed = await ConfirmDialog.show(
                                                              title: 'Reject');
                                                          if (confirmed) {
                                                                  postTask(task,task.rejSp??"", noteText.value, ref );
                                                          }
                                                                                                               },
                                                                                                               icon: Icons.cancel_outlined,
                                                                                                               label: "Reject",
                                                                                                             ),
                                                       ),
                                                  ],
                                                ),
                          ):Container(),),
                   
                  ],
                  
                ),
              ),
            ),
        ),
  const Spacer(flex: 1,)
      ],
    );
    
  }
}

void postTask(Taskqueitems item, String sp,String note, WidgetRef ref){
                   Map<String, dynamic> toPost ={
                       "WfCd": item.wfCd,
       "WfPrcsId": item.wfPrcsId,
      "RecId": item.recId,
      "WfTaskId": item.wfTaskId,
      "Seq":null,
      "TaskId": item.taskId,
      "Note": note,
      "Sp": sp
                   };
                       final querySave = QueryObject(
                                  querysql: '/sp/ApiTaskQueSave/queryasync',
                                  params: toPost,
                                  showMsg: false);
                                    final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                                           saveResult.then((Returndata value) {
                                Toast.showresult(value);
                      
                              });
                      
                   
}

Widget showUserStatus(String? userId) {
  if (userId != null) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Colors.blue,
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User ID'),
                Text('Kelly@gmail.com'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current Status'),
                Text('Active'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Failed Attempt Sign In'),
                Text('5'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Creation Date'),
                Text('01 Oct 2016'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Block Date'),
                Text(''),
              ],
            ),
          ]),
    );
  }
  return const Text('Add User');
}

enum StatusType {
  acctSts('ACCTSTS'),
  cmpySts('CMPYSTS'),
  custSts('CUSTSTS'),
  locSts('LOCSTS'),
  mbrSts('MBRSTS'),
  mchtSts('MCHTSTS'),
  mediaSts('MEDIASTS'),
  tadSts('TADSTS'),
  pukalSts('PUKALSTS');

  const StatusType(this.name);

  final String name;

  @override
  String toString() => name;
}

class Taskdtl {
  String wfPrcsDscp;
  String refTo;
  String refNo;
  String refNote;
  String finDate;
  String prgDscp;
  int reqCrLimit;
  int proposedCrLimit;
  dynamic crRiskDscp;
  dynamic crCtgryDscp;
  dynamic crtionDate;
  dynamic crtBy;
  dynamic actDate;
  dynamic actBy;
  dynamic wfPrcsTaskId;
  dynamic wfTaskId;
  dynamic wfPrcsTaskDscp;
  dynamic seq;
  int wfPrcsId;
  int recId;
  dynamic asgnToGrp;
  dynamic asgnToUser;
  dynamic note;
  dynamic taskId;
  dynamic taskSts;
  dynamic taskStsDscp;
  String wfCd;
  dynamic crRiskCd;
  dynamic crCtgryCd;
  dynamic appvlSp;
  dynamic rtnSp;
  dynamic rejSp;

  Taskdtl({
    required this.wfPrcsDscp,
    required this.refTo,
    required this.refNo,
    required this.refNote,
    required this.finDate,
    required this.prgDscp,
    required this.reqCrLimit,
    required this.proposedCrLimit,
    this.crRiskDscp,
    this.crCtgryDscp,
    this.crtionDate,
    this.crtBy,
    this.actDate,
    this.actBy,
    this.wfPrcsTaskId,
    this.wfTaskId,
    this.wfPrcsTaskDscp,
    this.seq,
    required this.wfPrcsId,
    required this.recId,
    this.asgnToGrp,
    this.asgnToUser,
    this.note,
    this.taskId,
    this.taskSts,
    this.taskStsDscp,
    required this.wfCd,
    this.crRiskCd,
    this.crCtgryCd,
    this.appvlSp,
    this.rtnSp,
    this.rejSp,
  });
}
