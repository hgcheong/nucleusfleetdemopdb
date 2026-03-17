import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_libview_addr.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_numberregex.dart';
import 'package:nucleusv2/src/core/components/shared/acx_address_controller.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:url_launcher/url_launcher.dart';


const int wid=888;

@RoutePage()
class SystemConfigSite extends ConsumerWidget {
  const SystemConfigSite({super.key, @PathParam('siteId') this.siteId});

  final String? siteId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   var toSavesiteId = convStrNewOrNullToNull(siteId);
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }

    final formKeysystemConfigSite = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
    "SiteId":toSavesiteId,
	"SiteName":null,
	"Street1":null,
	"Street2":null,
	"Street3":null,
	"CityCd":null,
	"PostCd":null,
	"StateCd":null,
	"GeoLoc":null,
	"ContactNo"	:null,
	"BusnTimeFrom": null,
	"BusnTimeTo": null,
	"IconMart": null,
	"IconCc": null,
	"IconWash": null,
	"IconEuro5": null,
	"IconEpay": null,
	"IconTnG": null,
  "Lat":null,
  "Long":null,
  "Sts":"A",
};
final qo = QueryObject(querysql: '/sp/ApiMgmtSite/queryasync', params: {
  "SiteId":toSavesiteId
}, showMsg: false);
final qres = ref.watch(ReturndatafreezedProvider(qo));
    //final isNewUser = convStrNewOrNullToNull(userId);
    return qres.when(data: (theData){
     
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
              if(theData.data![0]["GeoLoc"]!=null){
                var latLong =  getLatLong(theData.data![0]["GeoLoc"]);
                formValue["Lat"] = latLong.split(',').first;
                formValue["Long"] = latLong.split(',').last;
              }
        }
        return FormBuilder(
          key: formKeysystemConfigSite,
          initialValue: formValue,
          
          child: ListView(
           // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //   Flexible(flex: 2, child: showUserStatus(isNewUser)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [         
                        Text("Site Info")  ,
                        Row(
                          children: [
                               Expanded(
                              child: FbText(
                                                              name: 'SiteId',
                                                              label: 'Site Id',
                                                            ),
                            ),
                          ],
                        ),
              
                                                            FbText(
                                                        name: 'Street1',
                                                        label: 'Address Line 1',
                                                      ),
                                                            FbText(
                                                        name: 'Street2',
                                                        label: 'Address Line 2',
                                                      ),
                                                            FbText(
                                                        name: 'Street3',
                                                        label: 'Address Line 3',
                                                      ),
                                                
                                                                     Row(
                                                                       children: [
                                                                         Expanded(child: FbNumberRegex(name: 'Lat', label: 'Latitude (-90 to 90 )')),
                                                                         sbw10,
                                                                             Expanded(child: FbNumberRegex(name: 'Long',label:'Longtitude (-180 to 180)')),
                                                                       ],
                                                                     ),
                                                                     sbh10,
            
                                                      Text("Operation Time"),
                                                          const Row(
                  children: [
                    Flexible(
                        child: FbTimePicker(
                            label: 'From Time', name: 'BusnTimeFrom')),
                            sbw10,
                    Flexible(
                      child: FbTimePicker(
                        label: 'To Time',
                        name: 'BusnTimeTo',
                      ),
                    ),
                  ],
                ),
                 
                Text("Services"),
                             
                      
                          ],
                    ),
                  ),
                  sbw10,
                  Flexible(flex: 5,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                             
                      Text("Additional Info"),
                                     FbText(
                                                                     name: 'SiteName',
                                                                     label: 'Site Name',
                                                                   ),
                
                                        FbLibViewAddrState(
                        name: 'StateCd',
                        label: 'State',
                        params: const {"RefType": "STATE", "BitInd": null},
                        keyField: 'RefCd',
                        searchText: 'Dscp',
                        querySql: '/sp/GetLibRef/queryasyncnouser',
                        initialValue: formValue['StateCd'],
                        returnSelectedRef: (val){     

                         formKeysystemConfigSite.currentState!.patchValue({ "CityCd": null});
                       //  formKeysystemConfigSite.currentState!.save();
                                   ref.read(myStateCityProvider.notifier).state = val['RefCd'];

                        },
                      ),
                         Consumer(
                              builder: (BuildContext context, WidgetRef ref, Widget? child) { 
                                  final myState = ref.watch(myStateCityProvider);
                                    return FbLibView(
                                      onClearPress: (){
                                          formKeysystemConfigSite.currentState!.patchValue({ "CityCd": null});
                                      },
                                                      name: 'CityCd',
                                                      label: 'City',
                                                    //  params: myState == "" ? {} : {"view":"and RefType like '$myState%'"},
                                                      params: myState == "" ?  formValue['StateCd'] == null ? {}:{"view":"and RefType like '${formValue['StateCd']}%'"} : {"view":"and RefType like '$myState%'"},
                                                      keyField: 'RefCd',
                                                      searchText: 'Dscp',
                                                      querySql: '/view/async/VwMyCity/addcond',
                                                    );
                               },
                            ),     const FbText(
                            name: 'PostCd', label: 'Post Code'),
                   FbText(
                                                   name: 'ContactNo',
                                                   label: 'Contact Number',
                                                 ),
                                                   FbLibView(
                                          name: 'Sts',
                                          label: 'Status',
                                          params: const {
                                            "RefType": "SiteSts",
                                            "BitInd": null
                                          },
                                          keyField: 'RefCd',
                                          searchText: 'Dscp',
                                          querySql:
                                              '/sp/GetLibRef/queryasyncnouser',
                                          initialValue: formValue['Sts'],
                                        ),

                FormBuilderField(
                  name: 'GeoLoc',
                  //  initialValue: addrType,
                  builder: (FormFieldState f) {
                    return Container();
                  },
                ),
                  ],),),
                  sbw10,
                  //     signInHistory(isNewUser),
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                     
                      
                        AcxSaveButtonManual(onSave: () {
                            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                            Toast.message("Action Not Authorised");
                            return;
                          }
                          formKeysystemConfigSite.currentState!.save();
                  Map<String, dynamic> toPost = convertFormValueToSave(
                      Map.from(formKeysystemConfigSite.currentState!.value),
                      theData.columnInfo);
                       if(!isValidLongitude(toPost['Long'])){
                        Toast.message("Invalid Longtitude. Value must be between -180 to 180");
                        return;
                       }

                        if(!isValidLatitude(toPost['Lat'])){
                        Toast.message("Invalid Longtitude. Value must be between -90 to 90");
                        return;
                       }



                      if(toPost['Lat'].toString().isNotNullAndNotEmpty && toPost['Long'].toString().isNotNullAndNotEmpty){
                        toPost["GeoLoc"] = "Point (${toPost['Long']} ${toPost['Lat']})";
                      }

                      toPost.remove('Lat');
                      toPost.remove('Long');
                  final saveResult = ref.read(ReturndatafreezedProvider(
                          QueryObject(
                              querysql: '/sp/ApiMgmtSiteSave/queryasync',
                              params: toPost,
                              showMsg: false))
                      .future);
                  saveResult.then((Returndata? value) {
                    if(value==null){
                      return;
                    }
                    Toast.showresult(value);
                    if (isSuccess(value.message)) {
                            if (context.mounted) {
                      
                              String? outSiteId = getOutputValueStr(value.output, '@SiteId');
                      
                      singleton<AppRouter>()
                          .navigatePath('/systemconfig/site/dtl/$outSiteId')
                          .then((val) {
                      
                        ref.invalidate(
                            ReturndatafreezedProvider(qo));
                      });
                    }
                    }
                  });
                        }),
                              sbh10,
                          AcxBackToList(
                            fnBeforeNav: (){
                                    ref.read(myStateCityProvider.notifier).state = "";
                            },
                            listUrl: '/systemconfig/site/list'),
                            sbh10,
                            AcxAuditLogReqBtn('ApiMgmtSiteSave', ettyId: siteId.toString())
                      ],
                    ),
                  )
                ],
              ),
                 Wrap(
                             
                 
                     // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 110,
                          child: FormBuilderChoiceChips(
                            tooltip: 'Euro 5 Diesel',
                              name: 'IconEuro5',
                              options: [
                                FormBuilderChipOption(
                                  value: "1",
                                 child: Image.asset('assets/images/BEuro5.png',height: 25,),
                                ),
                              ]),
                        ),
                     
                        SizedBox(width: 110,
                          child: FormBuilderChoiceChips(
                            tooltip: 'BH Petrol Mart',
                              name: 'IconMart',
                              options:  [
                                FormBuilderChipOption(
                                  value: "1",
                                  child: Image.asset('assets/images/BMarket.png',height: 25,),
                                ),
                              ]),
                        ),
                              
                        SizedBox(
                          width: 110,
                          child: FormBuilderChoiceChips(
                            tooltip: 'ATM',
                              name: 'IconATM',
                              options:  [
                                FormBuilderChipOption(
                                  value: "1",
                                         child: Image.asset('assets/images/BATM.png',height: 25,),
                                ),
                              ]),
                        ),
                           
                                           SizedBox(width: 110,
                                             child: FormBuilderChoiceChips(
                                              tooltip: 'Food',
                                                 name: 'IconFood',
                                                 options:  [
                                                   FormBuilderChipOption(
                                                     value: "1",
                                                 child: Image.asset('assets/images/BFood.png',height: 25,),
                                                   ),
                                                 ]),
                                           ),
                              
                        SizedBox(width: 110,
                          child: FormBuilderChoiceChips(
                            tooltip: 'Car Wash',
                              name: 'IconWash',
                              options:  [
                                FormBuilderChipOption(
                                  value: "1",
                          child: Image.asset('assets/images/BCarWash.png',height: 25,),
                                ),
                              ]),
                        ),
                           
                            SizedBox(width: 110,
                              child: FormBuilderChoiceChips(
                                tooltip: 'EV',
                                  name: 'IconEV',
                                  options:  [
                                    FormBuilderChipOption(
                                      value: "1",
                              child: Image.asset('assets/images/BGreen.png',height: 25,),
                                    ),
                                  ]),
                            ),
                    
                      
                            SizedBox(width: 110,
                              child: FormBuilderChoiceChips(
                                tooltip: 'Touch n Go',
                                  name: 'IconTnG',
                                  options: [
                                    FormBuilderChipOption(
                                      value: "1",
                                      child: Image.asset('assets/images/BTng.png',height: 25,),
                                    ),
                                  ]),
                            ),
                     
                        SizedBox(width: 110,
                          child: FormBuilderChoiceChips(
                            tooltip: 'Touch ‘n Go Spot (formerly Touch ‘n Go Customer Services Centre)',
                              name: 'IconTnGSpot',
                              options: [
                                FormBuilderChipOption(
                                  value: "1",
                                  child: Image.asset('assets/images/tngspot.png',height: 25,),
                                ),
                              ]),
                        ),
                        SizedBox(width: 110,
                          child: FormBuilderChoiceChips(
                            tooltip: 'ePay',
                              name: 'IconEpay',
                              options: [
                                FormBuilderChipOption(
                                  value: "1",
                              child: Image.asset('assets/images/BePay.png',height: 25,),
                                ),
                              ]),
                        ),
                     
                      ]),
                      sbh10,
                      Row(children: [
                        (formValue["GeoLoc"] == "" ||  formValue["GeoLoc"] == null) ? Container(): ElevatedButton(onPressed: ()async {
                           final url = Uri.parse("https://www.google.com/maps/?q=${getLatLong(formValue["GeoLoc"])}");
          
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
                        }, child: Row(children: [
                          Icon(Icons.map_rounded),
                          sbw10,
                            Text('Show Location')
                        ],)),
                        // SizedBox(height: 500,
                        //   child: HtmlWidget(
                        //               '<iframe width="425" height="350" src="https://www.openstreetmap.org/export/embed.html?bbox=103.25823426246644%2C1.9912786809715337%2C103.27615141868593%2C2.001325499002224&amp;layer=mapnik&amp;marker=1.9963020976626833%2C103.26719284057617" style="border: 1px solid black"></iframe><br/><small><a href="https://www.openstreetmap.org/?mlat=1.996302&amp;mlon=103.267193#map=13/1.97232/103.25673">View Larger Map</a></small>',
                        //               factoryBuilder: () => MyWidgetFactory(),
                        //             ),
                        // ),
                      ],)
            ],
          ),
        );
    },       error: (x, e) => Center(child: Text(e.toString()),),
        loading: () => const Center(child: CircularProgressIndicator()));
    // return AsyncValueWidget(
    //   value: qres,
    //   data: (theData) {
    //     if (theData.data != null) {
    //       formValue = convertFormValueToDisplay(
    //           theData.data![0] as Map<String, dynamic>, theData.columnInfo);
    //           if(theData.data![0]["GeoLoc"]!=null){
    //             var latLong =  getLatLong(theData.data![0]["GeoLoc"]);
    //             formValue["Long"] = latLong.split(',').first;
    //             formValue["Lat"] = latLong.split(',').last;
    //           }
    //     }
    //     return FormBuilder(
    //       key: formKeysystemConfigSite,
    //       initialValue: formValue,
          
    //       child: ListView(
    //        // crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           //   Flexible(flex: 2, child: showUserStatus(isNewUser)),
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Flexible(
    //                 flex: 5,
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [         
    //                     Text("Site Info")  ,
    //                     Row(
    //                       children: [
    //                            Expanded(
    //                           child: FbText(
    //                                                           name: 'SiteId',
    //                                                           label: 'Site Id',
    //                                                         ),
    //                         ),
    //                       ],
    //                     ),
              
    //                                                         FbText(
    //                                                     name: 'Street1',
    //                                                     label: 'Address Line 1',
    //                                                   ),
    //                                                         FbText(
    //                                                     name: 'Street2',
    //                                                     label: 'Address Line 2',
    //                                                   ),
    //                                                         FbText(
    //                                                     name: 'Street3',
    //                                                     label: 'Address Line 3',
    //                                                   ),
                                                
    //                                                                  Row(
    //                                                                    children: [
    //                                                                      Expanded(child: FbText(name: 'Lat', label: 'Latitude')),
    //                                                                      sbw10,
    //                                                                          Expanded(child: FbText(name: 'Long',label:'Longtitude',)),
    //                                                                    ],
    //                                                                  ),
    //                                                                  sbh10,
            
    //                                                   Text("Operation Time"),
    //                                                       const Row(
    //               children: [
    //                 Flexible(
    //                     child: FbTimePicker(
    //                         label: 'From Time', name: 'BusnTimeFrom')),
    //                         sbw10,
    //                 Flexible(
    //                   child: FbTimePicker(
    //                     label: 'To Time',
    //                     name: 'BusnTimeTo',
    //                   ),
    //                 ),
    //               ],
    //             ),
                 
    //             Text("Services"),
                             
                      
    //                       ],
    //                 ),
    //               ),
    //               sbw10,
    //               Flexible(flex: 5,child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
                             
    //                   Text("Additional Info"),
    //                                  FbText(
    //                                                                  name: 'SiteName',
    //                                                                  label: 'Site Name',
    //                                                                ),
                
    //                                     FbLibViewAddrState(
    //                     name: 'StateCd',
    //                     label: 'State',
    //                     params: const {"RefType": "STATE", "BitInd": null},
    //                     keyField: 'RefCd',
    //                     searchText: 'Dscp',
    //                     querySql: '/sp/GetLibRef/queryasyncnouser',
    //                     initialValue: formValue['StateCd'],
    //                     returnSelectedRef: (val){     
               
    //                   formKeysystemConfigSite.currentState!.patchValue({ "CityCd": null});
    //                    ref.read(myStateCityProvider.notifier).state = val['RefCd'];
    //                     },
    //                   ),
    //                      Consumer(
    //                           builder: (BuildContext context, WidgetRef ref, Widget? child) { 
    //                               final myState = ref.watch(myStateCityProvider);
    //                                 return FbLibView(
    //                                                   name: 'CityCd',
    //                                                   label: 'City',
    //                                                 //  params: myState == "" ? {} : {"view":"and RefType like '$myState%'"},
    //                                                   params: myState == "" ?  formValue['StateCd'] == null ? {}:{"view":"and RefType like '${formValue['StateCd']}%'"} : {"view":"and RefType like '$myState%'"},
    //                                                   keyField: 'RefCd',
    //                                                   searchText: 'Dscp',
    //                                                   querySql: '/view/async/VwMyCity/addcond',
    //                                                   initialValue: formValue['CityCd'],
    //                                                 );
    //                            },
    //                         ),     const FbText(
    //                         name: 'PostCd', label: 'Post Code'),
    //             //     sbh10,
               
    //             //    sbh10,
    //             // FbLibView(
    //             //   name: 'CtryCd',
    //             //   label: 'Country',
    //             //   params: const {"RefType": "CtryCd", "BitInd": null},
    //             //   keyField: 'RefCd',
    //             //   searchText: 'Dscp',
    //             //   querySql: '/sp/GetLibRef/queryasyncnouser',
    //             //   initialValue: formValue['CtryCd'],
    //             // ),
    //                FbText(
    //                                                name: 'ContactNo',
    //                                                label: 'Contact Number',
    //                                              ),
    //                                                FbLibView(
    //                                       name: 'Sts',
    //                                       label: 'Status',
    //                                       params: const {
    //                                         "RefType": "SiteSts",
    //                                         "BitInd": null
    //                                       },
    //                                       keyField: 'RefCd',
    //                                       searchText: 'Dscp',
    //                                       querySql:
    //                                           '/sp/GetLibRef/queryasyncnouser',
    //                                       initialValue: formValue['Sts'],
    //                                     ),

    //             FormBuilderField(
    //               name: 'GeoLoc',
    //               //  initialValue: addrType,
    //               builder: (FormFieldState f) {
    //                 return Container();
    //               },
    //             ),
    //               ],),),
    //               sbw10,
    //               //     signInHistory(isNewUser),
    //               Flexible(
    //                 flex: 2,
    //                 child: Column(
    //                   children: [
                     
                      
    //                     AcxSaveButtonManual(onSave: () {
    //                         if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
    //                         Toast.message("Action Not Authorised");
    //                         return;
    //                       }
    //                       formKeysystemConfigSite.currentState!.save();
    //               Map<String, dynamic> toPost = convertFormValueToSave(
    //                   Map.from(formKeysystemConfigSite.currentState!.value),
    //                   theData.columnInfo);
    //                   if(toPost['Lat'].toString().isNotNullAndNotEmpty && toPost['Long'].toString().isNotNullAndNotEmpty){
    //                     toPost["GeoLoc"] = "Point (${toPost['Lat']} ${toPost['Long']})";
    //                   }
    //                   toPost.remove('Lat');
    //                   toPost.remove('Long');
    //               final saveResult = ref.read(ReturndatafreezedProvider(
    //                       QueryObject(
    //                           querysql: '/sp/ApiMgmtSiteSave/queryasync',
    //                           params: toPost,
    //                           showMsg: false))
    //                   .future);
    //               saveResult.then((Returndata? value) {
    //                 if(value==null){
    //                   return;
    //                 }
    //                 Toast.showresult(value);
    //                 if (isSuccess(value.message)) {
    //                         if (context.mounted) {
                      
    //                           String? outSiteId = getOutputValueStr(value.output, '@SiteId');
                      
    //                   singleton<AppRouter>()
    //                       .navigatePath('/systemconfig/site/dtl/$outSiteId')
    //                       .then((val) {
                      
    //                     ref.invalidate(
    //                         ReturndatafreezedProvider(qo));
    //                   });
    //                 }
    //                 }
    //               });
    //                     }),
    //                           sbh10,
    //                       AcxBackToList(
    //                         fnBeforeNav: (){
    //                                 ref.read(myStateCityProvider.notifier).state = "";
    //                         },
    //                         listUrl: '/systemconfig/site/list'),
    //                         sbh10,
    //                         AcxAuditLogReqBtn('ApiMgmtSiteSave', ettyId: siteId.toString())
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //              Wrap(
                             
                 
    //                  // crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     SizedBox(width: 110,
    //                       child: FormBuilderChoiceChips(
    //                           name: 'IconEuro5',
    //                           options: [
    //                             FormBuilderChipOption(
    //                               value: "1",
    //                              child: Image.asset('assets/images/BEuro5.png',height: 25,),
    //                             ),
    //                           ]),
    //                     ),
                     
    //                     SizedBox(width: 110,
    //                       child: FormBuilderChoiceChips(
    //                           name: 'IconMart',
    //                           options:  [
    //                             FormBuilderChipOption(
    //                               value: "1",
    //                               child: Image.asset('assets/images/BMarket.png',height: 25,),
    //                             ),
    //                           ]),
    //                     ),
                              
    //                     SizedBox(
    //                       width: 110,
    //                       child: FormBuilderChoiceChips(
    //                           name: 'IconATM',
    //                           options:  [
    //                             FormBuilderChipOption(
    //                               value: "1",
    //                                      child: Image.asset('assets/images/BATM.png',height: 25,),
    //                             ),
    //                           ]),
    //                     ),
                           
    //                                        SizedBox(width: 110,
    //                                          child: FormBuilderChoiceChips(
    //                                              name: 'IconFood',
    //                                              options:  [
    //                                                FormBuilderChipOption(
    //                                                  value: "1",
    //                                              child: Image.asset('assets/images/BFood.png',height: 25,),
    //                                                ),
    //                                              ]),
    //                                        ),
                              
    //                     SizedBox(width: 110,
    //                       child: FormBuilderChoiceChips(
    //                           name: 'IconWash',
    //                           options:  [
    //                             FormBuilderChipOption(
    //                               value: "1",
    //                       child: Image.asset('assets/images/BCarWash.png',height: 25,),
    //                             ),
    //                           ]),
    //                     ),
                           
    //                         SizedBox(width: 110,
    //                           child: FormBuilderChoiceChips(
    //                               name: 'IconEV',
    //                               options:  [
    //                                 FormBuilderChipOption(
    //                                   value: "1",
    //                           child: Image.asset('assets/images/BGreen.png',height: 25,),
    //                                 ),
    //                               ]),
    //                         ),
                    
                      
    //                         SizedBox(width: 110,
    //                           child: FormBuilderChoiceChips(
    //                               name: 'IconTnG',
    //                               options: [
    //                                 FormBuilderChipOption(
    //                                   value: "1",
    //                                   child: Image.asset('assets/images/BTng.png',height: 25,),
    //                                 ),
    //                               ]),
    //                         ),
                     
    //                     SizedBox(width: 110,
    //                       child: FormBuilderChoiceChips(
    //                           name: 'IconTnGSpot',
    //                           options: [
    //                             FormBuilderChipOption(
    //                               value: "1",
    //                               child: Image.asset('assets/images/tngspot.png',height: 25,),
    //                             ),
    //                           ]),
    //                     ),
    //                     SizedBox(width: 110,
    //                       child: FormBuilderChoiceChips(
    //                           name: 'IconEpay',
    //                           options: [
    //                             FormBuilderChipOption(
    //                               value: "1",
    //                           child: Image.asset('assets/images/BePay.png',height: 25,),
    //                             ),
    //                           ]),
    //                     ),
                     
    //                   ]),
    //                   sbh10,
    //                   Row(children: [
    //                     (formValue["GeoLoc"] == "" ||  formValue["GeoLoc"] == null) ? Container(): ElevatedButton(onPressed: ()async {
    //                        final url = Uri.parse("https://www.google.com/maps/?q=${getLatLong(formValue["GeoLoc"])}");
          
    //             if (await canLaunchUrl(url)) {
    //               await launchUrl(url);
    //             }
    //                     }, child: Row(children: [
    //                       Icon(Icons.map_rounded),
    //                       sbw10,
    //                         Text('Show Location')
    //                     ],)),
    //                     // SizedBox(height: 500,
    //                     //   child: HtmlWidget(
    //                     //               '<iframe width="425" height="350" src="https://www.openstreetmap.org/export/embed.html?bbox=103.25823426246644%2C1.9912786809715337%2C103.27615141868593%2C2.001325499002224&amp;layer=mapnik&amp;marker=1.9963020976626833%2C103.26719284057617" style="border: 1px solid black"></iframe><br/><small><a href="https://www.openstreetmap.org/?mlat=1.996302&amp;mlon=103.267193#map=13/1.97232/103.25673">View Larger Map</a></small>',
    //                     //               factoryBuilder: () => MyWidgetFactory(),
    //                     //             ),
    //                     // ),
    //                   ],)
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
