import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_autocomplete.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_hiddentext.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_libview.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_text.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';

const int wid=471;

@RoutePage()
class CustEnrollCostCentreProfileGenInfo extends StatelessWidget {
  const CustEnrollCostCentreProfileGenInfo(
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
    return CustEnrollCostCenProfileForm(
      custEttyId: custEttyId,
      costCtrEttyId: costCtrEttyId,
    );
  }
}

class CustEnrollCostCenProfileForm extends ConsumerWidget {
  const CustEnrollCostCenProfileForm(
      {super.key, this.custEttyId, this.costCtrEttyId, this.cmpyEttyId});

  final String? custEttyId;
  final String? costCtrEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    if(costCtrEttyId == 'new'){
    getTitle(
            ref,
            {
              "CustEttyId": custEttyId,
            },
            AppBarTitleType.enroll)
        .then((value) {
      ref.read(appBarTitleProvider.notifier).state = value.toString();
    });
    }else{
    getTitle(
            ref,
            {
              "CostCtrEttyId": costCtrEttyId,
            },
            AppBarTitleType.enroll)
        .then((value) {
      ref.read(appBarTitleProvider.notifier).state = value.toString();
    });
    }


    final custEnrollCmpyFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formValue = {
      "CostCtrEttyId":costCtrEttyId,
      "CustEttyId": custEttyId,
      "CmpyEttyId": cmpyEttyId,
      "Dscp": null,
      "CostCtr": null,
      "MbrCnt": 0,
      "MediaCnt": 0
    };

    //remove CostCtrCnt, MbrCnt, MediaCnt
    final query = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiEnrlCostCtr/queryasync',
        params: {
          "CostCtrEttyId": costCtrEttyId == 'new' ? null : costCtrEttyId,
          //  "CmpyEttyId": cmpyEttyId,
          "CustEttyId": custEttyId
        },
        showMsg: false));
    final formData = ref.watch(query);
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: custEnrollCmpyFormKey,
            initialValue: formValue,
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
                        const FbHiddenText(name: 'Dscp'),
                        const FbHiddenText(name: 'CustEttyId'),
                        const FbHiddenText(name: 'CostCtrEttyId'),
                        SelectableText(S.of(context).lblCostCenterInfo),
                        FbAutoComplete(
                            initialValue: formValue['CostCtr'] ?? '',
                            name: 'CostCtr',
                            label: 'Name',
                            keyField: 'CostCtr',
                            searchText: 'CostCtr',
                            query: QueryObject(
                                querysql: '/sp/ApiEnrlCostCtrList/queryasync',
                                params: {"CustEttyId": custEttyId},
                                showMsg: false)),
                        const Row(
                          children: [
                            Expanded(
                                child: FbText(
                              label: 'Description',
                              name: 'CostCtrDscp',
                              // onChanged: (val) {
                              //   custEnrollCmpyFormKey.currentState!.value['Dscp'] = val;
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
                            initialValue: formValue['CmpyEttyId'],
                            label: 'Attached to Company',
                            params: {"CustEttyId": custEttyId},
                            keyField: 'CmpyEttyId',
                            searchText: 'CompanyName',
                            querySql: '/sp/ApiEnrlCmpyList/queryasync'),
                        const SelectableText(
                            "Cost center Hiearchy consist of..."),
                        sbh10,
                        Wrap(runSpacing: 10, children: [
                          sbw10,
                          AcxNavButton(listOfContent: [
                            const SelectableText('Member'),
                            SelectableText(formValue['MbrCnt'])
                          ], listOfButton: [
                            IconButton(
                                onPressed: () {
                                  singleton<AppRouter>().navigatePath(
                                      '/custenroll/member/$custEttyId/list');
                                },
                                icon: const Icon(Icons.add))
                          ]),
                          sbw10,
                          AcxNavButton(listOfContent: [
                            const SelectableText('Media'),
                            SelectableText(formValue['MediaCnt'])
                          ], listOfButton: [
                            IconButton(
                                onPressed: () {
                                  singleton<AppRouter>().navigatePath(
                                      '/custenroll/media/$custEttyId/list');
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
                        custEnrollCmpyFormKey.currentState!.save();

                        Map<String, dynamic> toPost = Map.from(
                            convertFormValueToSave(
                                custEnrollCmpyFormKey.currentState!.value,
                                theData.columnInfo));
                        toPost['Dscp'] = toPost['CostCtrDscp'];
                        toPost.remove('CostCtrDscp');

                        final querySave = QueryObject(
                            querysql: '/sp/ApiEnrlCostCtrSave/queryasync?logId=${convStrNewOrNullToNull(costCtrEttyId) ?? 0}',
                            params: toPost,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            final costCtrEttyId =
                                getOutputValue(value.output, '@CostCtrEttyId');
                            // singleton<AppRouter>().navigatePath(
                            //   '/custenroll/costcen/$custEttyId/profile/$costCtrEttyId',
                            // );
                            singleton<AppRouter>()
                                .navigatePath(
                              '/custenroll/costcen/$custEttyId/profile/$costCtrEttyId',
                            )
                                .then((val) {
                              ref.invalidate(query);
                            });
                          }
                        });
                      },
                    ),
                    AcxBackToList(
                        listUrl: '/custenroll/costcen/$custEttyId/list'),
                        AcxAuditLogReqBtn('ApiEnrlCostCtrSave',ettyId: costCtrEttyId.toString(),)
                  ]),
                )
              ],
            ));
      },
    );
  }
}
