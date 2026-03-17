import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckoruncheck.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=425;

@RoutePage()
class UserMgmtWebGroupDtl extends ConsumerWidget {
  const UserMgmtWebGroupDtl(
      {super.key,
      @PathParam('userGrp') this.userGrp,
      @PathParam('userType') this.userType,
       @PathParam('grpId') this.grpId
      });

  final String? userGrp;
  final String? userType;
  final String? grpId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final userMgmtWebGroupDtlFormKey = GlobalKey<FormBuilderState>();

    var logUser = QueryObject(
        querysql: '/sp/ApiSignInWebGroup/queryasync',
        params: {
          "GrpId": grpId,
          "UserType": userType,
        },
        showMsg: false);
    final value = ref.watch(ReturndatafreezedProvider(logUser));
    Map<String, dynamic> formValue = {
      "UserId": null,
      "UserType": convStrNewOrNullToNull(userType),
      "UserGrp": convStrNewOrNullToNull(userGrp),
      "GrpId": grpId,
      "MdfDate": null
    };

    //final isNewUser = convStrNewOrNullToNull(userId);
    return AsyncValueWidget(
      value: value,
      data: (theData) {
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return SingleChildScrollView(
          child: SizedBox(
            height: 1200,
            child: FormBuilder(
              key: userMgmtWebGroupDtlFormKey,
              initialValue: formValue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //   Flexible(flex: 2, child: showUserStatus(isNewUser)),
                  Flexible(
                    flex: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FbHiddenDateTime(name: 'MdfDate'),
                              const FbHiddenText(name: 'GrpId'),
                              const FbText(
                                  name: 'UserGrp', label: 'User Group'),
                              FbLibViewExt(
                                name: 'UserType',
                                label: 'User Type',
                                searchText: 'Dscp',
                                keyField: 'RefCd',
                                datasrc: userTypeData,
                              ),
                              sbh10,
                              formValue['GrpId'] == null
                                  ? Container()
                                  : ElevatedButton.icon(
                                      label: const Text('Template Setup'),
                                      onPressed: () async {
                                        Set<TrinaRow> selectedItems =
                                            await showAcxDialog(
                                                context,
                                                WebGroupTemplate(
                                                    grpId: formValue['GrpId'],
                                                    userType:
                                                        formValue['UserType']));
                                        if (selectedItems.isEmpty) {
                                          return;
                                        }
                                        for (TrinaRow element
                                            in selectedItems) {
                                          final assigned = element
                                              .cells['AssignedInd']!.value
                                              .toString();
                                          final moduleId = element
                                              .cells['ModuleId']!.value
                                              .toString();
                                          final userType = element
                                              .cells['UserType']!.value
                                              .toString();
                                          final grpId = element
                                              .cells['GrpId']!.value
                                              .toString();
                                          final setupId = element
                                              .cells['SetupId']!.value
                                              .toString();
                                          updateWebGroupModuleTemplate(
                                              assigned,
                                              moduleId,
                                              userType,
                                              grpId,
                                              setupId,
                                              ref);
                                        }
                                        Toast.message('Updated');
                                      },
                                      icon: const Icon(Icons.list))
                            ],
                          ),
                        ),
                        sbw10,
                        //     signInHistory(isNewUser),
                        Flexible(
                          flex: 2,
                          child: Column(
                            children: [
                              const AcxBackToList(
                                  listUrl: '/usermgmt/webgroup'),
                              sbh10,
                              AcxSaveButtonManual(onSave: () {
                                  if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                                userMgmtWebGroupDtlFormKey.currentState!.save();
                                Map<String, dynamic> toPost =
                                    convertFormValueToSave(
                                        Map.from(userMgmtWebGroupDtlFormKey
                                            .currentState!.value),
                                        theData.columnInfo);
                                final querySave = QueryObject(
                                    querysql:
                                        '/sp/ApiSignInWebGroupSave/queryasync',
                                    params: toPost,
                                    showMsg: false);
                                final saveResult = ref.read(
                                    ReturndatafreezedProvider(querySave)
                                        .future);
                                saveResult.then((Returndata value) {
                                  Toast.showresult(value);
                                  if (isSuccess(value.message)) {
                                    //   String theNewId = getOutputValue(value.output, '@MsgTypePlanId').toString();
                                    singleton<AppRouter>()
                                        .navigatePath(
                                            '/usermgmt/webgroup/dtl/${toPost['UserGrp']}/${toPost['UserType']}')
                                        .then((val) {
                                      ref.invalidate(
                                          ReturndatafreezedProvider(logUser));
                                    });
                                  }
                                });
                              }),
                                   sbh10,
                            AcxAuditLogReqBtn('ApiSignInWebGroupSave',)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Returndata userTypeData = Returndata.fromJson({
  "data": [
    {
      "RefCd": "I",
      "Dscp": "Internal",
    },
    {
      "RefCd": "E",
      "Dscp": "External",
    },
  ],
  "output": [
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 2,
  "columnInfo": [
    {"title": "RefCd", "data": "RefCd", "dataType": "varchar", "visible": true},
    {"title": "Dscp", "data": "Dscp", "dataType": "nvarchar", "visible": true},
    {
      "title": "BitInd",
      "data": "BitInd",
      "dataType": "bigint",
      "visible": true
    },
  ],
  "message": null,
  "error": null
});

class WebGroupTemplate extends ConsumerWidget {
  const WebGroupTemplate({super.key, this.userType, this.grpId});

  final String? userType;
  final String? grpId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiSignInTmplModuleList/queryasync',
        params: {"GrpId": grpId, "UserType": userType},
        showMsg: false));
    final listData = ref.watch(listQuery);
    // final toNavUrl = '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/control/translimt/detail';
    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          final theWidget = AcxTrinaGridExtDataCheckOrUncheck(
            spName: 'ApiSignInTmplModuleList',
            idField: 'ModuleId',
            extData: dv,
            isMultiSelect: true,
            checkIndicatorField: 'AssignedInd',
          );
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Row(
                    children: [Text('Template Setup')],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(flex: 10, child: theWidget),
                      sbw10,
                      Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    singleton<AppRouter>().maybePop(
                                        theWidget.checkedOrUncheckedItem.value);
                                  },
                                  child: const Icon(Icons.save)),
                              sbh20,
                              ElevatedButton(
                                onPressed: () {
                                  theWidget.checkedOrUncheckedItem.value
                                      .clear();
                                  singleton<AppRouter>().maybePop(
                                      theWidget.checkedOrUncheckedItem.value);
                                },
                                child: const Icon(
                                  Icons.exit_to_app,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

void updateWebGroupModuleTemplate(String indicator, String moduleId,
    String userType, String grpId, String setupId, WidgetRef ref) {
  final query = QueryObject(
      querysql: indicator == 'Y'
          ? '/sp/ApiSignInTmplModuleSave/queryasync'
          : '/sp/ApiSignInTmplModuleDel/queryasync',
      params: {
        "ModuleId": moduleId,
        "UserType": userType,
        "GrpId": grpId,
        "SetupId": setupId
      },
      showMsg: false);
  final result = ref.read(ReturndatafreezedProvider(query).future);
  result.then((value) {
    if (!isSuccess(value.message)) {
      Toast.showresult(value);
    }
  });
  // resultDel.then((value) {
  //     ref.invalidate(ReturndatafreezedProvider(query));
  //   //  Toast.showresult(value);
  // });
}

// {
//     "ModuleId": 46,
//     "UserType":"I",
//      "GrpId": 1,
//   },
