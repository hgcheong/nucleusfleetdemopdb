import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=762;

@RoutePage()
class PrgCustMediaLanding extends StatelessWidget {
  const PrgCustMediaLanding(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return AcxTabView(align: Alignment.centerLeft, routes: [
      PrgCustMediaNumRange(),
      PrgCustMediaMTypeLanding(),
    ], tabs: [
      Tab(
        text: S.current.tabNumberRange,
      ),
      Tab(
        text: S.current.tabMediaType,
      ),
    ]);
  }
}
