import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=331;

@RoutePage()
class CustMgmtMemberDetailLanding extends StatelessWidget {
  const CustMgmtMemberDetailLanding(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam('mbrEttyId') this.mbrEttyId});

  final String? custEttyId;
  final String? mbrEttyId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    final valMbr = convStrNewOrNullToNull(mbrEttyId);
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: 1280,
        child: AcxTabView(
          routes: [
            CustMgmtMemberQuickInfoLanding(),
            CustMgmtMemberInfoLanding(),
                       const CustMgmtMemberContactLanding(),
            const CustMgmtMemberAddressLanding(),
 
            CustMgmtMemberCtrlLanding()
          ],
          tabs: [
            Tab(
              text: S.current.tabQuickInfo,
            ),
            Tab(
              text: S.current.tabMemberInfo,
            ),
              valMbr == null
                ? emptyTab
                : Tab(
                    text: S.current.tabContact,
                  ),
            valMbr == null
                ? emptyTab
                : Tab(
                    text: S.current.tabAddress,
                  ),
          
            valMbr == null
                ? emptyTab
                : Tab(
                    text: S.current.tabControl,
                  ),
          ],
        ),
      ),
    ));
  }
}
