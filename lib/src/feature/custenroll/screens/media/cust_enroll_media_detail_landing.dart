import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=287;

@RoutePage()
class CustEnrollMediaDetailanding extends StatelessWidget {
  const CustEnrollMediaDetailanding(
      {super.key,
      @PathParam('mbrEttyId') this.mbrEttyId,
      @PathParam('mediaEttyId') this.mediaEttyId,
      @PathParam('prgEttyId') this.prgEttyId,
      @PathParam('mediaCtgry') this.mediaCtgry});

  final String? mbrEttyId;
  final String? mediaEttyId;
  final String? prgEttyId;
  final String? mediaCtgry;
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
        routes: [CustEnrollMediaProperties(), CustEnrollMediaDesign()],
        tabs: [
          Tab(text: S.current.tabMediaProperties),
          (mediaEttyId == null || mediaEttyId == 'new')
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
