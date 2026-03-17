import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';

import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/mcenroll/mc_enroll_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=664;

@RoutePage()
class MchtEnrlocPrgSelection extends ConsumerWidget {
  const MchtEnrlocPrgSelection(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam('prgEttyId') this.prgEttyId,
      @PathParam('billingEttyType') this.billingEttyType,
      @PathParam('accptId') this.accptId});

  final String? mchtEttyId;
  final String? prgEttyId;
  final String? locEttyId;
  final String? accptId;
  final String? billingEttyType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyprgSelect = GlobalKey<FormBuilderState>();

    // "LocEttyId": 102,
    // "PrgEttyId" : 1,
    // "AccptId": 25,

    final formValue = {
      //  "MchtEttyId": mchtEttyId,
      "PrgEttyId": prgEttyId,
      "AccptId": convStrNewOrNullToNull(accptId),
      "LocEttyId": locEttyId,
      "BillingEttyType": billingEttyType
    };

    var prgSelect = ref.watch(mchtEnrollPrgSelectProvider);
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
                  'You are about to sign up a new Program, please select a Billing Entity of this Program'),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                //   const FbHiddenText(name: 'MchtEttyId'),
                const FbHiddenText(name: 'PrgEttyId'),
                const FbHiddenText(name: 'LocEttyId'),
                const FbHiddenText(name: 'AccptId'),
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
                            formKeyprgSelect.currentState!.save();
                            Map<String, dynamic> toPost =
                                formKeyprgSelect.currentState!.value;
                            final querySave = QueryObject(
                                querysql: '/sp/ApiEnrlLocPrgSave/queryasync?logId=${convStrNewOrNullToNull(locEttyId) ?? 0}',
                                params: toPost,
                                showMsg: false);
                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
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
                                '/mcenroll/loc/$mchtEttyId/detail/$locEttyId/program'),
                                sbh10,
                                AcxAuditLogReqBtn('ApiEnrlLocPrgSave', ettyId: locEttyId.toString(),)
                      ],
                    ))
              ]),
            ],
          ),
        ));
  }
}
