import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchbox.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/models/libref/libref.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

const int wid=223;

@RoutePage()
class CustMgmtNewScreen extends BaseScreen {
  const CustMgmtNewScreen(@PathParam('custEttyId') this.custEttyId, {super.key})
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
    return provideSideBar("custmgmt/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custmgmt/main", id: custEttyId.toString());
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
              child: SizedBox(height: 2000, child: CustMgmtForm()),
            ),
          ],
        ),
      ),
    ),
    appBar: AppBar(
      title: const SelectableText('Customer Management'),
      automaticallyImplyLeading: false, centerTitle: false,
    ),
  );
}

class CustMgmtForm extends ConsumerWidget {
  const CustMgmtForm({
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
    var querySql = QueryObject(
        querysql: '/sp/ApiMgmtCust/queryasync',
        params: {"CustEttyId": custEttyId == 'new' ? null : custEttyId},
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "CustEttyId": null,
      "CmpyName": null,
      "RgstionDate": DateTime.now(),
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
      "SubmtDate": DateTime.now(),
      "AcctMgrName": null,
      "AcctMgrContactNo": null,
      "Email": null,
      "MobileNo1": null,
       "MobileNo2": null,
        "MobileNo3": null,
      "OfficeContactNo": null,
      "OfficeExtNo": null,
      "SrcRef": null,
      "SegmtType": null
      //"BusnType":null
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
            key: custMgmtFormKey,
            initialValue: formNewValue,
            child: Row(
              children: [
                const FbHiddenText(name: 'CustEttyId'),
                //    "Title": null,
                const FbHiddenText(name: 'Title'),
                //   "TaxCtgry": null,
                const FbHiddenText(name: 'TaxCtgry'),
                const FbHiddenText(name: 'TaxNo'),
                const FbHiddenText(name: 'AcctMgrContactNo'),
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
                          name: 'CmpyName',
                           label: 'Company Name',  
                        ),
                       const FbText(
                          name: 'RgstionName',
                           label: 'Business Registration Name',
                        ),
                       const FbText(
                          name: 'RgstionNo',
                           label: 'Business Registration No',
                        ),
                        const FbLibref(
                            name: 'SegmtType',
                            label: "Business Segment",
                            params: {"RefType": "BUSNSEGMT", "BitInd": null}),
                        //    const  FbHiddenText(name: 'BusnType'),
                        const SelectableText('Person In Charge'),
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
                        FormBuilderField(
                            name: 'Dsgntion',
                            builder: (FormFieldState<dynamic> field) {
                              return AcxSearchBox(
                                  returnSelectedRef: (Libref? val) {
                                    val != null
                                        ? field.didChange(val.refCd)
                                        : field.didChange(null);
                                  },
                                  selectedRef: Libref(
                                      refCd:
                                          formNewValue['Dsgntion'].toString()),
                                  inputText: 'Designation',
                                  querysql: '/sp/GetLibRef/queryasyncnouser',
                                  params: const {
                                    "RefType": "Dsgntion",
                                    "BitInd": null
                                  });
                            }),
                       const FbText(
                          name: 'MobileNo1',
                          label: 'Mobile No.1'
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
                          name: 'Email',
                          label: 'Email Address',
                        ),
                       const Row(
                          children: [
                             Expanded(
                              child: FbText(
                                name: 'OfficeContactNo',
                                label: 'Phone No.',
                              ),
                            ),
                             Expanded(
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
                        FormBuilderField(
                            name: 'ApplSrc',
                            builder: (FormFieldState<dynamic> field) {
                              return AcxSearchBox(
                                  returnSelectedRef: (Libref? val) {
                                    val != null
                                        ? field.didChange(val.refCd)
                                        : field.didChange(null);
                                  },
                                  selectedRef: Libref(
                                      refCd:
                                          formNewValue['ApplSrc'].toString()),
                                  inputText: 'Application Source',
                                  querysql: '/sp/GetLibRef/queryasyncnouser',
                                  params: const {
                                    "RefType": "APPLSRC",
                                    "BitInd": null
                                  });
                            }),

                        const Flexible(
                            child: FbDateTimePicker(
                                name: 'SubmtDate', label: 'Submission Date')),
                        const Flexible(
                            child: FbDateTimePicker(
                                name: 'RgstionDate',
                                label: 'Registration Date')),
                        FbAutoComplete(
                            initialValue: formNewValue['AcctMgrName'],
                            name: 'AcctMgrName',
                            label: 'Account Manager',
                            keyField: 'AcctMgrName',
                            searchText: 'AccMgrName',
                            query: QueryObject(
                                querysql: '/view/async/VwAcctMgrCust',
                                params: const {},
                                showMsg: false)),
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
                      Map<String, dynamic> toPost = convertFormValueToSave(
                          custMgmtFormKey.currentState!.value,
                          theData.columnInfo);
                      final querySave = QueryObject(
                          querysql: '/sp/ApiMgmtCustSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
                          params: toPost,
                          showMsg: false);
                      final saveResult =
                          ref.read(ReturndatafreezedProvider(querySave).future);
                      saveResult.then((Returndata value) {
                        Toast.showresult(value);
                        if (isSuccess(value.message)) {
                          if (context.mounted) {
                            singleton<AppRouter>()
                                .navigatePath(getAfterSavePath(
                                    context, value.output, '@CustEttyId'))
                                .then((val) {
                              ref.invalidate(
                                  ReturndatafreezedProvider(querySql));
                            });
                          }
                        }
                      });
                    }),
                    const AcxBackToList(listUrl: '/custmgmt/main'),
                    AcxAuditLogReqBtn('ApiMgmtCustSave',ettyId: custEttyId.toString(),)
                  ]),
                )
              ],
            ));
      },
    );
  }
}
