import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/feature/auth/components/auth_button.dart';
import 'package:nucleusv2/src/feature/settings/settings_form.dart';
import 'package:nucleusv2/src/core/base_screen.dart';

const int wid=192;

@RoutePage()
class SettingsScreen extends BaseScreen {
  const SettingsScreen({super.key});

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      centerTitle: false,
      title: SelectableText(S.of(context).settingsScreenTitle),
      actions: const [AuthButton()],
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return const SettingsForm();
  }
}
