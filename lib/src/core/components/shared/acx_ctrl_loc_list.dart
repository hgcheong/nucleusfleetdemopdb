import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_libview_addr.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

class AcxCtrlLocList extends ConsumerWidget {
  const AcxCtrlLocList({
    super.key,
    this.accptId,
    required this.isMgmt
  });

  final String? accptId;
  final bool isMgmt;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

   if (accptId == null) {
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

    final query = QueryObject(
        querysql: '/sp/Api${isMgmt?'Mgmt':'Enrl'}LocAccptLocList/queryasync',
        params: {
          "AccptId": convStrNewOrNullToNull(accptId)
        },
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
  if (returnData.data == null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Flexible(
            flex: 1,
            child: ElevatedButton(
                onPressed: () async {
                  Set<TrinaRow> selectedItems = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: PopUpCtrlSearchLocForm(
                              accptId: accptId.toString(), isMgmt: isMgmt,));
                    },
                  );

                  if (selectedItems.isEmpty) return;

                  for (TrinaRow element in selectedItems) {
                  //  Debugger.log(element);
                    final siteId = element.cells['SiteId']!.value.toString();
                    final queryDel = QueryObject(
                        querysql: '/sp/Api${isMgmt?'Mgmt':'Enrl'}LocAccptLocSave/queryasync?logId=${convStrNewOrNullToNull(accptId) ?? 0}',
                        params: {
                          "AccptId": accptId,
                          "SiteId": siteId,
                        },
                        showMsg: false);
                    final resultDel =
                        ref.read(ReturndatafreezedProvider(queryDel).future);
                    resultDel.then((value) {
                    
                    if(!isSuccess(value.message)){
                      Toast.showresult(value);
                    }
                    else{
      ref.invalidate(ReturndatafreezedProvider(query));
                    }
                    });
                  }
                  //  Toast.showresult(value);
        
                },
                child: const Icon(Icons.post_add)),
          ),
              const SizedBox(
                  height: 300,
                  child: SelectableText('No Record ')),
            ],
          );
        }
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
            flex: 1,
            child: ElevatedButton(
                onPressed: () async {
                  Set<TrinaRow> selectedItems = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: PopUpCtrlSearchLocForm(
                              accptId: accptId.toString(), isMgmt:  isMgmt,));
                    },
                  );

                  if (selectedItems.isEmpty) return;

                  for (TrinaRow element in selectedItems) {
                  //  Debugger.log(element);
                    final siteId = element.cells['SiteId']!.value.toString();
                    final queryDel = QueryObject(
                        querysql: '/sp/Api${isMgmt?'Mgmt':'Enrl'}LocAccptLocSave/queryasync?logId=${convStrNewOrNullToNull(accptId) ?? 0}',
                        params: {
                          "AccptId": accptId,
                          "SiteId": siteId,
                        },
                        showMsg: false);
                    final resultDel =
                        ref.read(ReturndatafreezedProvider(queryDel).future);
                    resultDel.then((value) {
                    
                    if(!isSuccess(value.message)){
                      Toast.showresult(value);
                    }
                    else{
      ref.invalidate(ReturndatafreezedProvider(query));
                    }
                    });
                  }
                  //  Toast.showresult(value);
        
                },
                child: const Icon(Icons.post_add)),
          ),
          // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
          Expanded(
            child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: returnData.rowcount!,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      final currentData = returnData.data![index];
                      return currentData["SiteId"] ==null? const SelectableText('No Record'): ListTile(
                        title: SelectableText(
                            '${currentData['SiteId']} ${currentData['SiteName']}'),
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
                                      '/sp/Api${isMgmt?'Mgmt':'Enrl'}LocAccptLocDel/queryasync?logId=${convStrNewOrNullToNull(accptId) ?? 0}',
                                  params: {
                                    "AccptId":"${currentData['AccptId']}",
                                    "SiteId":"${currentData['SiteId']}"
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


class PopUpCtrlSearchLocForm extends HookWidget {
  const PopUpCtrlSearchLocForm({
    super.key,
    this.accptId,
    required this.isMgmt
  });


  final String? accptId;
  final bool isMgmt;
  @override
  Widget build(BuildContext context) {

    final searchLocName = useTextEditingController(text: '');
  //  final searchLocNo = useTextEditingController(text: '');
          final searchState = useTextEditingController(text: '');
        final dv = useState<Returndata>(Returndata());

    final checkedItem = useState<Set<TrinaRow>>(<TrinaRow>{});
 useEffect(() {
          Future<void> fetchData() async {
            try {
         final dda  = await retrieveData(searchLocName, searchState);
                    dv.value = Returndata(
                            output: dda.output,
                            data: dda.data,
                            columnInfo: dda.columnInfo);
            } catch (e) {
             Toast.error(e.toString());
            }
          }

          fetchData();
          return null; // No cleanup needed for this simple effect
        }, const []); 
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
                  // sbw54,
                  // Expanded(
                  //   flex: 1,
                  //   child: TextFormField(
                  //     controller: searchLocNo,
                  //     decoration:
                  //         const InputDecoration(hintText: 'Site Id'),
                  //   ),
                  // ),
                  sbw20,
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                    
                      controller: searchLocName,
                      decoration:
                          const InputDecoration(
                            labelText: 'Site Name',
                            floatingLabelBehavior: FloatingLabelBehavior.always, 
                            hintText: ''),
                    ),
                  ),
                      sbw20,
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: FbLibViewAddrState(
                            name: 'StateCd',
                            label: 'State',
                            params: const {"RefType": "STATE", "BitInd": null},
                            keyField: 'RefCd',
                            searchText: 'Dscp',
                            querySql: '/sp/GetLibRef/queryasyncnouser',
                            onClearPress: (){
                              searchState.text = '';
                            },
                            returnSelectedRef: (val){     
                                  searchState.text = val['RefCd'];
                            },
                          ),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final dda = await retrieveData(searchLocName, searchState);

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
                  idField: 'SiteId',
                  spName: 'Api${isMgmt?'Mgmt':'Enrl'}LocAccptLocSearch',
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

  Future<Returndata> retrieveData(TextEditingController searchLocName, TextEditingController searchState) {
    return AcxReturnDataService().retrieve(
                          '/sp/Api${isMgmt?'Mgmt':'Enrl'}LocAccptLocSearch/queryasync',
                          {
                            "AccptId": accptId,
                            "SiteName": searchLocName.value.text == ''
                                ? null
                                : searchLocName.value.text,
                            "StateCd":searchState.text == '' ? null: searchState.text
                          },
                          showMsg: false);
  }
}