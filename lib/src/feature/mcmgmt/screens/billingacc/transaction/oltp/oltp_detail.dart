import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:trina_grid/trina_grid.dart';

class McmgmtOltpDetail extends ConsumerWidget {
  const McmgmtOltpDetail({
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
            height: 1280,
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
                                  label: 'Card Number',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'AuthMediaNo',
                                  label: 'Driver Card',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'LocationNo',
                                  label: 'LocationNo',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'TerminalId',
                                  label: 'Terminal ID',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'STAN',
                                  label: 'STAN',
                                )),
                                ListTile(
                                    title: FbText(
                                  name: 'AuthCode',
                                  label: 'Authorization Code',
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
                                      name: 'ReqId', label: 'Req ID'),
                                ),
                                ListTile(
                                  title: FbText(
                                      name: 'RespCode', label: 'Resp Code'),
                                ),
                                ListTile(
                                  title: FbText(
                                      name: 'MesssgeType',
                                      label: 'Message Type'),
                                ),
                                ListTile(
                                  title:
                                      FbNumber(name: 'TxnAmt', label: 'TxnAmt'),
                                ),
                    
                      
                                ListTile(
                                  title: FbText(
                                      name: 'RewardNo', label: 'Reward No'),
                                ),
                  
                           
                                ListTile(
                                  title: FbText(name: 'ErrorMessage', label: 'Error Message'),
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
          // SizedBox(
          //   height: 1280,
          //   child: AcxTrinaGridWithColumn(
          //       useNav: false,
          //       idField: 'Id',
          //       spName: 'RpeDrivewayTxnItemSearch',
          //       params: {
          //         "Id": myformValue['Id'].toString(),
          //         "AcctId": myformValue['AcctId'] == "0"
          //             ? null
          //             : myformValue['AcctId'].toString(),
          //         "LogId": myformValue['LogId'].toString(),
          //       },
          //       querysql: '/sp/RpeDrivewayTxnItemSearch/queryasyncoltp'),
          // )
        ],
      ),
    );
  }
}
