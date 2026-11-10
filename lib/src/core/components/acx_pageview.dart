import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';

class AcxPageView extends ConsumerWidget {
  const AcxPageView(
      {super.key,
      required this.routes,
      required this.tabs,
      this.align = Alignment.centerLeft,
      this.headerBarWidget});
  final List<PageRouteInfo<dynamic>> routes;
  final List<Tab> tabs;
  final AlignmentGeometry align;
  final List<Widget>? headerBarWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter.tabBar(
      routes: routes,
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerBarWidget != null
                ? Expanded(
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
                  Expanded(
                    flex: 12,
                    child: Align(
                      alignment: align,
                      child: TabBar(
                          labelColor: tabBarColor,
                          dividerColor: Colors.transparent,
                          //  labelStyle: tabBarLabelStyle ,
                          unselectedLabelStyle: tabBarUnselectedStyle,
                          isScrollable: true,
                          onTap: (index) {
                       
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
              flex: 12,
              child: SizedBox(
                  height: 1280, child: child),
            )
          ],
        );
      },
    );
  }
}
