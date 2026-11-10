import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/utils/acx_authaccess.dart';
import 'package:nucleusv2/src/utils/acx_notauthorised.dart';
import 'package:nucleusv2/src/utils/uihelpers.dart';


const int wid=892;

@RoutePage()
class CustEnrollSubsidy2CustLanding extends StatelessWidget {
  const CustEnrollSubsidy2CustLanding({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return AutoRouter();
  }
  
}
