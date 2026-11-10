import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_libviewmultidisp.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=659;

@RoutePage()
class MchtEnrlLocationProfileGenInfo extends StatelessWidget {
  const MchtEnrlLocationProfileGenInfo(
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
    return MchtEnrlLocGeneralInfo(
      mchtEttyId: mchtEttyId,
      locEttyId: convStrNewOrNullToNull(locEttyId),
    );
  }
}

class MchtEnrlLocGeneralInfo extends ConsumerWidget {
  const MchtEnrlLocGeneralInfo({super.key, this.mchtEttyId, this.locEttyId});

  final String? mchtEttyId;
  final String? locEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mchtLocEnrollFormKey = GlobalKey<FormBuilderState>();
    var querySql = QueryObject(
        querysql: '/sp/ApiEnrlLoc/queryasync',
        params: {"MchtEttyId": mchtEttyId, "LocEttyId": locEttyId},
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "LocNo": null,
      "LocName": null,
      "SiteId": null,
      "MId":null,
      "DealerType": null,
      "AgrmtNo": null,
      "AgrmtDate": null,
      "RgstionNo": null,
      "RgstionName": null,
      "RgstionDate": null,
      "CmcmtDate": null,
      "CmpyType": null,
      "BusnType": null,
      "SegmtType": null,
      "CmpySize": null,
      "TaxCtgry": null,
      "TaxNo": null,
      "GeoLoc": null,
      "TadCnt": null,
      "PrgCnt": null,
      "MchtEttyId": mchtEttyId,
      "BusnUnitEttyId": null,
      "LocEttyId": locEttyId,
      "LocMdfDate": null,
      "CmpyMdfDate": null,
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
            child: Row(
              children: [
                const FbHiddenDateTime(name: 'LocMdfDate'),
                const FbHiddenDateTime(name: 'CmpyMdfDate'),
                const FbHiddenText(name: 'LocEttyId'),
                const FbHiddenText(name: 'MchtEttyId'),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText('Location Info'),
                          const Row(
                            children: [  Expanded(
                              flex: 1,
                              child:  FbText(name: 'LocNo', label: 'Location No')),sbw10,
                      Expanded(
                        flex: 1,
                        child: FbText(name: 'LocName', label: 'Location Name')),
                            ],
                          ),
                         
                                       Row(
                                         children: [
                                          Expanded(flex: 1, child: FbText(name: "MId", label: "MId"),),  sbw10,
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
                            name: 'CmpySize',
                            label: "Company Size",
                            initialValue: formNewValue['CmpySize'],
                            params: const {
                              "RefType": "BUSNSIZE",
                              "BitInd": null,
                            }),
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
                          label: 'Business Type',
                          params: const {"RefType": "BusnType", "BitInd": null},
                          initialValue: formNewValue['BusnType'],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText('Contract Info'),
                        const Row(
                          children: [
                            Expanded(
                                child: FbText(
                                    name: 'AgrmtNo',
                                    label: 'Agreement Number')),
                            Flexible(
                              child: FbDateTimePicker(
                                  name: 'AgrmtDate', label: 'Agreement Date'),
                            ),
                          ],
                        ),
                        const Flexible(
                          child: FbDateTimePicker(
                              name: 'CmcmtDate', label: 'Commencement Date'),
                        ),
                        FbLibref(
                            name: 'DealerType',
                            label: 'Dealer Type',
                            initialValue: formNewValue['DealerType'],
                            params: const {
                              "RefType": "DealerType",
                              "BitInd": null
                            }),
                        sbh10,
                        const SelectableText('Tax Info'),
                        Row(
                          children: [
                            const Expanded(
                                child:
                                    FbText(name: 'TaxNo', label: 'Tax Number')),
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
                        sbh10,
                        const SelectableText('Hieracrhy Group'),
                        FbLibView(
                            name: 'BusnUnitEttyId',
                            label: 'Attached to Busines Unit',
                            params: {"MchtEttyId": mchtEttyId},
                            keyField: 'BusnUnitEttyId',
                            searchText: 'Description',
                            querySql: '/sp/ApiEnrlMchtBusnUnitList/queryasync'),
                        sbh10,
                        Wrap(runSpacing: 20, children: [
                          sbw10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SelectableText(
                                  'Location has signed up for'),
                              AcxNavButton(listOfContent: [
                                const SelectableText('Porgram'),
                                SelectableText(
                                    formNewValue['PrgCnt'].toString())
                              ], listOfButton: [
                                IconButton(
                                    onPressed: () {
                                      singleton<AppRouter>().navigatePath(
                                          '/mcenroll/loc/$mchtEttyId/detail/$locEttyId/program');
                                    },
                                    icon: const Icon(Icons.add))
                              ]),
                            ],
                          ),
                          const VerticalDivider(),
                          sbw10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SelectableText(
                                  "Location's Hierarchy consist of"),
                              AcxNavButton(listOfContent: [
                                const SelectableText('TAD'),
                                SelectableText(
                                    formNewValue['TadCnt'].toString())
                              ], listOfButton: [
                                IconButton(
                                    onPressed: () {
                                      singleton<AppRouter>().navigatePath(
                                          '/mcenroll/tad/$mchtEttyId /list');
                                    },
                                    icon: const Icon(Icons.add))
                              ]),
                            ],
                          ),
                        ])
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
                      mchtLocEnrollFormKey.currentState!.save();
                      Map<String, dynamic> toPost = convertFormValueToSave(
                          Map.from(mchtLocEnrollFormKey.currentState!.value),
                          theData.columnInfo);
                      final querySave = QueryObject(
                          querysql: '/sp/ApiEnrlLocSave/queryasync?logId=${convStrNewOrNullToNull(locEttyId) ?? 0}',
                          params: toPost,
                          showMsg: false);
                      final saveResult =
                          ref.read(ReturndatafreezedProvider(querySave).future);
                      saveResult.then((Returndata value) {
                        Toast.showresult(value);
                        if (isSuccess(value.message)) {
                          String theNewId =
                              getOutputValue(value.output, '@LocEttyId')
                                  .toString();
                          singleton<AppRouter>().navigatePath(
                              '/mcenroll/loc/$mchtEttyId/detail/$theNewId/profile/geninfo');
                          ref.invalidate(ReturndatafreezedProvider(querySql));
                        }
                      });
                    }),
                    AcxBackToList(listUrl: '/mcenroll/loc/$mchtEttyId/list'),
                    AcxAuditLogReqBtn('ApiEnrlLocSave', ettyId: locEttyId.toString(),)
                  ]),
                )
              ],
            ));
      },
    );
  }
}
