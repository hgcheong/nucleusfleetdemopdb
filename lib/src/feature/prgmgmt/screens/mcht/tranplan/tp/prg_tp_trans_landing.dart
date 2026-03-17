import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=140;
@RoutePage()
class PrgMgmtMchtTpTransLanding extends StatelessWidget {
  const PrgMgmtMchtTpTransLanding({
    super.key,
    @PathParam.inherit('prgEttyId') this.prgEttyId,
  });
  final String? prgEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return const AutoRouter();
  }
}
