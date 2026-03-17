import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=718;

@RoutePage()
class MchtMgmtLocationProfileContactLanding extends ConsumerWidget {
  const MchtMgmtLocationProfileContactLanding({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return const AutoRouter();
  }
}
