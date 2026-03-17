import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatausercontrol.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/user_mgmt_controller.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=250;

@RoutePage()
class UserMgmtNucleusUser extends ConsumerWidget {
  const UserMgmtNucleusUser({super.key, @PathParam('userId') this.userId});

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
            //  formValue['PwdHash'] = null;
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
                                                      : currentUser['EttyId']
                                                          .toString(),
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
                                                        : currentUser['EttyId']
                                                            .toString(),
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
                                   sbh10,
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
  }
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

class UserSignInAccessCtrlList extends ConsumerWidget {
  const UserSignInAccessCtrlList(
      {this.userType,
      this.signIn,
      this.ettyId,
      super.key,
      required this.listQuery});

  final String? userType;
  final String? signIn;
  final String? ettyId;
  final ReturndatafreezedProvider listQuery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    // final listQuery = ReturndatafreezedProvider(QueryObject(
    //     querysql: '/sp/ApiSignInAccessCtrlList/queryasync',
    //     params: {"SignIn": signIn, "EttyId": ettyId, "UserType": userType},
    //     showMsg: false));
    final listData = ref.watch(listQuery);
    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          final theWidget = AcxTrinaGridExtDataUserControl(
            checkIndicatorField: 'AccessRightInd',
            spName: 'ApiSignInAccessCtrlList',
            idField: 'ModuleId',
            extData: dv, isMultiSelect: true,
            //    checkIndicatorField: 'AssignedInd',
          );
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                          'Control Setup - Change the AccessIndField to W-Write, R-Read Only or D-Denied')
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(flex: 10, child: theWidget),
                      sbw10,
                      Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    singleton<AppRouter>().maybePop(
                                        theWidget.checkedOrUncheckedItem.value);
                                  },
                                  child: const Icon(Icons.save)),
                              sbh20,
                              ElevatedButton(
                                onPressed: () {
                                  theWidget.checkedOrUncheckedItem.value
                                      .clear();
                                  singleton<AppRouter>().maybePop(
                                      theWidget.checkedOrUncheckedItem.value);
                                },
                                child: const Icon(
                                  Icons.exit_to_app,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
          );
        }); //
  }
}

void updateUserControl(Map<String, dynamic> params, WidgetRef ref) {
  final query = QueryObject(
      querysql: '/sp/ApiSignInAccessCtrlSave/queryasync',
      params: params,
      showMsg: false);
  final result = ref.read(ReturndatafreezedProvider(query).future);
  result.then((value) {
    if (!isSuccess(value.message)) {
      Toast.showresult(value);
    }
  });
  // resultDel.then((value) {
  //     ref.invalidate(ReturndatafreezedProvider(query));
  //   //  Toast.showresult(value);
  // });
}
