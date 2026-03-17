import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/base_component.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/feature/locale/locale_provider.dart';
import 'package:nucleusv2/src/feature/settings/settings_form_provider.dart';
import 'package:nucleusv2/src/feature/theme/app_theme.dart';

class SettingsForm extends BaseComponent {
  const SettingsForm({super.key});

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final form = ref.read(settingsForm.notifier);
    final formModel = ref.watch(settingsForm);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _ListItem(
                  icon: Icons.color_lens,
                  title: "Theme",
                  content: DropdownButton<ThemeMode>(
                    value: formModel.theme,
                    onChanged: (value) {
                      switch (value) {
                        case ThemeMode.dark:
                          form.setDark();
                          break;
                        case ThemeMode.light:
                          form.setLight();
                          break;
                        // case ThemeMode.system:
                        //   form.setSystem();
                        //   break;
                        default:
                          break;
                      }
                    },
                    items: const [
                      // DropdownMenuItem(
                      //   value: ThemeMode.system,
                      //   child: SelectableText('System Theme'),
                      // ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Light Theme'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Dark Theme'),
                      )
                    ],
                  ),
                ),
                _ListItem(
                  icon: Icons.language,
                  title: S.of(context).language,
                  content: DropdownButton<Locale>(
                    value: formModel.locale,
                    onChanged: (value) {
                      form.setLocale(value!);
                    },
                    items: form.supportedLocales
                        .map(
                          (locale) => DropdownMenuItem(
                            value: locale,
                            child: Text(LocaleProvider.localeToLabel(locale)),
                          ),
                        )
                        .toList(),
                  ),
                ),
                // if (formModel.isAuthenticated)
                //   _ListItem(
                //     icon: Icons.person,
                //     title: "Profile",
                //     content: OutlinedButton(
                //       onPressed: form.editProfile,
                //       child: const SelectableText("Edit Profile"),
                //     ),
                //   ),
                // if (formModel.user != null)
                //   _ListItem(
                //     icon: Icons.email,
                //     title: formModel.user!.email ?? "-",
                //     subtitle: "Email Address",
                //     content: OutlinedButton(
                //       onPressed: form.changeEmail,
                //       child: const SelectableText("Change Email"),
                //     ),
                //   ),
                // if (formModel.user != null)
                //   _ListItem(
                //     icon: Icons.phone,
                //     title: formModel.user!.phoneNumber.isEmpty
                //         ? "-"
                //         : formModel.user!.phoneNumber,
                //     subtitle: "Phone Number",
                //     content: OutlinedButton(
                //       child: SelectableText(formModel.user!.phoneNumber.isEmpty
                //           ? "Add Phone Number"
                //           : "Change Phone Number"),
                //       onPressed: () {
                //         form.changePhoneNumber(
                //             formModel.user!.phoneNumber.isNotEmpty);
                //       },
                //     ),
                //   ),
                // _ListItem(
                //   icon: Icons.lock,
                //   title: "******",
                //   subtitle: "Forgot Password",
                //   content: OutlinedButton(
                //     onPressed: form.forgotPassword,
                //     child: const SelectableText("Email Address"),
                //   ),
                // ),
                if (formModel.isAuthenticated)
                  _ListItem(
                    icon: Icons.lock,
                    title: "******",
                    subtitle: "Password",
                    content: OutlinedButton(
                      onPressed: form.changePassword,
                      child: const Text("Change Password"),
                    ),
                  ),
                // _ListItem(
                //   icon: Icons.lock,
                //   title: "******",
                //   subtitle: "New Password",
                //   content: OutlinedButton(
                //     onPressed: form.newPassword,
                //     child: const SelectableText("New Password"),
                //   ),
                // ),
                const Divider(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (formModel.isAuthenticated)
                          AppButton(
                            variant: AppColorVariant.Danger,
                            onPressed: form.logout,
                            label: "Logout",
                            icon: Icons.logout,
                          ),
                        if (!formModel.isAuthenticated)
                          AppButton(
                            onPressed: form.handleLogin,
                            label: "Login",
                            icon: Icons.login,
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget content;

  const _ListItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: content,
    );
  }
}
