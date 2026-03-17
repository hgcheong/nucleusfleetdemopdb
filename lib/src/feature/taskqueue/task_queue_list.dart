import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/components/shared/acx_task_approval_dialog.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=201;

@RoutePage()
class TaskQueueList extends StatelessWidget {
  const TaskQueueList(
      {super.key,
      @PathParam.inherit('wfcd') this.wfCd,
      @PathParam.inherit('wfprcsid') this.wfPrcsId,
      @PathParam.inherit('wfgrpid') this.wfGrpId});

  final String? wfCd;
  final String? wfPrcsId;
  final String? wfGrpId;
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
           if(row.cells['wfGrpId']==null) {

            Toast.message("Group Workflow ID not Assigned");
            return;
           }

           

            await showAcxDialog(
                context,
                AcxTaskApprovalDialog(
                  recId: row.cells['RecId']!.value.toString(),
                  wfCd: wfCd,
                  wfPrcsId: wfPrcsId,
                ));
          },
          idField: 'WfCd',
          spName: 'ApiTaskQueList',
          params: {
            'WfCd': wfCd,
            'WfPrcsId': wfPrcsId,
            'WfGrpId': convStrNewOrNullToNull(wfGrpId)
          },
          querysql: '/sp/ApiTaskQueList/queryasync'),
    );
  }
}
