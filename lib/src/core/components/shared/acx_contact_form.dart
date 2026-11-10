import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

import '../../../utils/utils_import.dart';
import 'package:nucleusv2/src/core/components/acx_action_spacing.dart';

class AcxContactForm extends ConsumerWidget {
  const AcxContactForm({
    super.key,
    this.ettyId,
    this.contactId,
    this.contactType,
    required this.backToListUrl,
    required this.query,
    required this.querySaveSql,
    this.isShowInvite = false,
    this.isShowResendEmail = false,
  });

  final String? ettyId;
  final String? contactId;
  final String? contactType;
  final String? backToListUrl;
  final QueryObject query;
  final String querySaveSql;
  final bool isShowInvite ;
  final bool isShowResendEmail ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKeyContactForm = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formNewValue = {
      "FullName":null,
      "Dsgntion": null,
      "WorkEmail": null,
      "PsnlEmail": null,
      "MobileNo1": null,
      "MobileNo2": null,
      "MobileNo3": null,
      "RocNo": null,
      "WorkPhoneNo": null,
      "WorkPhoneExt": null,
      "FaxNo": null,
      "ContactSts":"A",
      "EttyId": ettyId,
      "ContactTypeDscp":null,
      "ContactType": contactType,
      "ContactId": convStrNewOrNullToNull(contactId),
      "MdfDate": null
    };
    final formData = ref.watch(ReturndatafreezedProvider(query));

    return formData.when(
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          } else {
            formNewValue = formNewValue;
          }
          return SingleChildScrollView(
            child: SizedBox(
              height: 1280,
              child: FormBuilder(
                  initialValue: formNewValue,
                  key: formKeyContactForm,
                  onChanged: () {
                    formKeyContactForm.currentState!.save();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                FormBuilderField(
                                  name: 'EttyId',
                                  initialValue: ettyId,
                                  builder: (FormFieldState f) {
                                    return Container();
                                  },
                                ),
                                FormBuilderField(
                                  name: 'MdfDate',
                                  initialValue: formNewValue['MdfDate'],
                                  builder: (FormFieldState f) {
                                    return Container();
                                  },
                                ),
                                FormBuilderField(
                                  name: 'ContactId',
                                  initialValue: formNewValue['ContactId'],
                                  builder: (FormFieldState f) {
                                    return Container();
                                  },
                                ),
                                FormBuilderField(
                                  name: 'ContactType',
                                  initialValue: formNewValue['ContactType'],
                                  builder: (FormFieldState f) {
                                    return Container();
                                  },
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${formNewValue['ContactTypeDscp'] ?? contactType} Contact'),
                                        sbh10,
                                        FbLibref(
                                    label: 'Title',
                                    name: 'Title',
                                    params: {
                                  "RefType": "TITLE",
                                  "BitInd": null
                                }),
                                   
                                        Row(children: [
              Flexible(
                                              child: FbText(
                                                name: 'FullName',
                                                label: 'Name',
                                                initialValue:
                                                    formNewValue['FullName'],
                                              ),
                                            ),
                                        ],),
                                             FbLibView(
                                          name: 'Dsgntion',
                                          label: 'Designation',
                                          params: const {
                                            "RefType": "Dsgntion",
                                            "BitInd": null
                                          },
                                          keyField: 'RefCd',
                                          searchText: 'Dscp',
                                          querySql:
                                              '/sp/GetLibRef/queryasyncnouser',
                                          initialValue: formNewValue['Dsgntion'],
                                        ),
                                                          FbLibView(
                                          name: 'ContactSts',
                                          label: 'Status',
                                          initialValue: formNewValue
                                              ['ContactSts']
                                              .toString(),
                                          keyField: 'RefCd',
                                          params: const {
                                            "RefType": "ContactSts",
                                            "BitInd": null
                                          },
                                          searchText: 'Dscp',
                                          querySql:
                                              '/sp/GetLibRef/queryasyncnouser',
                                        ),
                                     
                                        sbh20,
                                        Text('Email'),
                                        sbh10,
                                        FbText(
                                          name: "WorkEmail",
                                          label: "Work Email",
                                          initialValue: formNewValue['WorkEmail'],
                                        ),
                                           FbText(
                                          name: "PsnlEmail",
                                          label: "Personal Email",
                                          initialValue: formNewValue['PsnlEmail'],
                                        ),
                                        sbh20,
                                        Text('Contact No.'),
                                        sbh10,
                                        Row(
                                          children: [
                                            Flexible(
                                                child: FbText(
                                              name: "WorkPhoneNo",
                                              label: "Work Phone No.",
                                              initialValue:
                                                  formNewValue['WorkPhoneNo'],
                                            )),
                                            fbFieldGap,
                                                    
                                            Flexible(
                                                child: FbText(
                                              name: "WorkPhoneExt",
                                              label: "Work Phone Ext",
                                              initialValue:
                                                  formNewValue['WorkPhoneExt'],
                                            )),
                                            fbFieldGap, Flexible(
                                                child: FbText(
                                              name: "FaxNo",
                                              label: "Fax No.",
                                              initialValue: formNewValue['FaxNo'],
                                            )),
                                    
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: FbText(
                                                name: "MobileNo1",
                                                label: "Mobile No.1",
                                                initialValue: formNewValue['MobileNo1'],
                                              ),
                                            ),
                                                  sbw10,    
                                         
                                          ],
                                        ),
                                             Row(
                                          children: [
                                            Flexible(
                                              child: FbText(
                                                name: "MobileNo2",
                                                label: "Mobile No.2",
                                                initialValue: formNewValue['MobileNo2'],
                                              ),
                                            ),
                                                  sbw10,    
                                      
                                          ],
                                        ),
                                             Row(
                                          children: [
                                            Flexible(
                                              child: FbText(
                                                name: "MobileNo3",
                                                label: "Mobile No.3",
                                                initialValue: formNewValue['MobileNo3'],
                                              ),
                                            ),
                                                  sbw10,    
                                  
                                          ],
                                        ),
                                   
                                        sbh20,
                                        
                                        isShowInvite ?    
                     Row(
                       children: [
               ElevatedButton(
                child: Text('Email Customer Portal Invitation'),
                onPressed: (){
                  final queryInv = QueryObject(querysql: '/sp/ApiSignInExt/queryasyncnouser', params: 
                    {  "SignIn": formNewValue['WorkEmail'], 
                     "ReqType": "SETUP",  
                     "FullName": formNewValue['FullName'],
                     "MobileNo": formNewValue['MobileNo1'],  
                    "Email": formNewValue['WorkEmail'],  
                    "PwdHash": "t0nTflPYn1YBESD4dCJTTn4Ep0eNZ25wwX/XLhGc2dUcEA0igOAx0KJUrz7AD2Xkk2tav2ZVoryditGl6gG7HGdgazuV0bfugO0S+33zILzbliyymX2NisyjfQgEXWBb7RMjMtBd/+ghirCLrNrg9lBGMQlQsLUX3lViMeVEwCTIHzUloQqgCrOgElXvT6IaRi3qWmyUuo1XW9rD52Lc8LJY7QXv/nA/rRlmzIgjo3yMjJ/93PJRentzRKo2ErhuHt+y6yuX8o/V5ozzTVeKjWEMdt9V7jYOlzOEG3VZIPrrm5B/w6qYbWGbjtJYSzR0TGuoimP8pqeV0c5kDLNleg=="} 
                  , showMsg: false);
                final invResult =  ref.read(ReturndatafreezedProvider(queryInv).future);
                   invResult.then((Returndata value) {
                                  Toast.showresult(value);
                                  if (isSuccess(value.message)) {
                                    ref.invalidate(ReturndatafreezedProvider(query));
                                  }
                                });
                  }
                  )
            
                       ],
                     ):Container(),
isShowResendEmail ? Row(children: [          ElevatedButton(
                child: Text('Resend Email'),
                onPressed: (){
                  final queryInv = QueryObject(querysql: '/sp/ApiSignInExt/queryasyncnouser', params: 
                    { 
                      "SignIn":formNewValue['WorkEmail'],
                     "ReqType": "RELINK",  
                    "Email": null},  
                    showMsg: false);
                final invResult =  ref.read(ReturndatafreezedProvider(queryInv).future);
                   invResult.then((Returndata value) {
                                  Toast.showresult(value);
                                  if (isSuccess(value.message)) {
                                    ref.invalidate(ReturndatafreezedProvider(query));
                                  }
                                });
                  }
                  ),],):Container()                                  ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(children: [
                          AcxSaveButtonManual(onSave: () {
                            formKeyContactForm.currentState!.save();
                            // Map<String, dynamic> toSave = formKey.currentState!.value;
                            // toSave = convertFormDateTimeValue(toSave, ['MdfDate']);
                            Map<String, dynamic> toPost = convertFormValueToSave(
                                Map.from(formKeyContactForm.currentState!.value),
                                theData.columnInfo);
                                toPost.remove('ContactTypeDscp');
                            final saveResult = ref.read(ReturndatafreezedProvider(
                                    QueryObject(
                                        querysql: querySaveSql,
                                        params: toPost,
                                        showMsg: false))
                                .future);
                            saveResult.then((Returndata value) {
                   
                               Toast.showresult(value);
                                       if (isSuccess(value.message)) {
                                  final outContactId =
                                      getOutputValue(value.output, '@ContactId');
                                      
                                  singleton<AppRouter>()
                                      .navigatePath(
                                    './contactdtl/$contactType/$outContactId',
                                  )
                                      .then((va0) {
                                    ref.invalidate(
                                        ReturndatafreezedProvider(query));
                                         
                                  });
                               
                                }
                              
                            });
                          }),
                                       AcxBackToList(listUrl: backToListUrl.toString()),
                          // AcxSaveButton(
                                   AcxActionSpacing(child: ElevatedButton(onPressed: (){
                               formKeyContactForm.currentState!.save();
                        final myVal = formKeyContactForm.currentState!.value;
                       ref.read(contactCopyContactProvider.notifier).state = {
                        "Title":myVal["Title"],
                          "FullName":myVal["FullName"],
                      "Dsgntion": myVal["Dsgntion"],
                      "WorkEmail": myVal["WorkEmail"],
                      "PsnlEmail": myVal["PsnlEmail"],
                      "MobileNo1": myVal["MobileNo1"],
                      "MobileNo2": myVal["MobileNo2"],
                      "MobileNo3": myVal["MobileNo3"],
                      "WorkPhoneNo": myVal["WorkPhoneNo"],
                      "WorkPhoneExt": myVal["WorkPhoneExt"],
                      "FaxNo": myVal["FaxNo"],
                      "ContactSts":myVal["ContactSts"]
                       };

                      },       child: const SizedBox(width: 30, child: Tooltip(
                        message: 'Copy',
                        child: Icon(Icons.copy))),)),
               
                      AcxActionSpacing(child: ElevatedButton(onPressed: (){
                        
                        final myVal = ref.read(contactCopyContactProvider.notifier).state;
    
                  formKeyContactForm.currentState!.patchValue(
                    {
                      "Title":myVal["Title"],
                      "FullName":myVal["FullName"],
                      "Dsgntion": myVal["Dsgntion"],
                      "WorkEmail": myVal["WorkEmail"],
                      "PsnlEmail": myVal["PsnlEmail"],
                      "MobileNo1": myVal["MobileNo1"],
                      "MobileNo2": myVal["MobileNo2"],
                      "MobileNo3": myVal["MobileNo3"],
                      "WorkPhoneNo": myVal["WorkPhoneNo"],
                      "WorkPhoneExt": myVal["WorkPhoneExt"],
                      "FaxNo": myVal["FaxNo"],
                      "ContactSts":myVal["ContactSts"]
                    });

                      }, child: const SizedBox(width: 30, child: Tooltip(
                        message: 'Paste',
                        child: Icon(Icons.paste))),)),
                    
                      AcxAuditLogReqBtn(querySaveSql,ettyId: formNewValue['ContactId'].toString(),),
                         
                        ]),
                      )
                    ],
                  )),
            ),
          );
        },
        error: (x, e) => Center(child: Text(e.toString()),),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

final contactCopyContactProvider= StateProvider<Map<String, dynamic>>((ref){
  return {
     "Title":null,
     "FullName":null,
      "Dsgntion": null,
      "WorkEmail": null,
      "PsnlEmail": null,
      "MobileNo1": null,
      "MobileNo2": null,
      "MobileNo3": null,
      "WorkPhoneNo": null,
      "WorkPhoneExt": null,
      "FaxNo": null,
      "ContactSts":null,
  };
});