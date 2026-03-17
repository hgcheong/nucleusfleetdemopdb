import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=831;

@RoutePage()
class CustEnrollProgramFeeTransLanding extends StatelessWidget {
  const CustEnrollProgramFeeTransLanding(
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
    return const Column(
      children: [
        Expanded(flex: 12, child: AutoRouter()),
      ],
    );
  }
}
