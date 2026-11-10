import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_libview_addr.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

import 'acx_address_controller.dart';
import 'package:nucleusv2/src/core/components/acx_action_spacing.dart';

class AcxAddressForm extends ConsumerWidget {
  const AcxAddressForm(
      {super.key,
      this.ettyId,
      this.contactId,
      this.addrId, 
      this.addrType,
      this.backToListUrl,
      required this.query,
      required this.querySaveSql});

  final String? ettyId;
  final String? addrId;
  final String? contactId;
  final String? addrType;
  final String? backToListUrl;
  final QueryObject query;
  final String querySaveSql;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKeyAddForm = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "EttyId": ettyId,
      "ContactId": convStrNewOrNullToNull(contactId),
      "AddrType": addrType,
      "AddrId": convStrNewOrNullToNull(addrId),
      "BdgName": null,
      "Street1": null,
      "Street2": null,
      "Street3": null,
      "CityCd": null,
      "PostCd": null,
      "CtryCd": null,
      "StateCd": null,
      "MdfDate": null,
      "GeoLoc": null,
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
          return FormBuilder(
              initialValue: formValue,
              key: formKeyAddForm,
              onChanged: () {
                formKeyAddForm.currentState!.save();
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
                              name: 'AddrId',
                              initialValue: formValue['AddrId'],
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
                            FormBuilderField(
                              name: 'ContactId',
                              initialValue: formValue['ContactId'],
                              builder: (FormFieldState f) {
                                return Container();
                              },
                            ),
                            FormBuilderField(
                              name: 'AddrType',
                              initialValue: formValue['AddrType'],
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
                                    Text(formValue['AddrType'] +
                                        ' Address'),
                                    FbField(child: FormBuilderTextField(
                                      name: 'BdgName',
                                      decoration: const InputDecoration(
                                        labelText: 'Building Name',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                    )),
                                    FbField(child: FormBuilderTextField(
                                      name: 'Street1',
                                      decoration: const InputDecoration(
                                        labelText: 'Address Line 1',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                    )),
                                    FbField(child: FormBuilderTextField(
                                      name: 'Street2',
                                      decoration: const InputDecoration(
                                        labelText: 'Address Line 2',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                    )),
                                    FbField(child: FormBuilderTextField(
                                      name: 'Street3',
                                      decoration: const InputDecoration(
                                        labelText: 'Address Line 3',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                    )),
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
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // matches the left column; the blank Text mirrors its title line
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text(" "),
      
                      //   sbh10,
                      //   FbLibView(
                      //   name: 'CityCd',
                      //   label: 'City',
                      //   params: const {},
                      //   keyField: 'RefCd',
                      //   searchText: 'Dscp',
                      //   querySql: '/view/async/VwMyCity',
                      //   initialValue: formValue['CityCd'],
                      // ),
                                  FbLibViewAddrState(
                        name: 'StateCd',
                        label: 'State',
                        params: const {"RefType": "STATE", "BitInd": null},
                        keyField: 'RefCd',
                        searchText: 'Dscp',
                        querySql: '/sp/GetLibRef/queryasyncnouser',
                        initialValue: formValue['StateCd'],
                        returnSelectedRef: (val){     
               
                      formKeyAddForm.currentState!.patchValue({ "CityCd": null});
                       ref.read(myStateCityProvider.notifier).state = val['RefCd'];
                        },
                      ),
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref, Widget? child) { 
                                  final myState = ref.watch(myStateCityProvider);
                                    return FbLibView(
                                                      name: 'CityCd',
                                                      label: 'City',
                                                    //  params: myState == "" ? {} : {"view":"and RefType like '$myState%'"},
                                                      params: myState == "" ?  formValue['StateCd'] == null ? {}:{"view":"and RefType like '${formValue['StateCd']}%'"} : {"view":"and RefType like '$myState%'"},
                                                      keyField: 'RefCd',
                                                      searchText: 'Dscp',
                                                      querySql: '/view/async/VwMyCity/addcond',
                                                      initialValue: formValue['CityCd'],
                                                    );
                               },
                            ),
                            FbNumber(name: 'PostCd', label: 'Post Code', maxLength: 5,),
                      //                  FormBuilderTextField(
                      //   name: 'PostCd',
                      //   decoration: const InputDecoration(
                      //     labelText: 'Post Code',
                      //     floatingLabelBehavior: FloatingLabelBehavior.always,
                      //   ),
                      // ),
                      //     sbh10,
          
                      // FbLibView(
                      //   name: 'CityCd',
                      //   label: 'City',
                      //   params: const {},
                      //   keyField: 'RefCd',
                      //   searchText: 'Dscp',
                      //   querySql: '/view/async/VwMyCity',
                      //   initialValue: formValue['CityCd'],
                      // ),
                      // //     sbh10,
                      // FbLibView(
                      //   name: 'StateCd',
                      //   label: 'State',
                      //   params: const {"RefType": "STATE", "BitInd": null},
                      //   keyField: 'RefCd',
                      //   searchText: 'Dscp',
                      //   querySql: '/sp/GetLibRef/queryasyncnouser',
                      //   initialValue: formValue['StateCd'],
                      // ),
                      //    sbh10,
                      FbLibView(
                        name: 'CtryCd',
                        label: 'Country',
                        params: const {"RefType": "Ctry", "BitInd": null},
                        keyField: 'RefCd',
                        searchText: 'Dscp',
                        querySql: '/sp/GetLibRef/queryasyncnouser',
                        initialValue: formValue['CtryCd'],
                      ),
                  
                      FormBuilderField(
                        name: 'GeoLoc',
                        //  initialValue: addrType,
                        builder: (FormFieldState f) {
                          return Container();
                        },
                      ),

                    ])),
                  ),
                  sbw10,
                  Flexible(
                    flex: 2,
                    child: Column(children: [
                      AcxSaveButtonManual(onSave: () {
                        formKeyAddForm.currentState!.save();
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            Map.from(formKeyAddForm.currentState!.value),
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
                                  final addrId =
                                      getOutputValue(value.output, '@AddrId');
                                      
                                  singleton<AppRouter>()
                                      .navigatePath(
                                    './adddtl/$addrType/$contactId/$addrId',
                                  )
                                      .then((va0) {
                                    ref.invalidate(
                                        ReturndatafreezedProvider(query));
                                         
                                  });
                                  
                                }
                        });
                      }),
                      AcxBackToList(listUrl: backToListUrl.toString()),
                           AcxActionSpacing(child: ElevatedButton(onPressed: (){
                               formKeyAddForm.currentState!.save();
                        final myVal = formKeyAddForm.currentState!.value;
                       ref.read(addCopyProvider.notifier).state = {
                          "BdgName": myVal["BdgName"],
                        "Street1": myVal["Street1"],
                         "Street2": myVal["Street2"],
                          "Street3": myVal["Street3"],
                        "StateCd": myVal["StateCd"],
                           "CityCd": myVal["CityCd"],
                         "CtryCd": myVal["CtryCd"],
                          "PostCd": myVal["PostCd"]
                       };

                      },       child: const SizedBox(width: 30, child: Tooltip(
                        message: 'Copy',
                        child: Icon(Icons.copy))),)),
                      AcxActionSpacing(child: ElevatedButton(onPressed: (){
                        
                        final myVal = ref.read(addCopyProvider.notifier).state;
                      ref.read(myStateCityProvider.notifier).state = myVal["StateCd"];
                  formKeyAddForm.currentState!.patchValue(
                    {
                     "BdgName": myVal["BdgName"],
                      "Street1": myVal["Street1"],
                      "Street2": myVal["Street2"],
                          "Street3": myVal["Street3"],
                        "StateCd": myVal["StateCd"],
                           "CityCd": myVal["CityCd"],
                         "CtryCd": myVal["CtryCd"],
                          "PostCd": myVal["PostCd"]
                    });

                      }, child: const SizedBox(width: 30, child: Tooltip(
                        message: 'Paste',
                        child: Icon(Icons.paste))),)),
                      AcxAuditLogReqBtn(querySaveSql,ettyId: formValue['AddrId'].toString(),),
                    ]),
                  )
                ],
              ));
        },
        error: (x, e) => Center(child: Text(e.toString()),),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

//adddtl/ROC/269





final addCopyProvider = StateProvider<Map<String, dynamic>>((ref){
  return {
    "BdgName":"",
    "Street1":"",
    "Street2":"",
    "Street3":"",
    "StateCd":"",
    "CityCd":null,
    "CtryCd":null,
    "PostCd":""
  };
});