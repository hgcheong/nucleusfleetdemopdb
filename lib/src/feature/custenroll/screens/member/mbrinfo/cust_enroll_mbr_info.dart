import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';

const int wid=521;

@RoutePage()
class CustEnrollMemberInfo extends HookConsumerWidget {
  const CustEnrollMemberInfo(
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
    if(mbrEttyId == 'new'){
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
              "MbrEttyId": mbrEttyId,
            },
            AppBarTitleType.enroll)
        .then((value) {
      ref.read(appBarTitleProvider.notifier).state = value.toString();
    });
    }
  
    return Center(
      child: CustEnrollMemberInfoForm(
        custEttyId: custEttyId,
        mbrEttyId: mbrEttyId,
      ),
    );
  }
}

class CustEnrollMemberInfoForm extends ConsumerWidget {
  const CustEnrollMemberInfoForm({super.key, this.custEttyId, this.mbrEttyId});

  final String? custEttyId;
  final String? mbrEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final custEnrollCmpyFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formValue = {
      "CustEttyId": custEttyId,
      "MbrEttyId": mbrEttyId,
      "CostCtr": null,
      "MbrCnt": 0,
      "MediaCnt": 0,
      "MbrRnk": null
    };
    final query = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiEnrlMbr/queryasync',
        params: {
          "MbrEttyId": mbrEttyId == 'new' ? null : mbrEttyId,
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
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FbHiddenText(name: 'CustEttyId'),
                        const FbHiddenText(name: 'MbrEttyId'),
                        SelectableText(S.of(context).tabMembership),
                        const FbLibView(
                            name: 'VipCd',
                            label: 'VIP Code',
                            params: {"RefType": "VIPIND", "BitInd": null},
                            keyField: 'RefCd',
                            searchText: 'Dscp',
                            querySql: '/sp/GetLibRef/queryasyncnouser'),
                        const FbLibView(
                            name: 'MbrRnk',
                            label: 'Member Rank',
                            params: {},
                            keyField: 'MbrRnk',
                            searchText: 'Dscp',
                            querySql: '/view/async/vwlibmbrrnk'),
                        const SelectableText("Member Hiearchy consist of..."),
                        sbh10,
                        Wrap(runSpacing: 10, children: [
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
                          searchText: 'CmpyName',
                          querySql: '/sp/ApiEnrlMbrCmpyList/queryasync',
                          // onClearPress: () {
                          //   //Below will never be triggered unless we provide a global key so we will moved to back to list to clear the selection
                          //   ref.read(mbrCostCenterProvider.notifier).state = {"CustEttyId": null, "CmpyEttyId": null};
                          // },
                          returnSelectedRef: (val) {
                            ref.read(mbrCostCenterProvider.notifier).state = {
                              "CustEttyId": val["CustEttyId"],
                              "CmpyEttyId": val["CmpyEttyId"]
                            };
                          },
                        ),
                        const DynamicDostCentre()
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

                        final querySave = QueryObject(
                            querysql: '/sp/ApiEnrlMbrSave/queryasync',
                            params: toPost,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            final mbrEttyId =
                                getOutputValue(value.output, '@MbrEttyId');
                            singleton<AppRouter>()
                                .navigatePath(
                              '/custenroll/member/$custEttyId/detail/$mbrEttyId/memberinfo/membership',
                            )
                                .then((val) {
                              ref.invalidate(query);
                            });
                          }
                        });
                      },
                    ),
                    AcxBackToList(
                      listUrl: '/custenroll/member/$custEttyId/list',
                      fnBeforeNav: () {
                        ref.read(mbrCostCenterProvider.notifier).state = {
                          "CustEttyId": null,
                          "CmpyEttyId": null
                        };
                      },
                    ),
                    AcxAuditLogReqBtn('ApiEnrlMbrSave', ettyId: mbrEttyId.toString(),)
                  ]),
                )
              ],
            ));
      },
    );
  }
}

class DynamicDostCentre extends ConsumerWidget {
  const DynamicDostCentre({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final val = ref.watch(mbrCostCenterProvider);
    final queryObject = QueryObject(
        querysql: '/sp/ApiEnrlMbrCostCtrList/queryasync',
        params: val,
        showMsg: false);
    final dataSrc = ref.watch(ReturndatafreezedProvider(queryObject));
    return AsyncValueWidget(
        value: dataSrc,
        data: (re) {
          if (re.data![0]['CostCtrEttyId'] == null) {
            return const Row(
              children: [
                Expanded(
                    child: SelectableText('Please create cost Center Code')),
                Expanded(
                    child: FbHiddenText(
                  name: 'CostCtrEttyId',
                )),
              ],
            );
          } else {
            return FbLibViewExt(
              name: 'CostCtrEttyId',
              datasrc: re,
              initialValue: null,
              label: 'Attached to Cost Centre',
              keyField: 'CostCtrEttyId',
              searchText: 'CostCtrDscp',
              returnSelectedRef: (Map<String, dynamic> val) {
                //   Toast.message(val.toString());
              },
            );
          }
        });
  }
}

final mbrCostCenterProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {"CustEttyId": null, "CmpyEttyId": null};
});
