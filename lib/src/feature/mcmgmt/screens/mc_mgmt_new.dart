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

const int wid=228;

@RoutePage()
class MchtMgmtNewScreen extends BaseScreen {
  const MchtMgmtNewScreen(@PathParam('mchtEttyId') this.mchtEttyId, {super.key})
      : super(
          includeMainDrawer: true,
        );

  final String? mchtEttyId;
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(mchtEttyId);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(mchtEttyId);
  }

  @override
  Widget sideBar() {
    return provideSideBar("mchtmgmt/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("mchtmgmt/main");
  }
}

Widget buildView(String? mchtEttyId) {
  return SingleChildScrollView(
      child: SizedBox(
    height: 1024,
    child: Column(
      children: [
        Expanded(
          child: SizedBox(
              height: 2000,
              child: MchtMgmtForm(
                mchtEttyId: mchtEttyId,
              )),
        ),
      ],
    ),
  ));

  // appBar: AppBar(
  //   title: const SelectableText('Merchant Enrolment'),
  //   automaticallyImplyLeading: false, centerTitle: false,
  // ),

  // return Scaffold(
  //   body: SingleChildScrollView(
  //     child: SizedBox(
  //       height: 1024,
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: SizedBox(
  //                 height: 2000,
  //                 child: MchtMgmtForm(
  //                   mchtEttyId: mchtEttyId,
  //                 )),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  //   // appBar: AppBar(
  //   //   title: const SelectableText('Merchant Enrolment'),
  //   //   automaticallyImplyLeading: false, centerTitle: false,
  //   // ),
  // );
}

class MchtMgmtForm extends ConsumerWidget {
  const MchtMgmtForm({
    super.key,
    this.mchtEttyId,
  });

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mchtMgmtFormKey = GlobalKey<FormBuilderState>();
    var querySql = QueryObject(
        querysql: '/sp/ApiMchtMgmt/queryasync',
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
            key: mchtMgmtFormKey,
            initialValue: formNewValue,
            child: Row(
              children: [
                const FbHiddenText(name: 'MchtEttyId'),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText('Merchant Info'),
                        const Row(
                          children: [
                            Expanded(
                                child: FbText(
                                    name: 'AgrmtNo',
                                    label: 'Agreement Number')),
                            Flexible(
                                child: FbDateTimePicker(
                                    name: 'AgrmtDate', label: 'Agreement Date'))
                          ],
                        ),
                       const FbText(
                          name: 'CmpyName',
                          label: 'Merchant Name',
                        ),
                      const  FbText(
                          name: 'RgstionName',
                          label: 'Business Registration Name',
                        ),
                        const Row(
                          children: [
                            Expanded(
                                child: FbText(
                                    name: 'RgstionNo',
                                    label: 'Business Registration No')),
                            Flexible(
                                child: FbDateTimePicker(
                                    name: 'RgstionDate',
                                    label: 'Date of Incorporation'))
                          ],
                        ),
                        Row(
                          children: [
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
                        FbLibref(
                          name: 'SegmtType',
                          label: "Business Segment",
                          params: const {
                            "RefType": "BUSNSEGMT",
                            "BitInd": null
                          },
                          initialValue: formNewValue['SegmtType'],
                        ),
                        FormBuilderField(
                            name: 'CmpyType',
                            builder: (FormFieldState<dynamic> field) {
                              return AcxSearchBox(
                                  returnSelectedRef: (Libref? val) {
                                    val != null
                                        ? field.didChange(val.refCd)
                                        : field.didChange(null);
                                  },
                                  selectedRef: Libref(
                                      refCd:
                                          formNewValue['CmpyType'].toString()),
                                  inputText: 'Company Type',
                                  querysql: '/sp/GetLibRef/queryasyncnouser',
                                  params: const {
                                    "RefType": "CMPYTYPE",
                                    "BitInd": null
                                  });
                            }),
                        FormBuilderField(
                            name: 'BusnType',
                            builder: (FormFieldState<dynamic> field) {
                              return AcxSearchBox(
                                  returnSelectedRef: (Libref? val) {
                                    val != null
                                        ? field.didChange(val.refCd)
                                        : field.didChange(null);
                                  },
                                  selectedRef: Libref(
                                      refCd:
                                          formNewValue['BusnType'].toString()),
                                  inputText: 'Business Type',
                                  querysql: '/sp/GetLibRef/queryasyncnouser',
                                  params: const {
                                    "RefType": "BusnType",
                                    "BitInd": null
                                  });
                            }),
                        convStrNewOrNullToNull(mchtEttyId) == null
                            ?  FbSwitch(
                                name: 'DedupInd',
                                initialValue: formNewValue['DedupInd'],
                                label:
                                    'Create Location with same information provided',
                              )
                            : Container()
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
                        const FbHiddenText(
                            name: 'AcctMgrContactNo',),
                         //   label: 'Account Manager Contact No.'),
                         FbLibView(
                          name: 'AcctMgrId',
                          label: 'Account Manager',
                          params: const {},
                          keyField: 'AcctMgrId',
                          searchText: 'AcctMgrName',
                          querySql: '/view/async/VwAcctMgrMcht',
                          initialValue: formNewValue['AcctMgrId'],
                        ),
                        FbLibref(
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
                      mchtMgmtFormKey.currentState!.save();
                      Map<String, dynamic> toPost = convertFormValueToSave(
                          mchtMgmtFormKey.currentState!.value,
                          theData.columnInfo);
                      final querySave = QueryObject(
                          querysql: '/sp/ApiMgmtMchtProfileSave/queryasync?logId=${convStrNewOrNullToNull(mchtEttyId) ?? 0}',
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
                                    context, value.output, '@MchtEttyId'))
                                .then((val) {
                              ref.invalidate(
                                  ReturndatafreezedProvider(querySql));
                            });
                          }
                        }
                      });
                    }),
                    const AcxBackToList(listUrl: '/mcmgmt/main'),
                    AcxAuditLogReqBtn('ApiMgmtMchtProfileSave',ettyId: mchtEttyId.toString(),)
                  ]),
                )
              ],
            ));
      },
    );
  }
}
