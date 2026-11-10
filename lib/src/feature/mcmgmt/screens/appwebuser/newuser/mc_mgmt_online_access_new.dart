import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=693;

@RoutePage()
class MchtMgmtOnlineAccessNew extends ConsumerWidget {
  const MchtMgmtOnlineAccessNew(
      {super.key,
      @PathParam.inherit('ettyId') this.ettyId,
      @PathParam('webId') this.webId,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? mchtEttyId;
  final String? ettyId;
  final String? webId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mcmtNewUserKey = GlobalKey<FormBuilderState>();

    final formNewValue = {
      "MchtEttyId": mchtEttyId,
      "EttyId": ettyId,
      "WebId": convStrNewOrNullToNull(webId),
      "SignIn": null,
      "Role": null,
      "FirstName": null,
      "LastName": null,
      "FullName":null,
      "MobileNo": null,
      "Email": null,
      "UserSts": null,
    };

    return FormBuilder(
      key: mcmtNewUserKey,
      initialValue: formNewValue,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SelectableText(
                              'Add a new User',
                              //     style: hdrStyle,
                            ),
                          ),
                          const FbText(name: 'SignIn', label: "Sign In"),
                          const FbText(name: 'FullName', label: "Name"),
                          const FbHiddenText(name: 'FirstName'),
                          const FbHiddenText(name: 'LastName'),
                        //  const FbText(name: 'LastName', label: "Last Name"),
                          const FbText(name: 'MobileNo', label: "Mobile No"),
                          const FbText(name: 'Email', label: 'Email'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.email),
                                sbw10,
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const SelectableText(
                                        'Send Invitation')),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Card(
                    child: ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SelectableText(
                            'User Access',
                            //  style: hdrStyle,
                          ),
                        ),
                        const SelectableText('Associate an Entity to the User'),
                        // FbLibViewExt(
                        //   name: '',
                        //   label: 'Access Level',
                        //   searchText: 'CmpyName',
                        //   keyField: 'UserId',
                        //   datasrc: dropDownViewStatement,
                        // ),
                        FbLibView(
                          name: 'EttyType',
                          querySql: '/sp/ApiMgmtMchtUserTypeList/queryasync',
                          params: {"MchtEttyId": mchtEttyId},
                          label: 'Entity',
                          searchText: 'Dscp',
                          keyField: 'RefCd',
                        ),
                        FbLibView(
                          name: 'EttyType',
                          querySql: '/sp/ApiMgmtMchtUserTypeList/queryasync',
                          params: {"MchtEttyId": mchtEttyId},
                          label: 'Entity',
                          searchText: 'Dscp',
                          keyField: 'RefCd',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(flex: 5),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                AcxSaveButtonManual(onSave: () {
                    if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                  Toast.message("Not Allowed");
                }),
                const AcxBackToList(
                  listUrl: '././list',
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
