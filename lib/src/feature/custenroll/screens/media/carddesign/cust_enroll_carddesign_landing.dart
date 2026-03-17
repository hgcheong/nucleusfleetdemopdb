import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';

const int wid=499;

@RoutePage()
class CustEnrollMediaDesignLanding extends StatelessWidget {
  const CustEnrollMediaDesignLanding({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {}, child: const SelectableText('Testing')),
          SelectableText(singleton<AppRouter>().currentPath),
          Container(
            height: 3000,
            color: Colors.green,
          ),
          Container(
            height: 150,
            color: Colors.amber,
          )
        ],
      ),
    );
  }
}
