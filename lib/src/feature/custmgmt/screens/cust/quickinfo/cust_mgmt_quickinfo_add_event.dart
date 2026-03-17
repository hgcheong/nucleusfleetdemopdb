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

const int wid=607;

@RoutePage()
class CustMgmtQuickInfoAddEvent extends StatelessWidget {
  const CustMgmtQuickInfoAddEvent(
      {super.key, @PathParam('custEttyId') this.custEttyId});

  final String? custEttyId;
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
    final isNewUser = convStrNewOrNullToNull(custEttyId);
    return FormBuilder(
      initialValue: formValue,
      child: Column(
        children: [
          Flexible(flex: 2, child: showMediatatus(isNewUser)),
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
          const SelectableText('Resissue/Replace History'),
          sbh20,
          AcxTrinaGridExtData(
              showBorder: false,
              showActions: false,
              extData: stsChangeHist,
              spName: 'ApiMgmtCustList',
              idField: 'UserId',
              onSelectedTap: (TrinaRow val) {}),
        ],
      ),
    );
  }
  return const Spacer(flex: 5);
}

Widget showMediatatus(String? userId) {
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
                SelectableText('Program'),
                SelectableText('Fleet Postpaid'),
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
                SelectableText('Media Category'),
                SelectableText('Vehicle Card'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText('Expiry Date Date'),
                SelectableText('01 Oct 2016'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText('Media Number: 7022 0010 0000 0123'),
                SelectableText(
                    'Mediaholder Gordon Waller (ABC1234D) @ Marvelous Pvt. Ltd. -Sales & Marketing'),
              ],
            ),
          ]),
    );
  }
  return const SelectableText('Add User');
}
