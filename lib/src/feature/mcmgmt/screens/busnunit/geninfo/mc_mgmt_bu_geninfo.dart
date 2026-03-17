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
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=712;

@RoutePage()
class MchtMgmtBusinessUnitGenInfo extends ConsumerWidget {
  const MchtMgmtBusinessUnitGenInfo(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('busnUnitEttyId') this.busnUnitEttyId});

  final String? mchtEttyId;
  final String? busnUnitEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mchtEnrlBUFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formNewValue = {
      "BusnUnitEttyId": convStrNewOrNullToNull(busnUnitEttyId),
      "MchtEttyId": mchtEttyId,
      "BusnUnit": null,
      "Dscp": null,
      "LocCnt": null,
      "TadCnt": null
    };

    //remove CostCtrCnt, MbrCnt, MediaCnt
    final query = QueryObject(
        querysql: '/sp/ApiMgmtBusnUnit/queryasync',
        params: {
          "BusnUnitEttyId": convStrNewOrNullToNull(busnUnitEttyId),
          "MchtEttyId": mchtEttyId
        },
        showMsg: false);
    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
              key: mchtEnrlBUFormKey,
              initialValue: formNewValue,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 1280,
                  child: Row(children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SelectableText("Business Unit Info"),
                            sbh10,
                            const FbHiddenText(name: 'BusnUnitEttyId'),
                            const FbHiddenText(name: 'MchtEttyId'),
                            FbText(
                              name: 'BusnUnit',
                              label: 'Business Unit',
                              initialValue: formNewValue['BusnUnit'],
                            ),
                            FbText(
                                name: 'Dscp',
                                label: 'Description',
                                initialValue: formNewValue['Dscp']),
                            sbh10,
                            const SelectableText(
                                "Business Unit Hiearchy consist of..."),
                            sbh10,
                            Wrap(runSpacing: 10, children: [
                              sbw10,
                              AcxNavButton(listOfContent: [
                                const SelectableText('Location'),
                                SelectableText(
                                    formNewValue['LocCnt'].toString())
                              ], listOfButton: [
                                IconButton(
                                    onPressed: () {
                                      singleton<AppRouter>().navigatePath(
                                          '/mcmgmt/loc/$mchtEttyId/list');
                                    },
                                    icon: const Icon(Icons.add))
                              ]),
                              sbw10,
                              AcxNavButton(listOfContent: [
                                const SelectableText('TAD'),
                                SelectableText(
                                    formNewValue['TadCnt'].toString())
                              ], listOfButton: [
                                IconButton(
                                    onPressed: () {
                                      singleton<AppRouter>().navigatePath(
                                          '/mcmgmt/tad/$mchtEttyId/list');
                                    },
                                    icon: const Icon(Icons.add))
                              ]),
                            ])
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            AcxSaveButtonManual(onSave: () {
                                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                              mchtEnrlBUFormKey.currentState!.save();
                              Map<String, dynamic> toPost =
                                  convertFormValueToSave(
                                      mchtEnrlBUFormKey.currentState!.value,
                                      theData.columnInfo);
                              final querySave = QueryObject(
                                  querysql:
                                      '/sp/ApiMgmtBusnUnitSave/queryasync?logId=${convStrNewOrNullToNull(busnUnitEttyId) ?? 0}',
                                  params: toPost,
                                  showMsg: false);
                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((Returndata value) {
                                Toast.showresult(value);
                                if (isSuccess(value.message)) {
                                  if (context.mounted) {
                                    singleton<AppRouter>()
                                        .navigatePath(getAfterSavePath(context,
                                            value.output, '@BusnUnitEttyId'))
                                        .then((val) {
                                      ref.invalidate(
                                          ReturndatafreezedProvider(query));
                                    });
                                  }

                                  //   singleton<AppRouter>().navigatePath('/mcmgmt/bu/$mchtEttyId/list');
                                }
                              });
                            }),
                            sbh10,
                            AcxBackToList(
                                listUrl: '/mcmgmt/bu/$mchtEttyId/list'),
                                sbh10,
                                AcxAuditLogReqBtn('ApiMgmtBusnUnitSave', ettyId: busnUnitEttyId.toString(),)
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ));
        });
  }
}
