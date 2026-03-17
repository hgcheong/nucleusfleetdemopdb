import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=666;

@RoutePage()
class MchtEnrlDocBank extends StatelessWidget {
  const MchtEnrlDocBank({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return const Center(
      child: SelectableText('MchtEnrlDocBank'),
    );
  }
}
