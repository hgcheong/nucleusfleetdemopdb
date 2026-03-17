import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/empty_placeholder.dart';
import 'package:nucleusv2/src/feature/user/components/profile.dart';
import 'package:nucleusv2/src/feature/user/providers/user_detail_provider.dart';

const int wid=248;

@RoutePage()
class ProfileScreen extends BaseScreen {
  final String uuid;
  const ProfileScreen({super.key, @PathParam('uuid') required this.uuid});

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDetailProvider(uuid));

    return user.when(
      loading: () => AppBar(
        centerTitle: false,
        title: const SelectableText("Profile"),
      ),
      data: (user) => AppBar(
        centerTitle: false,
        title: SelectableText(user.name),
      ),
      error: (_, __) => AppBar(
        centerTitle: false,
        title: const SelectableText("Error"),
      ),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final user = ref.watch(userDetailProvider(uuid));

    return user.when(
      data: (user) => Profile(user: user),
      error: (_, __) => const EmptyPlaceholder(title: "Error"),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
