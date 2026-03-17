import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/drawer_list_tile.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/core/models/accessmodel/accessmodel.dart';
import 'package:nucleusv2/src/core/models/drawer_item.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/user_mgmt_controller.dart';

class AcxSideTab extends ConsumerWidget {
  final List<DrawerItem> sideDrawerItems;
  const AcxSideTab(this.sideDrawerItems, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMenuSelected = ref.watch(menuSideTabSelectProvider);

    return SizedBox(
      height: 1280,
      width: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Drawer(
            //  backgroundColor: bgColor,
            child: ListView(
                shrinkWrap: true,
                children:
                    returnDrawerItems(context, ref, currentMenuSelected))),
      ),
    );
  }

  List<Widget> returnDrawerItems(
      BuildContext context, WidgetRef ref, String currentSelected) {
    final accessCtrlProvider = ref.watch(userAccessControllerProvider);
    List<Accessmodel> toBlock = [];
    if (accessCtrlProvider != null) {
      toBlock = accessCtrlProvider
          .where((c) => c.accessRightInd == "D" && c.moduleType == "st")
          .toList();
    }
    List<DrawerListTileSideTab> toReturn = <DrawerListTileSideTab>[];
    for (var i = 0; i < sideDrawerItems.length; i++) {
      String theTitle = sideDrawerItems[i].title;
      final blockedWidget =
          toBlock.where((c) => c.moduleId == sideDrawerItems[i].wid);
      if (blockedWidget.isEmpty) {
        toReturn.add(DrawerListTileSideTab(
            wid: sideDrawerItems[i].wid,
              wPid: sideDrawerItems[i].wPid,
            title: "",
            titleType: sideDrawerItems[i].titleType,
            titleParam: sideDrawerItems[i].titleParam,
            hightlightColor:
                currentSelected == theTitle ? secondaryColor : bgColor,
            tooltipMessage: sideDrawerItems[i].tooltipMessage,
            theIcon: sideDrawerItems[i].theIcon,
            svgSrc: sideDrawerItems[i].svgSrc.toString(),
            thecolor:
                currentSelected == theTitle ? tabBarColor : colorUnSelected,
            press: () {
              singleton<AppRouter>()
                  .navigatePath(sideDrawerItems[i].route.toString());
              ref.read(menuSideTabSelectProvider.notifier).state = theTitle;
            }));
      }
    }
    return toReturn;
    //  return [];
  }
}
