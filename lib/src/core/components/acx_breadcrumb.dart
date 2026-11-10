import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/core/models/drawer_item.dart';
import 'package:nucleusv2/src/feature/home/home_screen.dart';

class AcxBreadcrumb extends ConsumerWidget implements PreferredSizeWidget {
  final List<DrawerItem> sideDrawerItems;

  const AcxBreadcrumb(this.sideDrawerItems, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //  ElevatedButton(onPressed: (){
          //   Toast.message( ref.read(globalPlutoSelectedRow).toJson().toString());
          //  }, child:const Text("Test")),
          Expanded(
              flex: 7,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: returnBreadCrumbs(context, ref))),
          const Expanded(
            flex: 5,
            child: MainSearchComponent(),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  List<Widget> returnBreadCrumbs(BuildContext context, WidgetRef ref) {
    List<Widget> toReturn = <Widget>[];
    toReturn.add(
      IconButton(
        onPressed: () {
          final curOpen = ref.read(menuShowSideBarProvider.notifier).state;
          ref.read(menuShowSideBarProvider.notifier).state = !curOpen;
        },
        icon: const Icon(Icons.menu),
      ),
    );
    int noOfCurmbs = sideDrawerItems.length;
    for (var i = 0; i < noOfCurmbs; i++) {
      toReturn.add(
        TextButton(
            onPressed: () {
              String navto = sideDrawerItems[i].route??"";
              if (navto == 'Home') {
                navto = '';
              }
              ref.read(appBarTitleProvider.notifier).state = "";
              ref.read(menuMainDrawerSelectProvider.notifier).state = navto;
              singleton<AppRouter>()
                  .navigatePath(sideDrawerItems[i].route.toString());
            },
            child: Text(
              sideDrawerItems[i].title,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            )),
      );
      toReturn.add(
        const Icon(Icons.arrow_right),
      );
    }
    if (noOfCurmbs > 0) {
      toReturn.removeLast();
    }
    return toReturn;
  }
}
