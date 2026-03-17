import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/utils/appbartitle.dart';

const int wid=783;

@RoutePage()
class CreditCollectionDtlAcctContact extends ConsumerWidget {
  const CreditCollectionDtlAcctContact({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
   setTitle("Contact Page", ref);
    return const Center(child: Text('Acct Contact'),);
  }

}