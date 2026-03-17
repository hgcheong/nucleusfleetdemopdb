import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class MyAppRouter extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.data != null) {
      // print('didPush');
      // print(route.settings.name);
    }
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    // print('didInitTabRoute');
    // print(route.name);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    // print('didChangeTabRoute');
    // print(route.name);
  }
}
