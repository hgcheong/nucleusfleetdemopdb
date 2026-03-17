import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=622;

@RoutePage()
class CustMgmtMemberCtrlLanding extends StatelessWidget {
  const CustMgmtMemberCtrlLanding(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId});

  final String? custEttyId;
  final String? mbrEttyId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return AcxTabView(align: Alignment.centerLeft, routes: [
      CustMgmtMbrCtrlTxnListLanding(),
      const CustMgmtMbrCtrlLocListLanding(),
      CustMgmtMbrCtrlProdListLanding(),
    ], tabs: [
      Tab(text: S.current.tabTransaction),
      Tab(text: S.current.tabLocation),
      Tab(text: S.current.tabProdAccpt),
    ]);
  }
}
