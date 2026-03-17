import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=581;

@RoutePage()
class CustMgmtCostCentreProfileLanding extends StatelessWidget {
  const CustMgmtCostCentreProfileLanding(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam('costCtrEttyId') this.costCtrEttyId});

  final String? custEttyId;
  final String? costCtrEttyId;

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
            CustMgmtCostCentreProfileGenInfo(),
            CustMgmtCostContactList(),
            CustMgmtCostAddressList(),
          ], tabs: [
            Tab(text: S.current.lblGeneralInfo),
              (costCtrEttyId == null || costCtrEttyId == 'new')
                ? const Tab(
                    text: '',
                    height: 0,
                  )
                : Tab(
                    text: S.current.tabContact,
                  ),
            (costCtrEttyId == null || costCtrEttyId == 'new')
                ? const Tab(
                    text: '',
                    height: 0,
                  )
                : Tab(
                    text: S.current.tabAddress,
                  ),
          ]),
        ),
      ],
    );
  }
}
