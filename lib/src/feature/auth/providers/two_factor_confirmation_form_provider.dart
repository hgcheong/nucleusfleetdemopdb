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

class TwoFactorConfirmationFormModel {
  final String code;
  final String email;
  final String password;
  final FormStatus status;

  const TwoFactorConfirmationFormModel({
    this.code = '',
    this.email = '',
    this.password = '',
    this.status = FormStatus.Empty,
  });

  bool get isProcessing {
    return status == FormStatus.Processing;
  }

  TwoFactorConfirmationFormModel copyWith({
    String? code,
    String? email,
    String? password,
    FormStatus? status,
  }) {
    return TwoFactorConfirmationFormModel(
      code: code ?? this.code,
      email: email ?? this.email,
      status: status ?? this.status,
      password: password ?? this.password,
    );
  }
}

class TwoFactorConfirmationFormProvider
    extends StateNotifier<TwoFactorConfirmationFormModel> {
  TwoFactorConfirmationFormProvider(this.ref,
      [TwoFactorConfirmationFormModel model = _initial])
      : super(model) {
    codeController = TextEditingController(text: model.code);

    codeController.addListener(_updateState);
  }

  final Ref ref;

  static const _initial = TwoFactorConfirmationFormModel();

  late final TextEditingController codeController;

  void _updateState({
    FormStatus status = FormStatus.Dirty,
    bool clear = false,
  }) {
    state = TwoFactorConfirmationFormModel(
      code: clear ? '' : codeController.value.text,
      status: status,
    );
  }

  String get code => codeController.value.text;
  String get email => state.email;
  String get password => state.password;

  String? codeValidator(String? value) =>
      formValidatorNotEmpty(value, "Confirmation Code");

  void clear() {
    codeController.text = "";

    _updateState(status: FormStatus.Empty, clear: true);
  }

  Future<void> resendCode() async {
    return;
    // ref.read(loadingProvider.notifier).start();

    // final _email = ref.read(sessionProvider).metaData['email'] ?? '';
    // final _password = ref.read(sessionProvider).metaData['password'] ?? '';
    // await AuthService().login(email: _email, password: _password);

    // Toast.message("New OTP sent");
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  Future<void> submit() async {
    _updateState(status: FormStatus.Processing);
    ref.read(loadingProvider.notifier).start();

    final email =
        ref.read(sessionStateNotifierProvider).metaData['email'] ?? '';
    final password =
        ref.read(sessionStateNotifierProvider).metaData['password'] ?? '';

    final loginResult = await AuthService()
        .login(email: email, otpCode: code, password: password);

    if (loginResult == null || loginResult.token == null) {
      ref.read(loadingProvider.notifier).complete();
      Toast.error("Invalid OTP Code");
      return;
    }

    await ref
        .read(sessionStateNotifierProvider.notifier)
        .setToken(loginResult.token!);
    ref.read(loadingProvider.notifier).complete();

    singleton<AppRouter>().push(const DashboardContainer());
    Toast.message("Welcome back!");
    clear();
  }
}

final twoFactorConfirmationFormProvider = StateNotifierProvider<
    TwoFactorConfirmationFormProvider, TwoFactorConfirmationFormModel>((ref) {
  return TwoFactorConfirmationFormProvider(ref);
});
