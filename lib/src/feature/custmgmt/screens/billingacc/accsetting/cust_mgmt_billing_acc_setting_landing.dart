import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/cust_mgmt_billing_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=532;

@RoutePage()
class CustMgmtBillingAccSettingLanding extends ConsumerWidget {
  const CustMgmtBillingAccSettingLanding(
      {super.key,
      @PathParam.inherit('acctId') this.acctId,
      @PathParam('acctType') this.acctType});

  final String? acctId;
  final String? acctType;
  @override
  Widget build(BuildContext context, WidgetRef ref) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
 var val = ref.watch(pukalCustMgmtAccDetailProvider);
    switch (acctType) {
      case 'POSTPAID':
        return AcxTabView(routes: [
          CustMgmtBillingAccPostPaid(),
          CustMgmtPukal(),
          const CustMgmtStatementLanding(),
          CustMgmtTxnPostedLanding(),
          CustMgmtBillingAutoPay(),
        ], tabs:  val["PrgEttyId"].toString() == "1"?  [
          const Tab(text: 'Account'),
          const Tab(text: 'Pukal Account'),
          Tab(text: S.current.tabStatement),
          Tab(text: S.current.tabTransaction),
          Tab(text: S.current.tabAutoPayment),
        ]:[ const Tab(text: 'Account'),
          const Tab(text: 'Pukal Account'),
          Tab(text: S.current.tabStatement),
          Tab(text: S.current.tabTransaction),
          Tab(text: S.current.tabAutoPayment),] );

      case 'PREPAID':
        return AcxTabView(routes: [
          CustMgmtBillingAccPrePaid(),
          //    const CustMgmtBillingAutoPay(),
        ], tabs: [
          Tab(text: S.current.tabPrepaid),
          // Tab(text: S.current.tabAutoPayment),
        ]);
      default:
        singleton<AppRouter>().back();
    }
    return const AutoRouter();
  }
}
