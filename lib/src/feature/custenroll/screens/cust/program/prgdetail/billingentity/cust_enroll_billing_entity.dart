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
import 'package:nucleusv2/src/feature/custenroll/custenroll_controller.dart';

const int wid=821;

@RoutePage()
class CustEnrollBillingEntity extends ConsumerWidget {
  const CustEnrollBillingEntity(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('billingEttyType') this.billingEttyType});

  final String? custEttyId;
  final String? prgEttyId;
  final String? billingEttyType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyCustEnrollSelect = GlobalKey<FormBuilderState>();

    var prgSelect = ref.watch(custEnrollPrgSelectProvider);

    if (prgSelect == {}) {
      singleton<AppRouter>().back();
    }
    final formValue = {
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      "AccptId": prgSelect['AccptId'],
      "BillingEttyType": billingEttyType
    };
    return FormBuilder(
        key: formKeyCustEnrollSelect,
        initialValue: formValue,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: SizedBox(
              height: 1280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SelectableText('Current Program Selected'),
                  const FbHiddenText(name: 'CustEttyId'),
                  const FbHiddenText(name: 'PrgEttyId'),
                  const FbHiddenInt(name: 'AccptId'),
                  AcxNavButton(
                    listOfContent: [
                      SelectableText(prgSelect['PrgDscp'].toString())
                    ],
                    listOfButton: const [],
                  ),
                  const SelectableText(
                      'You are about to sign up a new Program, please select a type of Billing Level'),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                            child: FbLibView(
                                name: 'BillingEttyType',
                                label: 'Billing Level',
                                params: {},
                                keyField: 'EttyType',
                                searchText: 'Dscp',
                                querySql: '/view/async/VwCustBillingEttyType')),

                        sbw10,
                        Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                sbh10,
                                AcxSaveButtonManual(
                                  onSave: () {
                                           if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                                    formKeyCustEnrollSelect.currentState!
                                        .save();
                                    final querySave = QueryObject(
                                        querysql:
                                            '/sp/ApiEnrlCustPrgSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
                                        params: formKeyCustEnrollSelect
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
                                        '/custenroll/cust/$custEttyId/program/list'),
                                        sbh10,
                                        AcxAuditLogReqBtn('ApiEnrlCustPrgSave', ettyId: custEttyId.toString(),)
                              ],
                            ))
                      ]),
                ],
              ),
            ),
          ),
        ));
  }
}
