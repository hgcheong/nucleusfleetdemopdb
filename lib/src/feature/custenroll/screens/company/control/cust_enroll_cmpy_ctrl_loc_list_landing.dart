import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=437;

@RoutePage()
class CustEnrollCmpyCtrlLocListLanding extends StatelessWidget {
  const CustEnrollCmpyCtrlLocListLanding(
      {super.key,
      @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
      this.custEttyId});

  final String? custEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    //  return Container();
    return const AutoRouter();
  }
}
