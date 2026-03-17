import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';


const int wid=580;

@RoutePage()
class CustMgmtCostCentreProfileGenInfo extends StatelessWidget {
  const CustMgmtCostCentreProfileGenInfo(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('costCtrEttyId') this.costCtrEttyId});

  final String? custEttyId;
  final String? costCtrEttyId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return CustMgmtCostCenProfileForm(
      custEttyId: custEttyId,
      costCtrEttyId: costCtrEttyId,
    );
  }
}

class CustMgmtCostCenProfileForm extends ConsumerWidget {
  const CustMgmtCostCenProfileForm(
      {super.key, this.custEttyId, this.costCtrEttyId, this.cmpyEttyId});

  final String? custEttyId;
  final String? costCtrEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final custMgmtCmpyFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formNewValue = {
      "CostCtrEttyId": costCtrEttyId,
      "CustEttyId": custEttyId,
      "CmpyEttyId": cmpyEttyId,
      "Dscp": null,
      "CostCtr": null,
      "MbrCnt": 0,
      "MediaCnt": 0
    };

    //remove CostCtrCnt, MbrCnt, MediaCnt

    final formData = ref.watch(ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtCostCtr/queryasync',
        params: {
          "CostCtrEttyId": costCtrEttyId == 'new' ? null : costCtrEttyId,
          //  "CmpyEttyId": cmpyEttyId,
          "CustEttyId": custEttyId
        },
        showMsg: false)));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: custMgmtCmpyFormKey,
            initialValue: formNewValue,
            child: Row(
              children: [
                //   "TaxCtgry": null,

                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FbHiddenText(name: 'Dscp'),
                        const FbHiddenText(name: 'CustEttyId'),
                        const FbHiddenText(name: 'CostCtrEttyId'),
                        SelectableText(S.of(context).lblCostCenterInfo),
                          FbAutoComplete(
                            initialValue: formNewValue['CostCtr'] ?? '',
                            name: 'CostCtr',
                            label: 'Name',
                            keyField: 'CostCtr',
                            searchText: 'CostCtr',
                            query: QueryObject(
                                querysql: '/sp/ApiMgmtCostCtrList/queryasync',
                                params: {"CustEttyId": custEttyId},
                                showMsg: false)),
                        const Row(
                          children: [
                            Expanded(
                                child: FbText(
                              label: 'Description',
                              name: 'CostCtrDscp',
                              // onChanged: (val) {
                              //   custMgmtCmpyFormKey.currentState!.value['Dscp'] = val;
                              // },
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(S.of(context).lblHierarchyGroup),
                        FbLibView(
                            name: 'CmpyEttyId',
                            initialValue: formNewValue['CmpyEttyId'],
                            label: 'Attached to Company',
                            params: {"CustEttyId": custEttyId},
                            keyField: 'CmpyEttyId',
                            searchText: 'CmpyName',
                            querySql: '/sp/ApiMgmtCmpyList/queryasync'),
                        const SelectableText(
                            "Cost center Hiearchy consist of..."),
                        sbh10,
                        Wrap(runSpacing: 10, children: [
                          sbw10,
                          AcxNavButton(listOfContent: [
                            const SelectableText('Member'),
                            SelectableText(formNewValue['MbrCnt'].toString())
                          ], listOfButton: [
                            IconButton(
                                onPressed: () {
                                  ref
                                      .read(menuSideTabSelectProvider.notifier)
                                      .state = S.current.tabMember;
                                  singleton<AppRouter>().navigatePath(
                                      '/custmgmt/member/$custEttyId/list');
                                },
                                icon: const Icon(Icons.add))
                          ]),
                          sbw10,
                          AcxNavButton(listOfContent: [
                            const SelectableText('Media'),
                            SelectableText(formNewValue['MediaCnt'].toString())
                          ], listOfButton: [
                            IconButton(
                                onPressed: () {
                                  ref
                                      .read(menuSideTabSelectProvider.notifier)
                                      .state = S.current.tabMedia;
                                  singleton<AppRouter>().navigatePath(
                                      '/custmgmt/media/$custEttyId/list');
                                },
                                icon: const Icon(Icons.add))
                          ]),
                        ]),
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
                        custMgmtCmpyFormKey.currentState!.save();

                        Map<String, dynamic> toPost = Map.from(
                            convertFormValueToSave(
                                custMgmtCmpyFormKey.currentState!.value,
                                theData.columnInfo));
                        toPost['Dscp'] = toPost['CostCtrDscp'];
                        toPost.remove('CostCtrDscp');

                        final querySave = QueryObject(
                            querysql: '/sp/ApiMgmtCostCtrSave/queryasync?logId=${convStrNewOrNullToNull(costCtrEttyId) ?? 0}',
                            params: toPost,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            final costCtrEttyId =
                                getOutputValue(value.output, '@CostCtrEttyId');
                            singleton<AppRouter>().navigatePath(
                              '/custmgmt/costcen/$custEttyId/profile/$costCtrEttyId',
                            );
                          }
                        });
                      },
                    ),
                    sbh10,
                    AcxBackToList(listUrl: '/custmgmt/costcen/$custEttyId/list'),
                    sbh10,
                    AcxAuditLogReqBtn('ApiMgmtCostCtrSave', ettyId: costCtrEttyId.toString(),)

                  ]),
                )
              ],
            ));
      },
    );
  }
}
