import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app/session_provider.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_component.dart';

class MainDrawer extends BaseComponent {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionProvider = ref.watch(sessionStateNotifierProvider);

    final isAuthenticated =
        sessionProvider.isAuthenticated && sessionProvider.user != null;

    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: Text(S.of(context).homeScreenTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pop();
              singleton<AppRouter>().replace(const DashboardContainer());
            },
          ),
          ListTile(
            title: const Text("Style Guide"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pop();
              singleton<AppRouter>().push(const StyleguideRoute());
            },
          ),
          ListTile(
            title: const Text("Settings"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pop();
              singleton<AppRouter>().push(const SettingsRoute());
            },
          ),
          if (isAuthenticated)
            ListTile(
              title: const Text("Logout"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                ref
                    .read(sessionStateNotifierProvider.notifier)
                    .logout()
                    .then((value) {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                });

                // if (await ref.read(sessionStateNotifierProvider.notifier).logout()) {
                //   Navigator.of(context).pop();

                // }
              },
            ),
          if (!isAuthenticated)
            ListTile(
              title: const Text("Login"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pop();
                singleton<AppRouter>().replace(const LoginRoute());
              },
            )
        ],
      ),
    );
  }
}
