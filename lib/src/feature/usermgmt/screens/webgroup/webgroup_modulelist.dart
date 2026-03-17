import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=428;

@RoutePage()
class UserMgmtWebGroupModuleList extends ConsumerWidget {
  const UserMgmtWebGroupModuleList(
      {super.key,
      @PathParam('userGrp') this.userGrp,
      @PathParam('userType') this.userType});

  final String? userGrp;
  final String? userType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final userMgmtWebGroupDtlFormKey = GlobalKey<FormBuilderState>();

    var logUser = QueryObject(
        querysql: '/sp/ApiSignInWebGroup/queryasync',
        params: {
          "UserGrp": userGrp,
          "UserType": userType,
        },
        showMsg: false);
    final value = ref.watch(ReturndatafreezedProvider(logUser));
    Map<String, dynamic> formValue = {
      "UserId": null,
      "UserType": convStrNewOrNullToNull(userType),
      "UserGrp": convStrNewOrNullToNull(userGrp),
      "GrpId": null,
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
                            ],
                          ),
                        ),
                        //     signInHistory(isNewUser),
                        Flexible(
                          flex: 2,
                          child: Column(
                            children: [
                              const AcxBackToList(
                                  listUrl: '/usermgmt/webgroup'),
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
                    AcxAuditLogReqBtn('ApiSignInWebGroupSave',),
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
