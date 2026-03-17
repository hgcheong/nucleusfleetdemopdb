import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=680;

@RoutePage()
class MchtEnrlQuickInfoLanding extends ConsumerWidget {
  const MchtEnrlQuickInfoLanding({super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,});


final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: AcxTabView(align: Alignment.centerLeft, routes: [
            MchtEnrlQuickInfoOverView(),        
            MchtEnrollQuickInfoCheckList(),
            MchtEnrollQuickInfoCheckList(),
          ], 

          labelPadding:  EdgeInsets.only(left: 0, right: 16),
          tabs: [
            Tab(
              text: S.current.tabOverview,
            ),
             Tab(
              text: S.current.tabCustEnrollCheckList),
                   Tab(
                    child: AppButton(
                      icon: Icons.task_alt,
                      label: 'On Board Merchant', 
                                onPressed: ()async {
                        bool confirmed = await ConfirmDialog.show(
                              title: 'On Board Merchant?');
                                   
                          if(confirmed){
                            final queryPost = QueryObject(querysql: '/sp/ApiEnrlMchtVrfyToOnboard/queryasync', params: {
                            "MchtEttyId":mchtEttyId
                           }, showMsg: true);
                           ref.read(ReturndatafreezedProvider(queryPost));
                           ref.invalidate(ReturndatafreezedProvider(QueryObject(
                                querysql: '/sp/ApiEnrlMchtOverview/queryasync',
                                params: {"MchtEttyId": mchtEttyId},
                                showMsg: false)));
                                      
                          }
                                           
                        },
                    ),
                   )
                      
                ]),),
      ],
    );
      
    
  }
}
