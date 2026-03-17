import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=608;

@RoutePage()
class CustMgmtQuickInfoApprvHist extends StatelessWidget {
  const CustMgmtQuickInfoApprvHist(
      {super.key, @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SingleChildScrollView(
        child: AcxTrinaGridWithColumn(
      querysql: '/sp/ApiMgmtMchtAppvHist/queryasync',
      params: {"MchtEttyId": mchtEttyId},
      idField: 'Id',
      navPrefix: '/prgmgmt/setup',
      spName: 'ApiMgmtMchtAppvHistList',
      onSelectedTap: (TrinaRow val) {},
    ));
  }
}
