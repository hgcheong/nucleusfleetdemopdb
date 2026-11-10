import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custenroll/screens/media/mediaproperties/cust_enroll_media_properties.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=498;

@RoutePage()
class CustEnrollMediaDesign extends ConsumerWidget {
  const CustEnrollMediaDesign(
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
    final formKeyCustEnrllDesign = GlobalKey<FormBuilderState>();
    final qoFormData = QueryObject(
        querysql: '/sp/ApiEnrlMediaDsgn/queryasync',
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
            key: formKeyCustEnrllDesign,
            autovalidateMode: AutovalidateMode.always,
            initialValue: formNewValue,
            onChanged: () {
              formKeyCustEnrllDesign.currentState!.save();
            },
            child: SizedBox(
              height: 1280,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Flexible(
                    flex: 3,
                    child: ListView(
                      children:  [
                        MediaPropertiesHdr2(formNewValue['PrgDscp']),
                        FbHiddenText(name: 'PrgEttyId'),
                        FbHiddenText(name: 'CustEttyId'),
                        FbHiddenText(name: 'MbrEttyId'),
                        FbHiddenText(name: 'MediaEttyId'),

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
                        formKeyCustEnrllDesign.currentState!.save();
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            formKeyCustEnrllDesign.currentState!.value,
                            theData.columnInfo);

                        final querySave = QueryObject(
                            querysql: '/sp/ApiEnrlMediaDsgnSave/queryasync?logId=${convStrNewOrNullToNull(mediaEttyId) ?? 0}',
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
                                      context, value.output, '@MediaEttyId'))
                                  .then((val) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(qoFormData));
                              });
                            }
                          }
                        });
                      }),
                      AcxBackToList(
                          listUrl: '/custenroll/media/$custEttyId/list'),
                      AcxAuditLogReqBtn('ApiEnrlMediaDsgnSave', ettyId: mediaEttyId.toString(),)
                    ]),
                  )
                ],
              ),
            ),
          );
        });
  }
}
