import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/app.dart';
import 'package:nucleusv2/src/core/app/session_provider.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/feature/auth/providers/login_form_provider.dart';
import 'package:nucleusv2/src/utils/dialogs.dart';
import 'package:nucleusv2/src/feature/auth/services/auth_service.dart';
import 'package:nucleusv2/src/feature/locale/locale_provider.dart';
import 'package:nucleusv2/src/feature/theme/theme_provider.dart';
import 'package:nucleusv2/src/feature/user/models/user.dart';
import 'package:nucleusv2/src/utils/strings.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'package:nucleusv2/src/utils/validation.dart';

class SettingsFormModel {
  final ThemeMode theme;
  final Locale? locale;
  final bool isAuthenticated;
  final User? user;
  const SettingsFormModel({
    this.theme = ThemeMode.system,
    this.locale,
    this.isAuthenticated = false,
    this.user,
  });

  SettingsFormModel copyWith(
      {ThemeMode? theme, Locale? locale, bool? isAuthenticated, User? user}) {
    return SettingsFormModel(
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
    );
  }
}

class SettingsFormProvider extends StateNotifier<SettingsFormModel> {
  SettingsFormProvider(this.ref, [SettingsFormModel model = _initial])
      : super(model);
  final Ref ref;

  static const _initial = SettingsFormModel();

  //Theme
  void setDark() {
    ref.read(themeProvider.notifier).setDark();
    state = state.copyWith(theme: ThemeMode.dark);
  }

  void setLight() {
    ref.read(themeProvider.notifier).setLight();
    state = state.copyWith(theme: ThemeMode.light);
  }

  void setSystem() {
    ref.read(themeProvider.notifier).setSystem();
    state = state.copyWith(theme: ThemeMode.system);
  }

  // Locale

  List<Locale> get supportedLocales {
    return LocaleProvider.supportedLocales;
  }

  void setLocale(Locale locale) async {
    ref.read(localeProvider.notifier).setLocale(locale);

    state = state.copyWith(locale: locale);

    //await UserService().updateMe({'language': locale.languageCode});
  }

  // Session
  void logout() {
    ref.read(sessionStateNotifierProvider.notifier).logout();
    state = state.copyWith(isAuthenticated: false);
  }

  void handleLogin() {
    AutoRouter.of(rootNavigatorKey.currentContext!).push(const LoginRoute());
  }

  void newPassword() async {
    final loginFormProvider = ref.read(loginFormStateNotifierProvider.notifier);

    await PromptModalNewPassword.show(
      title: "Set a new Password",
      validator: (String? value) =>
          formValidatorNotEmpty(value, "Current Password"),
      labelText: "New Password",
      obscureText: true,
      seconaryInput: true,
      secondaryLabel: "Confirm New Password",
      secondaryValidator: formValidatorPassword,
      secondaryObscureText: true,
      onValidSubmission: (data) async {
        if (data.length < 2) return;
        final oldPassword = data[0];
        final newPassword = data[1];

        final success = await AuthService().changePassword(
            email: loginFormProvider.email,
            oldPassword: oldPassword,
            newPassword: newPassword);

        if (success) {
          Navigator.of(rootNavigatorKey.currentContext!).pop();
          Toast.message("Password Changed");
        } else {
          Toast.error();
        }
      },
    );
  }

  void changePassword() async {
    final loginFormProvider = ref.read(loginFormStateNotifierProvider.notifier);
    await PromptModal.show(
      title: "Change Password",
      validator: (String? value) =>
          formValidatorNotEmpty(value, "Current Password"),
      labelText: "Current Password",
      obscureText: true,
      seconaryInput: true,
      secondaryLabel: "Confirm New Password",
      secondaryValidator: formValidatorPassword,
      secondaryObscureText: true,
      onValidSubmission: (data) async {
        if (data.length < 2) return;
        final oldPassword = data[0];
        final newPassword = data[1];

        final success = await AuthService().changePassword(
            email: loginFormProvider.email,
            oldPassword: oldPassword,
            newPassword: newPassword);
        Navigator.of(rootNavigatorKey.currentContext!).pop();
        if (success) {
  
          Toast.message("Password Changed");
        } else {

           Toast.error('Failed to Change password');
        }
      },
    );
  }

  void forgotPassword() async {
    await PromptModal.show(
      title: "Forgot Password",
      validator: (String? value) => formValidatorEmail(value),
      labelText: "Your Email",
      onValidSubmission: (data) async {
        if (data.isEmpty) return;
        final email = data[0];

        final available = await AuthService().emailAvailable(email);
        if (!available) {
          Toast.message("This email is already in use.");
          return;
        }

        final success = await AuthService().changeEmail(email: email);

        if (success) {
          Navigator.of(rootNavigatorKey.currentContext!).pop();
          Toast.message("We've sent a confirmation link to $email.");
        } else {
          Toast.error();
        }
      },
    );
  }

  void changeEmail() async {
    await PromptModal.show(
      title: "Change Email",
      validator: (String? value) => formValidatorEmail(value),
      labelText: "New Email",
      onValidSubmission: (data) async {
        if (data.isEmpty) return;
        final email = data[0];

        final available = await AuthService().emailAvailable(email);
        if (!available) {
          Toast.message("This email is already in use.");
          return;
        }

        final success = await AuthService().changeEmail(email: email);

        if (success) {
          Navigator.of(rootNavigatorKey.currentContext!).pop();
          Toast.message("We've sent a confirmation link to $email.");
        } else {
          Toast.error();
        }
      },
    );
  }

  void changePhoneNumber([bool change = true]) async {
    await PromptModal.show(
      title: change ? "Change Phone Number" : "Add Phone Number",
      validator: (String? value) => formValidatorPhoneNumber(value),
      labelText: change ? "New Phone Number" : "Phone Number",
      seconaryInput: true,
      secondaryLabel: "Password",
      secondaryObscureText: true,
      secondaryValidator: (String? value) =>
          formValidatorNotEmpty(value, "Password"),
      onValidSubmission: (data) async {
        if (data.length < 2) return;
        final phoneNumber = normalizePhoneNumber(data[0]);
        final password = data[1];

        final email = ref.read(sessionStateNotifierProvider).user!.email!;

        final passwordIsCorrect = await AuthService()
            .validateLoginCredentials(email: email, password: password);

        if (!passwordIsCorrect) {
          Toast.error("Incorrect Password");
          return;
        }

        ref
            .read(sessionStateNotifierProvider.notifier)
            .setMetaData({'email': email, 'password': password});

        final success =
            await AuthService().changePhoneNumber(phoneNumber: phoneNumber);

        if (success) {
          Navigator.of(rootNavigatorKey.currentContext!).pop();
          Toast.message("We've sent a confirmation code to $phoneNumber.");
          singleton<AppRouter>().push(const TwoFactorConfirmationRoute());
        } else {
          Toast.error();
        }
      },
    );
  }

  void editProfile() {
    singleton<AppRouter>().push(const EditProfileRoute());
  }
}

final settingsForm =
    StateNotifierProvider<SettingsFormProvider, SettingsFormModel>((ref) {
  final initial = SettingsFormModel(
    theme: ref.read(themeProvider),
    locale: ref.read(localeProvider),
    isAuthenticated: ref.watch(sessionStateNotifierProvider).isAuthenticated,
    user: ref.watch(sessionStateNotifierProvider).user,
  );

  return SettingsFormProvider(ref, initial);
});
