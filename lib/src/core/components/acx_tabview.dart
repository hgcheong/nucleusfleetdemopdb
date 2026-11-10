import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/constants.dart';

class AcxTabView extends ConsumerWidget {
  const AcxTabView(
      {super.key,
      required this.routes,
      required this.tabs,
      this.align = Alignment.centerLeft,
      this.headerBarWidget,
      this.labelPadding = const EdgeInsets.only(
    left: 16,
    right: 16,
    top: 0,
    bottom: 0,
  ),
      this.tabPadding  = const EdgeInsets.only(
    left: 10,
    right: 10,
    top: 0,
    bottom: 0,
  )
      });
  final List<PageRouteInfo<dynamic>> routes;
  final List<Tab> tabs;
  final AlignmentGeometry align;
  final List<Widget>? headerBarWidget;
  final EdgeInsets tabPadding;
 final EdgeInsets labelPadding;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter.tabBar(
      routes: routes,
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerBarWidget != null
                ? Flexible(
                    child: Container(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: headerBarWidget!.toList()),
                  ))
                : Container(),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Flexible(
                    flex: 12,
                    child: Align(
                      alignment: align,
                      child:  TabBar(
                        labelPadding: labelPadding,
                        padding: tabPadding,
                          indicatorColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? secondarylightColor
                                  : primarylightColor,
                          //     labelColor: tabBarColor ,
                          dividerColor: Colors.transparent,
                          //  labelStyle: tabBarLabelStyle ,
                          //    unselectedLabelStyle:tabBarUnselectedStyle ,
                          isScrollable: true,
                          onTap: (index) {
                            //       ref.read(appBarTitleProvider.notifier).state = tabs[index].text.toString();
                            if (tabs[index].height != 0) {
                              return tabsRouter.setActiveIndex(index);
                            } else {
                              return tabsRouter
                                  .setActiveIndex(controller.previousIndex);
                            }
                          },
                          controller: controller,
                          tabs: tabs),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 17,
              child: SizedBox(
                  height: 1280, child: child),
            )
         
          ],
        );
      },
    );
  }
}
