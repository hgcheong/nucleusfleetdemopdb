import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/base_component.dart';
import 'package:nucleusv2/src/core/base_screen.dart';


import 'app_router.gr.dart';

@RoutePage()
class DashboardContainer extends BaseComponent {
  const DashboardContainer({super.key});

  static const List<PageRouteInfo> routes = [
    // HomeTabRouter(),
    // CategoryTabRouter(),
    // UsersTabRouter(),
    HomeRoute(),

  ];

  @override
  Widget body(BuildContext context, WidgetRef ref) {
 
//    Future.delayed(const Duration(seconds: 1), () {
   
//  ref.read(appBarTitleProvider.notifier).state = "";
//       });
    return AutoTabsScaffold(
      drawer: provideSideBar("Transaction"),
      routes: routes,
    );
  }

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    return body(context, ref);
  }
}
