import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/media/cust_mgmt_media_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=614;

@RoutePage()
class CustMgmtMediaAddOnCardDesign extends ConsumerWidget {
  const CustMgmtMediaAddOnCardDesign(
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
    final formKeyCustMgmtlDesign = GlobalKey<FormBuilderState>();
    final qoFormData = QueryObject(
        querysql: '/sp/ApiMgmtMediaAddOnDsgn/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "PrgEttyId": prgEttyId,
          "MbrEttyId": mbrEttyId,
          "mediaId": convStrNewOrNullToNull(mediaId)
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      // "MbrEttyId": mbrEttyId,
      "MediaId": convStrNewOrNullToNull(mediaId),
      "CardDsgn": null,
      "NameOnMedia1": null,
      "NameOnMedia2": null,
      "MediaCtgry": mediaCtgry,
    };

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
            child: SizedBox(
              height: 1280,
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: ListView(
                      children: const [
                        MediaPropertiesHdr2(),
                        FbHiddenText(name: 'CustEttyId'),
                        FbHiddenText(name: 'PrgEttyId'),
                        FbHiddenText(name: 'MbrEttyId'),
                        FbHiddenText(name: 'MediaId'),
                        //       FbHiddenText(name: 'MediaCtgry'),
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
                        formKeyCustMgmtlDesign.currentState!.save();
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            formKeyCustMgmtlDesign.currentState!.value,
                            theData.columnInfo);
                        final querySave = QueryObject(
                            querysql:
                                '/sp/ApiMgmtMediaAddOnDsgnSave/queryasync?logId=${convStrNewOrNullToNull(mediaId) ?? 0}',
                            params: toPost,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((Returndata value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            if (context.mounted) {
                              singleton<AppRouter>()
                                  .navigatePath(getAfterSavePath(
                                      context, value.output, '@mediaId'))
                                  .then((val) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(qoFormData));
                              });
                            }
                          }
                        });
                      }),
                      sbh10,
                     const AcxBackToList(
                          listUrl: './prop'),
                          sbh10,
                      AcxAuditLogReqBtn('ApiMgmtMediaAddOnDsgnSave',ettyId: mediaId.toString(),)
                    ]),
                  )
                ],
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
      color: Colors.blue,
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
