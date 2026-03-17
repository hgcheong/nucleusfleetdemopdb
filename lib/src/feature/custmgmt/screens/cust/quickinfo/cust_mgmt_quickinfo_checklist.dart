import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=609;

@RoutePage()
class CustMgmtQuickInfoCheckList extends StatelessWidget {
  const CustMgmtQuickInfoCheckList(
      {super.key, @PathParam.inherit('CustEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SingleChildScrollView(
      child: AcxTrinaGridWithColumn(
        querysql: '/sp/ApiMgmtCustOverviewChkList/queryasync',
        params: {"CustEttyId": custEttyId},
        idField: 'Id',
        navPrefix: '/custmgmt/cust',
        spName: 'ApiMgmtCustOverviewChkList',
        onSelectedTap: (TrinaRow val) {},
      ),
    );
  }
}
