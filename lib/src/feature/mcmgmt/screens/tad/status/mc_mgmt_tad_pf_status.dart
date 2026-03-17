import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/components/shared/acx_status_form.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=754;

@RoutePage()
class MchtMgmtTADProfileStatus extends ConsumerWidget {
  const MchtMgmtTADProfileStatus(
      {super.key,
      @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam.inherit('tadEttyId') this.tadEttyId,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? locEttyId;
  final String? mchtEttyId;
  final String? tadEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return AcxStatusForm(
      query: QueryObject(
          querysql: '/sp/ApiMgmtSts/queryasync',
          params: {
            "EttyId": tadEttyId,
          },
          showMsg: false),
      ettyId: tadEttyId,
      querySaveSql: 'ApiMgmtStsSave',
      backToListUrl:
          '/mcmgmt/tad/$mchtEttyId/geninfo/$tadEttyId/$locEttyId/main',
    );
  }
}

///mcmgmt/tad/83/geninfo/90/86/main
