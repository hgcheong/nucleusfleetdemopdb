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

const int wid=458;

@RoutePage()
class CustEnrollCmpySecurityDep extends StatelessWidget {
  const CustEnrollCmpySecurityDep(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
      @PathParam('depId') this.depId});

  final String? depId;
  final String? custEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Center(
      child: CustEnrollSecurityDepForm(
          custEttyId: custEttyId,
          depId: convStrNewOrNullToNull(depId),
          cmpyEttyId: cmpyEttyId),
    );
  }
}

class CustEnrollSecurityDepForm extends ConsumerWidget {
  const CustEnrollSecurityDepForm(
      {super.key, this.custEttyId, this.depId, this.cmpyEttyId});

  final String? custEttyId;
  final String? depId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final custEnrollSecurityDepFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formNewValue = {
      "CollateralType": null,
      "SecurityRefNo": null,
      "Bank": null,
      "BranchCd": null,
      "IssDate": null,
      "ExpDate": null,
      "SecuritySum": null,
      "RvwDate": null,
      "Note": null,
      "CustEttyId": custEttyId,
      "DepId": depId,
      "CmpyEttyId": cmpyEttyId,
      "MdfDate": Null
    };
    final querySql = QueryObject(
        querysql: '/sp/ApiEnrlCrDep/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "CmpyEttyId": cmpyEttyId,
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
            key: custEnrollSecurityDepFormKey,
            initialValue: formNewValue,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
               const FbHiddenText(name: 'CustEttyId'),
                const FbHiddenText(name: 'CmpyEttyId'),
                const FbHiddenText(name: 'DepId'),
                const FbHiddenDateTime(name: 'MdfDate'),
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
                        custEnrollSecurityDepFormKey.currentState!.save();
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            custEnrollSecurityDepFormKey.currentState!.value,
                            theData.columnInfo);
                        final querySave = QueryObject(
                            querysql: '/sp/ApiEnrlCrDepSave/queryasync?logId=${convStrNewOrNullToNull(cmpyEttyId) ?? 0}',
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
                    const AcxBackToList(listUrl: './././secdep'),
                    AcxAuditLogReqBtn('ApiEnrlCrDepSave',ettyId:  cmpyEttyId.toString(),)
                    
                  ]),
                )
              ],
            ));
      },
    );
  }
}
