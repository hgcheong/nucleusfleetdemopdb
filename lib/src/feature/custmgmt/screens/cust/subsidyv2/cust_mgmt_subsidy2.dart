import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/strings.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/helpers.dart';


const int wid=461;

@RoutePage()
class CustMgmtSubsidy2 extends BaseScreen {
  const CustMgmtSubsidy2(
      {super.key,
      @PathParam.inherit('chargeType') this.chargeType,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('cbId') this.cbId,
      @PathParam('cbPrgEttyId') this.cbPrgEttyId,
      @PathParam('ettyId') this.ettyId,
      @PathParam('cbQuoId') this.cbQuoId,

      });

  final String? ettyId;
  final String? cbId;
  final String? cbPrgEttyId;
  final String? prgEttyId;
  final String? cbQuoId;
  final String? chargeType;

 @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

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
    return provideBreadCrumb("custmgmt/main");
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }
  Widget buildView() { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: false,
        title: Text('Customer Subsidy Setup'),
        automaticallyImplyLeading: false,),
      body: CustMgmtSubsidy2Form(
        ettyId: convStrNewOrNullToNull(ettyId),
        cbId: convStrNewOrNullToNull(cbId),
        cbPrgEttyId: convStrNewOrNullToNull(cbPrgEttyId),
        prgEttyId: convStrNewOrNullToNull(prgEttyId),
        cbQuoId: convStrNewOrNullToNull(cbQuoId),
        chargeType: chargeType,

      ),
    );
  }
}

class CustMgmtSubsidy2Form extends ConsumerWidget {
  const CustMgmtSubsidy2Form({
    super.key,
    this.ettyId,
    this.cbId,
this.cbPrgEttyId,
    this.prgEttyId,
    this.cbQuoId,
    this.chargeType

  });

   final String? ettyId;
  final String? cbId;
  final String? cbPrgEttyId;
  final String? prgEttyId;
  final String? cbQuoId;
  final String? chargeType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final subVechFormKey = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiMgmtCbp/queryasync',
        params: {
          "CbQuoId": cbQuoId,
          "EttyId" : ettyId,
    "CbId":cbId,
    "CbPrgEttyId":cbPrgEttyId,
    "PrgEttyId":prgEttyId,
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
    "RefNo": null,
      "FromDate": null,
      "ToDate": null,
      "QuoLimit": null,
     "AllocMethod": null,
      "Note": null,
      "CbId": cbId,
      "CbPrgEttyId": cbPrgEttyId,
      "EttyId": ettyId,
      "CbQuoId": cbQuoId,
      "PrgEttyId": prgEttyId
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }

          return FormBuilder(
            key: subVechFormKey,
            initialValue: formNewValue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbw20,
                Expanded(
                    flex: 5,
                    child: ListView(
                      children: [
                        const FbHiddenText(name: 'CbQuoId'),
                         const FbHiddenText(name: 'CbId'),
                          const FbHiddenText(name: 'CbPrgEttyId'),
                        const FbHiddenText(name: 'PrgEttyId'),
                          const FbHiddenText(name: 'ACTVSUSPSTS'),
                        FbLibView(
                          name: 'EttyId',
                          initialValue: formNewValue["EttyId"],
                          label: 'Customer/Company',
                          params: const {    "EttyId":null,
    "Hierarchy " : 0},
                          keyField: 'Id',
                          searchText: 'Dscp',
                          querySql: '/sp/ApiMgmtEtty/queryasync',
                        ),
                            // FbLibref(
                            // name: 'RefreshCycle',
                            // initialValue: formNewValue["ACTVSUSPSTS"],
                            // label: 'Status',
                            // params: const {
                            //   "RefType": "ACTVSUSPSTS",
                            //   "BitInd": null
                            // }),
                          //     const FbText(name: 'Dscp', label: 'Description',readOnly: true,),
                        const FbText(
                            name: 'RefNo', label: 'Reference Number'),
                          const FbOption(
                            name: 'AllocMethod',
                            label: 'Allocate Method',
                            params: {
                             "RefType": "CBQUOTAALLOC",
                              "BitInd": null
                            }),
                        const Row(
                          children: [
                            Flexible(
                                child: FbDateTimePicker(
                                    name: 'FromDate', label: 'From Date')),
                                    fbFieldGap,
                            Flexible(
                              child: FbDateTimePicker(
                                name: 'ToDate',
                                label: 'To Date',
                              ),
                            )
                          ],
                        ),
                        const FbText(name: 'QuoLimit', label: 'Quota Limit'),         
                               const FbText(
                          name: 'Note',
                          label: 'Note',
                          maxLines: 5,
                        ),
                      ],
                    )),
                Expanded(
                    flex: 5,
                    child: CustMgmtSubsidy2VehcList(
                      ettyId: ettyId,
                      cbId: cbId,
                      cbQuoId: cbQuoId,
                      fromDate: formNewValue['FromDate'],
                      toDate: formNewValue['ToDate'],
                    )),
                Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        AcxSaveButtonManual(
                          onSave: () {
                                   if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                            subVechFormKey.currentState!.save();
                            final quoId =
                                subVechFormKey.currentState!.value['QuoId'];
                            subVechFormKey.currentState!.patchValue(
                                {'QuoId': quoId == '' ? null : quoId});
                            Map<String, dynamic> toPost =
                                convertFormValueToSave(
                                    subVechFormKey.currentState!.value,
                                    theData.columnInfo);
                                    toPost.remove('ACTVSUSPSTS');
                            final querySave = QueryObject(
                               querysql: '/sp/ApiMgmtCbpSave/queryasync?logId=',
                                params: toPost,
                                showMsg: false);

                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((value) {
                              Toast.showresult(value);
                              if (isSuccess(value.message)) {
                                String theNewId =
                                    getOutputValue(value.output, '@QuoId')
                                        .toString();
                                singleton<AppRouter>()
                                    .navigatePath(
                                        '/custMgmt/subsidy2/quotadtl/$theNewId'
                                        ''
                                        )
                                    .then((val) {
                                  ref.invalidate(
                                      ReturndatafreezedProvider(query));
                                });
                              }
                            });
                          },
                        ),
                        ///custMgmt/subsidy2/cbplist/SUBS/1/1
                        AcxBackToList(
                            listUrl:
                                '/custmgmt/subsidy2/cbp/$chargeType/$prgEttyId/$cbId/cbplist'),
                                AcxAuditLogReqBtn('ApiMgmtCmpySubsSave',ettyId: '')
                      ],
                    ))
              ],
            ),
          );
        });
  }
}

class CustMgmtSubsidy2VehcList extends ConsumerWidget {
  const CustMgmtSubsidy2VehcList({
    super.key,
    this.ettyId,
    this.cbId,
    this.cbQuoId, this.fromDate, this.toDate
  });

  final String? ettyId;
  final String? cbId;
  final String? cbQuoId;
  final DateTime? fromDate;
  final DateTime? toDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {


 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtCbpChildList/queryasync',
        params: {
          'EttyId': ettyId,
          'CbId': cbId,
          'CbQuoId': convStrNewOrNullToNull(cbQuoId)
        },
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));
    const hdrText = SelectableText('List of Vehicle entitled');

    return AsyncValueWidget(
        value: listData,
        data: (srcData) {
          if (srcData.data == null || srcData.data![0]['CbQuoId'] == null) {
            return const SizedBox(
                height: 300,
                child: Column(
                  children: [
                    SelectableText('No Record Vehicle List'),
                  ],
                ));
          }
          // if (srcData.data![0]['QuoId'] != null) {
          //   return ListView(
          //     children: [
          //       hdrText,
          //       sbh20,
          //       Row(
          //         children: [
          //           ElevatedButton(
          //               onPressed: () async {
          //                 //   await showVehcForm(context, srcData.data![0], quoId);
          //                 //     ref.invalidate(ReturndatafreezedProvider(query));
          //                 // },
          //                 await showAcxDialog(
          //                   context,
          //                   CustMgmtCmpySubsidy2VehcForm(
          //                     quotaLimit:
          //                         srcData.data![0]['QuotaLimit'].toString(),
          //                     custEttyId: custEttyId.toString(),
          //                     mbrEttyId: convStrNewOrNullToNull(
          //                         srcData.data![0]['MbrEttyId'].toString()),
          //                     quoId: quoId,
          //                     vhcRgsNo: convStrNewOrNullToNull(
          //                         srcData.data![0]['VhcRgsNo'].toString()),
          //                     vhcId: convStrNewOrNullToNull(
          //                         srcData.data![0]['VhcId'].toString()),
          //                   ),
          //                 );
          //               },
          //               child: const Icon(Icons.post_add)),
          //         ],
          //       ),
          //       const SelectableText('No Vehicle setup'),
          //       // SizedBox(
          //       //     height: 100,
          //       //     child: ListView(
          //       //       children: const [SelectableText('No Record')],
          //       //     ))
          //     ],
          //   );
          // }

          return SingleChildScrollView(
            child: SizedBox(
              height: 500,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hdrText,
              
                    ElevatedButton(
                        onPressed: () async {
                          //   await showVehcForm(context, {'CustEttyId': custEttyId, 'CmpyEttyId': cmpyEttyId, 'QuoId': convStrNewOrNullToNull(quoId)}, quoId);
                          await showAcxDialog(
                              context,
                              CustMgmtCmpySubsidy2VehcForm(
                                ettyId: ettyId.toString(),
                                cbId: cbId.toString(),
                                cbQuoId: cbQuoId.toString(),
                                toDate: toDate,
                                fromDate: fromDate,
                                
                              ));
                          ref.invalidate(ReturndatafreezedProvider(query));
                        },
                        child: const Icon(Icons.post_add)),
                    // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
                    const Divider(),
                    const Row(
                      children: [
                        Expanded(child: SelectableText("Vehicle Reg. Number")),
                        Expanded(child: SelectableText("Quota Limit")),
                         Expanded(child: SelectableText("From Date")),
                        Expanded(child: SelectableText("To Date")),
                        Spacer()
                      ],
                    ),
                    const Divider(),
                    SizedBox(
                      height: 300,
                      child: srcData.data![0]['ChildId'] == null
                          ? const SelectableText('No record')
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: srcData.rowcount!,
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemBuilder: (context, index) {
                                final currentData = srcData.data![index];
                                return ListTile(
                                  //         onTap: () async {
                                  // //          await showAcxDialog(context, CustMgmtCmpySubsidy2VehcForm(
                                  // //   quotaLimit: currentData['QuotaLimit'].toString(),
                                  // //   custEttyId: custEttyId.toString(),
                                  // //   cmpyEttyId: cmpyEttyId.toString(),
                                  // //   mbrEttyId: convStrNewOrNullToNull(currentData['MbrEttyId'].toString()),
                                  // //   quoId: quoId,
                                  // //   vhcRgsNo: convStrNewOrNullToNull(currentData['VhcRgsNo'].toString()),
                                  // //   vhcId: convStrNewOrNullToNull(currentData['VhcId'].toString()),
                                  // // ) );
                                  //         },
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: SelectableText(
                                              '${currentData['VhcRgsNo']}')),
                                      Expanded(
                                          child: SelectableText(
                                              '${fmtNumberNoDecimal(currentData['QuotaLimit'])} ')),
                                              Expanded(
                                          child:currentData['FromDate'] == null? Text(''): SelectableText(
                                              '${fmtDateyyyyMMdd(currentData['FromDate'])} ')),
                                              Expanded(
                                          child: currentData['ToDate'] == null? Text(''): SelectableText(
                                              '${fmtDateyyyyMMdd(currentData['ToDate'])} ')),
                                      Expanded(
                                          child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () async {
                                          bool confirmed = await ConfirmDialog.show(
                                              title:
                                                  'Are you sure you want to delete the record?');
              
                                          if (confirmed) {
                                            final queryDel = QueryObject(
                                                querysql:
                                                    '/sp/ApiMgmtCbpChildDel/queryasync',
                                                params: {
                                                      "CbQuoId":currentData['CbQuoId'],
                                                     "ChildId":currentData['ChildId'],
                                                },
                                                showMsg: false);
                                            final resultDel = ref.read(
                                                ReturndatafreezedProvider(queryDel)
                                                    .future);
                                            resultDel.then((value) {
                                              ref.invalidate(
                                                  ReturndatafreezedProvider(query));
                                              Toast.showresult(value);
                                            });
                                          }
                                        },
                                      )),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ]),
            ),
          );
        });
  }
}

class CustMgmtCmpySubsidy2VehcForm extends ConsumerWidget {
  const CustMgmtCmpySubsidy2VehcForm({
    super.key, this.ettyId, this.cbId, this.cbQuoId, this.childId, this.vhcRgsNo,
    this.fromDate, this.toDate  
  });

 final String? ettyId;
  final String? cbId;
  final String? cbQuoId;
  final String? childId;
  final String? vhcRgsNo;
  final DateTime? fromDate;
  final DateTime? toDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
        "CbQuoId":cbQuoId,
    "ChildId":convStrNewOrNullToNull(childId),
    "FromDate":null,
    "ToDate":null,
    "QuoLimit": null,
    "MbrEttyId":null,
    "VhcRgsNo": null,
    "VhcId":null,
    "CbId":null,
    "EttyId":null
};

    final queryPlanListForm = QueryObject(
        querysql: '/sp/ApiMgmtCbpChild/queryasync',
        params: {
    "EttyId" : ettyId,
    "CbId":cbId,
    "CbQuoId":cbQuoId,
    "VhcRgsNo":vhcRgsNo,
    "ChildId":convStrNewOrNullToNull(childId)
},
        showMsg: false);

    final formDataPlanListForm =
        ref.watch(ReturndatafreezedProvider(queryPlanListForm));


    return AsyncValueWidget<Returndata>(
        value: formDataPlanListForm,
        data: (theData) {
              if (theData.data != null) {
                formValue = convertFormValueToDisplay(
                    theData.data![0] as Map<String, dynamic>,
                    theData.columnInfo);
                formValue['CbQuoId'] = cbQuoId;
                formValue['CbId'] = cbId;
                formValue['EttyId'] = ettyId;
                formValue['FromDate'] = fromDate;
                formValue['ToDate'] = toDate;
              } else {}

              return FormBuilder(
                key: formKeyPlan,
                initialValue: formValue,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FbHiddenText(name: 'EttyId'),
                            const FbHiddenText(name: 'CbQuoId'),
                            const FbHiddenText(name: 'CbId'),
                            const FbHiddenText(name: 'MbrEttyId'),
                           const FbHiddenText(name: 'VhcRgsNo'),
                                  FbLibView(
                          name: 'VhcId',
                          returnSelectedRef:(val){
                  
                            formKeyPlan.currentState!.patchValue({
                              'VhcRgsNo':val['VhcRgsNo'],
                              'MbrEttyId':val['MbrEttyId'],
                            });
                          },
                          initialValue: formValue["VhcId"],
                          label: 'Vehicle Registration Number',
                          params:  {    "EttyId":ettyId,
                      "Hierarchy " : 4},
                          keyField: 'VhcId',
                          searchText: 'Dscp',
                          querySql: '/sp/ApiMgmtEtty/queryasync',
                        ),
                                FbNumber(
                              name: 'QuoLimit', label: 'Quota Limit'),
                                const Row(
                          children: [
                            Flexible(
                                child: FbDateTimePicker(
                                    name: 'FromDate', label: 'From Date')),
                                    fbFieldGap,
                            Flexible(
                              child: FbDateTimePicker(
                                name: 'ToDate',
                                label: 'To Date',
                              ),
                            )
                          ],
                        ),
                            //     FbLibref(
                            // name: 'Status',
                            // initialValue: formValue["ACTVSUSPSTS"],
                            // label: 'Status',
                            // params: const {
                            //   "RefType": "ACTVSUSPSTS",
                            //   "BitInd": null
                            // }),
                         
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  formKeyPlan.currentState!.save();
                                  final cbId =
                                      formKeyPlan.currentState!.value['CbId'];
                                  formKeyPlan.currentState!.patchValue(
                                      {'CbId': cbId == '' ? null : cbId});
                                  final toPost = convertFormValueToSave(
                                      formKeyPlan.currentState!.value,
                                      theData.columnInfo);
                                  final querySave = QueryObject(
                                      querysql:
                                          'ApiMgmtCbpChildSave',
                                      params: toPost,
                                      showMsg: false);
                  
                                  final saveResult = ref.read(
                                      ReturndatafreezedProvider(querySave)
                                          .future);
                                  saveResult.then((value1) {
                                    Toast.showresult(value1);
                                  });
                                },
                                child: const Icon(Icons.save),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.maybePop();
                                },
                                child: const RotationTransition(
                                  turns: AlwaysStoppedAnimation(180 / 360),
                                  child: Icon(
                                    Icons.exit_to_app,
                                  ),
                                ),
                              ),
                                   sbh10,
                              AcxAuditLogReqBtn('ApiMgmtCbpChildSave',ettyId:'',)
                            ],
                          ))
                    ],
                  ),
                ),
              );
            },
          );
  }
}
