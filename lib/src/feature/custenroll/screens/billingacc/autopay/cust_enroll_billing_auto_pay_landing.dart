import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=433;

@RoutePage()
class CustEnrollBillingAutoPayLanding extends StatelessWidget {
  const CustEnrollBillingAutoPayLanding({super.key, this.billingModelId});

  final String? billingModelId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return const AutoRouter();
  }
}
