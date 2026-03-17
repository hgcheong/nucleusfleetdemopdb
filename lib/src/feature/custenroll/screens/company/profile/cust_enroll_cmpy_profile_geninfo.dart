import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';

const int wid=453;

@RoutePage()
class CustEnrollCmpyProfileGenInfo extends ConsumerWidget {
  const CustEnrollCmpyProfileGenInfo({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;

  Widget profileForm(BuildContext context, WidgetRef ref) {
    getTitle(
            ref,
            {
              "CmpyEttyId": cmpyEttyId,
            },
            AppBarTitleType.enroll)
        .then((value) {
      if(value!.startsWith("  ")){

            }else{  
      ref.read(appBarTitleProvider.notifier).state = value.toString();
            }
    });
    final custEnrollCmpyFormKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "CmpyEttyId": convStrNewOrNullToNull(cmpyEttyId),
      "CustEttyId": custEttyId,
      "MdfDate": null,
      "CmpyName": null,
      "RgstionName": null,
      "RgstionNo": null,
      "RgstionDate": null,
      "CmpyType": null,
      "BusnType": null,
      "CmpySize": null,
      "SegmtType": null,
      "BranchCd": null,
      "SrcRef": null,
      "TaxCtgry": null,
      "TaxNo": null,
      "CmpySts": null,
      "Region": null,
      "QuotaFlag": null,
      "ColltorId": null,
      "OldRgstionNo": null,
      "CostCtrCnt": 0,
      "MbrCnt": 0,
      "MediaCnt": 0
    };

    //remove CostCtrCnt, MbrCnt, MediaCnt
    final querySql = QueryObject(
        querysql: '/sp/ApiEnrlCmpy/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "CmpyEttyId": convStrNewOrNullToNull(cmpyEttyId),
        },
        showMsg: false);
    final formData = ref.watch(ReturndatafreezedProvider(querySql));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);

        }
        return FormBuilder(
            key: custEnrollCmpyFormKey,
            initialValue: formValue,
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //   "TaxCtgry": null,

                  const FbHiddenText( name: 'BranchCd'),
                  const FbHiddenText( name: 'CmpySts'),
                  const FbHiddenText( name: 'MdfDate'),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText('Company Info'),
                          const FbHiddenText(
                              name: 'CmpyEttyId'),
                          const FbHiddenText(
                              name: 'CustEttyId'),
                         const FbText(
                            name: 'CmpyName',
                              label: 'Company Name',
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
                          const Row(
                            children: [
                              Flexible(
                                child: FbDateTimePicker(
                                  label: 'Registration Date',
                                  name: 'RgstionDate',
                                ),
                              ),
                            ],
                          ),
                          FbLibref(
                            name: 'CmpyType',
                            label: 'Company Type',
                            initialValue: formValue['CmpyType'].toString(),
                            params: const {
                              "RefType": "CMPYTYPE",
                              "BitInd": null
                            },
                          ),
                          FbLibref(
                            name: 'CmpySize',
                            label: "Company Size",
                            initialValue: formValue['CmpySize'].toString(),
                            params: const {
                              "RefType": "BUSNSIZE",
                              "BitInd": null
                            },
                          ),
                          FbLibref(
                            name: 'BusnType',
                            label: 'Business Type',
                            initialValue: formValue['BusnType'].toString(),
                            params: const {
                              "RefType": "BusnType",
                              "BitInd": null
                            },
                          ),
                          FbLibref(
                            name: 'SegmtType',
                            label: 'Nature of Business',
                            initialValue: formValue['SegmtType'].toString(),
                            params: const {
                              "RefType": "BusnSegmt",
                              "BitInd": null
                            },
                          ),
                          FbLibref(
                            name: 'Region',
                            label: 'Region',
                            initialValue: formValue['Region'].toString(),
                            params: const {"RefType": "Region", "BitInd": null},
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
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText('Other Info'),
                          const FbText(
                              name: 'RewardNo',
                              label: 'Virtual Loyalty Number'),
                          const FbText(
                              name: 'SrcRef', label: 'Source Reference'),
                          const FbText(name: 'TaxNo', label: 'Tax Number'),
                          FbLibref(
                              name: 'TaxCtgry',
                              initialValue: formValue['TaxCtgry'],
                              label: 'Tax Category',
                              params: const {
                                "RefType": "TaxCtgry",
                                "BitInd": null
                              }),
                          const SelectableText(
                              "Company's Hiearchy consist of..."),
                          sbh10,
                          Wrap(runSpacing: 10, children: [
                            AcxNavButton(listOfContent: [
                              const SelectableText('Cost Center'),
                              SelectableText(formValue['CostCtrCnt'])
                            ], listOfButton: [
                              IconButton(
                                  onPressed: () {
                                    singleton<AppRouter>().navigatePath(
                                        '/custenroll/costcen/$custEttyId/list');
                                  },
                                  icon: const Icon(Icons.add))
                            ]),
                            sbw10,
                            AcxNavButton(listOfContent: [
                              const SelectableText('Member'),
                              SelectableText(formValue['MbrCnt'])
                            ], listOfButton: [
                              IconButton(
                                  onPressed: () {
                                    singleton<AppRouter>().navigatePath(
                                        '/custenroll/member/$custEttyId/list');
                                  },
                                  icon: const Icon(Icons.add))
                            ]),
                            sbw10,
                            AcxNavButton(listOfContent: [
                              const SelectableText('Media'),
                              SelectableText(formValue['MediaCnt'])
                            ], listOfButton: [
                              IconButton(
                                  onPressed: () {
                                    singleton<AppRouter>().navigatePath(
                                        '/custenroll/media/$custEttyId/list');
                                  },
                                  icon: const Icon(Icons.add))
                            ]),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      AcxSaveButtonManual(
                        onSave: () {
                                 if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          custEnrollCmpyFormKey.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(
                                  custEnrollCmpyFormKey.currentState!.value),
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiEnrlCmpySave/queryasync?logId=${convStrNewOrNullToNull(cmpyEttyId) ?? 0}',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((Returndata value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              final outCmpyId =
                                  getOutputValue(value.output, '@CmpyEttyId');
                              singleton<AppRouter>()
                                  .navigatePath(
                                '/custenroll/cmpy/$custEttyId/detail/$outCmpyId/profile/geninfo',
                              )
                                  .then((va0) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(querySql));
                              });
                            }
                          });
                        },
                      ),
                      sbh10,
                      AcxBackToList(
                          listUrl: '/custenroll/cmpy/$custEttyId/list'),
                          sbh10,
                      AcxAuditLogReqBtn('ApiEnrlCmpySave', ettyId: cmpyEttyId.toString(),) 
                    ]),
                  )
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return profileForm(context, ref);
  }
}
