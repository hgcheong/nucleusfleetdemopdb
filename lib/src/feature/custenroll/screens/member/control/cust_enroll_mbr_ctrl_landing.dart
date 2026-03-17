import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=508;

@RoutePage()
class CustEnrollMemberCtrlLanding extends StatelessWidget {
  const CustEnrollMemberCtrlLanding(
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
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: AcxTabView(align: Alignment.centerLeft, routes: [
            CustEnrollMbrCtrlTxnListLanding(),
            const CustEnrollMbrCtrlLocListLanding(),
            CustEnrollMbrCtrlProdListLanding(),
          ], tabs: [
            Tab(text: S.current.tabTransaction),
            Tab(text: S.current.tabLocation),
            Tab(text: S.current.tabProdAccpt),
          ]),
        ),
      ],
    );
  }
}
