import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=465;

@RoutePage()
class CustEnrollCostCtrlLoc extends StatelessWidget {
  const CustEnrollCostCtrlLoc({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return const Center(
      child: SelectableText('CustEnrollCostCtrlLoc'),
    );
  }
}
