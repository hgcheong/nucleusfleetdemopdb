import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=689;

@RoutePage()
class MchtEnrlTadGenInfo extends StatelessWidget {
  const MchtEnrlTadGenInfo(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam('tadId') this.tadId,
      @PathParam('tadEttyId') this.tadEttyId});

  final String? mchtEttyId;
  final String? tadId;
  final String? tadEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return MchtEnrlTadForm(
        mchtEttyId: mchtEttyId,
        tadEttyId: convStrNewOrNullToNull(tadEttyId),
        tadId: convStrNewOrNullToNull(tadId));
  }
}

class MchtEnrlTadForm extends ConsumerWidget {
  const MchtEnrlTadForm({
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
        querysql: '/sp/ApiEnrlMchtTad/queryasync',
        params: {
          "MchtEttyId": mchtEttyId,
          "TadId": tadId,
          "TadEttyId": tadEttyId,
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "TadNo": null,
      "MnM": null,
      "Vendor": null,
      "SerialNo": null,
      "InstallDate": null,
      "Installer": null,
      "AcqringNw": null,
      "MchtEttyId": mchtEttyId,
      "BusnUnitEttyId": null,
      "LocEttyId": null,
      "TadEttyId": tadEttyId,
      "TadId": tadId
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FbHiddenText(name: 'TadEttyId'),
                        const FbHiddenText(name: 'MchtEttyId'),
                        const FbHiddenText(name: 'AcqringNw'),
                        const FbHiddenText(name: 'TadId'),
                        const SelectableText('Device Info'),
                               sbh10,
                      Row(
                                children: [
                                  Expanded(child: FbText(name: 'TadNo', label: 'TAD No.')),
                                  sbw10,
                                  Expanded(child: FbText(name: 'TId', label: 'TID'))
                                ],
                              ),
                        Flexible(
                          child: FbLibView(
                            name: 'BusnUnitEttyId',
                            initialValue: formNewValue['BusnUnitEttyId'],
                            label: 'Attached to Business Unit',
                            params: {"MchtEttyId": mchtEttyId},
                            keyField: 'BusnUnitEttyId',
                            searchText: 'Description',
                            querySql: '/sp/ApiEnrlMchtBusnUnitList/queryasync',
                            // onClearPress: () {
                            //   ref.read(ettyIdDynamicChildProvider.notifier).state = {
                            //     "EttyId": null,
                            //   };
                            // },
                            returnSelectedRef: (val) {
                              ref
                                  .read(ettyIdDynamicChildProvider.notifier)
                                  .state = {"EttyId": val["BusnUnitEttyId"]};
                            },
                          ),
                        ),
                        DynamicChild(
                          searchText: 'Dscp',
                          label: 'Attached to Location',
                          ettyProvider: ettyIdDynamicChildProvider,
                          name: 'LocEttyId',
                          keyEttyId: 'LocEttyId',
                        ),
                        sbh20,
                         Flexible(
                            child: FbSwitch(
                               initialValue: formNewValue['SttlmtInd'],
                                name: 'SttlmtInd',
                                label: 'Device initiate EOD Settlement')),
                      ],
                    ),
                  ),
                  sbw20,
                  Flexible(
                    flex: 5,
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const SelectableText('Hardware Info'),
                      sbh10,
                      FbLibref(
                        initialValue: formNewValue['MnM'],
                        name: 'MnM',
                        label: 'Make & Model',
                        params: const {"RefType": "TADMNM", "BitInd": null},
                      ),
                      FbLibref(
                        initialValue: formNewValue['Vendor'],
                        name: 'Vendor',
                        label: 'Vendor',
                        params: const {"RefType": "TADVENDOR", "BitInd": null},
                      ),
                      const FbText(
                        label: 'Serial Number',
                        name: 'SerialNo',
                      ),
        Row(
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
                                )
                    ]),
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
                            final saveResult = ref.read(
                                ReturndatafreezedProvider(QueryObject(
                                        querysql:
                                            '/sp/ApiEnrlMchtTadSave/queryasync?logId=${convStrNewOrNullToNull(tadEttyId) ?? 0}',
                                        params: toPost,
                                        showMsg: false))
                                    .future);
                            saveResult.then((Returndata value) {
                              Toast.showresult(value);
                              if (isSuccess(value.message)) {
                                final tadId =
                                    getOutputValue(value.output, "@TadId");
                                final tadEttyId =
                                    getOutputValue(value.output, "@TadEttyId");
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                                singleton<AppRouter>().navigatePath(
                                    '/mcenroll/tad/$mchtEttyId/geninfo/$tadEttyId/$tadId');
                              }
                            });
                          },
                        ),
                        AcxBackToList(
                          listUrl: '/mcenroll/tad/$mchtEttyId/list',
                          fnBeforeNav: () {
                            ref
                                .read(ettyIdDynamicChildProvider.notifier)
                                .state = {
                              "EttyId": null,
                            };
                          },
                        ),
                        AcxAuditLogReqBtn('ApiEnrlMchtTadSave', ettyId: tadEttyId.toString(),)
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

final ettyIdDynamicChildProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "EttyId": null,
  };
});

class DynamicChild extends ConsumerWidget {
  const DynamicChild({
    super.key,
    required this.keyEttyId,
    required this.ettyProvider,
    required this.label,
    required this.name,
    required this.searchText,
    this.emptyMessage = "Please Create Record",
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
        querysql: '/sp/ApiEnrlEttyList/queryasync',
        params: val,
        showMsg: false);
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

final mchtEnrlBusnUnitProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {"BusnUnitEttyId": null, "LocEttyId": null};
});
