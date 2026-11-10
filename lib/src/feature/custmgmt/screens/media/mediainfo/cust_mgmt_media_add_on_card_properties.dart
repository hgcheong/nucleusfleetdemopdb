import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/media/cust_mgmt_media_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=612;

@RoutePage()
class CustMgmtMediaAddOnCardProperties extends ConsumerWidget {
  const CustMgmtMediaAddOnCardProperties(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('mediaCtgry') this.mediaCtgry,
      @PathParam.inherit('mediaId') this.mediaId});

  final String? custEttyId;
  final String? mbrEttyId;
  final String? prgEttyId;
  final String? mediaCtgry;
  final String? mediaId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyCustMgmtlMediaProp = GlobalKey<FormBuilderState>();
    final queryMediaTypeList = QueryObject(
        querysql: '/sp/ApiMgmtCustMediaTypeList/queryasync',
        params: {"CustEttyId": custEttyId, "PrgEttyId": prgEttyId},
        showMsg: false);

    final queryMediaTypeListData =
        ref.watch(ReturndatafreezedProvider(queryMediaTypeList));

    final qoFormData = QueryObject(
        querysql: '/sp/ApiMgmtMediaAddOnProp/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "PrgEttyId": prgEttyId,
          "MbrEttyId": mbrEttyId,
          "MediaId": convStrNewOrNullToNull(mediaId)
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      "MbrEttyId": mbrEttyId,
      "MediaId": convStrNewOrNullToNull(mediaId),
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
            //return form value does not have the category so we add it back
            formNewValue["MediaCtgry"] = mediaCtgry;
          }

          return AsyncValueWidget(
              value: queryMediaTypeListData,
              data: (optionData) {
                return FormBuilder(
                  key: formKeyCustMgmtlMediaProp,
                  autovalidateMode: AutovalidateMode.always,
                  initialValue: formNewValue,
                  onChanged: () {
                    formKeyCustMgmtlMediaProp.currentState!.save();
                  },
                  child: SizedBox(
                    height: 1280,
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                        Flexible(
                          flex: 3,
                          child: ListView(
                            children: [
                              const MediaPropertiesHdr2(),
                              const FbHiddenText(name: 'CustEttyId'),
                              const FbHiddenText(name: 'PrgEttyId'),
                              const FbHiddenText(name: 'MbrEttyId'),
                              const FbHiddenText(name: 'MediaId'),
                   
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
                                  label: 'Required Pre-approval', initialValue: formNewValue['RequireAppvl']),
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
                                  name: 'OdmCtrl', label: 'Odometer Control', initialValue: formNewValue['OdmCtrl'],),
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
                              //           'CHIP': Icon(
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
                              formKeyCustMgmtlMediaProp.currentState!.save();
                              Map<String, dynamic> toPost =
                                  convertFormValueToSave(
                                      formKeyCustMgmtlMediaProp
                                          .currentState!.value,
                                      theData.columnInfo);
                              final querySave = QueryObject(
                                  querysql:
                                      '/sp/ApiMgmtMediaAddOnPropSave/queryasync?logId=${convStrNewOrNullToNull(mbrEttyId) ?? 0}',
                                  params: toPost,
                                  showMsg: false);
                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((Returndata value) {
                                Toast.showresult(value);
                                if (isSuccess(value.message)) {
                                  if (context.mounted) {
                                    singleton<AppRouter>()
                                        .navigatePath(getAfterSavePath(
                                            context, value.output, '@MediaId'))
                                        .then((val) {
                                      ref.invalidate(ReturndatafreezedProvider(
                                          qoFormData));
                                    });
                                  }
                                }
                              });
                            }),
                            AcxBackToList(
                                listUrl: '/custmgmt/media/$custEttyId/list/addOn'),
                                AcxAuditLogReqBtn('ApiMgmtMediaAddOnPropSave', ettyId: mbrEttyId.toString(),)
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

class MediaPropertiesHdr extends StatelessWidget {
  const MediaPropertiesHdr({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: const Row(
        children: [
          Flexible(
              child: Column(
            children: [
              SelectableText('Media Holder'),
              SelectableText('Program'),
              SelectableText('PostPaid')
            ],
          )),
          Flexible(
              child: Column(
            children: [
              SelectableText(''),
              SelectableText('Media Category'),
              SelectableText('Vehicle Card')
            ],
          )),
          Flexible(
              child: Column(
            children: [SelectableText(''), SelectableText('1a')],
          )),
        ],
      ),
    );
  }
}

class MediaPropertiesHdr2 extends ConsumerWidget {
  const MediaPropertiesHdr2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mediaHolderName = ref.watch(mediaCustMgmtMediaHolderNameProvider);
    // final mediaMediaPrgSelect = ref.watch(mediaCustMgmtMediaPrgSelectProvider);
    // final mediaMediaCategorySelect =
    //     ref.watch(mediaCustMgmtMediaCategorySelectProvider);
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          Row(
            children: [
              const SelectableText('Media Holder'),
              SelectableText(mediaHolderName),
            ],
          ),
          // const Row(
          //   children: [
          //     SelectableText('Program'),
          //     sbw10,
          //     SelectableText('Media Category'),
          //   ],
          // ),
          // Row(
          //   children: [
          //     SelectableText(mediaMediaPrgSelect['PrgDscp'] ?? ''),
          //     sbw10,
          //     SelectableText(mediaMediaCategorySelect['Dscp'] ?? '')
          //   ],
          // ),
        ],
      ),
    );
  }
}
