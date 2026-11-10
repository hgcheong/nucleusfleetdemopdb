import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/acx_searchmain.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/mediarenewal/mediarenewal_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=179;

@RoutePage()
class MediaRenewalSearch extends ConsumerWidget {
  const MediaRenewalSearch(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mediaRenewSearchKey = GlobalKey<FormBuilderState>();
    //  final mediaParam = ref.watch(mediaSearchContorllerProvider);
    Map<String, dynamic> formNewValue = {
      "CmpyEttyId": null,
      "MediaEttyId": null,
      "VhcRgsNo": null,
      "FromDate": null,
      "ToDate": null,
    };
    return Column(children: [
      sbh10,
      const SelectableText("Media Renewal Search"),
      // sbh20,
      // const SelectableText(
      //   "Transaction Search",
      // ),
      sbh10,
      FormBuilder(
        key: mediaRenewSearchKey,
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
                      const FbHiddenText(name: 'CmpyEttyId'),
                      const FbHiddenText(name: 'MediaEttyId'),
        //                                           const Row(
        //                             children: [
        //                               Padding(
        //                                 padding: EdgeInsets.only(left: 8),
        //                                 child: Icon(Icons.person),
        //                               ),
        // sbw20,
        //                               Expanded(child: FbNumber(label: 'Media No', name: 'MediaNo')),
        //                             ],
        //                           ),
        
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: AcxSearchMain(
                                  searchAttr: 'Str',
                                  label: 'Company',
                                  params: const {},
                                  keyField: 'CmpyEttyId',
                                  searchText: 'Dscp',
                                  showSearchBox: true,
                                  refCd: 'CMPYNAME',
                                  selectedRef: formNewValue['CmpyEttId'],
                                  querysql:
                                      '/sp/ApiMgmtMainSearch/queryasync',
                                  inputText: 'Company',
                                  returnSelectedRef: (val) {
                                    mediaRenewSearchKey.currentState!
                                        .patchValue({
                                      'CmpyEttyId':
                                          val['CmpyEttyId'].toString()
                                    });
                                    // mediaRenewSearchKey.currentState!.save();
                                  }),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: AcxSearchMain(
                                  // name: 'MchtEttyId',
                                  searchAttr: 'Int',
                                  label: 'Media Number',
                                  params: const {},
                                  keyField: 'MediaEttyId',
                                  searchText: 'Dscp',
                                  showSearchBox: true,
                                  refCd: 'MEDIANO',
                                  querysql:
                                      '/sp/ApiMgmtMainSearch/queryasync',
                                  inputText: 'Media Number',
                                  returnSelectedRef: (val) {
                                    mediaRenewSearchKey.currentState!
                                        .patchValue({
                                      'MediaEttyId':
                                          val['MediaEttyId'].toString()
                                    });
                                    //   mediaRenewSearchKey.currentState!.save();
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                sbw10,
                const Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: FbDateTimePicker(
                            name: 'FromDate',
                            label: 'From Date',
                          )),
                          fbFieldGap,
                          Flexible(
                              child: FbDateTimePicker(
                                  name: 'ToDate', label: 'To Date'))
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                mediaRenewSearchKey.currentState!.save();
                                Map<String, dynamic> toPost =
                                    convertFormDateValue(
                                        mediaRenewSearchKey
                                            .currentState!.value,
                                        ['FromDate', 'ToDate']);
                                ref
                                    .read(mediaSearchContorllerProvider
                                        .notifier)
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
      ),
        
     const Expanded(child:  TxnMediaRenewalSearch())
    ]);
  }
}

class TxnMediaRenewalSearch extends ConsumerWidget {
  const TxnMediaRenewalSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(mediaSearchContorllerProvider);
    final query = QueryObject(
        querysql: '/sp/ApiMgmtMediaRenewSearch/queryasync',
        params: toPost,
        showMsg: false);
    final data = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: data,
        data: (theData) {
          return AcxTrinaGridExtDataCheckBox(
              iconButtons: [
                IconWithFunction(
                    icon: const Icon(Icons.library_add),
                    func: (ValueNotifier<Set<TrinaRow>> val) async {
                      bool confirmed = await ConfirmDialog.show(
                          title: 'Renew selected cards?');
                    
                      if (confirmed) {
                        var rows = val.value;
                        // for (var element in theTotalNo) {
                        //   //  Toast.message(element.toJson().toString());
                        // }
                    
                        var futures = <Future>[];
                        for (var i = 0; i < rows.length; i++) {
                    //                     ###
                    // POST {{baseUrl}}/sp/ApiMgmtMediaRenewSave/queryasync HTTP/1.1
                    // Authorization: Bearer {{authorization}}
                    // content-type: application/json
                    
                    // {
                    // "CmpyEttyId":529,
                    // "MediaEttyId":null,
                    // "MediaNo":null,
                    // "MediaId":null,
                    // "PrgEttyId":1,
                    // "CustEttyId":null,
                    
                    // }
                          final queryDel = QueryObject(
                              querysql:
                                  '/sp/ApiEnrlCmpyLocAccptDel/queryasync',
                              params: {
                                // "CustEttyId": custEttyId,
                                // "CmpyEttyId": cmpyEttyId,
                                // "PrgEttyId": rows.elementAt(i).cells["PrgEttyId"]!.value.toString(),
                                // "AccptId": rows.elementAt(i).cells["AccptId"]!.value.toString(),
                                "CmpyEttyId": rows
                                    .elementAt(i)
                                    .cells["CmpyEttyId"]!
                                    .value
                                    .toString(),
                                "MediaEttyId": rows
                                    .elementAt(i)
                                    .cells["MediaEttyId"]!
                                    .value
                                    .toString(),
                                "MediaNo": rows
                                    .elementAt(i)
                                    .cells["MediaNo"]!
                                    .value
                                    .toString(),
                                "MediaId": rows
                                    .elementAt(i)
                                    .cells["MediaId"]!
                                    .value
                                    .toString(),
                                "PrgEttyId": rows
                                    .elementAt(i)
                                    .cells["PrgEttyId"]!
                                    .value
                                    .toString(),
                                "CustEttyId": rows
                                    .elementAt(i)
                                    .cells["CustEttyId"]!
                                    .value
                                    .toString(),
                              },
                              showMsg: false);
                          final resultDel = ref.read(
                              ReturndatafreezedProvider(queryDel).future);
                          futures.add(resultDel);
                        }
                        await Future.wait(futures, eagerError: true)
                            .then((value) {
                          //   ref.invalidate(listQuery);
                          List<dynamic> rtt = value;
                    
                          for (var element in rtt) {
                            if (!isSuccess(element.message)) {
                              Toast.showresult(element);
                            }
                          }
                          ref.invalidate(
                              ReturndatafreezedProvider(query));
                        }).onError((error, stackTrace) {
                          Toast.message(error.toString());
                        });
                      }
                    })
              ],
              isMultiSelect: true,
              // gridTitle: 'Renewal List',
              extData: theData,
              idField: 'MediaId',
              spName: 'ApiMgmtMediaRenewSearch');
        });
  }
}
