import 'package:auto_route/auto_route.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';

const int wid=184;

@RoutePage()
class ReimbursementSignatory extends ConsumerWidget {
  const ReimbursementSignatory({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
 
    return buildView(context);
  }

  // static const List<PageRouteInfo> routes = [PrgmgmtmainTabRouter()];


}

Widget buildView(
  BuildContext context,
) {
  return const Scaffold(
    body:  RptReimburseSignatoryearchSliver(),
    // appBar: AppBar(
    //   title: const SelectableText('Schedule Report'),
    //   automaticallyImplyLeading: false, centerTitle: false,
    // ),
  );
}
class RptReimburseSignatoryearchSliver extends ConsumerWidget {
  const RptReimburseSignatoryearchSliver(
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final rimburseAuthSignatory = GlobalKey<FormBuilderState>();
       var querySql = QueryObject(
        querysql: '/sp/ApiMchtReimburseAuth/queryasync',
        params: {},
        showMsg: false);
          Map<String, dynamic> formNewValue = 
            {
      "AuthVarName": null,
      "AuthName": null,
      "AuthDept": null,
      "AppvVarName": null,
      "AppvName": null,
      "AppvDept": null,
  };
  final formData = ref.watch(ReturndatafreezedProvider(querySql));
   return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }

         return CustomScrollView(
    slivers: <Widget>[
      const SliverAppBar(  title:  Text('Reimbursement Report Signatory'),
      automaticallyImplyLeading: false, centerTitle: false,
       
      ),
      //2
      SliverToBoxAdapter(child: Column(
        mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            FormBuilder(
              key: rimburseAuthSignatory,
              initialValue: formNewValue,
              child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               FbHiddenText(name:   'AuthVarName'),
               FbHiddenText(name:   'AppvVarName'),
               FbText(name: 'AuthName', label: 'Verified By'),
                FbText(name: 'AuthDept', label: 'Verified By Title')
                ],
              ),
            ),
            sbw10,
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               FbText(name: 'AppvName', label: 'Approved By'),
              FbText(name: 'AppvDept', label: 'Approved By Title')
                ],
              ),
            ),
         Expanded(
                  flex: 1,
                  child: Column(children: [
                    AcxSaveButtonManual(onSave: () {
                        if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                      rimburseAuthSignatory.currentState!.save();
                      Map<String, dynamic> toPost = convertFormValueToSave(
                          rimburseAuthSignatory.currentState!.value,
                          theData.columnInfo);
                      final querySave = QueryObject(
                          querysql: '/sp/ApiMchtReimburseAuthSave/queryasync?logId=0',
                          params: toPost,
                          showMsg: false);
                      final saveResult =
                          ref.read(ReturndatafreezedProvider(querySave).future);
                      saveResult.then((Returndata value) {
                        Toast.showresult(value);
                        if (isSuccess(value.message)) {
                          ref.invalidate(ReturndatafreezedProvider(querySql));
                        }
                      });
                    }),
                    const AcxBackToList(listUrl: '/reimburse/main/out'),
                    AcxAuditLogReqBtn('ApiMchtReimburseAuthSave', ettyId: "0",)
                  ]),
                )
          ],
        ),
      ),
              ),
            )
          ]),),
    ],
  );

   } );

  
  }
}


