import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/shared/acx_status_dialog.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=751;

@RoutePage()
class MchtMgmtTadGenInfo extends StatelessWidget {
  const MchtMgmtTadGenInfo(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('tadId') this.tadId,
      @PathParam.inherit('tadEttyId') this.tadEttyId});

  final String? mchtEttyId;
  final String? tadId;
  final String? tadEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return MchtMgmtTadForm(
        mchtEttyId: mchtEttyId,
        tadEttyId: convStrNewOrNullToNull(tadEttyId),
        tadId: convStrNewOrNullToNull(tadId));
  }
}

class MchtMgmtTadForm extends ConsumerWidget {
  const MchtMgmtTadForm({
    super.key,
    this.mchtEttyId,
    this.tadId,
    this.tadEttyId,
  });

  final String? mchtEttyId;
  final String? tadId;
  final String? tadEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();
    final query = QueryObject(
        querysql: '/sp/ApiMgmtMchtTad/queryasync',
        params: {
          "MchtEttyId": mchtEttyId,
          //    "LocEttyId": locEttyId,
          "TadEttyId": tadEttyId,
          "TadId": tadId
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "TadNo": null,
      "MnM": null,
      "Vendor": null,
      "SerialNo": null,
      "InstallDate": null,
      "Installer": null,
      "SttlmtInd": null,
      "AcqringNw": null,
      "MchtEttyId": mchtEttyId,
      "BusnUnitEttyId": null,
      "LocEttyId": null,
      "TadEttyId": tadEttyId,
      "TadId": tadId,
      "TmntionDate": null
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return formData.when(
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
              initialValue: formNewValue,
              key: formKey,
              onChanged: () {
                formKey.currentState!.save();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Card(
                      child: ListView(
                        children: [
                          const FbHiddenText(name: 'TadEttyId'),
                          const FbHiddenText(name: 'TadId'),
                          const FbHiddenText(name: 'MchtEttyId'),
                          const FbHiddenText(name: 'AcqringNw'),
                          const ListTile(
                              title: SelectableText(
                            'Device Info',
                            //    style: hdrStyle
                          )),
                          const ListTile(
                              title: Row(
                                children: [
                                  Expanded(child: FbText(name: 'TadNo', label: 'TAD No.', readOnly: true,)),
                                  sbw10,
                                  Expanded(child: FbText(name: 'TId', label: 'TID'))
                                ],
                              )),
                          ListTile(
                            title: FbLibView(
                              name: 'BusnUnitEttyId',
                              initialValue: formNewValue['BusnUnitEttyId'],
                              label: 'Attached to Business Unit',
                              params: {"MchtEttyId": mchtEttyId},
                              keyField: 'BusnUnitEttyId',
                              searchText: 'Description',
                              querySql: '/sp/ApiMgmtBusnUnitList/queryasync',
                              // onClearPress: () {
                              //   ref.read(ettyIdDynamicChildProvider.notifier).state = {
                              //     "EttyId": null,
                              //   };
                              // },
                              returnSelectedRef: (val) {
                                ref
                                    .read(
                                        ettyIdMgmtDynamicChildProvider.notifier)
                                    .state = {"EttyId": val["BusnUnitEttyId"]};
                              },
                            ),
                          ),
                          ListTile(
                            title: DynamicMgmtChild(
                              searchText: 'Dscp',
                              label: 'Attached to Location',
                              ettyProvider: ettyIdMgmtDynamicChildProvider,
                              name: 'LocEttyId',
                              keyEttyId: 'LocEttyId',
                            ),
                          ),
                           ListTile(
                              title: FbSwitch(
                                  name: 'SttlmtInd',
                                  initialValue: formNewValue['SttlmtInd'],
                                  label: 'Device initiate EOD Settlement')),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Card(
                      child: ListView(
                          //  crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            const ListTile(
                                title: SelectableText(
                              'Hardware Info',
                              //     style: hdrStyle
                            )),
                            ListTile(
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: FbLibref(
                                                                    initialValue: formNewValue['MnM'],
                                                                    name: 'MnM',
                                                                    label: 'Make & Model',
                                                                    params: const {
                                      "RefType": "TADMNM",
                                      "BitInd": null
                                                                    },
                                                                  ),
                                    ),
                                    sbw10,
                                                                Expanded(
                                                                  child: FbLibref(
                                                                                                initialValue: formNewValue['Vendor'],
                                                                                                name: 'Vendor',
                                                                                                label: 'Vendor',
                                                                                                params: const {
                                                                                                  "RefType": "TADVENDOR",
                                                                                                  "BitInd": null
                                                                                                },
                                                                                              ),
                                                                )
                                  ],
                                )),
                            const ListTile(
                              title: FbText(
                                label: 'Serial Number',
                                name: 'SerialNo',
                              ),
                            ),
                            const ListTile(
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: FbText(
                                          name: 'Installer', label: 'Installer'),
                                    ),
                                    sbw10,
                                   Expanded(
                                      child: FbDateTimePicker(
                                      name: 'InstallDate',
                                      label: 'Install Date'),
                                    )
                                  ],
                                )),
                              
                            ListTile(
                              title: const Row(
                                children: [
                                  // Expanded(child: FbText(name: 'SiteId', label: 'Site Id')),
                                  Expanded(
                                    child: FbText(
                                      name: 'TadStsDscp',
                                      label: 'Status',
                                      readOnly: true,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: formNewValue['TadId'] ==null? const IconButton(
                                
                                  onPressed: null,
                                  icon:  Icon(Icons.arrow_right)):  IconButton(
                                  onPressed: () async {
                                    await showAcxDialog(
                                        context,
                                        AcxStatusDialog(
                                          stsType: StatusType.tadSts,
                                          ettyId: tadEttyId,
                                        ));

                                    ref.invalidate(
                                        ReturndatafreezedProvider(query));
                                  },
                                  icon: const Icon(Icons.arrow_right)),
                            ),
                            //TmntionDate
                            // const ListTile(title: FbDateTimePicker(name: 'TmntionDate', label: 'Termination Date'))
                          ]),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        AcxSaveButtonManual(
                          onSave: () {
                              if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                            formKey.currentState!.save();
                            //ApiEnrlLocTadFeeSave
                            Map<String, dynamic> toPost =
                                convertFormValueToSave(
                                    Map.from(formKey.currentState!.value),
                                    theData.columnInfo);

                            toPost.remove('TadStsDscp');
                            //  toPost.remove('BusnUnitEttyId');
                            final saveResult = ref.read(
                                ReturndatafreezedProvider(QueryObject(
                                        querysql:
                                            '/sp/ApiMgmtMchtTadSave/queryasync?logId=${convStrNewOrNullToNull(tadEttyId) ?? 0}',
                                        params: toPost,
                                        showMsg: false))
                                    .future);
                            saveResult.then((Returndata value) {
                              Toast.showresult(value);
                              if (isSuccess(value.message)) {
                                var tadId =
                                    getOutputValue(value.output, '@TadId');
                                    var tadEttyId =  getOutputValue(value.output, '@TadEttyId');
                                String toNav =
                                    '/mcmgmt/tad/$mchtEttyId/geninfo/$tadEttyId/$tadId/main';
    
                                //   String afterSavedPath = getAfterSavePath(context, value.output, '@FeeId');
                                   ref.invalidate(
                                      ReturndatafreezedProvider(query));
                                singleton<AppRouter>()
                                    .navigatePath(toNav);
                                //
                              }
                            });
                          },
                        ),
                        // '/mcenroll/tad/$mchtEttyId/geninfo/$tadEttyId/$tadId');
                         AcxBackToList(listUrl: '/mcmgmt/tad/$mchtEttyId/list'),
                         AcxAuditLogReqBtn('ApiMgmtMchtTadSave',ettyId: tadEttyId.toString(),)
                      ],
                    ),
                  )
                ],
              ));
        },
        error: (x, e) => Center(child: Text(e.toString()),),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

final ettyIdMgmtDynamicChildProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "EttyId": null,
  };
});

class DynamicMgmtChild extends ConsumerWidget {
  const DynamicMgmtChild({
    super.key,
    required this.keyEttyId,
    required this.ettyProvider,
    required this.label,
    required this.name,
    required this.searchText,
    this.emptyMessage = "Please Create Location",
  });

  final String keyEttyId;
  final String emptyMessage;
  final String label;
  final String searchText;
  final StateProvider<Map<String, dynamic>> ettyProvider;
  final String name;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final val = ref.watch(ettyProvider);
    if (val["EttyId"] == null) {
      return FbHiddenText(name: name);
      // return Row(
      //   children: [
      //     Flexible(child: SelectableText(emptyMessage)),
      //     Flexible(
      //         child: FbHiddenText(
      //       name: name,
      //     )),
      //   ],
      // );
    }
    final queryObject = QueryObject(
        querysql: '/sp/ApiEttyList /queryasync', params: val, showMsg: false);
    final dataSrc = ref.watch(ReturndatafreezedProvider(queryObject));
    return AsyncValueWidget(
        value: dataSrc,
        data: (re) {
          if (re.data == null) {
            return SelectableText(emptyMessage);
          }
          if (re.data![0][keyEttyId] == null) {
            return Row(
              children: [
                SelectableText(emptyMessage),
                FbHiddenText(
                  name: name,
                ),
              ],
              // children: [
              //   Expanded(child: SelectableText(emptyMessage)),
              //   Expanded(
              //       child: FbHiddenText(
              //     name: name,
              //   )),
              // ],
            );
          } else {
            return FbLibViewExt(
              name: name,
              datasrc: re,
              initialValue: null,
              label: label,
              keyField: keyEttyId,
              searchText: searchText,
              returnSelectedRef: (Map<String, dynamic> val) {
                //  Toast.message(val.toString());
              },
            );
          }
        });
  }
}

final mchtMgmtBusnUnitProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {"BusnUnitEttyId": null, "LocEttyId": null};
});
