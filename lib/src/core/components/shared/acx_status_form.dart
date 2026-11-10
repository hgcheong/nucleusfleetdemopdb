import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/mockdata.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

@RoutePage()
class AcxStatusForm extends ConsumerWidget {
  const AcxStatusForm({
    super.key,
    this.ettyId,
    required this.backToListUrl,
    required this.query,
    required this.querySaveSql,
  });

  final String? ettyId;
  final String? backToListUrl;
  final QueryObject query;
  final String querySaveSql;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stsChangeKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "ChgSts": null,
      "RsnCd": null,
      "Rmrk": null,
      "EffvDate": null,
      "EttyId": ettyId,
      "EttyType": null,
      "Dscp": null,
      "StsDscp": null
    };

    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          if (theData.data != null) {
            formValue = convertForm(theData);
          }
          return FormBuilder(
            key: stsChangeKey,
            initialValue: formValue,
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
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 10,
                          child: Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ListView(
                                    children: [
                                      const FbHiddenText(name: 'EttyId'),
                                      FbText(
                                        name: 'Dscp',
                                        label: 'Description',
                                        initialValue:
                                            formValue['Dscp'].toString(),
                                        readOnly: true,
                                      ),
                                      // FbText(
                                      //   name: 'RmrkDisplay',
                                      //   label: 'Remark',
                                      //   initialValue: formValue['Rmrk'].toString(),
                                      //   readOnly: true,
                                      // ),
                                    ],
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: ListView(
                                    children: [
                                      FbText(
                                        name: 'StsDscp',
                                        label: 'Current Status',
                                        initialValue:
                                            formValue['StsDscp'].toString(),
                                        readOnly: true,
                                      ),
                                      // FbText(
                                      //   name: 'EffvDateDisplay',
                                      //   label: 'Effective Date',
                                      //   initialValue: formValue['EffvDate'].toString(),
                                      //   readOnly: true,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // child: GridView.count(
                            //   crossAxisCount: 2,
                            //   children:  [
                            //     ListTile(
                            //       leading:const Text('Location No:'),
                            //       title: Text(formValue['LocNo'].toString()),
                            //     ),
                            //        ListTile(
                            //       leading:const Text('Location Name:'),
                            //       title: Text(formValue['LocName'].toString()),
                            //     ),

                            //     ListTile(
                            //       leading:const Text('Status'),
                            //       title: Text(formValue['StsDscp'].toString()),
                            //     )
                            //   ],
                            // ),
                          ))),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            AcxSaveButtonManual(onSave: () {
                              stsChangeKey.currentState!.save();
                              Map<String, dynamic> toPost =
                                  Map.from(stsChangeKey.currentState!.value);
                              toPost.remove('StsDscp');
                              toPost.remove('Dscp');
                              toPost.remove('EffvDateDisplay');
                              toPost.remove('RmrkDisplay');
                              final querySave = QueryObject(
                                  querysql: querySaveSql,
                                  params: toPost,
                                  showMsg: false);
                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((Returndata value) {
                                Toast.showresult(value);
                                if (isSuccess(value.message)) {
                                  ref.invalidate(
                                      ReturndatafreezedProvider(query));
                                }
                              });
                            }),
                            AcxBackToList(listUrl: backToListUrl.toString()),
                            AcxAuditLogReqBtn(querySaveSql,ettyId: formValue['EttyId'].toString(),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
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
                                            name: 'ChgSts',
                                            label: 'Change Status to',
                                            params: {"EttyId": ettyId},
                                            keyField: 'RefCd',
                                            searchText: 'Dscp',
                                            querySql:
                                                '/sp/GetEttyStsList/queryasyncnouser')),
                                    ListTile(
                                        title: FbLibView(
                                            name: 'RsnCd',
                                            label: 'Reason to Change',
                                            params: {"EttyId": ettyId},
                                            keyField: 'RefCd',
                                            searchText: 'Dscp',
                                            querySql:
                                                '/sp/GetEttyRsnCdList/queryasyncnouser')),
                                    const ListTile(
                                        title: FbDateTimePicker(
                                            name: 'EffvDate',
                                            label: 'Effective Date')),
                                    const ListTile(
                                        title: FbText(
                                      name: 'Rmrk',
                                      label: 'Remarks',
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
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8, left: 8),
                              child: Text(
                                'Change Location Status History',
                                //   style: hdrStyle,
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Card(
                                    child: SingleChildScrollView(
                                        child: AcxTrinaGridExtData(
                                            showBorder: false,
                                            showActions: false,
                                            extData: stsChangeHist,
                                            spName: 'ApiEnrlCustList',
                                            idField: 'UserId',
                                            onSelectedTap:
                                                (TrinaRow val) {})))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
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
          AcxTrinaGridExtData(
              showBorder: false,
              showActions: false,
              extData: stsChangeHist,
              spName: 'ApiEnrlCustList',
              idField: 'UserId',
              onSelectedTap: (TrinaRow val) {}),
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
      color: DbColors.primary,
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
