import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=571;

@RoutePage()
class CustMgmtCmpySubsidyLanding extends StatelessWidget {
  const CustMgmtCmpySubsidyLanding({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return const AutoRouter();
  }
}
