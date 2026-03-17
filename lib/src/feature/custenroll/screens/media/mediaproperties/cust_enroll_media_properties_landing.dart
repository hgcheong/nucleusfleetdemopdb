import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';

const int wid=501;

@RoutePage()
class CustEnrollMediaPropertiesLanding extends StatelessWidget {
  const CustEnrollMediaPropertiesLanding({
    super.key,
  });

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    var container = Container(
      height: 3000,
      color: Colors.green,
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {}, child: const SelectableText('Testing')),
          SelectableText(singleton<AppRouter>().currentPath),
          container,
          Container(
            height: 150,
            color: Colors.amber,
          )
        ],
      ),
    );
  }
}
