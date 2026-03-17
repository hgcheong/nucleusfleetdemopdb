import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=303;

@RoutePage()
class CustMgmtBillingDetailLanding extends StatelessWidget {
  const CustMgmtBillingDetailLanding({
    super.key,
  });

  @override
  Widget build(BuildContext context) { 
  
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SingleChildScrollView(child: SizedBox(height: 1280,child: const AutoRouter()));
    // return AcxTabView(
    //   routes: [
    //       CustMgmtBillingAccountInfo(),
    //     const CustMgmtSettlementLanding(),
    //   const CustMgmtTxnLanding(),
    //     CustMgmtBillingAutoPay()
    //     ],
    //   tabs: [
    //     Tab(text: S.current.tabAccount),
    //     Tab(text: S.current.tabStatement),
    //     Tab(text: S.current.sbTransaction),
    //     Tab(text: S.current.tabAutoPayment)

    //     ],
    // );
  }
}
