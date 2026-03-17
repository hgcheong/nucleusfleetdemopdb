import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/components/shared/acx_status_dialog.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/helpers.dart';

const int wid=561;

@RoutePage()
class CustMgmtCmpyProfileGenInfo extends ConsumerWidget {
  const CustMgmtCmpyProfileGenInfo({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;

  Widget profileForm(BuildContext context, WidgetRef ref) {
    final custMgmtCmpyFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formNewValue = {
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
        querysql: '/sp/ApiMgmtCmpy/queryasync',
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
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: custMgmtCmpyFormKey,
            initialValue: formNewValue,
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
                          const SelectableText('Company Info', style: TextStyle(fontSize: defaultDropDownSize),),
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
                             label: 'Business Registration Name'
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
                          FbLibView(
                            name: 'CmpyType',
                            label: 'Company Type',
                            params: const {
                              "RefType": "CMPYTYPE",
                              "BitInd": null
                            },
                            keyField: 'RefCd',
                            searchText: 'Dscp',
                            querySql: '/sp/GetLibRef/queryasyncnouser',
                            initialValue: formNewValue['CmpyType'].toString(),
                          ),
                          FbLibref(
                            name: 'CmpySize',
                            label: "Company Size",
                            initialValue: formNewValue['CmpySize'].toString(),
                            params: const {
                              "RefType": "BUSNSIZE",
                              "BitInd": null
                            },
                          ),
                          FbLibView(
                            name: 'BusnType',
                            label: 'Business Type',
                            params: const {
                              "RefType": "BusnType",
                              "BitInd": null
                            },
                            keyField: 'RefCd',
                            searchText: 'Dscp',
                            querySql: '/sp/GetLibRef/queryasyncnouser',
                            initialValue: formNewValue['BusnType'].toString(),
                          ),
                          FbLibView(
                            name: 'SegmtType',
                            label: 'Nature of Business',
                            params: const {
                              "RefType": "BusnSegmt",
                              "BitInd": null
                            },
                            keyField: 'RefCd',
                            searchText: 'Dscp',
                            querySql: '/sp/GetLibRef/queryasyncnouser',
                            initialValue: formNewValue['BusnSegmt'].toString(),
                          ),
                          FbLibView(
                            name: 'Region',
                            label: 'Region',
                            params: const {"RefType": "Region", "BitInd": null},
                            keyField: 'RefCd',
                            searchText: 'Dscp',
                            querySql: '/sp/GetLibRef/queryasyncnouser',
                            initialValue: formNewValue['Region'].toString(),
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
                          const SelectableText('Other Info', style: TextStyle(fontSize: defaultDropDownSize),),
              
                          const FbText(
                              name: 'RewardNo',
                              label: 'Virtual Loyalty Number'),
                          const FbText(
                              name: 'SrcRef', label: 'Source Reference'),
                          const FbText(name: 'TaxNo', label: 'Tax Number'),
                          FbLibref(
                              name: 'TaxCtgry',
                              initialValue: formNewValue['TaxCtgry'],
                              label: 'Tax Category',
                              params: const {
                                "RefType": "TaxCtgry",
                                "BitInd": null
                              }),
                          const SelectableText(
                              "Company's Hiearchy consist of...", style: TextStyle(fontSize: defaultDropDownSize),),
                          sbh10,
                          Wrap(runSpacing: 10, children: [
                            AcxNavButton(listOfContent: [
                              const SelectableText('Cost Center'),
                              SelectableText(
                                  formNewValue['CostCtrCnt'].toString())
                            ], listOfButton: [
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(
                                            menuSideTabSelectProvider.notifier)
                                        .state = S.current.tabCostCenter;
                                    singleton<AppRouter>().navigatePath(
                                        '/custmgmt/costcen/$custEttyId/list');
                                  },
                                  icon: const Icon(Icons.add))
                            ]),
                            sbw10,
                            AcxNavButton(listOfContent: [
                              const SelectableText('Member'),
                              SelectableText(formNewValue['MbrCnt'].toString())
                            ], listOfButton: [
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(
                                            menuSideTabSelectProvider.notifier)
                                        .state = S.current.tabMember;
                                    singleton<AppRouter>().navigatePath(
                                        '/custmgmt/member/$custEttyId/list');
                                  },
                                  icon: const Icon(Icons.add))
                            ]),
                            sbw10,
                            AcxNavButton(listOfContent: [
                              const SelectableText('Media'),
                              SelectableText(
                                  formNewValue['MediaCnt'].toString())
                            ], listOfButton: [
                              IconButton(
                                  onPressed: () {
                                    ref
                                        .read(
                                            menuSideTabSelectProvider.notifier)
                                        .state = S.current.tabMedia;
                                    singleton<AppRouter>().navigatePath(
                                        '/custmgmt/media/$custEttyId/list');
                                  },
                                  icon: const Icon(Icons.add))
                            ]),
                          ]),
                          Row(
                            children: [
                              const Expanded(
                                child: FbText(
                                  name: 'CmpyStsDscp',
                                  label: 'Status',
                                  readOnly: true,
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await showAcxDialog(
                                        context,
                                        AcxStatusDialog(
                                          stsType: StatusType.cmpySts,
                                          ettyId: cmpyEttyId,
                                        ));

                                    ref.invalidate(
                                        ReturndatafreezedProvider(querySql));
                                  },
                                  icon: const Icon(Icons.arrow_right)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      AcxSaveButtonManual(
                        // saveUrl: '/sp/ApiMgmtCmpySave/queryasync',
                        //  saveForm: custMgmtCmpyFormKey,
                        // dateFieldToConvert: const ['RgstionDate', 'SubmtDate'],
                        onSave: () {
                            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          custMgmtCmpyFormKey.currentState!.save();

                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(custMgmtCmpyFormKey.currentState!.value),
                              theData.columnInfo);
                          toPost.remove('CmpyStsDscp');
                          final querySave = QueryObject(
                              querysql: '/sp/ApiMgmtCmpySave/queryasync?logId=${convStrNewOrNullToNull(cmpyEttyId) ?? 0}',
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
                                '/custmgmt/cmpy/$custEttyId/detail/$outCmpyId/profile/geninfo',
                              )
                                  .then((val) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(querySql));
                                 
                              });
                            }
                          });
                        },
                      ),
                      sbh10,
                      AcxBackToList(listUrl: '/custmgmt/cmpy/$custEttyId/list'),
                      sbh10,
                      AcxAuditLogReqBtn('ApiMgmtCmpySave',ettyId: cmpyEttyId.toString(),)
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
