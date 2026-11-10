import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/user_mgmt_controller.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/user_mgmt_nucleus_user.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=262;

@RoutePage()
class UserMgmtWebPortalUser extends BaseScreen {
  const UserMgmtWebPortalUser({super.key, @PathParam('userId') this.userId});

  final String? userId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var currentUser = ref.watch(userMgmtControllerProvider);
    final formKeyUserMdl = GlobalKey<FormBuilderState>();
    var logUser = QueryObject(
        querysql: '/sp/ApiSignIn/queryasync',
        params: {
          "SignIn": currentUser["UserId"],
          "PwdHash": currentUser["PwdHash"],
          "UserType": "I",
          "ApplName": null,
          "ApplVer": null,
          "ReqType": "query"
        },
        showMsg: false);
    final value = ref.watch(ReturndatafreezedProvider(logUser));
    Map<String, dynamic> formValue = {
      "SignIn":currentUser["UserId"],
      "PwdHash": currentUser["PwdHash"],
      "FirstName": null,
      "LastName": null,
      "FullName":null,
      "UserType": "I",
      "ReqType":currentUser["UserId"]== "RESET",
      "Role": null,
      "ApplName":"Nucleus",
      "AccessRightGrpId": null,
      "Access Rights Group": null,
      "pwdoption": 'Y',
 
    };
    //final isNewUser = convStrNewOrNullToNull(userId);
    return AsyncValueWidget(
      value: value,
      data: (theData) {
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
              formValue['SignIn'] = formValue['UserId'];
              formValue['Mobile'] = formValue['ContactNo'];
              formValue['PwdHash'] = null;
        }
        return SingleChildScrollView(
          child: SizedBox(
            height: 1200,
            child: FormBuilder(
              key: formKeyUserMdl,
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

                              const FbText(name: 'SignIn', label: 'User ID'),
                               FbHiddenText(name: 'UserType'),
                                 FbHiddenText(name: 'ReqType'),
                                 Row(children: [
  Expanded(
                                      child: FbText(
                                    name: 'FullName',
                                    label: 'Name',
                                  )),
                                 ],),
                              const Row(
                                children: [
                                
                                       Expanded(
                                      child: FbHiddenText(
                                    name: 'FirstName',
                                  )),
                                       Expanded(
                                      child: FbHiddenText(
                                    name: 'LastName',
                                  )),
                                  // Expanded(
                                  //     child: FbText(
                                  //   name: 'LastName',
                                  //   label: 'Last Name',
                                  // )),
                                ],
                              ),
                              const FbHiddenText(name: 'ApplName'),
                              const FbHiddenText(name: 'ApplVer'),
                              const FbHiddenText(name: 'UserType'),
          
                                  const FbText(
                                  name: 'Mobile', label: 'Mobile Number'),
                              const FbText(name: 'Email', label: 'Email'),
                              //                           spName: 'ApiSignInWebGroupList',
                              // idField: 'UserGrp',
                         //    currentUser["UserId"] == 'new' ?  FbText(name:'PwdHash', label: 'Password',):FbHiddenText(name:'PwdHash'),
                              FbText(name:'PwdHash', label: 'Password',),
                              Row(
                                children: [
                                  Expanded(child: const FbText(name: 'Sts',label: 'Status',readOnly: true,)),
                                    formValue['Sts'] != 'A' ? ElevatedButton.icon(label:const Text('Activate User'),
                                    onPressed: (){
                                                          formKeyUserMdl.currentState!.save();
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            Map.from(formKeyUserMdl.currentState!.value),
                            theData.columnInfo);
                            toPost.remove('UserId');
                            toPost['UserType'] = 'I';
                            toPost['ReqType'] = 'ACTV';
                            toPost['Sts'] = 'A';
                            toPost['PwdHash'] = getRSAEncryptedPWD(toPost['PwdHash'].toString());
                        final saveResult = ref.read(ReturndatafreezedProvider(
                                QueryObject(
                                    querysql: '/sp/ApiSignInSave/queryasync',
                                    params: toPost,
                                    showMsg: false))
                            .future);
                        saveResult.then((Returndata? value) {
                          if(value==null){
                            return;
                          }
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                   
                            singleton<AppRouter>().navigatePath('/usermgmt/nucleususer/dtl/${toPost['SignIn']}').then((val){
      ref.invalidate(ReturndatafreezedProvider(logUser));
                            });
                      
                          }
                        }); 
                                    },):Container()
                                ],
                              ),    
                              const FbLibView(
                                  name: 'AccessRightGrpId',
                                  label: 'Group',
                                  params: {},
                                  keyField: 'GrpId',
                                  searchText: 'UserGrp',
                                  querySql:
                                      '/sp/ApiSignInWebGroupList/queryasync'),

                             formValue['AccessRightGrpId'] == null? Container(): ElevatedButton.icon(
                                  label: const Text('User Access Control'),
                                  onPressed: () async {
                                    final listQuery = ReturndatafreezedProvider(
                                        QueryObject(
                                            querysql:
                                                '/sp/ApiSignInAccessCtrlList/queryasync',
                                            params: {
                                              "SignIn": currentUser['UserId'],
                                              "EttyId":
                                                  currentUser['EttyId'] == 0
                                                      ? null
                                                      :  convStrNewOrNullToNull(currentUser['EttyId']),
                                              "UserType":
                                                  currentUser['UserType']
                                            },
                                            showMsg: false));
                                    Set<TrinaRow> selectedItems =
                                        await showAcxDialog(
                                            context,
                                            UserSignInAccessCtrlList(
                                                listQuery: listQuery,
                                                ettyId:
                                                    currentUser['EttyId'] == 0
                                                        ? null
                                                        : convStrNewOrNullToNull(currentUser['EttyId']),
                                                signIn: currentUser['UserId'],
                                                userType:
                                                    currentUser['UserType']));
                                    if (selectedItems.isEmpty) {
                                      return;
                                    }
                                    for (TrinaRow element in selectedItems) {
                                      var toPost = {
                                        "UId": element.cells['UId']!.value
                                            .toString(),
                                        "AccessRightInd": element
                                            .cells['AccessRightInd']!.value
                                            .toString(),
                                        "GrpId": element.cells['GrpId']!.value
                                            .toString(),
                                        "ModuleId": element
                                            .cells['ModuleId']!.value
                                            .toString(),
                                        "ModuleName": element
                                            .cells['ModuleName']!.value
                                            .toString(),
                                        "UserType": currentUser['UserType'],
                                        "SignIn": currentUser['UserId'],
                                        "SetupId":
                                            element.cells['SetupId']!.value,
                                        "EttyId":
                                            element.cells['EttyId']!.value == 0
                                                ? null
                                                : element.cells['EttyId']!.value
                                                    .toString(),
                                      };

                                      updateUserControl(toPost, ref);
                                      ref.invalidate(listQuery);
                                    }
                                    Toast.message('Updated');
                                  },
                                  icon: const Icon(Icons.list)),
                              // userId == 'new' ? Container() : const FbDateTimePicker(name: 'terminationdate', label: 'Termination Date')
                            ],
                          ),
                        ),
                        //     signInHistory(isNewUser),
                        Flexible(
                          flex: 2,
                          child: Row(
                            children: [
                              const AcxBackToList(
                                  listUrl: '/usermgmt/nucleususer/'),
                              AcxSaveButtonManual(onSave: () {
                                  if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                                formKeyUserMdl.currentState!.save();
                              
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            Map.from(formKeyUserMdl.currentState!.value),
                            theData.columnInfo);
                            toPost.remove('UserId');
                            toPost['UserType'] = 'I';
                            toPost['ReqType'] = 'Setup';
                            if(toPost['PwdHash']== null || toPost['PwdHash']=='')
                            {
                              Toast.message('Please Key in Password');
                              return;
                            }
                            toPost['PwdHash'] = getRSAEncryptedPWD(toPost['PwdHash'].toString());
                          
                        final saveResult = ref.read(ReturndatafreezedProvider(
                                QueryObject(
                                    querysql: '/sp/ApiSignInSave/queryasync',
                                    params: toPost,
                                    showMsg: false))
                            .future);
                        saveResult.then((Returndata? value) {
                          if(value==null){
                            return;
                          }
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            ref.invalidate(ReturndatafreezedProvider(logUser));
                          }
                        });
                              }),
                    AcxAuditLogReqBtn('ApiSignInSave',),
                    sbh10,
                              PopupMenuButton(
                                icon: const Icon(Icons.more_vert),
                                onSelected: (val) {},
                                itemBuilder: (context) {
                                  return <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      value: 'OTP',
                                      child:
                                          const SelectableText('Change Status'),
                                      onTap: () {
                                        singleton<AppRouter>().navigatePath(
                                            '/usermgmt/nucleususer/status/$userId');
                                      },
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'OTPLIST',
                                      child: SelectableText('Reset Password'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'OTPLIST',
                                      child:
                                          SelectableText('Reset Failed Count'),
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
            ),
          ),
        );
      },
    );
  }}