import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=414;

@RoutePage()
class CreditCollectionEventList extends StatelessWidget {
  const CreditCollectionEventList({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SingleChildScrollView(
      child: AcxTrinaGridWithColumn(
          useNav: false,
          onSelectedTap: (TrinaRow row) async {
            // AcxTaskApprovalDialog
            //   await showAcxDialog(context,const AcxTaskApprovalDialog(recId: null, usrId: null, wfCd: null, wfPrcsId: null,));
          },
          idField: 'EventId',
          spName: 'ApiTaskCollEventList',
          params: const {
            "EttyId": null,
            "TaskId": null,
            "AcctId": null,
            "StmtId": null
          },
          querysql: '/sp/ApiTaskCollEventList/queryasync'),
    );
  }
}
