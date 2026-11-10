import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_libviewmultidisp.dart';
import 'package:nucleusv2/src/core/components/shared/acx_status_dialog.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=720;

@RoutePage()
class MchtMgmtLocationProfileGenInfo extends StatelessWidget {
  const MchtMgmtLocationProfileGenInfo(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId});

  final String? mchtEttyId;
  final String? locEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return MchtMgmtLocGeneralInfo(
      mchtEttyId: mchtEttyId,
      locEttyId: convStrNewOrNullToNull(locEttyId),
    );
  }
}

class MchtMgmtLocGeneralInfo extends ConsumerWidget {
  const MchtMgmtLocGeneralInfo({super.key, this.mchtEttyId, this.locEttyId});

  final String? mchtEttyId;
  final String? locEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mchtLocEnrollFormKey = GlobalKey<FormBuilderState>();
    var querySql = QueryObject(
        querysql: '/sp/ApiMgmtLoc/queryasync',
        params: {"MchtEttyId": mchtEttyId, "LocEttyId": locEttyId},
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "AgrmtDate": null,
      "AgrmtNo": null,
      "BusnType": null,
      "BusnUnitEttyId": null,
      "CmcmtDate": null,
      "IntervalRvwdate": null,
      "CmpyMdfDate": null,
      "CmpySize": null,
      "CmpyType": null,
      "DealerType": null,
      "GeoLoc": null,
      "LocEttyId": locEttyId,
      "LocMdfDate": null,
      "LocName": null,
      "LocNo": null,
      "MchtEttyId": mchtEttyId,
      "RgstionDate": null,
      "RgstionName": null,
      "RgstionNo": null,
      "SegmtType": null,
      "SiteId": null,
      "MId":null,
      "TaxCtgry": null,
      "TaxNo": null
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
            key: mchtLocEnrollFormKey,
            initialValue: formNewValue,
            child: SingleChildScrollView(
              child: SizedBox(
                height: 1280,
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FbHiddenText(name: 'MchtEttyId'),
                          const FbHiddenText(name: 'GeoLoc'),
                          const FbHiddenText(name: 'LocEttyId'),
                          const FbHiddenDateTime(name: 'LocMdfDate'),
                          const FbHiddenDateTime(name: 'CmpyMdfDate'),
                          const SelectableText(
                            'Location Info',
                          ),

                             const Row(
                            children: [  Expanded(
                              flex: 1,
                              child:  FbText(name: 'LocNo', label: 'Location No', readOnly: true,)),fbFieldGap,
                      Expanded(
                        flex: 1,
                        child: FbText(name: 'LocName', label: 'Location Name')),
                            ],
                          ),
                         
                                       Row(
                                         children: [
                                          Expanded(flex: 1, child: FbText(name: "MId", label: "MId"),),  fbFieldGap,
                                           Expanded(flex: 1,
                                                                       child: FbLibViewMultiDisplay(
                                                                         listsearchText: ['SiteId','SiteName','CityDscp','StateDscp'],
                                                                         name: 'SiteId',
                                                                         label: 'SiteId',
                                                                         params:  {},
                                                                         keyField: 'SiteId',
                                                                         querySql: '/view/async/VwLibSite',
                                                                       
                                                                       ),
                                                                     ),
                                                                     
                                         ],
                                       ),
                        
                          FbLibView(
                              name: 'BusnUnitEttyId',
                              label: 'Attached To',
                              params: {"MchtEttyId": mchtEttyId},
                              keyField: 'BusnUnitEttyId',
                              searchText: 'Dscp',
                              querySql: '/sp/ApiMgmtBusnUnitList/queryasync'),
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
                        Flexible(
                          child: FbDateTimePicker(
                              name: 'RgstionDate',
                              label: 'Date of Incorporation'),
                        ),
                          FbLibref(
                              name: 'SegmtType',
                              label: "Business Segment",
                              initialValue: formNewValue['SegmtType'],
                              params: const {
                                "RefType": "BUSNSEGMT",
                                "BitInd": null,
                              }),
                          FbLibref(
                              name: 'BusnType',
                              label: "Business Type",
                              initialValue: formNewValue['BusnType'],
                              params: const {
                                "RefType": "BusnType",
                                "BitInd": null,
                              }),
                          FbLibref(
                              name: 'CmpyType',
                              label: "Company Type",
                              initialValue: formNewValue['CmpyType'],
                              params: const {
                                "RefType": "CMPYTYPE",
                                "BitInd": null,
                              }),
                          FbLibref(
                              name: 'CmpySize',
                              label: "Company Size",
                              initialValue: formNewValue['CmpySize'],
                              params: const {
                                "RefType": "BUSNSIZE",
                                "BitInd": null,
                              }),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText('Contract Info'),
                          const FbText(
                              name: 'AgrmtNo', label: 'Agreement Number'),
                          const FbDateTimePicker(
                              name: 'AgrmtDate', label: 'Agreement Date'),
                          const FbDateTimePicker(
                              name: 'CmcmtDate', label: 'Commencement Date'),
                          const FbDateTimePicker(
                              name: 'IntervalRvwDate',
                              label: 'Interval Review Date'),
                          FbLibref(
                              name: 'DealerType',
                              label: 'Dealer Type',
                              initialValue: formNewValue['DealerType'],
                              params: const {
                                "RefType": "DealerType",
                                "BitInd": null
                              }),
                          const SelectableText('Tax Info'),
                          FbLibref(
                              name: 'TaxCtgry',
                              initialValue: formNewValue['TaxCtgry'],
                              label: 'Tax Category',
                              params: const {
                                "RefType": "TaxCtgry",
                                "BitInd": null
                              }),
                          const FbText(name: 'TaxNo', label: 'Tax Number'),
                          Row(
                            children: [
                              const Expanded(
                                child: FbText(
                                  name: 'LocStsDscp',
                                  label: 'Status',
                                  readOnly: true,
                                ),
                              ),formNewValue['LocEttyId'] ==null? const IconButton(
                                
                                  onPressed: null,
                                  icon:  Icon(Icons.arrow_right)): 
                              IconButton(
                                  onPressed: () async {
                                    await showAcxDialog(
                                        context,
                                        AcxStatusDialog(
                                          stsType: StatusType.locSts,
                                          ettyId: locEttyId,
                                        ));

                                    ref.invalidate(
                                        ReturndatafreezedProvider(querySql));
                                  },
                                  icon: const Icon(Icons.arrow_right))
                            ],
                          )
                        ],
                      ),
                    ),
                    sbw10,
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          AcxSaveButtonManual(onSave: () {
                              if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                            mchtLocEnrollFormKey.currentState!.save();
                            Map<String, dynamic> toPost =
                                convertFormValueToSave(
                                    mchtLocEnrollFormKey.currentState!.value,
                                    theData.columnInfo);
                            toPost.remove('LocSts');
                            toPost.remove('LocStsDscp');
                            final querySave = QueryObject(
                                querysql: '/sp/ApiMgmtLocSave/queryasync?logId=${convStrNewOrNullToNull(locEttyId) ?? 0}',
                                params: toPost,
                                showMsg: false);
                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((Returndata value) {
                              Toast.showresult(value);
                              if (isSuccess(value.message)) {
                                String theNewId =
                                    getOutputValue(value.output, '@LocEttyId')
                                        .toString();
                                singleton<AppRouter>().navigatePath(
                                    '/mcmgmt/loc/$mchtEttyId/detail/$theNewId/profile/geninfo');
                                ref.invalidate(
                                    ReturndatafreezedProvider(querySql));
                              }
                            });
                          }),
                          const AcxBackToList(
                            listUrl: '././list',
                          ),
                          AcxAuditLogReqBtn('ApiMgmtLocSave', ettyId: locEttyId.toString(),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
