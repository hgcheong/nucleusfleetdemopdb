import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/app.dart';

class HomeScreenProvider {
  HomeScreenProvider();

  void handleEdit() {
    AutoRouter.of(rootNavigatorKey.currentContext!).pushPath('placeholder');
  }
}

final homeScreenProvider = Provider((ref) {
  return HomeScreenProvider();
});
