import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/components/shared/acx_status_form.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=728;

@RoutePage()
class MchtMgmtLocationProfileStatus extends ConsumerWidget {
  const MchtMgmtLocationProfileStatus(
      {super.key,
      @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? locEttyId;
  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return AcxStatusForm(
      query: QueryObject(
          querysql: '/sp/ApiMgmtSts/queryasync',
          params: {
            "EttyId": locEttyId,
          },
          showMsg: false),
      ettyId: locEttyId,
      querySaveSql: 'ApiMgmtStsSave',
      backToListUrl: '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/profile',
    );
  }
}
