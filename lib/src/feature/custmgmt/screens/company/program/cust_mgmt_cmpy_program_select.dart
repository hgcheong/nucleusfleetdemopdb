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
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/custmgmt_controller.dart';

const int wid=565;

@RoutePage()
class CustMgmtCmpyProgramSelect extends ConsumerWidget {
  const CustMgmtCmpyProgramSelect(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
      @PathParam.inherit('accptId') this.accptId,
      @PathParam('prgEttyId') this.prgEttyId});

  final String? custEttyId;
  final String? cmpyEttyId;
  final String? prgEttyId;
  final String? accptId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyCmpyPrgSelect = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formValue = {
      "CustEttyId": custEttyId,
      "CmpyEttyId": cmpyEttyId,
      "PrgEttyId": prgEttyId,
      "AccptId": accptId,
      "BillingType": null,
      "BillingEttyType": null
    };

    var prgSelect = ref.watch(custMgmtPrgSelectProvider);
    if (prgSelect == {}) {
      singleton<AppRouter>().back();
    }

    final query = QueryObject(
        querysql: '/sp/ApiMgmtCmpyPrgAccpt/queryasync',
        params: {
          "CmpyEttyId": cmpyEttyId,
          "CustEttyId": custEttyId,
          "PrgEttyId": prgEttyId,
          "AccptId": accptId
        },
        showMsg: false);

    final queryRes = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
      value: queryRes,
      data: (theData) {
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: formKeyCmpyPrgSelect,
            initialValue: formValue,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SelectableText('Current Program Selected'),
                  AcxNavButton(
                    listOfContent: [
                      SelectableText(prgSelect['PrgDscp'].toString())
                    ],
                    listOfButton: const [],
                  ),
                  const SelectableText(
                      'You are about to sign up a new Program, please select a type of Billing'),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          flex: 2,
                          child: FbLibView(
                              inputIcon: Icon(Icons.search),
                              name: 'BillingType',
                              label: 'Billing Type',
                              params: {
                                "RefType": "BillingType",
                                "BitInd": null
                              },
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/sp/GetLibRef/queryasyncnouser'),
                        ),
                        const FbHiddenText(name: 'CustEttyId'),
                        const FbHiddenText(name: 'CmpyEttyId'),
                        const FbHiddenText(name: 'PrgEttyId'),
                        const FbHiddenText(name: 'BillingEttyType'),
                        sbw10,
                        Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                sbh10,
                                AcxSaveButtonManual(
                                  onSave: () async {
                                      if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                                    formKeyCmpyPrgSelect.currentState!.save();

                                    final querySave = QueryObject(
                                        querysql:
                                            '/sp/ApiMgmtCmpyPrgAccptSave/queryasync?logId=${convStrNewOrNullToNull(cmpyEttyId) ?? 0}',
                                        params: formKeyCmpyPrgSelect
                                            .currentState!.value,
                                        showMsg: false);
                                    final saveResult = ref.read(
                                        ReturndatafreezedProvider(querySave)
                                            .future);
                                    saveResult.then((value) {
                                      Toast.showresult(value);
                                      if (isSuccess(value.message)) {
                                        if (context.mounted) {
                                          context.maybePop();
                                        }
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                sbh10,
                                AcxBackToList(
                                    listUrl:
                                        '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/program/list'),
                                        sbh10,
                                        AcxAuditLogReqBtn('ApiMgmtCmpyPrgAccptSave',ettyId: cmpyEttyId.toString(),)

                                ///custmgmt/cmpy/528/detail/529/program/list
                              ],
                            ))
                      ]),
                  //  const  Row(
                  //      children: [
                  //         Flexible(
                  //         flex: 2,
                  //               child: FbLibView(
                  //                  inputIcon:  Icon(Icons.search),
                  //                 name: 'BillingType', label: 'Type of Billing', params: {"RefType": "BillingType", "BitInd": null}, keyField: 'RefCd', searchText: 'Dscp', querySql: '/sp/GetLibRef/queryasyncnouser'),
                  //             ),
                  //                sbw10,
                  //                Spacer(flex: 1,)
                  //      ],
                  //    ),
                ],
              ),
            ));
      },
    );
  }
}
