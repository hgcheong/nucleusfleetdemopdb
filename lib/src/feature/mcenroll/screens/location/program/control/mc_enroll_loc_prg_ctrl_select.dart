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
import 'package:nucleusv2/src/feature/mcenroll/screens/location/program/control/mc_enroll_loc_prg_ctrl_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=799;

@RoutePage()
class MchtEnrlLocPrgControlSelection extends ConsumerWidget {
  const MchtEnrlLocPrgControlSelection(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam.inherit('txnCtgry') this.txnCtgry,
      @PathParam.inherit('accptId2') this.accptId});

  final String? prgEttyId;
  final String? locEttyId;
  final String? accptId;
  final String? txnCtgry;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyprgSelect = GlobalKey<FormBuilderState>();

    final formValue = {
      //  "MchtEttyId": mchtEttyId,
      "PrgEttyId": prgEttyId,
      "AccptId": convStrNewOrNullToNull(accptId),
      "LocEttyId": locEttyId,
      "TxnCtgry": txnCtgry
    };

    var prgSelect = ref.watch(mchtEnrollLocCtrlSelectProvider);
    if (prgSelect == {}) {
      singleton<AppRouter>().back();
    }

    return FormBuilder(
        key: formKeyprgSelect,
        initialValue: formValue,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectableText('New Transaction type Selected'),
              AcxNavButton(
                listOfContent: [
                  SelectableText(prgSelect['TxnCtgryDscp'].toString())
                ],
                listOfButton: const [],
              ),
              const SelectableText('You are about add a new trnsaction type'),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                //   const FbHiddenText(name: 'MchtEttyId'),
                const FbHiddenText(name: 'PrgEttyId'),
                const FbHiddenText(name: 'LocEttyId'),
                const FbHiddenText(name: 'AccptId'),
                const FbHiddenText(name: 'TxnCtgry'),
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

                            final querySave = QueryObject(
                                querysql:
                                    '/sp/ApiEnrlLocTxnAccptSave/queryasync?logId=${convStrNewOrNullToNull(locEttyId) ?? 0}',
                                params: formKeyprgSelect.currentState!.value,
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
                        const AcxBackToList(listUrl: './././list'),
                        AcxAuditLogReqBtn('ApiEnrlLocTxnAccptSave', ettyId: locEttyId.toString(),)
                      ],
                    ))
              ]),
            ],
          ),
        ));
  }
}
