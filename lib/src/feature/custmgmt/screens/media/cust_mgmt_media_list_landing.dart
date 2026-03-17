import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=325;

@RoutePage()
class CustMgmtMediaListLanding extends ConsumerWidget {
  const CustMgmtMediaListLanding({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  });

  final String? custEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Scaffold(
      body: AcxTabView(
        routes: [CustMgmtMediaList(), CustMgmtMediaListAddOn(), CustMgmtMediaListAddOnCheckList(), CustMgmtMediaListActivation()],
        tabs:  [
          Tab(
            text: "Card List",
          ),
          Tab(
            text: "Card List Add On",
          ),
             Tab(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Add On Check List'),
                sbw10,
                  IconButton(
                    tooltip: 'Verify Add On Cards?',
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    onPressed: ()async {
                    bool confirmed = await ConfirmDialog.show(
                          title: 'Verify Add On Cards?');
           
                      if(confirmed){
    final queryPost = QueryObject(querysql: '/sp/ApiMgmtCustMediaAddOnVrfyToOnboard/queryasync', params: {
                        "CustEttyId":custEttyId
                       }, showMsg: true);
                       ref.read(ReturndatafreezedProvider(queryPost));
                      }
                   
                    },
                   icon: Icon(Icons.task_alt),)
                ],
              ),
          ),
            Tab(
            text: "Card Activation",
          ),
        ],
      ),
    );
  }
}
