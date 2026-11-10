// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatauniquekey.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

import 'package:trina_grid/trina_grid.dart';

class AcxEventList extends ConsumerWidget {
  const AcxEventList(
      {super.key, required this.ettyId, this.refType, this.refId});

  final String ettyId;
  final String? refType;
  final String? refId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = QueryObject(
        querysql: 'ApiMgmtEventHist',
        params: {"EttyId": ettyId},
        showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          return AcxTrinaGridExtDataUniqueKey(
            onRefresh: () {
              ref.invalidate(ReturndatafreezedProvider(query));
            },
            onNew: () async {
              await showAcxDialog(
                  context,
                  EventDialog(
                    ettyId: ettyId,
                    eventId: null,
                    // refType: refType,
                    //  refId: refId
                  )).then(
                (val) {
                  ref.invalidate(ReturndatafreezedProvider(query));
                },
              );
            },
            onSelectedTap: (TrinaRow val) {
              showAcxDialog(
                  context,
                  EventDialog(
                    ettyId: ettyId,
                    eventId: val.cells['EventId']!.value.toString(),
                    //  refType: refType,
                    //  refId: refId,
                    rsnCd: val.cells['RsnCd']!.value.toString(),
                    reminder: DateFormat.yMMMEd()
                        .parse(val.cells['Reminder']!.value.toString()),
                    effvdate: DateFormat.yMMMEd()
                        .parse(val.cells['EffvDate']!.value.toString()),
                    eventType: val.cells['EventType']!.value.toString(),
                    note: val.cells['Note']!.value.toString(),
                  ));
            },
            extData: theData,
            spName: 'ApiMgmtEventHist',
            idField: 'EventId',
          );
        });
  }
}

class EventDialog extends ConsumerWidget {
  const EventDialog({
    super.key,
    this.ettyId,
    this.refType,
    this.refId,
    this.eventType,
    this.eventId,
    this.sts,
    this.rsnCd,
    this.note,
    this.effvdate,
    this.reminder,
  });

  final String? ettyId;
  //passed ACCTNO for billing account
  final String? refType;
  //passed actual account number for billing account
  final String? refId;
  final String? eventType;
  final String? eventId;
  final String? sts;
  final String? rsnCd;
  final String? note;
  final DateTime? effvdate;
  final DateTime? reminder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stsChangeKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "EttyId": ettyId,
      "EventType": eventType,
      "EventId": eventId,
      "RefType": refType,
      "RefId": refId,
      "Sts": sts,
      "RsnCd": rsnCd,
      "Note": note,
      "EffvDate": effvdate,
      "Reminder": reminder,
    };

    return FormBuilder(
      key: stsChangeKey,
      initialValue: formValue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: Text(
              'Event Info',
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Expanded(
                    flex: 11,
                    child: Card(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: ListView(
                              children: [
                                FbHiddenText(name: 'EttyId'),
                                FbHiddenText(name: 'EventId'),
                                //  FbHiddenText(name: 'RefId'),
                                // FbHiddenText(name: 'RefType'),
                                // FbText(
                                //   name: 'Dscp',
                                //   label: 'Description',
                                //   initialValue: formValue['Dscp']?? '',
                                //   readOnly: true,
                                // ),

                                ListTile(
                                    title: FbLibView(
                                        name: 'EventType',
                                        label: 'Event Type',
                                        params: const {
                                          "RefType": "EventType",
                                          "BitInd": null
                                        },
                                        keyField: 'RefCd',
                                        searchText: 'Dscp',
                                        querySql:
                                            '/sp/GetLibRef/queryasyncnouser')),
                                ListTile(
                                    title: FbLibView(
                                        name: 'RsnCd',
                                        label: 'Reason',
                                        params: {"EttyId": ettyId},
                                        keyField: 'RefCd',
                                        searchText: 'Dscp',
                                        querySql:
                                            '/sp/ApiRsnCdList/queryasyncnouser')),
                                ListTile(
                                    title: FbDateTimePicker(
                                        name: 'EffvDate',
                                        label: 'Effective Date')),
                                ListTile(
                                    title: FbDateTimePicker(
                                        name: 'Reminder',
                                        label: 'Reminder Date')),
                                ListTile(
                                    title: FbText(
                                  name: 'Note',
                                  label: 'Note',
                                  maxLines: 3,
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      AcxSaveButtonManual(onSave: () {
                        stsChangeKey.currentState!.save();
                        //   Map<String, dynamic> toPost = convertFormValueToSave(stsChangeKey.currentState!.value,theData.columnInfo );
                        //   toPost.remove('Dscp');

                        var toPost = convertFormDateValue(
                            stsChangeKey.currentState!.value,
                            ['Reminder', 'EffvDate']);
                        final querySave = QueryObject(
                            querysql: '/sp/ApiMgmtEventSave/queryasync?logId=${ettyId ?? 0}',
                            params: toPost,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((Returndata value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            final eventId =
                                getOutputValueStr(value.output, '@EventId');
                            stsChangeKey.currentState!
                                .patchValue({"EventId": eventId});
                            stsChangeKey.currentState!.save();
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
                      AcxAuditLogReqBtn('ApiMgmtEventSave',ettyId: ettyId.toString(),),
                    ],
                  ),
                )
              ],
            ),
          ),
          //               Expanded(
          //                 flex: 10,
          //                 child: Row(
          //                   children: [
          //                     Expanded(
          //                       flex: 3,
          //                       child: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           const Padding(
          //                             padding: EdgeInsets.only(top: 8, left: 8),
          //                             child: Text(
          //                               'Change Status',
          //                               //   style: hdrStyle,
          //                             ),
          //                           ),
          //                           Expanded(
          //                             flex: 5,
          //                             child: Card(
          //                               child: ListView(
          //                                 children: [

          //                                   ListTile(title: FbLibView(name: 'RsnCd', label: 'Reason to Change', params: {"EttyId": ettyId}, keyField: 'RefCd', searchText: 'Dscp', querySql: '/sp/ApiRsnCdList/queryasyncnouser')),
          //  const ListTile(title: FbDateTimePicker(name: 'Reminder', label: 'Reminder Date')),
          //                                   const ListTile(
          //                                       title: FbText(
          //                                     name: 'Note',
          //                                     label: 'Note',
          //                                     maxLines: 3,
          //                                   )),
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),

          //                   ],
          //                 ),
          //               ),
        ],
      ),
    );
  }

  // @EttyId = 109,
  // 	@EventType = ADHOC,
  // 	@EventId = @EventId OUTPUT,
  // 	@RefType = "ACCTNO",
  // 	@RefId = 123,
  // 	@Sts = NULL,
  // 	@RsnCd = NULL,
  // 	@Note = "Second Event",
  // 	@EffvDate = NULL,
  // 	@Reminder = NULL,
}
