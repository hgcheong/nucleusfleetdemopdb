import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/media/cust_mgmt_media_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=615;

@RoutePage()
class CustMgmtMediaProperties extends ConsumerWidget {
  const CustMgmtMediaProperties(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('mediaCtgry') this.mediaCtgry,
      @PathParam.inherit('issId') this.issId,
      @PathParam.inherit('mediaEttyId') this.mediaEttyId});

  final String? custEttyId;
  final String? mbrEttyId;
  final String? prgEttyId;
  final String? mediaCtgry;
  final String? mediaEttyId;
  final String? issId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyCustMgmtlDesign = GlobalKey<FormBuilderState>();
    final qoFormData = QueryObject(
        querysql: '/sp/ApiMgmtMediaProp/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "PrgEttyId": prgEttyId,
          "IssId": issId,
          "MbrEttyId": mbrEttyId,
          "MediaEttyId": convStrNewOrNullToNull(mediaEttyId)
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      "MbrEttyId": mbrEttyId,
      "MediaEttyId": convStrNewOrNullToNull(mediaEttyId),
      "CardDsgn": null,
      "NameOnMedia1": null,
      "NameOnMedia2": null,
      "ExpDate": null,
      "ExpMth": null,
      "MediaCtgry": null,
      "MediaType": null,
      "OdmCtrl": null,
      "RequireAppvl": null,
      "TacType": null
    };

    // {"CustEttyId":null ,"ExpDate":null ,"ExpMth":null ,"MbrEttyId":null ,"MediaCtgry":null ,"MediaEttyId":null ,"MediaType":null ,"OdmCtrl":null ,"PrgEttyId":null ,"RequireAppvl":null ,"TacType":null }

    // return AsyncValueWidget<Returndata>(value: theData, data: (theResul) {});
    final formData = ref.watch(ReturndatafreezedProvider(qoFormData));

    return AsyncValueWidget(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
            key: formKeyCustMgmtlDesign,
            autovalidateMode: AutovalidateMode.always,
            initialValue: formNewValue,
            onChanged: () {
              formKeyCustMgmtlDesign.currentState!.save();
            },
            child: SingleChildScrollView(
              child: SizedBox(
                height: 1280,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText('Card Attributes'),
                          //RequireAppvl

                          FbSwitch(
                              name: 'OdmCtrl',
                              label: 'Odometer Control',
                              initialValue: formNewValue['OdmCtrl']),
                          sbh10,
                          FbSwitch(
                              name: 'RequireAppvl',
                              label: 'Require Approval',
                              initialValue: formNewValue['RequireAppvl']),
                          const FbOption(
                            orientation: OptionsOrientation.wrap,
                            label: 'Type of Transaction TAC',
                            name: 'TacType',
                            querysql: '/sp/GetLibRef/queryasyncnouser',
                            params: {"RefType": "TacType", "BitInd": null},
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    const Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // MediaPropertiesHdr2(),
                          FbHiddenText(name: 'CustEttyId'),
                          FbHiddenText(name: 'PrgEttyId'),
                          FbHiddenText(name: 'MbrEttyId'),
                          FbHiddenText(name: 'MediaEttyId'),
                          FbHiddenText(name: 'MediaCtgry'),
                          FbHiddenText(name: 'MediaType'),
                          SelectableText('Plastic Card Design'),
                          FbText(
                            label: 'Name1 appear on Card',
                            name: 'NameOnMedia1',
                          ),
                          FbText(
                            label: 'Name2 appear on Card',
                            name: 'NameOnMedia2',
                          ),
                          FbLibView(
                              name: 'CardDsgn',
                              label: 'Background Design',
                              params: {"RefType": "CardDsgn", "BitInd": null},
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/sp/GetLibRef/queryasyncnouser')
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
                          formKeyCustMgmtlDesign.currentState!
                          .save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              formKeyCustMgmtlDesign.currentState!.value,
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiMgmtMediaPropSave/queryasync?logId=${convStrNewOrNullToNull(mediaEttyId) ?? 0}',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((Returndata value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              if (context.mounted) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(qoFormData));
                                //  singleton<AppRouter>().navigatePath(getAfterSavePath(context, value.output, '@MediaEttyId')).then((val){

                                //  });
                              }
                            }
                          });
                        }),
                        sbh10,
                       const AcxBackToList(
                            listUrl: './prop'),
                            sbh10,
                            AcxAuditLogReqBtn('ApiMgmtMediaPropSave', ettyId: mediaEttyId.toString(),)
                      ]),
                    )
                  ],
                ),
              ),
            ),
          );
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
      color: Colors.blue,
      child: const Row(
        children: [
          Flexible(
              child: Column(
            children: [
              SelectableText('Card Holder'),
              SelectableText('Program'),
              SelectableText('PostPaid')
            ],
          )),
          Flexible(
              child: Column(
            children: [
              SelectableText(''),
              SelectableText('Card Category'),
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
    final mediaMediaPrgSelect = ref.watch(mediaCustMgmtMediaPrgSelectProvider);
    final mediaMediaCategorySelect =
        ref.watch(mediaCustMgmtMediaCategorySelectProvider);
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          Row(
            children: [
              const SelectableText('Card Holder'),
              SelectableText(mediaHolderName),
            ],
          ),
          const Row(
            children: [
              SelectableText('Program'),
              sbw10,
              SelectableText('Card Category'),
            ],
          ),
          Row(
            children: [
              SelectableText(mediaMediaPrgSelect['PrgDscp'] ?? ''),
              sbw10,
              SelectableText(mediaMediaCategorySelect['Dscp'] ?? '')
            ],
          ),
        ],
      ),
    );
  }
}
