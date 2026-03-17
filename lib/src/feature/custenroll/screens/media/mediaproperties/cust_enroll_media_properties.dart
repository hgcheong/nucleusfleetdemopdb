import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/feature/custenroll/screens/media/cust_enroll_media_provider.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=500;

@RoutePage()
class CustEnrollMediaProperties extends ConsumerWidget {
  const CustEnrollMediaProperties(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('mediaCtgry') this.mediaCtgry,
      @PathParam.inherit('mediaEttyId') this.mediaEttyId});

  final String? custEttyId;
  final String? mbrEttyId;
  final String? prgEttyId;
  final String? mediaCtgry;
  final String? mediaEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    getTitle(
            ref,
            {
              "MediaEttyId": mbrEttyId,
            },
            AppBarTitleType.enroll)
        .then((value) {
      ref.read(appBarTitleProvider.notifier).state = value.toString();
    });
    final formKeyCustEnrllMediaProp = GlobalKey<FormBuilderState>();
    final queryMediaTypeList = QueryObject(
        querysql: '/sp/ApiEnrlCustMediaTypeList/queryasync',
        params: {"CustEttyId": custEttyId, "PrgEttyId": prgEttyId},
        showMsg: false);

    final queryMediaTypeListData =
        ref.watch(ReturndatafreezedProvider(queryMediaTypeList));

    final qoFormData = QueryObject(
        querysql: '/sp/ApiEnrlMediaProp/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "PrgEttyId": prgEttyId,
          "MbrEttyId": mbrEttyId,
          "MediaEttyId": convStrNewOrNullToNull(mediaEttyId)
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      "MbrEttyId": mbrEttyId,
      "MediaEttyId": convStrNewOrNullToNull(mediaEttyId),
      "MediaCtgry": mediaCtgry,
      "MediaType": null,
      "ExpMth": null,
      "ExpDate": null,
      "OdmCtrl": null,
      "RequireAppvl": null,
      "TacType": null,
    };

    // return AsyncValueWidget<Returndata>(value: theData, data: (theResul) {});
    final formData = ref.watch(ReturndatafreezedProvider(qoFormData));

    return AsyncValueWidget(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
            formNewValue['MediaCtgry'] = mediaCtgry;
          }

          return AsyncValueWidget(
              value: queryMediaTypeListData,
              data: (optionData) {
                return FormBuilder(
                  key: formKeyCustEnrllMediaProp,
                  autovalidateMode: AutovalidateMode.always,
                  initialValue: formNewValue,
                  onChanged: () {
                    formKeyCustEnrllMediaProp.currentState!.save();
                  },
                  child: SizedBox(
                    height: 1280,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: ListView(
                            children: [
                              MediaPropertiesHdr2(formNewValue['PrgDscp']),
                              const FbHiddenText(name: 'CustEttyId'),
                              const FbHiddenText(name: 'PrgEttyId'),
                              const FbHiddenText(name: 'MbrEttyId'),
                              const FbHiddenText(name: 'MediaEttyId'),
                              // const FbHiddenText(name: 'MediaCtgry'),
                              FbLibView(
                                name: 'MediaCtgry',
                                initialValue: formNewValue['MediaCtgry'],
                                label: 'Category',
                                params: {'PrgEttyId': prgEttyId},
                                keyField: 'MediaCtgry',
                                searchText: 'Dscp',
                                querySql: '/sp/ApiPrgMediaCtgryList/queryasync',
                                returnSelectedRef: (val) {},
                              ),
                              FbSwitch(
                                  name: 'RequireAppvl',
                                  label: 'Required Pre-approval',
                                  initialValue: formNewValue['RequireAppvl']),
                              const SelectableText('Expiry Month'),
                              const Row(
                                children: [
                                  Flexible(
                                      child: FbText(
                                          name: 'ExpMth', label: '# Months')),
                                  Flexible(child: SelectableText('OR')),
                                  Flexible(
                                    child: FbDateTimePicker(
                                        name: 'ExpDate',
                                        label: 'Specific Date'),
                                  )
                                ],
                              ),
                              FbSwitch(
                                  name: 'OdmCtrl',
                                  label: 'Odometer Control',
                                  initialValue: formNewValue['OdmCtrl']),
                                  FbHiddenText(name: 'TacType'),
                                  FbHiddenText(name: 'MediaType')
                              // const FbOption(
                              //   label: 'Type of Transaction Tac',
                              //   name: 'TacType',
                              //   querysql: '/sp/GetLibRef/queryasyncnouser',
                              //   params: {"RefType": "TacType", "BitInd": null},
                              // ),
                              // const SelectableText('Media Type'),
                              // SizedBox(
                              //   height: 250,
                              //   child: FbChoiceChipOptionExt(
                              //       label: '',
                              //       iconList: const {
                              //         'CHIP': Icon(
                              //           Icons.sim_card,
                              //           color: Colors.green,
                              //         ),
                              //         'MAG': Icon(
                              //           Icons.credit_card,
                              //           color: Colors.green,
                              //         ),
                              //       },
                              //       keyField: 'MediaType',
                              //       displayField: 'MediaTypeDscp',
                              //       name: 'MediaType',
                              //       dataext: optionData),
                              // ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Column(children: [
                            AcxSaveButtonManual(onSave: () {
                                     if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                              formKeyCustEnrllMediaProp.currentState!.save();
                              Map<String, dynamic> toPost =
                                  convertFormValueToSave(
                                      formKeyCustEnrllMediaProp
                                          .currentState!.value,
                                      theData.columnInfo);
                              final querySave = QueryObject(
                                  querysql:
                                      '/sp/ApiEnrlMediaPropSave/queryasync?logId=${convStrNewOrNullToNull(mediaEttyId) ?? 0}',
                                  params: toPost,
                                  showMsg: false);
                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((Returndata value) {
                                Toast.showresult(value);
                                if (isSuccess(value.message)) {
                                  final mediaEttyId = getOutputValue(
                                      value.output, '@MediaEttyId');
                                  ref.invalidate(
                                      ReturndatafreezedProvider(qoFormData));

                                  ///custenroll/media/3/detail/FLEET/1/14/16
                                  final strCategory = toPost['MediaCtgry'];
                                  String url =
                                      "/custenroll/media/$custEttyId/detail/$strCategory/$prgEttyId/$mbrEttyId/$mediaEttyId";
                                  singleton<AppRouter>().navigatePath(url);
                                }
                              });
                            }),
                            sbh10,
                            AcxBackToList(
                                listUrl: '/custenroll/media/$custEttyId/list'),
                                sbh10,
                                AcxAuditLogReqBtn('ApiEnrlMediaPropSave',ettyId: mediaEttyId.toString(),)
                          ]),
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

class MediaPropertiesHdr2 extends ConsumerWidget {
  const MediaPropertiesHdr2(this.prgTitle, {super.key});

  final String? prgTitle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mediaHolderName = ref.watch(mediaMediaHolderNameProvider);
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          Row(
            children: [
              const SelectableText('Media Holder'),
              SelectableText(mediaHolderName),
            ],
          ),
        ],
      ),
    );
  }
}
