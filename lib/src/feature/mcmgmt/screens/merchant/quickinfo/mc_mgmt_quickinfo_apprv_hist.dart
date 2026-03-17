import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=744;

@RoutePage()
class MchtMgmtQuickInfoApprvHist extends StatelessWidget {
  const MchtMgmtQuickInfoApprvHist({super.key, this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Center(
        child: AcxTrinaGridWithColumn(
      querysql: '/sp/ApiMchtMgmtAppvHist/queryasync',
      params: {"MchtEttyId": mchtEttyId},
      idField: 'Id',
      spName: 'ApiMchtMgmtAppvHist',
      onSelectedTap: (TrinaRow val) {},
    ));
  }
}
