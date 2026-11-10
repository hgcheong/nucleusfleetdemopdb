import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=676;

@RoutePage()
class MchtEnrlProfileGenInfo extends StatelessWidget {
  const MchtEnrlProfileGenInfo({
    super.key,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
  });

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return MchtEnrlGeneralInfo(
      mchtEttyId: mchtEttyId,
    );
  }
}

class MchtEnrlGeneralInfo extends ConsumerWidget {
  const MchtEnrlGeneralInfo({
    super.key,
    this.mchtEttyId,
  });

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mchtEnrollFormKey = GlobalKey<FormBuilderState>();
    var querySql = QueryObject(
        querysql: '/sp/ApiEnrlMcht/queryasync',
        params: {"MchtEttyId": mchtEttyId == 'new' ? null : mchtEttyId},
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "MchtEttyId": convStrNewOrNullToNull(mchtEttyId),
      "TaxCtgry": null,
      "TaxNo": null,
      "AcctMgrContactNo": null,
      "CmpyName": null,
      "RgstionName": null,
      "RgstionNo": null,
      "SegmtType": null,
      "ApplRef": null,
      "ApplSrc": null,
      "SubmtDate": null,
      "RgstionDate": null,
      "AcctMgrName": null,
      "AgrmtNo": null,
      "CmpyType": null,
      "AgrmtDate": null,
      "BusnType": null,
      "CmpySize": null,
      "MchtSts": null,
      "DedupInd": null,
    };

    final formData = ref.watch(ReturndatafreezedProvider(querySql));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: mchtEnrollFormKey,
            initialValue: formNewValue,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                const FbHiddenText(name: 'MchtEttyId'),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      //    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText('Merchant Info'),
                        const Row(
                          children: [
                            Expanded(
                                child: FbText(
                                    name: 'AgrmtNo',
                                    label: 'Agreement Number')),
                                    fbFieldGap,
                            Expanded(
                              child: FbDateTimePicker(
                                  name: 'AgrmtDate', label: 'Agreement Date'),
                            )
                          ],
                        ),
                       const FbText(
                          name: 'CmpyName',
                          label: 'Merchant Name',
                        ),
                       const FbText(
                          name: 'RgstionName',
                          label: 'Business Registration Name',
                        ),
                                    const  Row(
                            children: [
                              Expanded(
                                child: FbText(
                                  name: 'RgstionNo',
                                         label: 'Business Registration No',
                       
                                ),
                              ),
                   
                            ],
                          ),
                            const  Row(
                            children: [
                              Expanded(
                                child: FbText(
                                  name: 'OldRgstionNo',
                                    label: 'Old Registration No',
                                ),
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            
                            Expanded(
                              child: FbDateTimePicker(
                                  name: 'RgstionDate',
                                  label: 'Date of Incorporation'),
                            ),
                            fbFieldGap,
                                   Expanded(
                              child: FbLibref(
                                  name: 'CmpySize',
                                  label: "Company Size",
                                  initialValue: formNewValue['CmpySize'],
                                  params: const {
                                    "RefType": "BUSNSIZE",
                                    "BitInd": null,
                                  }),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                     
                            const Expanded(
                                child:
                                    FbText(name: 'TaxNo', label: 'Tax Number')),
                           fbFieldGap,
                            Expanded(
                              child: FbLibref(
                                  name: 'TaxCtgry',
                                  initialValue: formNewValue['TaxCtgry'],
                                  label: 'Tax Category',
                                  params: const {
                                    "RefType": "TaxCtgry",
                                    "BitInd": null
                                  }),
                            )
                          ],
                        ),
                        FbLibref(
                          name: 'SegmtType',
                          label: "Business Segment",
                          params: const {
                            "RefType": "BUSNSEGMT",
                            "BitInd": null
                          },
                          initialValue: formNewValue['SegmtType'],
                        ),
                        FbLibref(
                          name: 'CmpyType',
                          label: 'Company Type',
                          params: const {"RefType": "CMPYTYPE", "BitInd": null},
                          initialValue: formNewValue['CmpyType'],
                        ),
                        FbLibref(
                          name: 'BusnType',
                          label: "Business Type",
                          params: const {"RefType": "BusnType", "BitInd": null},
                          initialValue: formNewValue['BusnType'],
                        ),
                        convStrNewOrNullToNull(mchtEttyId) == null
                            ? const FbSwitch(
                                name: 'DedupInd',
                                label:
                                    'Create Location with same information provided',
                              )
                            : const FbHiddenText(name: 'DedupInd')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText('Application Info'),
                       const FbText(
                          name: 'ApplRef',
                          label: 'Application Reference',
                        ),
                        FbLibref(
                            name: 'ApplSrc',
                            label: 'Application Source',
                            params: const {
                              "RefType": "APPLSRC",
                              "BitInd": null
                            },
                            initialValue: formNewValue['ApplSrc']),
                        const FbDateTimePicker(
                            name: 'SubmtDate', label: 'Submission Date'),
                        FbLibView(name: 'AcctMgrId', label: 'Account Manager', params: {}, keyField: 'AcctMgrId', searchText: 'AcctMgrName', querySql: '/view/async/VwAcctMgrMcht'),
                        FbLibref(   
                          readOnly: true,
                          name: 'MchtSts',
                          label: 'Merchant Status',
                          params: const {"RefType": "EnrlSts", "BitInd": null},
                          initialValue: formNewValue['MchtSts'],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    AcxSaveButtonManual(onSave: () {
                        if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                      mchtEnrollFormKey.currentState!.save();
                      Map<String, dynamic> toPost = convertFormValueToSave(
                          mchtEnrollFormKey.currentState!.value,
                          theData.columnInfo);
                      final querySave = QueryObject(
                          querysql: '/sp/ApiEnrlMchtSave/queryasync?logId=${convStrNewOrNullToNull(mchtEttyId) ?? 0}',
                          params: toPost,
                          showMsg: false);
                      final saveResult =
                          ref.read(ReturndatafreezedProvider(querySave).future);
                      saveResult.then((Returndata value) {
                        Toast.showresult(value);
                        if (isSuccess(value.message)) {
                          ref.invalidate(ReturndatafreezedProvider(querySql));
                        }
                      });
                    }),
                    const AcxBackToList(listUrl: '/mcenroll/main'),
                    AcxAuditLogReqBtn('ApiEnrlMchtSave', ettyId: mchtEttyId.toString(),)
                  ]),
                )
              ],
            ));
      },
    );
  }
}
