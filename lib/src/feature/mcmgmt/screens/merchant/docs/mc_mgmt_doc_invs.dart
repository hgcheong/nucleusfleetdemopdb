import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=733;

@RoutePage()
class MchtMgmtDocInvs extends StatelessWidget {
  const MchtMgmtDocInvs({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return const Center(
      child: SelectableText('MchtMgmtDocInvs'),
    );
  }
}
