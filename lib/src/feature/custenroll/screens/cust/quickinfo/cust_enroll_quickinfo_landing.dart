import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=496;

@RoutePage()
class CustEnrollQuickInfoLanding extends ConsumerWidget {
  const CustEnrollQuickInfoLanding({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  });
  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: AcxTabView(
               labelPadding:  EdgeInsets.only(left: 0, right: 16),
            align: Alignment.centerLeft, routes: [
            CustEnrollQuickInfoOverView(),
            CustEnrollQuickInfoCheckList(),
              CustEnrollQuickInfoCheckList(),
          //Temp For Meeting  CustEnrollQuickInfoApprvHist(),
          ], tabs: [
            Tab(
              text: S.current.tabOverview,
            ),
              Tab(
              text: S.current.tabCustEnrollCheckList),
                  Tab(
                    child: AppButton(
                      icon: Icons.task_alt,
                      label: 'On Board Customer', 
                    onPressed: ()async {
                    bool confirmed = await ConfirmDialog.show(
                          title: 'On Board Customer?');
           
                      if(confirmed){
    final queryPost = QueryObject(querysql: '/sp/ApiEnrlCustVrfyToOnboard/queryasync', params: {
                        "CustEttyId":custEttyId
                       }, showMsg: true);
                       ref.read(ReturndatafreezedProvider(queryPost));
                       ref.invalidate(ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiEnrlCustOverview/queryasync',
        params: {"CustEttyId": custEttyId},
        showMsg: false)));
                      }
                   
                    },
                    ),
                   )
      
            // Tab(
            //   text: S.current.tabApprovalHistory,
            // ),
          ]),
        ),
      ],
    );
  }
}
