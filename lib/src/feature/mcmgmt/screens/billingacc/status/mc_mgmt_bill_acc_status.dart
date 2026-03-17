import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/components/shared/acx_status_form.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=709;

@RoutePage()
class MchtMgmtBillingAcctStatus extends ConsumerWidget {
  const MchtMgmtBillingAcctStatus({
    super.key,
    @PathParam.inherit('ettyId') this.ettyId,
    @PathParam.inherit('prgEttyId') this.prgEttyId,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
    @PathParam.inherit('acctId') this.acctId,
  });

  final String? ettyId;
  final String? prgEttyId;
  final String? mchtEttyId;
  final String? acctId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return AcxStatusForm(
      query: QueryObject(
          querysql: '/sp/ApiMgmtSts/queryasync',
          params: {
            "EttyId": acctId,
          },
          showMsg: false),
      ettyId: acctId,
      querySaveSql: 'ApiMgmtStsSave',
      backToListUrl:
          '/mcmgmt/billingAccount/$mchtEttyId/dtl/$prgEttyId/$ettyId/account',
    );
  }
}

///mcmgmt/billingAccount/83/dtl/1/86/account
