import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/shared/acx_status_dialog.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';

const int wid=601;

@RoutePage()
class CustMgmtProfileGenInfo extends StatelessWidget {
  const CustMgmtProfileGenInfo({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  });

  final String? custEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return CustGeneralInfo(
      custEttyId: custEttyId,
    );
  }
}

class CustGeneralInfo extends ConsumerWidget {
  const CustGeneralInfo({
    super.key,
    this.custEttyId,
  });

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final custMgmtFormKey = GlobalKey<FormBuilderState>();
    final querySql = QueryObject(
        querysql: '/sp/ApiMgmtCustProfile/queryasync',
        params: {"CustEttyId": custEttyId},
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "AcctMgrId": null,
      "AcctMgrName": null,
      "ApplRef": null,
      "ApplSrc": null,
      "BusnType": null,
      "CmpyMdfDate": null,
      "CmpyName": null,
      "CmpySize": null,
      "CmpyType": null,
      "ContMdfDate": null,
      "CustEttyId": custMgmtFormKey,
      "CustMdfDate": null,
      "Dsgntion": null,
      "FirstName": null,
      "LastName": null,
      "FullName":null,
      "RgstionDate": null,
      "RgstionName": null,
      "RgstionNo": null,
      "SegmtType": null,
      "SrcRef": null,
      "SubmtDate": null,
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
        return SingleChildScrollView(
          child: SizedBox(
            height: 1280,
            child: FormBuilder(
                key: custMgmtFormKey,
                initialValue: formNewValue,
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    const FbHiddenText( name: 'CustEttyId'),
                    const FbHiddenText( name: 'TaxCtgry'),
                    const FbHiddenText( name: 'TaxNo'),
                    // const FbHiddenText(
                    //     name: 'AcctMgrContactNo'),
                    const FbHiddenText(name: 'AcctMgrId'),
                    const FbHiddenDateTime(name: 'CustMdfDate'),
                    const FbHiddenDateTime(name: 'CmpyMdfDate'),
                    const FbHiddenDateTime(name: 'ContMdfDate'),
                    const FbHiddenText( name: 'SrcRef'),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SelectableText('Customer Info'),
                            const FbText(
                              label: 'Customer Number',
                              name: 'CustNo',
                              readOnly: true,
                            ),
                            //    FbText(
                            //   name: 'CustNo',
                            //   decoration: const InputDecoration(
                            //     labelText: 'Customer Number',
                            //     floatingLabelBehavior: FloatingLabelBehavior.always,
                            //   ),
                            // ),
                           const FbText(
                              name: 'CmpyName',
                              label: 'Customer Name',
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
                            const Flexible(
                              child: FbDateTimePicker(
                                  name: 'RgstionDate',
                                  label: 'Registration Date'),
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
                            FbLibref(
                                name: 'SegmtType',
                                label: "Business Segment",
                                initialValue:
                                    formNewValue['SegmtType'].toString(),
                                params: const {
                                  "RefType": "BUSNSEGMT",
                                  "BitInd": null
                                }),
                            FbLibref(
                                name: 'BusnType',
                                label: "Business Type",
                                initialValue:
                                    formNewValue['BusnType'].toString(),
                                params: const {
                                  "RefType": "BUSNTYPE",
                                  "BitInd": null
                                }),
                            //    const  FbHiddenText(name: 'BusnType'),
                            FbLibref(
                                name: 'CmpyType',
                                label: "Company Type",
                                initialValue:
                                    formNewValue['CmpyType'].toString(),
                                params: const {
                                  "RefType": "CMPYTYPE",
                                  "BitInd": null
                                }),
                            const SelectableText('Person In Charge'),
                                 FbLibView(
                                                           name: 'Title',
                                                           label: 'Title',
                                                           labelStyle: getFormTextStyle('Title', theData.columnInfo),
                                                           params: const {"RefType": "Title", "BitInd": null},
                                                           keyField: 'RefCd',
                                                           searchText: 'Dscp',
                                                           querySql: '/sp/GetLibRef/queryasyncnouser',
                                                           initialValue: formNewValue['Title'],
                                                         ),
                            const FbText(
                              name: 'FullName',
                               label: 'Name',
                            ),
                               const FbHiddenText(
                              name: 'FirstName',
                        
                            ),


                            const FbHiddenText(
                              name: 'LastName',
                            ),
                            FbLibref(
                              name: 'Dsgntion',
                              label: "Designation",
                              initialValue: formNewValue['Dsgntion'].toString(),
                              params: const {
                                "RefType": "Dsgntion",
                                "BitInd": null
                              },
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
                            const SelectableText('Application Info'),
                            const FbText(
                              name: 'ApplRef',
                              label: 'Application Reference',
                            ),
                            FbLibref(
                                name: 'ApplSrc',
                                label: "Application Source",
                                initialValue:
                                    formNewValue['ApplSrc'].toString(),
                                params: const {
                                  "RefType": "APPLSRC",
                                  "BitInd": null
                                }),
                            const Flexible(
                              child: FbDateTimePicker(
                                  name: 'SubmtDate', label: 'Submission Date'),
                            ),
                            //AppvDate
                            const Flexible(
                              child: FbDateTimePicker(
                                  name: 'AppvDate', label: 'Approval Date'),
                            ),
                            sbh20,
                            Wrap(runSpacing: 10, children: [
                              AcxNavButton(listOfContent: [
                                const SelectableText('Cost Center'),
                                SelectableText(
                                    formNewValue['CostCtrCnt'].toString())
                              ], listOfButton: [
                                IconButton(
                                    onPressed: () {
                                      singleton<AppRouter>().navigatePath(
                                          '/custmgmt/costcen/$custEttyId/list');
                                    },
                                    icon: const Icon(Icons.add))
                              ]),
                              sbw10,
                              AcxNavButton(listOfContent: [
                                const SelectableText('Member'),
                                SelectableText(
                                    formNewValue['MbrCnt'].toString())
                              ], listOfButton: [
                                IconButton(
                                    onPressed: () {
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
                                      singleton<AppRouter>().navigatePath(
                                          '/custmgmt/media/$custEttyId/list');
                                    },
                                    icon: const Icon(Icons.add))
                              ]),
                            ]),

                            Row(
                              children: [
                                // Expanded(child: FbText(name: 'SiteId', label: 'Site Id')),
                                const Expanded(
                                  child: FbText(
                                    name: 'CustStsDscp',
                                    label: 'Status',
                                    readOnly: true,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await showAcxDialog(
                                          context,
                                          AcxStatusDialog(
                                            stsType: StatusType.custSts,
                                            ettyId: custEttyId,
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
                        AcxSaveButtonManual(onSave: () {
                            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          custMgmtFormKey.currentState!.save();
                          Map<String, dynamic> toPost = Map.from(
                              convertFormValueToSave(
                                  custMgmtFormKey.currentState!.value,
                                  theData.columnInfo));
                          toPost.remove('CrtionDate');
                          toPost.remove('CustNo');
                          toPost.remove('AppvDate');
                          toPost.remove('CustStsDscp');
                          final querySave = QueryObject(
                              querysql: '/sp/ApiMgmtCustProfileSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((Returndata value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              ref.invalidate(
                                  ReturndatafreezedProvider(querySql));
                            }
                          });
                        }),
                        AcxBackToList(
                            listUrl:
                                '/custmgmt/cust/$custEttyId/quickinfo/overview'),
                                AcxAuditLogReqBtn('ApiMgmtCustProfileSave',ettyId: custEttyId.toString(),)
                      ]),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
