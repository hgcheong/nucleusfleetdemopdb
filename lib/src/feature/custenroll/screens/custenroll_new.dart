import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

import 'package:nucleusv2/src/core/app_router.dart';

const int wid=221;

@RoutePage()
class CustEnrollNewScreen extends BaseScreen {
  const CustEnrollNewScreen(@PathParam('custEttyId') this.custEttyId,
      {super.key})
      : super(
          includeMainDrawer: true,
        );

  final String? custEttyId;
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }
  
  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }

  @override
  Widget sideBar() {
    return provideSideBar("custenroll/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custenroll/main");
  }
}

Widget buildView() {
  return Scaffold(
    body: const SingleChildScrollView(
      child: SizedBox(
        height: 1024,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(height: 2000, child: CustEnrollForm()),
            ),
          ],
        ),
      ),
    ),
    appBar: AppBar(
      title: const SelectableText('Customer Enrolment'),
      automaticallyImplyLeading: false, centerTitle: false,
    ),
  );
}

class CustEnrollForm extends ConsumerWidget {
  const CustEnrollForm({
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
    var querySql = QueryObject(
      //  querysql: '/sp/qkeyrd?combo=1',
         querysql: '/sp/ApiEnrlCust/queryasync',
           params: {"CustEttyId": custEttyId == 'new' ? null : custEttyId},
         

        // params: {
        //   "ApiEnrlCust":{"CustEttyId": custEttyId == 'new' ? null : custEttyId},
        //   "ApiEnrlCustSave":{}
        // },
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "CustEttyId": null,
      "CmpyName": null,
      "RgstionDate": null,
      "RgstionNo": null,
      "RgstionName": null,
      "FirstName": null,
      "LastName": null,
      "FullName":null,
      "Dsgntion": null,
      "Title": null,
      "ApplRef": null,
      "ApplSrc": null,
      "TaxCtgry": null,
      "TaxNo": null,
      "SubmtDate": null,
      "AcctMgrName": null,
      "AcctMgrContactNo": null,
      "WorkEmail": null,
      "PersonalEmail": null,
      "MobileNo1": null,
        "MobileNo2": null,
          "MobileNo3": null,
      "OfficeContactNo": null,
      "OfficeExtNo": null,
      "SrcRef": null,
      "SegmtType": null,
      "CustMdfDate": null,
      "CmpyMdfDate": null,
      "PersonMdfDate": null
      //"BusnType":null
    };
    // final reqValue = ref.watch(ReturndatafreezedProvider(QueryObject(
    //     querysql: '/sp/ApiLogReqSpList/queryasync',
    //     params: {"SpName": "ApiEnrlCust"},
    //     showMsg: false)));
    
    // reqValue.when(data: (theData), error: ()=>, loading: loading)

    final formData = ref.watch(ReturndatafreezedProvider(querySql));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: custEnrollFormKey,
            initialValue: formNewValue,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                const FbHiddenDateTime(name: 'CustMdfDate'),
                const FbHiddenDateTime(name: 'CmpyMdfDate'),
                const FbHiddenDateTime(name: 'PersonMdfDate'),
                const FbHiddenText(name: 'CustEttyId'),
                const FbHiddenText(name: 'TaxCtgry'),
                const FbHiddenText(name: 'TaxNo'),
                // const FbHiddenText(name: 'AcctMgrContactNo'),
                 const FbHiddenText(name: 'AcctMgrId'),
                const FbHiddenText(name: 'SrcRef'),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText('Customer Info'),
                        const FbText(
                          isReq: true,
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
                         Flexible(
                            child: FbDateTimePicker(
                              labelStyle: getFormTextStyle('RgstionDate', theData.columnInfo),
                                name: 'RgstionDate',
                                label: 'Registration Date')),
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
                      //     label: 'FirstName',
                        ),
                       const FbHiddenText(
                          name: 'LastName',
                      //     label: 'LastName',
                        ),
                        FbLibView(
                          name: 'Dsgntion',
                          label: 'Designation',
                                labelStyle: getFormTextStyle('Dsgntion', theData.columnInfo),
                          params: const {"RefType": "Dsgntion", "BitInd": null},
                          keyField: 'RefCd',
                          searchText: 'Dscp',
                          querySql: '/sp/GetLibRef/queryasyncnouser',
                          initialValue: formNewValue['Dsgntion'],
                        ),
                         const FbText(
                          name: 'MobileNo1',
                           label: 'Mobile No.1', 
                        ),
                           const FbText(
                          name: 'MobileNo2',
                           label: 'Mobile No.2', 
                        ),
                           const FbText(
                          name: 'MobileNo3',
                           label: 'Mobile No.3', 
                        ),
                       const FbText(
                          name: 'WorkEmail',
                           label: 'Work Email Address',
                        ),
                           const FbText(
                          name: 'PsnlEmail',
                           label: 'Personal Email Address',
                        ),
                        const Row(
                          children: [
                           Expanded(
                              child: FbText(
                                name: 'OfficeContactNo',
                                  label: 'Work Phone No.',
                              ),
                            ),
                            fbFieldGap, Expanded(
                              child: FbText(
                                name: 'OfficeExtNo',
                                label: 'Extension',
                              ),
                            ),
                          ],
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
                        FbLibView(
                          name: 'ApplSrc',
                          label: 'Application Source',
                          labelStyle: getFormTextStyle('ApplSrc', theData.columnInfo),
                          params: const {"RefType": "APPLSRC", "BitInd": null},
                          keyField: 'RefCd',
                          searchText: 'Dscp',
                          querySql: '/sp/GetLibRef/queryasyncnouser',
                          initialValue: formNewValue['ApplSrc'],
                        ),
                         Flexible(
                            child: FbDateTimePicker(
                              labelStyle: getFormTextStyle('SubmtDate', theData.columnInfo),
                                name: 'SubmtDate', label: 'Submission Date')),
                        // FbAutoComplete(
                        //     initialValue: formNewValue['AcctMgrName'],
                        //     name: 'AcctMgrName',
                        //     label: 'Account Manager',
                        //     lableStyle: getFormTextStyle('AcctMgrName', theData.columnInfo),
                        //     keyField: 'AcctMgrName',
                        //     searchText: 'AccMgrName',
                        //     query: QueryObject(
                        //         querysql: '/view/async/VwAcctMgrCust',
                        //         params: const {},
                        //         showMsg: false)),
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
                      // bool isValid =  custEnrollFormKey.currentState!.validate();
                      // if (!isValid) {
                       
                      //   return;
                      // }
                      custEnrollFormKey.currentState!.save();
                     
                      Map<String, dynamic> toPost = convertFormValueToSave(
                          Map.from(custEnrollFormKey.currentState!.value),
                          theData.columnInfo);
                      final querySave = QueryObject(
                          querysql: '/sp/ApiEnrlCustSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
                          params: toPost,
                          showMsg: false);
                      final saveResult =
                          ref.read(ReturndatafreezedProvider(querySave).future);
                      saveResult.then((Returndata value) {
                        Toast.showresult(value);
                        if (isSuccess(value.message)) {
                          if (context.mounted) {
var custEttyId = getOutputValue(value.output, '@CustEttyId');
                                  getTitle(
                  ref,
                  {
                    "CustEttyId": custEttyId
                  },
                  AppBarTitleType.enroll)
              .then((value) {
            singleton<AppRouter>().navigatePath(
                '/custenroll/cust/$custEttyId');
            ref.read(menuSideTabSelectProvider.notifier).state = "Customer";
            ref.read(appBarTitleProvider.notifier).state = value.toString();
          });
                            // singleton<AppRouter>()
                            //     .navigatePath(getAfterSavePath(
                            //         context, value.output, '@CustEttyId'))
                            //     .then((val) {
                            //   ref.invalidate(
                            //       ReturndatafreezedProvider(querySql));
                            // });
                          }
                        }
                      });
                    }),
                    const AcxBackToList(listUrl: '/custenroll/main'),
                    AcxAuditLogReqBtn('ApiEnrlCustSave',ettyId: custEttyId.toString(),)
                  ]),
                )
              ],
            ));
      },
    );
  }
}
