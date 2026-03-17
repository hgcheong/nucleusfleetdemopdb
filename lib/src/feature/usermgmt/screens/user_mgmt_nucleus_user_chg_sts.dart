import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/mockdata.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=255;

@RoutePage()
class UserMgmtNucleusUserChangeStatus extends StatelessWidget {
  const UserMgmtNucleusUserChangeStatus(
      {super.key, @PathParam('userId') this.userId});

  final String? userId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
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
                      sbh10,
                      const AcxBackToList(listUrl: '/usermgmt/nucleususer/'),
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
              extData: stsChangeHist,
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
      color: Colors.blue,
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
