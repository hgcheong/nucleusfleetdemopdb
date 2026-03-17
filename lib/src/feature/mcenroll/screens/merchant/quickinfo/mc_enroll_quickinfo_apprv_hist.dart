import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=678;

@RoutePage()
class MchtEnrlQuickInfoApprvHist extends StatelessWidget {
  const MchtEnrlQuickInfoApprvHist({super.key, this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SingleChildScrollView(
        child: AcxTrinaGridWithColumn(
      querysql: '/sp/ApiEnrlMchtAppvHist/queryasync',
      params: {"MchtEttyId": mchtEttyId},
      idField: 'Id',
      spName: 'ApiEnrlMchtAppvHist',
      onSelectedTap: (TrinaRow val) {},
    ));
  }
}
