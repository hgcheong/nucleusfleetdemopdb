import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/feature/auth/components/auth_button.dart';
import 'package:nucleusv2/src/feature/user/components/edit_profile.dart';

const int wid=247;

@RoutePage()
class EditProfileScreen extends BaseScreen {
  const EditProfileScreen({super.key});

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const SelectableText("Edit Profile"),
      centerTitle: false,
      actions: const [AuthButton()],
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return const EditProfile();
  }
}
