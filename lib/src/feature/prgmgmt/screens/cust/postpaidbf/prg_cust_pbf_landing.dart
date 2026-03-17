import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=772;

@RoutePage()
class PrgCustPbfLanding extends StatelessWidget {
  const PrgCustPbfLanding({super.key});

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
            PrgCustPbfBillingList(),
            PrgCustPbfFinLpc(),
        //    PrgCustPbfPayPriority(),
         //   PrgCustPbfDelinqSts(),
          ], tabs: [
            Tab(
              text: S.current.tabBilling,
            ),
            Tab(
              text: S.current.tabFinanceLPCCharge,
            ),
            // Tab(
            //   text: S.current.tabPaymentPriority,
            // ),
            // Tab(
            //   text: S.current.tabDelinquencySts,
            // )
          ]),
        ),
      ],
    );
  }
}
