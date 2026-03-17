import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/app/loading_provider.dart';
import 'package:nucleusv2/src/core/app/session_provider.dart';
import 'package:nucleusv2/src/core/app/shared_enums.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/feature/auth/services/auth_service.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'package:nucleusv2/src/utils/validation.dart';

class RegisterFormModel {
  final String email;
  final String password;
  final String username;
  final String phoneNumber;
  final String name;
  final FormStatus status;

  const RegisterFormModel({
    this.email = 'tyler@tylersavery.com',
    this.password = 'artyarty87',
    this.username = 'tylersavery',
    this.phoneNumber = '14169974264',
    this.name = 'Tyler Savery',
    this.status = FormStatus.Empty,
  });
}

class RegisterFormProvider extends StateNotifier<RegisterFormModel> {
  RegisterFormProvider(this.ref, [RegisterFormModel model = _initial])
      : super(model) {
    emailController = TextEditingController(text: model.email);
    usernameController = TextEditingController(text: model.username);
    phoneNumberController = TextEditingController(text: model.phoneNumber);
    passwordController = TextEditingController(text: model.password);
    nameController = TextEditingController(text: model.name);

    emailController.addListener(_updateState);
    usernameController.addListener(_updateState);
    phoneNumberController.addListener(_updateState);
    passwordController.addListener(_updateState);
    nameController.addListener(_updateState);
  }

  final Ref ref;

  static const _initial = RegisterFormModel();

  late final TextEditingController emailController;
  late final TextEditingController usernameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;

  void _updateState({
    FormStatus status = FormStatus.Dirty,
    bool clear = false,
  }) {
    state = RegisterFormModel(
      email: clear ? '' : emailController.value.text,
      username: clear ? '' : usernameController.value.text,
      phoneNumber: clear ? '' : phoneNumberController.value.text,
      password: clear ? '' : passwordController.value.text,
      name: clear ? '' : nameController.value.text,
      status: status,
    );
  }

  String get email => emailController.value.text;
  String get username => usernameController.value.text;
  String get phoneNumber => phoneNumberController.value.text;
  String get password => passwordController.value.text;
  String get name => nameController.value.text;

  String? emailValidator(String? value) => formValidatorEmail(value);
  String? usernameValidator(String? value) => formValidatorUsername(value);
  String? phoneNumberValidator(String? value) =>
      formValidatorPhoneNumber(value);
  String? passwordValidator(String? value) => formValidatorPassword(value);

  String? nameValidator(String? value) => formValidatorNotEmpty(value, "Name");

  void clear() {
    emailController.text = "";
    usernameController.text = "";
    phoneNumberController.text = "";
    passwordController.text = "";
    nameController.text = "";
    _updateState(status: FormStatus.Empty, clear: true);
  }

  Future<bool> _validateEmail(String email) {
    return AuthService().emailAvailable(email);
  }

  Future<bool> _validateUsername(String username) {
    return AuthService().usernameAvailable(username);
  }

  Future<void> submit() async {
    _updateState(status: FormStatus.Processing);
    ref.read(loadingProvider.notifier).start();

    if (!await _validateEmail(email)) {
      Toast.error("Email unavailable.");
      return;
    }

    if (!await _validateUsername(username)) {
      Toast.error("Username unavailable.");
      return;
    }

    final user = await AuthService().register(
      email: email,
      username: username,
      password: password,
      phoneNumber: phoneNumber,
      name: name,
    );

    if (user == null) {
      Toast.error();

      return;
    }

    if (user.is2faEnabled) {
      singleton<AppRouter>().push(const TwoFactorConfirmationRoute());

      ref
          .read(sessionStateNotifierProvider.notifier)
          .setMetaData({'email': email, 'password': password});
      Toast.message("A confirmation code has been sent to your phone number.");
      ref.read(loadingProvider.notifier).complete();
    } else {
      final loginResult =
          await AuthService().login(email: email, password: password);
      if (loginResult != null && loginResult.token != null) {
        await ref
            .read(sessionStateNotifierProvider.notifier)
            .setToken(loginResult.token!);

        singleton<AppRouter>().push(const DashboardContainer());
        Toast.message("Thanks for joining!");
        ref.read(loadingProvider.notifier).complete();
        clear();
        return;
      } else {
        Toast.error();
        ref.read(loadingProvider.notifier).complete();
      }
    }
  }
}

final registerFormStateNotifierProvider =
    StateNotifierProvider<RegisterFormProvider, RegisterFormModel>((ref) {
  return RegisterFormProvider(ref);
});
