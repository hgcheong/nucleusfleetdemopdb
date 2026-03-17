import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=488;

@RoutePage()
class CustEnrollProfileGenInfo extends StatelessWidget {
  const CustEnrollProfileGenInfo({
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
    final custEnrollFormKey = GlobalKey<FormBuilderState>();
    final querySql = QueryObject(
      //  querysql: '/sp/qkeyrd?combo=1',
         querysql: '/sp/ApiEnrlCustProfile/queryasync',
        //params: {"ApiEnrlCustProfile":{"CustEttyId": custEttyId},"ApiEnrlCustProfileSave":{}} ,
           params: {"CustEttyId": custEttyId} ,
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "CmpyName": null,
      "RgstionName": null,
      "RgstionNo": null,
      "RgstionDate": null,
      "SubmtDate": null,
      "FirstName": null,
      "LastName": null,
      "FullName":null,
      "Dsgntion": null,
      "ApplRef": null,
      "ApplSrc": null,
      "TaxCtgry": null,
      "TaxNo": null,
      "CmpyType": null,
      "CmpySize": null,
      "BusnType": null,
      "SegmtType": null,
      "AcctMgrName": null,
      "SrcRef": null,
      "CustSts": null,
      "AppvDate": null,
      "AcctMgrId": null,
      "CustEttyId": null,
      "CmpyCnt": null,
      "CostCtrCnt": null,
      "MbrCnt": null,
      "MediaCnt": null,
      "CustMdfDate": null,
      "CmpyMdfDate": null,
      "ContMdfDate": null,
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
                key: custEnrollFormKey,
                initialValue: formNewValue,
                child: Row(
                  children: [
                    const FbHiddenText( name: 'CustEttyId'),
                    const FbHiddenText( name: 'TaxCtgry'),
                    const FbHiddenText( name: 'TaxNo'),
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
                            const SelectableText('Customer Info', style: TextStyle(fontSize: defaultDropDownSize),),
                            FbText(
                              name: 'CmpyName',
                              label: '*Customer Name',
                              isReq: true           
                            ),
                            FbText(
                              name: 'RgstionName',
                              label: 'Business Registration Name',
                              isReq: true,  
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
                            FbLibView(
                                querySql: librefquerysql,
                                keyField: 'RefCd',
                                searchText: 'Dscp',
                                name: 'SegmtType',
                                label: "Business Segment",
                                initialValue:
                                    formNewValue['SegmtType'].toString(),
                                params: const {
                                  "RefType": "BUSNSEGMT",
                                  "BitInd": null
                                }),

                            //    FbLibref(name: 'SegmtType', label: "Business Segment", initialValue: formNewValue['SegmtType'].toString(), params: const {"RefType": "BUSNSEGMT", "BitInd": null}),
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
                                label: "*Company Type",
                                initialValue:
                                    formNewValue['CmpyType'].toString(),
                                params: const {
                                  "RefType": "CMPYTYPE",
                                  "BitInd": null
                                }),
                            const SelectableText('Person In Charge', style: TextStyle(fontSize: defaultDropDownSize),),
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
                              label: 'Designation',
                              params: const {
                                "RefType": "Dsgntion",
                                "BitInd": null
                              },
                              initialValue: formNewValue['Dsgntion'].toString(),
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
                            const SelectableText('Application Info', style: TextStyle(fontSize: defaultDropDownSize),),
                            const FbText(
                              name: 'ApplRef',
                                label: 'Application Reference',
                            ),
                            const FbLibView(
                              name: 'ApplSrc',
                              label: 'Application Source',
                              params: {"RefType": "APPLSRC", "BitInd": null},
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/sp/GetLibRef/queryasyncnouser',
                            ),

                            const Flexible(
                              child: FbDateTimePicker(
                                  name: 'SubmtDate', label: 'Submission Date'),
                            ),

                            // ),
                            // FbAutoComplete(
                            //     initialValue: formNewValue['AcctMgrName'],
                            //     name: 'AcctMgrName',
                            //     label: 'Account Manager',
                            //     keyField: 'AcctMgrName',
                            //     searchText: 'AccMgrName',
                            //     query: QueryObject(
                            //         querysql: '/view/async/VwAcctMgrCust',
                            //         params: const {},
                            //         showMsg: false)),
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
                                          '/custenroll/costcen/$custEttyId/list');
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
                                          '/custenroll/member/$custEttyId/list');
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
                        AcxSaveButtonManual(onSave: () {
                                 if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          custEnrollFormKey.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              Map.from(custEnrollFormKey.currentState!.value),
                              theData.columnInfo);
                          // toPost['AcctMgrId'] = null;
                          final querySave = QueryObject(
                              querysql: '/sp/ApiEnrlCustProfileSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
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
                        sbh10,
                        AcxAuditLogReqBtn('ApiEnrlCustProfileSave',ettyId: custEttyId.toString(),)
                        //  const AcxBackToList(listUrl: '/custenroll/main' )
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
