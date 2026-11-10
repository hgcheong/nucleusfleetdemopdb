import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=585;

@RoutePage()
class CustMgmtSecurityDep extends StatelessWidget {
  const CustMgmtSecurityDep(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam('depId') this.depId});

  final String? depId;
  final String? custEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Center(
      child: CustMgmtSecurityDepForm(
        custEttyId: custEttyId,
        depId: convStrNewOrNullToNull(depId),
      ),
    );
  }
}

class CustMgmtSecurityDepForm extends ConsumerWidget {
  const CustMgmtSecurityDepForm({
    super.key,
    this.custEttyId,
    this.depId,
  });

  final String? custEttyId;
  final String? depId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final custMgmtSecurityDepFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formNewValue = {
      "CollateralType": null,
      "SecurityRefNo": null,
      "Bank": null,
      "BranchCd": null,
      "IssDate": null,
      "ExpDate": null,
      "SecuritySum": null,
      "SecurityBal": null,
      "RvwDate": null,
      "Note": null,
      "CustEttyId": custEttyId,
      "DepId": depId
    };
    final querySql = QueryObject(
        querysql: '/sp/ApiMgmtCrDep/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "DepId": depId,
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
            key: custMgmtSecurityDepFormKey,
            initialValue: formNewValue,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                const FbHiddenText(name: 'CustEttyId'),
                const FbHiddenText(name: 'DepId'),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText('Security Deposit Details'),
                        FbLibref(
                            name: 'CollateralType',
                            initialValue: formNewValue["CollateralType"],
                            label: 'Security Type',
                            params: const {
                              "RefType": "CollateralType",
                              "BitInd": null
                            }),
                        // FbLibref(name: 'Bank', initialValue: formNewValue["Bank"], label: 'Bank', params: const {"RefType": "BANK", "BitInd": null}),
                        FbLibView(
                            name: 'Bank',
                            label: 'Bank',
                            params: const {},
                            keyField: 'Bank',
                            searchText: 'BankName',
                            querySql: '/view/async/VwBank',
                            initialValue: formNewValue['Bank'].toString()),
                       const FbText(
                          name: 'BranchCd',
                          label: 'Branch Cd',
                        ),
                       const FbText(
                          name: 'SecurityRefNo',
                          label: 'Security Ref No',
                        ),
                       const FbText(
                          name: 'SecuritySum',
                          label: 'Security Sum',
                        ),
                       const FbText(
                          name: 'SecurityBal',
                          label: 'Security Balance',
                        ),
                        sbh10,
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: FbDateTimePicker(
                            name: 'IssDate',
                            label: 'Issue date',
                          ),
                        ),
                        Flexible(
                          child: FbDateTimePicker(
                            name: 'ExpDate',
                            label: 'Expiry date',
                          ),
                        ),
                        Flexible(
                          child: FbDateTimePicker(
                            name: 'RvwDate',
                            label: 'Review date',
                          ),
                        ),
                        SelectableText('Notes'),
                        FbText(name: 'Note', label: 'Notes'),
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
                        custMgmtSecurityDepFormKey.currentState!.save();
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            custMgmtSecurityDepFormKey.currentState!.value,
                            theData.columnInfo);
                        final querySave = QueryObject(
                            querysql: '/sp/ApiMgmtCrDepSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
                            params: toPost,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((Returndata value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            if (context.mounted) {
                              singleton<AppRouter>()
                                  .navigatePath(getAfterSavePath(
                                      context, value.output, '@DepId'))
                                  .then((val) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(querySql));
                              });
                            }
                          }
                        });
                      },
                    ),
                    AcxBackToList(
                        listUrl: '/custmgmt/cust/$custEttyId/criskctrl/secdep'),
                    AcxAuditLogReqBtn('ApiMgmtCrDepSave',ettyId: custEttyId.toString(),)
                  ]),
                )
              ],
            ));
      },
    );
  }
}
