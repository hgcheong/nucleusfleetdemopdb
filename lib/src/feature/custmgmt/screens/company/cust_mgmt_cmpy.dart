import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=307;

@RoutePage()
class CustMgmtCmpy extends StatelessWidget {
  const CustMgmtCmpy({super.key, @PathParam('custEttyId') this.custEttyId});
  final String? custEttyId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return const AutoRouter();
  }
}
