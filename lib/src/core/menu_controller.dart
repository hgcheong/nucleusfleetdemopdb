import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trina_grid/trina_grid.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void closeDrawer() {
    _scaffoldKey.currentState!.closeDrawer();
  }
}

final menuMainDrawerSelectProvider = StateProvider<String>((ref) {
  return "";
});

final menuSideTabSelectProvider = StateProvider<String>((ref) {
  return "";
});

final menuShowSideBarProvider = StateProvider<bool>((ref) {
  return true;
});

final appBarTitleProvider = StateProvider.autoDispose<String?>((ref) {
  return "";
});

final menuControllerProvider = ChangeNotifierProvider<MenuController>((ref) {
  return MenuController();
});

final menuItemsAndSelectionProvider =
    StateProvider<MenuItemsAndSelection>(((ref) {
  return MenuItemsAndSelection();
}));

class MenuItemsAndSelection {
  //The strSideBar and strSideTab will determine what will be shown
  final String? strSideBar;
  final String? strSideTab;
  //The strSelectedSideBar or Tab will need to be used to hightlight
  final String? strSelectedSideBar;
  final String? strSelectedTabBar;
  final String? strBreadCrumb;
  MenuItemsAndSelection({
    this.strSideBar,
    this.strSideTab,
    this.strSelectedSideBar,
    this.strSelectedTabBar,
    this.strBreadCrumb,
  });
}

final globalPlutoSelectedRow = StateProvider<TrinaRow>((ref) {
  return TrinaRow.fromJson({});
});
