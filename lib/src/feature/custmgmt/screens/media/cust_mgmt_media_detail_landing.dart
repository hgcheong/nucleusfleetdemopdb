import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=320;

@RoutePage()
class CustMgmtMediaDetailanding extends StatelessWidget {
  const CustMgmtMediaDetailanding(
      {super.key,
      @PathParam('mbrEttyId') this.mbrEttyId,
      @PathParam('mediaEttyId') this.mediaEttyId,
      @PathParam('prgEttyId') this.prgEttyId,
      @PathParam('mediaCtry') this.mediaCtry});

  final String? mbrEttyId;
  final String? mediaEttyId;
  final String? prgEttyId;
  final String? mediaCtry;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Scaffold(
        body: SingleChildScrollView(
            child: SizedBox(
      height: 1280,
      child: AcxTabView(
        routes: [CustMgmtMediaInfo(), CustMgmtMediaProperties(),CustMgmtMediaBalance()],
        tabs: [
          Tab(text: S.current.tabMediaInfo),
          Tab(text: S.current.tabMediaProperties),
          Tab(text: S.current.tabCardBalance),
        ],
      ),
    )));
  }
}
