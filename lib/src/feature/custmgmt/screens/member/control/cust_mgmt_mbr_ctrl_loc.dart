import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/shared/acx_ctrl_loc_list.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=623;

@RoutePage()
class CustMgmtMemberCtrlLoc extends ConsumerWidget {
  const CustMgmtMemberCtrlLoc(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId,
      @PathParam('prgEttyId') this.prgEttyId,
      @PathParam('accptId') this.accptId});

  final String? custEttyId;
  final String? mbrEttyId;
  final String? prgEttyId;
  final String? accptId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();
    final accptIdVal = convStrNewOrNullToNull(accptId);
    final query = QueryObject(
        querysql: '/sp/ApiMgmtMbrLocAccpt/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "MbrEttyId": mbrEttyId,
          "AccptId": accptIdVal
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "FromTime": null,
      "ToTime": null,
      "FromDate": null,
      "ToDate": null,
      "Dscp": "",
      "Mon": "0",
      "Tue": "0",
      "Wed": "0",
      "Thu": "0",
      "Fri": "0",
      "Sat": "0",
      "Sun": "0",
      "mbrEttyId": mbrEttyId,
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      "AccptType": "W",
      "AccptId": accptIdVal
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
            key: formKey,
            initialValue: formNewValue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const FbHiddenText(name: 'MbrEttyId'),
                      const FbHiddenText(name: 'CustEttyId'),
                      const FbHiddenText(name: 'PrgEttyId'),
                      const FbHiddenText(name: 'AccptId'),
                      const FbText(name: 'Dscp', label: 'Description'),
                      const SelectableText('Type of Acceptance'),
                      FbField(child: FormBuilderRadioGroup(
                        orientation: OptionsOrientation.horizontal,
                        name: 'AccptType',
                        options: const [
                          FormBuilderFieldOption(
                            value: 'W',
                            child: Icon(Icons.playlist_add_check),
                          ),
                          FormBuilderFieldOption(
                            value: 'B',
                            child: Icon(Icons.playlist_remove),
                          )
                        ],
                      )),
                      const SelectableText('Valid Transaction Day'),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: FbField(child: FormBuilderChoiceChips(
                                  name: 'Mon',
                                  options: const [
                                    FormBuilderChipOption(
                                      value: "1",
                                      child: SelectableText('M'),
                                    ),
                                  ])),
                            ),
                            Expanded(
                              child: FbField(child: FormBuilderChoiceChips(
                                  name: 'Tue',
                                  options: const [
                                    FormBuilderChipOption(
                                      value: "1",
                                      child: SelectableText('T'),
                                    ),
                                  ])),
                            ),
                            Expanded(
                              child: FbField(child: FormBuilderChoiceChips(
                                  name: 'Wed',
                                  options: const [
                                    FormBuilderChipOption(
                                      value: "1",
                                      child: SelectableText('W'),
                                    ),
                                  ])),
                            ),
                            Expanded(
                              child: FbField(child: FormBuilderChoiceChips(
                                  name: 'Thu',
                                  options: const [
                                    FormBuilderChipOption(
                                      value: "1",
                                      child: SelectableText('T'),
                                    ),
                                  ])),
                            ),
                            Expanded(
                              child: FbField(child: FormBuilderChoiceChips(
                                  name: 'Fri',
                                  options: const [
                                    FormBuilderChipOption(
                                      value: "1",
                                      child: SelectableText('F'),
                                    ),
                                  ])),
                            ),
                            Expanded(
                              child: FbField(child: FormBuilderChoiceChips(
                                  name: 'Sat',
                                  options: const [
                                    FormBuilderChipOption(
                                      value: "1",
                                      child: SelectableText('S'),
                                    ),
                                  ])),
                            ),
                            Expanded(
                              child: FbField(child: FormBuilderChoiceChips(
                                  name: 'Sun',
                                  options: const [
                                    FormBuilderChipOption(
                                      value: "1",
                                      child: SelectableText('S'),
                                    ),
                                  ])),
                            ),
                          ]),
                      const Row(
                        children: [
                          Flexible(
                              child: FbTimePicker(
                                  label: 'From Time', name: 'FromTime')),
                          fbFieldGap, Flexible(
                            child: FbTimePicker(
                              label: 'To Time',
                              name: 'ToTime',
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Flexible(
                              child: FbDateTimePicker(
                                  label: 'From Date', name: 'FromDate')),
                          fbFieldGap, Flexible(
                            child: FbDateTimePicker(
                              label: 'To Date',
                              name: 'ToDate',
                            ),
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: ListView(
                    children: [
                      const Row(
                        children: [
                          SelectableText(
                              'Apply settings to the following location.')
                        ],
                      ),
                      const SelectableText(
                          '(Settings will apply to all Location if no entry in the list)'),
                      SizedBox(
                        height: 1280,
                       child: AcxCtrlLocList(
                          accptId: convStrNewOrNullToNull(accptId),isMgmt: true,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        ElevatedButton(
                          child: const Icon(Icons.save),
                          onPressed: () {
                            formKey.currentState!.save();
                            final toPost = convertIntNullValue(
                                convertFormValueToSave(
                                    formKey.currentState!.value,
                                    theData.columnInfo),
                                [
                                  'Mon',
                                  'Tue',
                                  'Wed',
                                  'Thu',
                                  'Fri',
                                  'Sat',
                                  'Sun'
                                ]);
                                        if(!isValidFromToTime(toPost['FromTime'],toPost['ToTime'])){
   Toast.error("From Time cannot equal To Time");
                                return;
                            }
                            final querySave = QueryObject(
                                querysql:
                                    '/sp/ApiMgmtMbrLocAccptSave/queryasync',
                                params: toPost,
                                showMsg: false);
                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((value) {
                              Toast.showresult(value);
                              if (isSuccess(value.message)) {
                                String theNewId =
                                    getOutputValue(value.output, '@AccptId')
                                        .toString();
                                singleton<AppRouter>().navigatePath(
                                    '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/locaccpt/detail/$prgEttyId/$theNewId');
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                              }
                            });
                          },
                        ),
                        sbh10,
                        AcxBackToList(
                            listUrl:
                                '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/locaccpt'),
                        AcxAuditLogReqBtn('ApiMgmtMbrLocAccptSave,ApiMgmtLocAccptLocSave,ApiMgmtLocAccptLocDel',ettyId: formNewValue["AccptId"].toString(),)
                      ],
                    )),
              ],
            ),
          );
        });
  }
}

class CustMgmtMemberCtrlLocList extends ConsumerWidget {
  const CustMgmtMemberCtrlLocList({
    super.key,
    this.accptId,
    this.custEttyId,
    this.mbrEttyId,
    this.prgEttyId,
  });

  final String? accptId;
  final String? custEttyId;
  final String? mbrEttyId;
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtMbrLocAccptLocList/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "MbrEttyId": mbrEttyId,
          "AccptId": convStrNewOrNullToNull(accptId)
        },
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          return const SizedBox(
              height: 300,
              child: Expanded(child: SelectableText('No Record ')));
        }
        if (returnData.data![0]['AccptId'] == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectableText('No Location Setup, Please Save First'),
              Expanded(
                  child: ListView(
                children: const [SelectableText('No Record')],
              ))
            ],
          );
        }

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
            flex: 1,
            child: ElevatedButton(
                onPressed: () async {
                  Set<TrinaRow> selectedItems = await showAcxDialog(
                      context,
                      PopUpCustMgmtMemberCtrlSearchLocForm(
                          prgEttyId: prgEttyId.toString(),
                          custEttyId: custEttyId,
                          mbrEttyId: mbrEttyId,
                          accptId: accptId.toString()));

                  if (selectedItems.isEmpty) return;

                  for (TrinaRow element in selectedItems) {
                  //  Debugger.log(element);
                    final locno = element.cells['LocNo']!.value.toString();
                    final queryDel = QueryObject(
                        querysql: '/sp/ApiMgmtMbrLocAccptLocSave/queryasync',
                        params: {
                          "CustEttyId": custEttyId,
                          "MbrEttyId": mbrEttyId,
                          "PrgEttyId": prgEttyId,
                          "AccptId": accptId,
                          "LocNo": locno,
                        },
                        showMsg: false);
                    final resultDel =
                        ref.read(ReturndatafreezedProvider(queryDel).future);
                    resultDel.then((value) {
   ref.invalidate(ReturndatafreezedProvider(query));
                    });
                  }
                  //  Toast.showresult(value);
               
                },
                child: const Icon(Icons.post_add)),
          ),
          // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
          Expanded(
            child: returnData.data![0]['LocateId'] == null
                ? const SelectableText('No Record')
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: returnData.rowcount!,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      final currentData = returnData.data![index];
                      return ListTile(
                        title: SelectableText(
                            '${currentData['LocName']} ${currentData['LocNo']}'),
                        trailing: IconButton(
                            onPressed: () async {
                              bool confirmed = await ConfirmDialog.show(
                                title: "Delete?",
                                body: "Are you sure you want to Delete?",
                                destructive: true,
                                confirmText: "Yes",
                                cancelText: "Cancel",
                              );

                              if (!confirmed) {
                                return;
                              }

                              final queryDel = QueryObject(
                                  querysql:
                                      '/sp/ApiMgmtMbrLocAccptLocDel/queryasync',
                                  params: {
                                    "CustEttyId": custEttyId,
                                    "PrgEttyId": prgEttyId,
                                    "MbrEttyId": mbrEttyId,
                                    "AccptId": accptId,
                                    "LocNo": "${currentData['LocNo']}",
                                    "LocateId": "${currentData['LocateId']}"
                                  },
                                  showMsg: false);
                              final resultDel = ref.read(
                                  ReturndatafreezedProvider(queryDel).future);
                              resultDel.then((value) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                                Toast.showresult(value);
                              });
                            },
                            icon: const Icon(Icons.delete)),
                      );
                    },
                  ),
          ),
        ]);
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()),);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class CustMgmtMemberCtrlTxnLocList extends HookConsumerWidget {
  const CustMgmtMemberCtrlTxnLocList({
    super.key,
    this.custEttyId,
    this.mbrEttyId,
    this.prgEttyId,
    this.accptId,
    required this.onChecked,
    required this.toggleCheckAll,
  });

  final String? custEttyId;
  final String? mbrEttyId;
  final String? prgEttyId;
  final String? accptId;
  final Function onChecked;
  final Function toggleCheckAll;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtMbrLocAccptLocList/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "MbrEttyId": mbrEttyId,
          "CustEttyId": custEttyId,
          "AccptId": accptId
        },
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));
    //   final isAllChecked = useState<bool>(false);
    final listOfItems = useState<List<Map<String, dynamic>>>([
      {'id': 0, 'checked': false, 'value': 'abc'},
      {'id': 1, 'checked': true, 'value': 'cde'},
      {'id': 2, 'checked': false, 'value': 'fgh'}
    ]);

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          List<Widget> toAdd = [];
          toAdd.add(ElevatedButton(
              onPressed: () {
                for (var i = 0; i < listOfItems.value.length; i++) {
                  if (listOfItems.value.elementAt(i)['checked']) {
                    Toast.message(listOfItems.value.elementAt(i).toString());
                  }
                }
              },
              child: const Icon(Icons.delete)));
          toAdd.addAll(listOfItems.value
              .map((item) => ListTile(
                  leading: Checkbox(
                    value: listOfItems.value
                        .where((element) => element['id'] == item['id'])
                        .first['checked'],
                    onChanged: (va) {
                      var copiedval =
                          List<Map<String, dynamic>>.from(listOfItems.value);
                      final vv = copiedval
                          .where((element) => element['id'] == item['id'])
                          .first;
                      vv['checked'] = va;
                      //    vv['another'] = 'asdf';
                      listOfItems.value = copiedval;
                    },
                  ),
                  title: SelectableText(item['value'].toString())))
              .toList());
          //   toAdd.add(SelectableText('heelo'));
          return Column(
            children: toAdd,
          );
          //  Column(
          //   children: [
          //     ListTile(
          //       title: Row(
          //         children: [
          //           Checkbox(
          //               value: isAllChecked.value,
          //               onChanged: (v) {
          //                 isAllChecked.value = !isAllChecked.value;
          //                 toggleCheckAll(isAllChecked.value);
          //               }),
          //           const SelectableText('Location ID'),
          //           const SelectableText('Name'),
          //         ],
          //       ),
          //     ),
          //     ListTile(
          //       title: Row(
          //         children: [
          //           Checkbox(
          //               value: isAllChecked.value,
          //               onChanged: (v) {
          //                 isAllChecked.value = !isAllChecked.value;
          //                 toggleCheckAll(isAllChecked.value);
          //               }),
          //           const SelectableText('Location ID'),
          //           const SelectableText('Name'),
          //         ],
          //       ),
          //     ),
          //     ListTile(
          //       title: Row(
          //         children: [
          //           Checkbox(
          //               value: isAllChecked.value,
          //               onChanged: (v) {
          //                 isAllChecked.value = !isAllChecked.value;
          //                 toggleCheckAll(isAllChecked.value);
          //               }),
          //           const SelectableText('Location ID'),
          //           const SelectableText('Name'),
          //         ],
          //       ),
          //     ),
          //   ],
          // );
        }
        if (returnData.data![0]['AccptId'] == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    Set<TrinaRow> selectedItems = await showAcxDialog(
                        context,
                        const Spacer(
                          flex: 1,
                        )
                        // PopUpSearchLocForm(prgEttyId: prgEttyId.toString(), custEttyId: custEttyId, accptId: accptId.toString())
                        );

                    for (TrinaRow element in selectedItems) {
                      Debugger.log(element);
                      final locno = element.cells['LocNo']!.value.toString();
                      final queryDel = QueryObject(
                          querysql: '/sp/ApiMgmtMbrLocAccptSave/queryasync',
                          params: {
                            "CustEttyId": custEttyId,
                            "PrgEttyId": prgEttyId,
                            "AccptId": accptId,
                            "LocNo": locno,
                          },
                          showMsg: false);
                      final resultDel =
                          ref.read(ReturndatafreezedProvider(queryDel).future);
                      resultDel.then((value) {
                        //  ref.invalidate(ReturndatafreezedProvider(query));
                        //  Toast.showresult(value);
                      });
                    }
                    //  Toast.showresult(value);
                    ref.invalidate(ReturndatafreezedProvider(query));
                    Debugger.log(selectedItems);
                  },
                  child: const Icon(Icons.post_add)),
              const SelectableText('No Location Setup'),
              Expanded(
                  child: ListView(
                children: const [
                  SelectableText('No Record'),
                ],
              ))
            ],
          );
        }

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ElevatedButton(
              onPressed: () async {
                Set<TrinaRow> selectedItems = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Dialog(
                      //  backgroundColor: bgColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: PopUpCustMgmtMemberCtrlSearchLocForm(
                            mbrEttyId: mbrEttyId,
                            prgEttyId: prgEttyId.toString(),
                            custEttyId: custEttyId,
                            accptId: accptId.toString()));
                  },
                );

                if (selectedItems.isEmpty) return;

                for (TrinaRow element in selectedItems) {
                  Debugger.log(element);
                  final locno = element.cells['LocNo']!.value.toString();
                  final queryDel = QueryObject(
                      querysql: '/sp/ApiMgmtMbrLocAccptSave/queryasync',
                      params: {
                        "CustEttyId": custEttyId,
                        "PrgEttyId": prgEttyId,
                        "AccptId": accptId,
                        "LocNo": locno,
                      },
                      showMsg: false);
                  final resultDel =
                      ref.read(ReturndatafreezedProvider(queryDel).future);
                  resultDel.then((value) {});
                }
                //  Toast.showresult(value);
                ref.invalidate(ReturndatafreezedProvider(query));
              },
              child: const Icon(Icons.post_add)),
          const ListTile(
            title: SelectableText('Location ID'),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: returnData.rowcount!,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  final currentData = returnData.data![index];
                  return currentData["LocateId"] ==null? const SelectableText('No Record'): ListTile(
                    title: SelectableText(
                        '${currentData['LocName']} ${currentData['LocNo']}'),
                    trailing: IconButton(
                        onPressed: () async {
                          bool confirmed = await ConfirmDialog.show(
                            title: "Delete?",
                            body: "Are you sure you want to Delete?",
                            destructive: true,
                            confirmText: "Yes",
                            cancelText: "Cancel",
                          );

                          if (!confirmed) {
                            return;
                          }

                          final queryDel = QueryObject(
                              querysql: '/sp/ApiMgmtMbrLocAccptDel/queryasync',
                              params: {
                                "CustEttyId": custEttyId,
                                "PrgEttyId": prgEttyId,
                                "AccptId": accptId,
                                "LocNo": "${currentData['LocNo']}",
                                "FeeLocId": "${currentData['FeeLocId']}"
                              },
                              showMsg: false);
                          final resultDel = ref
                              .read(ReturndatafreezedProvider(queryDel).future);
                          resultDel.then((value) {
                            ref.invalidate(ReturndatafreezedProvider(query));
                            Toast.showresult(value);
                          });
                        },
                        icon: const Icon(Icons.delete)),
                  );
                },
              ),
            ),
          ),
        ]);
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()),);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class PopUpCustMgmtMemberCtrlSearchLocForm extends HookWidget {
  const PopUpCustMgmtMemberCtrlSearchLocForm({
    super.key,
    this.prgEttyId,
    this.custEttyId,
    this.mbrEttyId,
    this.accptId,
  });

  final String? prgEttyId;
  final String? custEttyId;
  final String? mbrEttyId;
  final String? accptId;
  @override
  Widget build(BuildContext context) {
    final dv = useState<Returndata>(Returndata());
    final searchLocName = useTextEditingController(text: '');
    final searchLocNo = useTextEditingController(text: '');
    final checkedItem = useState<Set<TrinaRow>>(<TrinaRow>{});

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 500,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sbw54,
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: searchLocNo,
                      decoration:
                          const InputDecoration(hintText: 'Location No'),
                    ),
                  ),
                  sbw20,
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: searchLocName,
                      decoration:
                          const InputDecoration(hintText: 'Location Name'),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final dda = await AcxReturnDataService().retrieve(
                            '/sp/ApiMgmtMbrLocAccptLocSearch/queryasync',
                            {
                              "CustEttyId": custEttyId,
                              "PrgEttyId": prgEttyId,
                              "AccptId": accptId,
                              "MbrEttyId": mbrEttyId,
                               "LocNo":searchLocNo.value.text == ''
                                  ? null
                                  : searchLocNo.value.text,
                              "LocName": searchLocName.value.text == ''
                                  ? null
                                  : searchLocName.value.text,
                            },
                            showMsg: false);

                        dv.value = Returndata(
                            output: dda.output,
                            data: dda.data,
                            columnInfo: dda.columnInfo);
                        //  return;
                      },
                      child: const SelectableText(
                        'Search',
                      )),
                  sbw20,
                  IconButton(
                      onPressed: () {
                        singleton<AppRouter>().maybePop(checkedItem.value);
                      },
                      icon: const Icon(Icons.save)),
                  sbw20,
                  IconButton(
                      onPressed: () {
                        singleton<AppRouter>().maybePop(checkedItem.value);
                      },
                      icon: const Icon(Icons.close)),
                ],
              ),
              Expanded(
                child: AcxTrinaGridExtData(
                  idField: 'LocEttyId',
                  spName: 'ApiMgmtMbrLocAccptLocSearch',
                  extData: dv.value,
                  useCheckBox: true,
                  onCheckedAll: (TrinaGridOnRowCheckedEvent v) {
                    if (v.isAll) {
                      if (v.isChecked!) {
                        if (dv.value.data != null) {
                          final theD = dv.value;
                          checkedItem.value.addAll(getRows(theD.data!,
                              theD.columnInfo!, theD.columnInfo!.length, null));
                        }
                      } else {
                        checkedItem.value.clear();
                      }
                    }
                  },
                  onChecked: (TrinaRow? rw) {
                    if (rw!.checked!) {
                      checkedItem.value.add(rw);
                    } else {
                      checkedItem.value.remove(rw);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
