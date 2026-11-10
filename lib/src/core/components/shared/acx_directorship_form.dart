import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_number1to100wdecimal.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class AcxDirectorShipForm extends ConsumerWidget {
  const AcxDirectorShipForm(
      {super.key,
      this.ettyId,
      this.indvdId,
      this.backToListUrl,
      required this.query,
      required this.querySaveSql});

  final String? ettyId;
  final String? indvdId;
  final String? backToListUrl;
  final QueryObject query;
  final String querySaveSql;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "EttyId": ettyId,
      "IndvdId": convStrNewOrNullToNull(indvdId),
      "Title": null,
      "FullName": null,
      "Directorship": null,
      "ShareClass": null,
      "ShareHolding": null,
      "DirectorshipSts": null,
      "MdfDate": null,
      "MobileNo": null,
      "WorkPhoneNo": null,
      "WorkPhoneExt": null,
      "WorkEmail": null,
      "PsnlEmail": null,
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return formData.when(
        data: (theData) {
          if (theData.data != null) {
            formValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
            
          } else {
            // formValue = formValue;
          }
          return SingleChildScrollView(
            child: SizedBox(
              height: 1280,
              child: FormBuilder(
                  initialValue: formValue,
                  key: formKey,
                  onChanged: () {
                    formKey.currentState!.save();
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
                                  name: 'IndvdId',
                                  initialValue: formValue['IndvdId'],
                                  builder: (FormFieldState f) {
                                    return Container();
                                  },
                                ),
                                FormBuilderField(
                                  name: 'MdfDate',
                                  initialValue: formValue['MdfDate'],
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
                                      
                                       Text('Director Info'),
                                       sbh10,
                                       Row(
                                         children: [
                                           Expanded(
                                            flex:4,
                                             child: FbLibView(
                                                                       name: 'Title',
                                                                       label: 'Title',
                                                                       labelStyle: getFormTextStyle('Title', theData.columnInfo),
                                                                       params: const {"RefType": "Title", "BitInd": null},
                                                                       keyField: 'RefCd',
                                                                       searchText: 'Dscp',
                                                                       querySql: '/sp/GetLibRef/queryasyncnouser',
                                                                       initialValue: formValue['Title'],
                                                                     ),
                                                                     
                                           ),fbFieldGap,    Expanded(
                                                  flex: 8,
                                                   child: FbLibView(
                                                                       name: 'Directorship',
                                                                       label: 'Directorship',
                                                                       params: const {"RefType": "ShareDirectorShip", "BitInd": null},
                                                                       keyField: 'RefCd',
                                                                       searchText: 'Dscp',
                                                                       querySql: '/sp/GetLibRef/queryasyncnouser',
                                                                       initialValue: formValue['Directorship'],
                                                                     ),
                                                 )
                                                
                                         ],
                                       ),
                                       Row(children: [ Expanded(
                                                flex: 8,
                                                 child: FbField(child: FormBuilderTextField(
                                                                                           name: 'FullName',
                                                                                           decoration: const InputDecoration(
                                                                                             labelText: 'Name',
                                                                                             floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                                                                           ),
                                                                                         )),
                                               ),],),
                                    
                                  
                                                 Row(
                                                   children: [
                                          Expanded(
                                                          flex: 4,
                                                           child: FbNumber1to100withDecimal(
                                                                                                     name: 'ShareHolding',
                                                                                                label: 'Share Holding %',
                                                                                                   ),
                                                         ),
                                                          fbFieldGap,
                                                     Expanded(
                                                      flex: 8,
                                                       child: FbLibView(
                                                                       name: 'ShareClass',
                                                                       label: 'ShareClass',
                                                                       params: const {"RefType": "ShareClass", "BitInd": null},
                                                                       keyField: 'RefCd',
                                                                       searchText: 'Dscp',
                                                                       querySql: '/sp/GetLibRef/queryasyncnouser',
                                                                       initialValue: formValue['ShareClass'],
                                                                     ),
                                                     ),
                                                    
                                                        ],
                                                 ),
                                          Row(children: [
                                                         Expanded(child:FbLibView(
                            name: 'PsnlIdType',
                            label: S.of(context).lblTypeOfId,
                            params: const {
                              "RefType": "PsnlIdType",
                              "BitInd": null
                            },
                            keyField: "RefCd",
                            searchText: "Dscp",
                            querySql: '/sp/GetLibRef/queryasyncnouser')),
                            fbFieldGap,
                        Expanded(child:FbText(name: 'PsnlId', label: S.of(context).lblIDNumber)),
                        fbFieldGap,
                                            Expanded(
                                              child: FbLibView(
                                                                         name: 'DirectorshipSts',
                                                                         label: 'Status',
                                                                         params: const {"RefType": "DirectorshipSts", "BitInd": null},
                                                                         keyField: 'RefCd',
                                                                         searchText: 'Dscp',
                                                                         querySql: '/sp/GetLibRef/queryasyncnouser',
                                                                         initialValue: formValue['DirectorshipSts'],
                                                                       ),
                                            ),
                                          ],),
                                          
                                  
                                      
                                          sbh20,
                                            Text('Email'),
                                            sbh10,
                                            FbText(
                                              name: "WorkEmail",
                                              label: "Work Email",
                                              initialValue: formValue['WorkEmail'],
                                            ),
                                               FbText(
                                              name: "PsnlEmail",
                                              label: "Personal Email",
                                              initialValue: formValue['PsnlEmail'],
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
                                                      formValue['WorkPhoneNo'],
                                                )),
                                                fbFieldGap,
                                                        
                                                Flexible(
                                                    child: FbText(
                                                  name: "WorkPhoneExt",
                                                  label: "Work Phone Ext",
                                                  initialValue:
                                                      formValue['WorkPhoneExt'],
                                                )),
                                                 fbFieldGap, Flexible(
                                                child: FbText(
                                              name: "FaxNo",
                                              label: "Fax No.",
                                              initialValue: formValue['FaxNo'],
                                            )),
                                             
                                        
                                              ],
                                            ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: FbText(
                                                name: "MobileNo1",
                                                label: "Mobile No.1",
                                                initialValue: formValue['MobileNo1'],
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
                                                initialValue: formValue['MobileNo2'],
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
                                                initialValue: formValue['MobileNo3'],
                                              ),
                                            ),
                                                  sbw10,    
                                  
                                          ],
                                        ),
                                      ],
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
                            formKey.currentState!.save();
              
                            Map<String, dynamic> toPost = convertFormValueToSave(
                                Map.from(formKey.currentState!.value),
                                theData.columnInfo);
                            final saveResult = ref.read(ReturndatafreezedProvider(
                                    QueryObject(
                                        querysql: querySaveSql,
                                        params: toPost,
                                        showMsg: false))
                                .future);
                            saveResult.then((Returndata value) {
                                   Toast.showresult(value);
                                   if (isSuccess(value.message)) {
                                      final indvdId =
                                          getOutputValue(value.output, '@IndvdId');
                                          
                                      singleton<AppRouter>()
                                          .navigatePath(
                                        './director/directordtl/$indvdId',
                                      )
                                          .then((va0) {
                                        ref.invalidate(
                                            ReturndatafreezedProvider(query));
                                             
                                      });
                                      
                                    }
                            });
                          }),
                          AcxBackToList(listUrl: backToListUrl.toString()),
                       AcxAuditLogReqBtn(querySaveSql,ettyId: formValue['IndvdId'].toString(),),
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

//adddtl/ROC/269



final myStateCityProvider = StateProvider<String>((ref) {
  return "";
});