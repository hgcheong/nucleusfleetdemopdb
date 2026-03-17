import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatav3.dart';
import 'package:nucleusv2/src/core/components/acx_searchmain.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/user_mgmt_controller.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=262;

@RoutePage()
class UserMgmtWebPortalUserAssign extends BaseScreen {
  const UserMgmtWebPortalUserAssign({super.key, @PathParam('userId') this.userId});

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
     // appBar: AppBar(title: const Text("Web Portal Users",),automaticallyImplyLeading: false, centerTitle: false,),
      body:  const UserMgmtWebPortalUserForm(),

    );
  }
}

class UserMgmtWebPortalUserForm extends ConsumerWidget {
  const UserMgmtWebPortalUserForm(
      {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }

    
    var currentUser = ref.watch(userPortalControllerProvider);
  //  final formKeyWebPortalUserMdl = GlobalKey<FormBuilderState>();
//     var logUser = QueryObject(
//         querysql: '/sp/ApiSignInRole/queryasync',
//         params: {
//   "UsrId": currentUser["UsrId"],
//   "EttyId":currentUser["EttyId"],
//   "UserType": currentUser["UserType"],
//   "SignIn": currentUser["SignIn"],
// }, showMsg: false);
//     final value = ref.watch(ReturndatafreezedProvider(logUser));
    // Map<String, dynamic> formValue =   {
    //   "SignIn": currentUser["SignIn"],
    //   "UsrId": currentUser["UsrId"],
    //   "Email": null,
    //   "MobileNo": null,
    //   "UserType": currentUser["UserType"],
    //   "UserSts": null,
    //   "EttyId": currentUser["EttyId"],
    //   "AtvnDate": null,
    //   "TmntionDate": null,
    //   "AccessSts": null,
    //   "UserRole": null,
    //   "WebEttyUId": null
    // };
    //final isNewUser = convStrNewOrNullToNull(userId);
           return Scaffold(
            
          body: Row(
            children: [
              Expanded(
                flex:11,
                child: ListView(
                  children: [

                  
                 
                    SizedBox(
                      height: 1280,
                      child: UserRoleList(convStrNewOrNullToNull(currentUser["UsrId"].toString()),
                      convStrNewOrNullToNull(currentUser["SignIn"].toString())),)
                  ],
                ),
              ),
            const Expanded(flex: 1,child:    Column(
                children: [
                       
              //     AcxSaveButtonManual(onSave: () {
              //         if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
              //         Toast.message("Action Not Authorised");
              //         return;
              //       }
              //       formKeyWebPortalUserMdl.currentState!.save();
              //                 Map<String, dynamic> toPost = convertFormValueToSave(
              //   Map.from(formKeyWebPortalUserMdl.currentState!.value),
              //   theData.columnInfo);
              //                  //   toPost.remove('UserId');
              //                 final saveResult = ref.read(ReturndatafreezedProvider(
              //       QueryObject(
              //           querysql: '/sp/ApiSignInRoleSave/queryasync',
              //           params: toPost,
              //           showMsg: false))
              //   .future);
              //                 saveResult.then((Returndata? value) {
              // if(value==null){
              //   return;
              // }
              // Toast.showresult(value);
              // if (isSuccess(value.message)) {
              //   ref.invalidate(ReturndatafreezedProvider(logUser));
              // }
              //                 });
              //     }),
                             AcxBackToList(
                      listUrl: '/usermgmt/webportaluser/'),
                ],
              ),)
            ],
          ),
        );
    // return AsyncValueWidget(
    //   value: value,
    //   data: (theData) {
    //     if (theData.data != null) {
    //       // formValue = convertFormValueToDisplay(
    //       //     theData.data![0] as Map<String, dynamic>, theData.columnInfo);
    //     }
 
    //   },
    // );
  }
}

class UserRoleList extends ConsumerWidget {
  const UserRoleList(this.usrId, this.signIn, {super.key});

  final String? usrId;
  final String? signIn;
  final String userType= "E";


  @override
  Widget build(BuildContext context, WidgetRef ref) {

// {
//       "UsrId": 53,
//       "SignIn":"ali002",
//       "UserType": "E",
// }

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(userRoleGridSearchControllerProvider);
    if(toPost["SignIn"]==null && toPost["Email"]==null){
      return const Center(child:Text('No Data'));
    }
    final qo = QueryObject(
        querysql: '/sp/ApiSignInRoleList/queryasync',
        params: {
          "UsrId":usrId,
          "SignIn":signIn,
          "UserType":userType
        },
        showMsg: false);
    final query = ReturndatafreezedProvider(qo);
    final data = ref.watch(query);
      late void Function(QueryObject returndata) myMethod;
    return AsyncValueWidget(
        value: data,
        data: (theData) {
          return  Row(
            children: [
              Expanded(flex:11,child: AcxTrinaGridExtv3(   
                gridTitle: 'Assign/Remove Customer to Sign In',
                extData: theData,checkIndicatorField: 'UId',
                onRefresh: (){
                    myMethod.call(qo);
                },
                onSelected: (val)async{
      await showAcxAlertDialog(context,  RoleAssignDialog(
                    usrId: usrId,
                    signIn: signIn,
                    userType: userType,
                    ettyId: val.cells['EttyId']!.value.toString(),
                     webEttyUId: val.cells['WebEttyUId']!.value.toString(),
                    mobileNo: val.cells['MobileNo']!.value.toString(),
                      userRole: val.cells['UserRole']!.value.toString(),
                    accessSts: val.cells['UserSts']!.value.toString(),  
                    email: val.cells['Email']!.value.toString(),
                    initialComp: val.cells['CustName'] == null? '' : val.cells['CustName']!.value.toString()
                  )).then((val){
                     myMethod.call(qo);
                  });
                },
                 builder: (BuildContext context, void Function(QueryObject A) methodA) { 
                  myMethod = methodA;
                 },
                )),
            ],
          );
          // return AcxTrinaGridExtv2(
          //    exportTitle: 'Assign Company',
          //      gridTitle: 'Assign Company',
          //     extData: theData,
          //     idField: 'UId',
          //     onRefresh: (){
            
          //        //  ref.invalidate(query);
          //     },
          //     onNew: ()async{
          //        await showAcxAlertDialog(context,  RoleAssignDialog(
          //           usrId: usrId,
          //           signIn: signIn,
          //           userType: userType,
          //         )).then((val){
          //           ref.invalidate(query);
          //         });
                
          //     },
          //     onSelected: (TrinaRow val) async {
         
                
          //             await showAcxAlertDialog(context,  RoleAssignDialog(
          //           usrId: usrId,
          //           signIn: signIn,
          //           userType: userType,
          //           ettyId: val.cells['EttyId']!.value.toString(),
          //            webEttyUId: val.cells['WebEttyUId']!.value.toString(),
          //           mobileNo: val.cells['MobileNo']!.value.toString(),
          //             userRole: val.cells['UserRole']!.value.toString(),
          //           accessSts: val.cells['UserSts']!.value.toString(),  
          //           email: val.cells['Email']!.value.toString(),
          //           initialComp: val.cells['CmpyName'] == null? '' : val.cells['CmpyName']!.value.toString()
          //         )).then((val){
          //            ref.invalidate(query);
          //         });
          //     //      ref.read(userPortalControllerProvider.notifier).state = val.toJson();
          //     //    //  print(val.toJson());
          //     // singleton<AppRouter>().navigatePath(
          //     // '/usermgmt/webportaluser/dtl/${val.cells['SignIn']!.value.toString()}');

          //     });
        });
  }
}

class RoleAssignDialog extends ConsumerWidget{
  const RoleAssignDialog({this.usrId, this.signIn, this.userType, 
  this.mobileNo,this.email, this.userRole, this.accessSts, this.ettyId,this.initialComp, this.webEttyUId,  super.key});

  final String? usrId;
  final String? signIn;
  final String? userType;
  final String? mobileNo;
  final String? email;
  final String? userRole;
  final String? accessSts;
  final String? ettyId;
  final String? initialComp;
  final String? webEttyUId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKeyRoleAssignDialog = GlobalKey<FormBuilderState>();
     Map<String, dynamic> formRoleAssign= {
      "UsrId": usrId,
      "SignIn":signIn,
      "UserType": userType,
      "MobileNo":mobileNo,
      "Email":email,
      "EttyId":convStrNewOrNullToNull(ettyId),
      "UserRole":userRole,
      "AccessSts": accessSts,
      "WebEttyUId": convStrNewOrNullToNull(webEttyUId)
};
 return FormBuilder(
            key: formKeyRoleAssignDialog,
            initialValue: formRoleAssign, child: Row(
              children: [
                Expanded(
                  flex:11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const  Text('Please assign/remove Customer, Role and Access Status to this Sign In'),
                      //   Flexible(flex: 2, child: showUserStatus(isNewUser)),
                      const FbText(name: 'SignIn', label: 'Sign ID', readOnly: true,),
                        FbHiddenText(name: 'UserType'),
                        FbHiddenText(name: 'EttyId'),
                          FbHiddenText(name: 'WebEttyUId'),
                        FbHiddenText(name: 'UsrId'),    
                                         const FbText(
                           name: 'MobileNo', label: 'Mobile Number'),
                       const FbText(name: 'Email', label: 'Email'),
                                const FbLibView(
                                      
                            name: 'UserRole',              
                            label: 'User Role',
                            searchText: 'Dscp',
                            keyField: 'RefCd',
                            params: {'RefType':'USERROLE'},
                            querySql: '/view/async/vwlibref ',
                          ),
                                const FbLibView(
                                      
                            name: 'AccessSts',              
                            label: 'Access Status',
                            searchText: 'Dscp',
                            keyField: 'RefCd',
                            params: {"view":"and RefType='UserSts' and dbo.ufnBitUserActvSusp(BitInd)>0"},
                            querySql: '/view/async/vwlibref/addcond',
                          ),
                       //                           spName: 'ApiSignInWebGroupList',
                       // idField: 'UserGrp',
                      
                           AcxSearchMain(
                             // name: 'MchtEttyId',
                            //  selectedRef:   const {
                            //        "Dscp": "CMPY# UEM Group Berhad (UEM Group)   CUST# 202400000000003   EID# 703",
                            //        "RefCd": "CUSTNAME",
                            //        "CustEttyId": 703
                            //  },
                                 initialStr: initialComp??'',
                             searchAttr: 'Str',
                             label: 'Customer Name',
                             params: const {},
                             keyField: 'CustEttyId',
                             searchText: 'Dscp',
                             showSearchBox: true,
                             refCd: 'CUSTNAME',
                             querysql: '/sp/ApiMgmtMainSearch/queryasync',
                             inputText: 'Customer Name',
                             returnSelectedRef: (val) {
                                 formKeyRoleAssignDialog.currentState!
                                    .patchValue({'EttyId': val['CustEttyId'].toString()});
                             }),
                      //     signInHistory(isNewUser),
                   
                    ],
                  ),
                ),
                sbw10,
                Expanded(flex: 1,child:   Column(
                  children: [
                         
                    AcxSaveButtonManual(onSave: () {
                        if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                        Toast.message("Action Not Authorised");
                        return;
                      }
                      formKeyRoleAssignDialog.currentState!.save();
                                Map<String, dynamic> toPost = Map.from(formKeyRoleAssignDialog.currentState!.value);
                          toPost["WebEttyUId"]= convStrNewOrNullToNull(toPost["WebEttyUId"]);
                          toPost["EttyId"]= convStrNewOrNullToNull(toPost["EttyId"]);
                           
                                 //   toPost.remove('UserId');
                                final saveResult = ref.read(ReturndatafreezedProvider(
                      QueryObject(
                          querysql: '/sp/ApiSignInRoleSave/queryasync',
                          params: toPost,
                          showMsg: true))
                  .future);
                                saveResult.then((Returndata? value) {
                if(value==null){
                  return;
                }
                      Toast.showresult(value);
                                  if(isSuccess(value.message)){
        
                                       if (context.mounted) {
                                          context.maybePop();
                                        }
                                  }
                              
                                });
                    }),sbh10, 
                    AcxAuditLogReqBtn('ApiSignInRoleSave',ettyId: formRoleAssign['EttyId'].toString(),),
                    ettyId == null || ettyId=="" ? Container():
                    AcxSaveButtonManual(
                      iconData: Icons.delete,
                      onSave: () async {
                        if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
              bool confirmed = await ConfirmDialog.show(
                  title: 'Are you sure you want remove Customer assigned to Sign In?');
              if (confirmed) {
                formKeyRoleAssignDialog.currentState!.save();
                                Map<String, dynamic> toPost = Map.from(formKeyRoleAssignDialog.currentState!.value);
                          toPost["WebEttyUId"]= convStrNewOrNullToNull(toPost["WebEttyUId"]);
                          toPost["EttyId"]= convStrNewOrNullToNull(toPost["EttyId"]);

       final saveResult = ref.read(ReturndatafreezedProvider(
                       QueryObject(
                      querysql: '/sp/ApiSignInRoleDel/queryasync',
                      params: {
                     "UsrId": usrId,
                    "SignIn": signIn,
                    "UserType": userType,
                    "EttyId": toPost["EttyId"],
                     "WebEttyUId": toPost["WebEttyUId"]
                      },
                      showMsg: false))
                  .future);
              saveResult.then((Returndata? value) {
                if(value==null){
                  return;
                }
                  Toast.showresult(value);
                                  if(isSuccess(value.message)){
        
                                       if (context.mounted) {
                                          context.maybePop();
                                        }
                                  }
                              
                                });

              }
                    }),sbh10,
                                AcxBackToList(listUrl: '',useFunctionOnly: true,fnBeforeNav: (){
   if (context.mounted) {
                                          context.maybePop();
                                        }
                               },
                        ),
                  ],
                ),)
              ],
            ), );
  }

}
 
