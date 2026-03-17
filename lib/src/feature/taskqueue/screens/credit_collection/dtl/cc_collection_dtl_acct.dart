import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/utils/appbartitle.dart';

const int wid=782;

@RoutePage()
class CreditCollectionDtlAcct extends ConsumerWidget {
  const CreditCollectionDtlAcct({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
      setTitle("Accounts Page", ref);
    return const Center(child: Text('Acct'),);
  }

}