import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=582;

@RoutePage()
class CustMgmtCrditRiskLanding extends StatelessWidget {
  const CustMgmtCrditRiskLanding({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  });

  final String? custEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: AcxTabView(align: Alignment.centerLeft, routes: [
            CustMgmtRiskSetting(),
            CustMgmtSecurityDepList()
          ], tabs: [
            Tab(
              text: S.current.tabCreditRiskControl,
            ),
            Tab(
              text: S.current.tabSecurityDeposit,
            )
          ]),
        ),
      ],
    );
  }
}
