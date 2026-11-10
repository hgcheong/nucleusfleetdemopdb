import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

const int wid=523;

@RoutePage()
class CustEnrollMemberInfoPersonal extends HookConsumerWidget {
  const CustEnrollMemberInfoPersonal(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId});

  final String? custEttyId;
  final String? mbrEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Center(
      child: CustEnrollMemberInfoPersonalForm(
        custEttyId: custEttyId,
        mbrEttyId: mbrEttyId,
      ),
    );
  }
}

class CustEnrollMemberInfoPersonalForm extends ConsumerWidget {
  const CustEnrollMemberInfoPersonalForm(
      {super.key, this.custEttyId, this.mbrEttyId});

  final String? custEttyId;
  final String? mbrEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final custEnrollPsnlFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "MbrEttyId": mbrEttyId,
      "Dscp": null,
      "CostCtr": null,
      "MbrCnt": 0,
      "MediaCnt": 0,
      "Title": null,
      "Gender": null,
      "Email": null,
      "PersonId": null,
    };
    final formQuery = QueryObject(
        querysql: '/sp/ApiEnrlMbrPsnl/queryasync',
        params: {
          "MbrEttyId": mbrEttyId == 'new' ? null : mbrEttyId,
          "CustEttyId": custEttyId
        },
        showMsg: false);
    final formData = ref.watch(ReturndatafreezedProvider(formQuery));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: custEnrollPsnlFormKey,
            initialValue: formNewValue,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                //   "TaxCtgry": null,

                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FbHiddenText(name: 'CustEttyId'),
                        const FbHiddenText(name: 'MbrEttyId'),
                        const FbHiddenText(name: 'PersonId'),
                        SelectableText(S.of(context).tabMembership),
                  
                        Row(
                          children: [
                         
                                  Expanded(
                              child: FbHiddenText(
                                name: 'FirstName',
                              ),
                            ),
                            Expanded(
                              child: FbHiddenText(
                                name: 'LastName',
                              ),
                            )
                          ],
                        ),
      
                        const FbHiddenText(
                        //  label: 'Email',
                          name: 'Email',
                        ),
                 
                        const Row(
                          children: [
                            Expanded(
                                child: FbLibref(
                                    label: 'Title',
                                    name: 'Title',
                                    params: {
                                  "RefType": "TITLE",
                                  "BitInd": null
                                })),
                            fbFieldGap,
                            Expanded(
                                child: FbLibref(
                                    label: 'Gender',
                                    name: 'Gender',
                                    params: {
                                  "RefType": "Gender",
                                  "BitInd": null
                                })),
                          ],
                        ),
                              Row(children: [
   Expanded(
                              child: FbText(
                                  name: 'FullName',
                                  label: S.of(context).lblName),
                            ),
                        ],),
                        FbText(
                          name: 'EmployeeCd',
                          label: S.of(context).lblEmployeeNumber,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: FbDateTimePicker(
                                  name: 'EmploymtStartDate',
                                  label: S.of(context).lblEmployeeStartDate),
                            ),
                          ],
                        ),
                        FbLibView(
                            name: 'PsnlIdType',
                            label: S.of(context).lblTypeOfId,
                            params: const {
                              "RefType": "PsnlIdType",
                              "BitInd": null
                            },
                            keyField: "RefCd",
                            searchText: "Dscp",
                            querySql: '/sp/GetLibRef/queryasyncnouser'),
                        FbText(name: 'PsnlId', label: S.of(context).lblIDNumber)
                      ],
                    ),
                  ),
                ),
                const Expanded(flex: 5, child: SelectableText('')),
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    AcxSaveButtonManual(
                      onSave: () {
                               if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                        custEnrollPsnlFormKey.currentState!.save();

                        Map<String, dynamic> toPost = Map.from(
                            convertFormValueToSave(
                                custEnrollPsnlFormKey.currentState!.value,
                                theData.columnInfo));

                        final querySave = QueryObject(
                            querysql: '/sp/ApiEnrlMbrPsnlSave/queryasync',
                            params: toPost,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            ref.invalidate(
                                ReturndatafreezedProvider(formQuery));
                          }
                          //   context.maybePop();
                        });
                      },
                    ),
                    AcxAuditLogReqBtn('ApiEnrlMbrPsnlSave',ettyId: convStrNewOrNullToNull(formNewValue["PersonId"]).toString(),)
                  ]),
                )
              ],
            ));
      },
    );
  }
}
