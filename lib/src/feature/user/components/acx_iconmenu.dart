import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/config/constants/breakpoints.dart';
import 'package:nucleusv2/src/core/app/session_provider.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';

class AcxIconMenu extends ConsumerWidget {
  const AcxIconMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionProvider = ref.watch(sessionStateNotifierProvider);
    // final strSideBar = ref.watch(menuSideBarProvider);

    final isAuthenticated =
        sessionProvider.isAuthenticated && sessionProvider.user != null;

    return isAuthenticated
        ? IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Open shopping cart',
            onPressed: () {
              if (BreakPoints.useMobileLayout(context)) {
                Scaffold.of(context).openDrawer();
              } else {
                ref.read(menuShowSideBarProvider.notifier).state =
                    !ref.read(menuShowSideBarProvider.notifier).state;
              }
            },
          )
        : Container();
  }
}
