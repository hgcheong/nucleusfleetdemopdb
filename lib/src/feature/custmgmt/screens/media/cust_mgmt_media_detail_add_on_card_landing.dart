import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=319;

@RoutePage()
class CustMgmtMediaDetailAddOnCardLanding extends StatelessWidget {
  const CustMgmtMediaDetailAddOnCardLanding(
      {super.key,
      @PathParam('mbrEttyId') this.mbrEttyId,
      @PathParam('mediaId') this.mediaId,
      @PathParam('prgEttyId') this.prgEttyId,
      @PathParam('mediaCtry') this.mediaCtry});

  final String? mbrEttyId;
  final String? mediaId;
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
        routes: [
          CustMgmtMediaAddOnCardProperties(),
          CustMgmtMediaAddOnCardDesign()
        ],
        tabs: [
          Tab(text: S.current.tabMediaProperties),
          (mediaId == null || mediaId == 'new')
              ? const Tab(
                  text: '',
                  height: 0,
                )
              : Tab(text: S.current.tabCardDesign),
        ],
      ),
    )));
  }
}
