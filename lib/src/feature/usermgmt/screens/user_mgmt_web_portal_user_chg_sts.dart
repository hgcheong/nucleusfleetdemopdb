import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=266;

@RoutePage()
class UserMgmtWebPortalUserChangeStatus extends BaseScreen {
  const UserMgmtWebPortalUserChangeStatus(
      {super.key, @PathParam('userId') this.userId});

  final String? userId;
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }

  @override
  Widget sideTab() {
    return provideSideTab("");
  }

  @override
  Widget sideBar() {
   return provideSideBar("usermgmt/nucleususer");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("usermgmt/webportaluser");
  }

  Widget buildView() {
    return Scaffold(
      body: toReturn(),
      appBar: AppBar(
        centerTitle: false,
        title: const SelectableText('Web Portal Access Control'),
      ),
    );
  }

  Widget toReturn() {
    Map<String, dynamic> formValue = {
      "UserId": null,
      "FirstName": null,
      "LastName": null,
      "FullName":null,
      "Role": null,
      "Access Rights Group": null
    };
    final isNewUser = convStrNewOrNullToNull(userId);
    return FormBuilder(
      initialValue: formValue,
      child: Column(
        children: [
          Flexible(flex: 2, child: showUserStatus(isNewUser)),
          Flexible(
            flex: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FbLibViewExt(
                        name: '',
                        label: 'Change Status to...',
                        searchText: 'CmpyName',
                        keyField: 'UserId',
                        datasrc: dropDownAccessRightsGroup,
                      ),
                      const FbDateTimePicker(name: '', label: 'Effective Date'),
                      FbLibViewExt(
                        name: '',
                        label: 'Reason to Change',
                        searchText: 'CmpyName',
                        keyField: 'UserId',
                        datasrc: dropDownValue,
                      ),
                      const Flexible(
                          child: FbText(
                        name: '',
                        label: 'Remarks',
                      )),
                      const Expanded(
                          child: FbText(
                        name: '',
                        label: 'Created By',
                      )),
                    ],
                  ),
                ),
                signInHistory(isNewUser),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      AcxSaveButtonManual(onSave: () {
                          if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                      }),
                      const AcxBackToList(listUrl: '/usermgmt/webportaluser'),
                      PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (val) {},
                        itemBuilder: (context) {
                          return const <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'OTP',
                              child: SelectableText('Change Status'),
                            ),
                            PopupMenuItem<String>(
                              value: 'OTPLIST',
                              child: SelectableText('Reset Password'),
                            ),
                            PopupMenuItem<String>(
                              value: 'OTPLIST',
                              child: SelectableText('Reset Failed Count'),
                            ),
                          ];
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Returndata passwordOption = Returndata.fromJson({
  "data": [
    {
      "RefType": "BUSNSEGMT",
      "RefCd": "ADVERTISE",
      "Dscp": "Strong Password",
      "BitInd": 0,
      "Sts": "A"
    },
    {
      "RefType": "BUSNSEGMT",
      "RefCd": "AGRI",
      "Dscp": "Password Never Expired",
      "BitInd": 0,
      "Sts": "A"
    },
  ],
  "output": [
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 2,
  "columnInfo": [
    {
      "title": "RefType",
      "data": "RefType",
      "dataType": "varchar",
      "visible": true
    },
    {"title": "RefCd", "data": "RefCd", "dataType": "varchar", "visible": true},
    {"title": "Dscp", "data": "Dscp", "dataType": "nvarchar", "visible": true},
    {
      "title": "BitInd",
      "data": "BitInd",
      "dataType": "bigint",
      "visible": true
    },
    {"title": "Sts", "data": "Sts", "dataType": "varchar", "visible": true}
  ],
  "message": null,
  "error": null
});

Returndata dropDownValue = Returndata.fromJson({
  "data": [
    {
      "CmpyName": "Administrator",
      "RgstionNo": "Kelly@gmail.com",
      "CustName": "Administrator",
      "SubmtDate": "0",
      "AppvDate": "Active",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "CustEttyId": 16
    },
    {
      "CmpyName": "1234567890",
      "RgstionNo": "Ben@yahoo.com",
      "CustName": "System User",
      "SubmtDate": "0",
      "AppvDate": "Blocked",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "UserId": 17
    },
  ],
  "output": [
    {"parameter": "@ColCnt", "value": 7.0},
    {"parameter": "@MsgId", "value": 10001},
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 2,
  "columnInfo": [
    {
      "title": "User Id",
      "data": "CmpyName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Email",
      "data": "RgstionNo",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "Role",
      "data": "CustName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Sign-In Failed",
      "data": "SubmtDate",
      "dataType": "bigint",
      "visible": true
    },
    {
      "title": "Status",
      "data": "AppvDate",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Creation Date",
      "data": "CrtionDate",
      "dataType": "datetime",
      "visible": true
    },
    {
      "title": "UserId",
      "data": "UserId",
      "dataType": "bigint",
      "visible": false
    }
  ],
  "message": {
    "msgId": 10001,
    "dscp": "Record Exists",
    "msgSeverity": 0,
    "bitInd": 0
  },
  "error": null
});

Returndata dropDownAccessRightsGroup = Returndata.fromJson({
  "data": [
    {
      "CmpyName": "Administrator",
      "RgstionNo": "Kelly@gmail.com",
      "CustName": "Administrator",
      "SubmtDate": "0",
      "AppvDate": "Active",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "CustEttyId": 16
    },
    {
      "CmpyName": "1234567890",
      "RgstionNo": "Ben@yahoo.com",
      "CustName": "System User",
      "SubmtDate": "0",
      "AppvDate": "Blocked",
      "CrtionDate": "2023-08-27T00:24:48.54",
      "UserId": 17
    },
  ],
  "output": [
    {"parameter": "@ColCnt", "value": 7.0},
    {"parameter": "@MsgId", "value": 10001},
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 2,
  "columnInfo": [
    {
      "title": "User Id",
      "data": "CmpyName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Email",
      "data": "RgstionNo",
      "dataType": "varchar",
      "visible": true
    },
    {
      "title": "Role",
      "data": "CustName",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Sign-In Failed",
      "data": "SubmtDate",
      "dataType": "bigint",
      "visible": true
    },
    {
      "title": "Status",
      "data": "AppvDate",
      "dataType": "nvarchar",
      "visible": true
    },
    {
      "title": "Creation Date",
      "data": "CrtionDate",
      "dataType": "datetime",
      "visible": true
    },
    {
      "title": "UserId",
      "data": "UserId",
      "dataType": "bigint",
      "visible": false
    }
  ],
  "message": {
    "msgId": 10001,
    "dscp": "Record Exists",
    "msgSeverity": 0,
    "bitInd": 0
  },
  "error": null
});

Returndata _stsChangeHist = Returndata.fromJson({
  "data": [
    {
      "1": "31 Oct 2017 13:13:13",
      "2": "Suspend",
      "3": "Active",
      "4": "ToActive",
      "5": "admin",
      "UserId": 16
    },
  ],
  "output": [
    {"parameter": "@ColCnt", "value": 5.0},
    {"parameter": "@MsgId", "value": 10001},
    {"parameter": "@Return_Value", "value": 0}
  ],
  "rowcount": 1,
  "columnInfo": [
    {
      "title": "Date of Change",
      "data": "1",
      "dataType": "nvarchar",
      "visible": true
    },
    {"title": "From", "data": "2", "dataType": "varchar", "visible": true},
    {"title": "To", "data": "3", "dataType": "nvarchar", "visible": true},
    {"title": "Reason", "data": "4", "dataType": "nvarchar", "visible": true},
    {"title": "User", "data": "5", "dataType": "nvarchar", "visible": true},
    {
      "title": "UserId",
      "data": "UserId",
      "dataType": "bigint",
      "visible": false
    }
  ],
  "message": {
    "msgId": 10001,
    "dscp": "Record Exists",
    "msgSeverity": 0,
    "bitInd": 0
  },
  "error": null
});

Widget signInHistory(String? userId) {
  if (userId != null) {
    return Flexible(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SelectableText('Status Change History'),
          sbh20,
          AcxTrinaGridExtData(
              showBorder: false,
              showActions: false,
              extData: _stsChangeHist,
              spName: 'ApiEnrlCustList',
              idField: 'UserId',
              onSelectedTap: (TrinaRow val) {}),
        ],
      ),
    );
  }
  return const Spacer(flex: 5);
}

Widget showUserStatus(String? userId) {
  if (userId != null) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: DbColors.primary,
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText('User ID'),
                SelectableText('Kelly@gmail.com'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText('Current Status'),
                SelectableText('Active'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText('Failed Attempt Sign In'),
                SelectableText('5'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText('Creation Date'),
                SelectableText('01 Oct 2016'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText('Block Date'),
                SelectableText(''),
              ],
            ),
          ]),
    );
  }
  return const SelectableText('Add User');
}
