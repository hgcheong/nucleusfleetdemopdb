import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/mockdata.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

@RoutePage()
class AcxStatusDialog extends ConsumerWidget {
  const AcxStatusDialog(
      {super.key,
      this.ettyId,
      this.acctNo,
      required this.stsType,
      this.refType,
      this.eventType});

  final String? ettyId;
  final String? acctNo;
  final StatusType stsType;
  final String? eventType;
  final String? refType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stsChangeKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "Dscp": null,
      "Sts": null,
      "RsnCd": null,
      "Note": null,
      "EffvDate": null,
      "Reminder": null,
      "EttyId": ettyId,
      "EttyType": null,
      "RefType": null,
      "RefId": null,
      "AcctNo": acctNo,
      "EventId": null,
      "EventType": eventType
    };

    final query = QueryObject(
        querysql: '/sp/ApiMgmtSts/queryasync',
        params: {"EttyId": ettyId, "AcctNo": acctNo, "EventType": eventType},
        showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));
    final queryHist = QueryObject(
        querysql: '/sp/ApiMgmtStsHist/queryasync',
        params: refType == null?  {"EttyId": ettyId, "AcctNo": acctNo}:  {"EttyId": ettyId, "AcctNo": acctNo, "RefType":refType},
        showMsg: false);
    final queryHistRes = ref.watch(ReturndatafreezedProvider(queryHist));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          return AsyncValueWidget(
              value: queryHistRes,
              data: (theHistData) {
                if (theData.data != null) {
                  formValue = convertFormValueToDisplay(
                      theData.data![0], theData.columnInfo);
                }
                return FormBuilder(
                  key: stsChangeKey,
                  initialValue: formValue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8, left: 8),
                          child: Text(
                            'Status Info',
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 11,
                                  child: Card(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ListView(
                                            children: [
                                              const FbHiddenText(
                                                  name: 'EttyId'),
                                              const FbHiddenText(
                                                  name: 'AcctNo'),
                                              const FbHiddenText(
                                                  name: 'EventType'),
                                              const FbHiddenDateTime(
                                                  name: 'EffvDate'),
                                              FbText(
                                                name: 'Dscp',
                                                label: 'Description',
                                                initialValue:
                                                    formValue['Dscp'] ?? '',
                                                readOnly: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // const Spacer(
                                        //   flex: 1,
                                        // ),
                                        // Expanded(
                                        //   flex: 5,
                                        //   child: ListView(
                                        //     children: [
                                        //       FbText(
                                        //         name: 'StsDscp',
                                        //         label: 'Current Status',
                                        //         initialValue: formValue['StsDscp'] ?? '',
                                        //         readOnly: true,
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ))),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    AcxSaveButtonManual(onSave: () {
                                      stsChangeKey.currentState!.save();
                                      Map<String, dynamic> toPost =
                                          convertFormValueToSave(
                                              stsChangeKey.currentState!.value,
                                              theData.columnInfo);
                                      toPost.remove('Dscp');

                                      final querySave = QueryObject(
                                          querysql:
                                              '/sp/ApiMgmtStsSave/queryasync',
                                          params: toPost,
                                          showMsg: false);
                                      final saveResult = ref.read(
                                          ReturndatafreezedProvider(querySave)
                                              .future);
                                      saveResult.then((Returndata value) {
                                        Toast.showresult(value);
                                        if (isSuccess(value.message)) {
                                          ref.invalidate(
                                              ReturndatafreezedProvider(
                                                  queryHist));
                                        }
                                      });
                                    }),
                                    sbh10,
                                    ElevatedButton(
                                        onPressed: () {
                                          singleton<AppRouter>().maybePop();
                                        },
                                        child: const Icon(Icons.exit_to_app)),
                                        sbh10,
                                        AcxAuditLogReqBtn('ApiMgmtStsSave' ,ettyId: formValue['EttyId'].toString(),)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 10,
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
                                        'Change Status',
                                        //   style: hdrStyle,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Card(
                                        child: ListView(
                                          children: [
                                            ListTile(
                                                title: FbLibView(
                                                    name: 'Sts',
                                                    label: 'Change Status to',
                                                    params: {
                                                      "RefType": stsType.name
                                                    },
                                                    keyField: 'RefCd',
                                                    searchText: 'Dscp',
                                                    querySql:
                                                        '/sp/ApiStsList/queryasyncnouser')),
                                            ListTile(
                                                title: FbLibView(
                                                    name: 'RsnCd',
                                                    label: 'Reason to Change',
                                                    params: {
                                                      "EttyId": ettyId,
                                                      "AcctNo": acctNo
                                                    },
                                                    keyField: 'RefCd',
                                                    searchText: 'Dscp',
                                                    querySql:
                                                        '/sp/ApiRsnCdList/queryasyncnouser')),
                                            const ListTile(
                                                title: FbDateTimePicker(
                                                    name: 'Reminder',
                                                    label: 'Reminder Date')),
                                            const ListTile(
                                                title: FbText(
                                              name: 'Note',
                                              label: 'Note',
                                              maxLines: 3,
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8, left: 8),
                                      child: Text(
                                        'Status History',
                                        //   style: hdrStyle,
                                      ),
                                    ),
                                              Expanded(
                                                 flex: 5,
                                                child: Card(
                                                                                       
                                                                                        child: AcxTrinaGridExtDatawExport(
                                                                                         
                                                                                            extData: theHistData,
                                                                                         
                                                                                            idField: 'EventId',
                                                                                         
                                                  )),
                                              ),
                          
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

Widget signInHistory(String? userId) {
  if (userId != null) {
    return Flexible(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Status Change History'),
          sbh20,
          SizedBox(
              height: 300,
              child: AcxTrinaGridExtData(
                  showBorder: false,
                  showActions: false,
                  extData: stsChangeHist,
                  spName: 'ApiEnrlCustList',
                  idField: 'UserId',
                  onSelectedTap: (TrinaRow val) {})),
        ],
      ),
    );
  }
  return const Spacer(flex: 5);
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
