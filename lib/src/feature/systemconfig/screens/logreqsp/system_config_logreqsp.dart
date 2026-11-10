import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=888;

@RoutePage()
class SystemConfigLogReqSp extends ConsumerWidget {
  const SystemConfigLogReqSp({super.key, @PathParam('Id') this.id});

  final String? id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }

    final formKeysystemConfigSite = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
    "Id":id
};
final qo = QueryObject(querysql: '/sp/ApiLogReqSp/queryasync', params: {
  "Id":id
}, showMsg: false);
final qres = ref.watch(ReturndatafreezedProvider(qo));
    //final isNewUser = convStrNewOrNullToNull(userId);
    return AsyncValueWidget(
      value: qres,
      data: (theData) {
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);

        }
        return FormBuilder(
          key: formKeysystemConfigSite,
          initialValue: formValue,
          
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [         
                    Text("Log Req Info")  ,
                    Row(
                      children: [
                           Expanded(
                          child: FbText(
                                                          name: 'Id',
                                                          label: 'Id',
                                                          readOnly: true,
                                                        ),
                        ),
                      ],
                    ),
          
                                                        FbText(
                                                    name: 'SpName',
                                                    label: 'Name',
                                                    readOnly: true,
                                                  ),
                                                        FbText(
                                                    name: 'ParaName',
                                                    label: 'Parameter Name',
                                                    readOnly: true,
                                                  ),
                                                        FbText(
                                                    name: 'SrcName',
                                                    label: 'Source Name',
                                                  ),
                                                          FbText(
                                                    name: 'SrcKey',
                                                    label: 'Source Key',
                                                  ),
                                                          FbText(
                                                    name: 'SrcDscp',
                                                    label: 'Source Description',
                                                  ),
                                                               FbText(
                                                    name: 'LabelDscp',
                                                    label: 'Label Description',
                                                  ),
                                               
                                                           FbText(
                                                    name: 'MaxLength',
                                                    label: 'Max Length',
                                                  ),
                                                          FbText(
                                                    name: 'SrcType',
                                                    label: 'Source Type(LibReference,Table,View,Static)',
                                                  ),
                                                  sbh10,
                                                              FbSwitch(
                                                    name: 'IsReq',
                                                    label: 'Is Required',
                                                    initialValue: formValue['IsReq']
                                                  ),
          
                
          
                 
              //     signInHistory(isNewUser),
       
            ],
          )),       Flexible(
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
          
              final saveResult = ref.read(ReturndatafreezedProvider(
                      QueryObject(
                          querysql: '/sp/ApiLogReqSpSave/queryasync?logId=$id',
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
                  singleton<AppRouter>()
                      .navigatePath('/systemconfig/logreq/dtl/$id')
                      .then((val) {
                    ref.invalidate(
                        ReturndatafreezedProvider(qo));
                  });
                }
                }
              });
                    }),
                     const AcxBackToList(
                        listUrl: '/systemconfig/logreq/list'),
                        AcxAuditLogReqBtn('ApiLogReqSpSave', ettyId: id.toString(),)
                  ],
                ),
              )
                      
             
                      ],
                    ));
      },
    );
  }
}
