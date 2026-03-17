import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=826;

@RoutePage()
class CustEnrollProgramFeeLanding extends StatelessWidget {
  const CustEnrollProgramFeeLanding(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('billingEttyType') this.billingEttyType});

  final String? custEttyId;
  final String? prgEttyId;
  final String? billingEttyType;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return AcxTabView(align: Alignment.centerLeft, routes: [
      CustEnrollProgramFeeMediaLanding(),
      CustEnrollProgramFeeTransLanding(),
    ], tabs: [
      Tab(
        text: S.current.tabMedia,
      ),
      Tab(
        text: S.current.tabTransaction,
      ),
    ]);
  }
}
