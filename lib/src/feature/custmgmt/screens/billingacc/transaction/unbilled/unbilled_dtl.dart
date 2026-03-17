import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:trina_grid/trina_grid.dart';

class UnbilldedDtl extends ConsumerWidget {
  const UnbilldedDtl({
    super.key,
    required this.val,
  });
  final TrinaRow val;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var valoriginal = val.toJson();
    Map<String, String> myformValue =
        valoriginal.map((key, value) => MapEntry(key, value.toString()));

    final mgmtoltpform = GlobalKey<FormBuilderState>();

    return FormBuilder(
      key: mgmtoltpform,
      initialValue: myformValue,
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: SelectableText(
              'Transaction Info',
            ),
          ),
          SizedBox(
            height: 300,
            child: Row(
              children: [
                Expanded(
                    flex: 11,
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: ListView(
                              children: const [
                                ListTile(
                                    title: FbText(
                                  name: 'TxnDate',
                                  label: 'Transaction Date',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'MediaNo',
                                  label: 'Media Number',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'AuthMediaNo',
                                  label: 'Auth Media Number',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'LocationNo',
                                  label: 'LocationNo',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'TADNo',
                                  label: 'TadNo',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'STAN',
                                  label: 'STAN',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'AuthorizationCode',
                                  label: 'AuthCd',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'TADBatchNo',
                                  label: 'TadBatchNo',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'OdometerReading',
                                  label: 'Odometer Reading',
                                )),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: ListView(
                              children: const [
                                ListTile(
                                  title: FbText(
                                      name: 'ResponseCode', label: 'RespCd'),
                                ),
                                ListTile(
                                  title: FbText(
                                      name: 'MessageType',
                                      label: 'Message type'),
                                ),
                                ListTile(
                                  title:
                                      FbNumber(name: 'TxnAmt', label: 'TxnAmt'),
                                ),
                                ListTile(
                                  title:
                                      FbNumber(name: 'BillAmt', label: 'Bill'),
                                ),
                                ListTile(
                                  title: FbNumber(
                                      name: 'SettledDate',
                                      label: 'Settled Date'),
                                ),
                                ListTile(
                                  title: FbText(
                                      name: 'RewardNo', label: 'Reward No'),
                                ),
                                ListTile(
                                  title: FbText(name: 'RRN', label: 'RRN'),
                                ),
                                ListTile(
                                  title:
                                      FbText(name: 'Track2', label: 'Track2'),
                                ),
                                ListTile(
                                  title: FbText(name: 'Error', label: 'Error'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
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
          SizedBox(
            height: 1280,
            child: AcxTrinaGridWithColumn(
                useNav: false,
                idField: 'Seq',
                spName: myformValue['AcctId'] == null ? 'RpeDrivewayTxnUnbillItemList': 'ApiMgmtCustAcctTxnDetailList',
                params: {
                  "TxnId": myformValue['TxnId'].toString(),
                  "AcctId": myformValue['AcctId'] == "0"
                      ? null
                      : myformValue['AcctId'].toString(),
                },
                querysql: myformValue['SrcDestn']!.toUpperCase() == "NUCLEUS" ? '/sp/ApiMgmtCustAcctTxnItemUnbillList/queryasync':'/sp/RpeDrivewayTxnUnbillItemList/queryasyncoltp'),
          )
        ],
      ),
    );
  }
}
