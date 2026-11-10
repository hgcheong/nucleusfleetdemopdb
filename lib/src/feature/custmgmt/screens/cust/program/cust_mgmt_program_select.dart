import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_hiddentext.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/feature/custmgmt/custmgmt_controller.dart';

const int wid=606;

@RoutePage()
class CustMgmtProgramSelect extends ConsumerWidget {
  const CustMgmtProgramSelect(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam('prgEttyId') this.prgEttyId});

  final String? custEttyId;
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyprgSelect = GlobalKey<FormBuilderState>();

    final formValue = {
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      "BillingEttyType": null,
    };

    var prgSelect = ref.watch(custMgmtPrgSelectProvider);
    if (prgSelect == {}) {
      singleton<AppRouter>().back();
    }

    return FormBuilder(
        key: formKeyprgSelect,
        initialValue: formValue,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectableText('New Program Selected'),
              AcxNavButton(
                listOfContent: [
                  SelectableText(prgSelect['PrgDscp'].toString())
                ],
                listOfButton: const [],
              ),
              const SelectableText(
                  'You are about to sign up a new Program, please select a type of Billing Level'),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                    flex: 2,
                    child: FormBuilderField(
                        name: 'BillingEttyType',
                        builder: (field) {
                          return AcxSearchBoxMap(
                              returnSelectedRef: (dynamic val) {
                                field.didChange(val['EttyType']);
                              },
                              inputText: 'Billing Level',
                              inputIcon: const Icon(Icons.search),
                              querysql: '/view/async/VwCustBillingEttyType',
                              searchText: 'Dscp',
                              keyField: 'EttyType',
                              params: const {});
                        })),
                const FbHiddenText(name: 'CustEttyId'),
                const FbHiddenText(name: 'PrgEttyId'),
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
                            formKeyprgSelect.currentState!.save();
                            Map<String, dynamic> toPost =
                                formKeyprgSelect.currentState!.value;
                            final querySave = QueryObject(
                                querysql: '/sp/ApiMgmtCustPrgSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
                                params: toPost,
                                showMsg: false);
                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((value) {
                              Toast.showresult(value);
                              if (isSuccess(value.message)) {
                                if (context.mounted) {
                                  if (context.mounted) {
                                    context.maybePop();
                                  }
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
                            listUrl: '/custmgmt/cust/$custEttyId/program/list'),
                        AcxAuditLogReqBtn('ApiMgmtCustPrgSave', ettyId: custEttyId.toString(),)
                      ],
                    ))
              ]),
              // const Row(
              //    children: [
              //       Flexible(
              //       flex: 2,
              //             child: FbLibView(
              //                   inputIcon:  Icon(Icons.search),
              //               name: 'BillingType', label: 'Type of Billing', params: {"RefType": "BillingType", "BitInd": null}, keyField: 'RefCd', searchText: 'Dscp', querySql: '/sp/GetLibRef/queryasyncnouser'),
              //           ),
              //                  sbw10,
              //                  Spacer(flex: 1,)
              //    ],
              //  ),
            ],
          ),
        ));
  }
}
