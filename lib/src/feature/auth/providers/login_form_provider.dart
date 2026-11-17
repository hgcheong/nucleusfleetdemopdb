// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app/env.dart';
import 'package:nucleusv2/src/core/app/session_provider.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/accessmodel/accessmodel.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/user_mgmt_controller.dart';
import 'package:nucleusv2/src/feature/auth/components/login_splash.dart';
import 'package:nucleusv2/src/feature/auth/services/auth_service.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:nucleusv2/src/utils/validation.dart';

enum LoginFormStatus {
  Empty,
  Dirty,
  Processing,
  Success,
  Error,
}

class LoginFormModel {
  final String email;
  final String password;
  final LoginFormStatus status;

  const LoginFormModel({
    this.email = '',
    this.password = '',
    this.status = LoginFormStatus.Empty,
  });

  bool get isProcessing {
    return status == LoginFormStatus.Processing;
  }
}

class LoginFormProvider extends StateNotifier<LoginFormModel> {
  LoginFormProvider(this.ref, [LoginFormModel model = _initial])
      : super(model) {
    emailController = TextEditingController(text: model.email);
    passwordController = TextEditingController(text: model.password);

    emailController.addListener(_updateState);
    passwordController.addListener(_updateState);

    // After sign-out, make sure the form comes back ready: no splash and not
    // stuck in Processing.
    ref.listen<SessionModel>(sessionStateNotifierProvider, (prev, next) {
      if (prev?.isAuthenticated == true && !next.isAuthenticated) {
        _splash(null);
        if (state.isProcessing) _updateState(status: LoginFormStatus.Dirty);
      }
    });

    // Debug helper for remembering the preferred login credentials
    // Can be updated in the .env file
    if (Env.debug) {
      state = LoginFormModel(
        email: Env.debugLoginEmail,
        password: Env.debugLoginPassword,
        status: Env.debugLoginEmail.isEmpty && Env.debugLoginPassword.isEmpty
            ? LoginFormStatus.Empty
            : LoginFormStatus.Dirty,
      );

      emailController.text = Env.debugLoginEmail;
      passwordController.text = Env.debugLoginPassword;
    }
  }

  final Ref ref;

  static const _initial = LoginFormModel();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  void _updateState({
    LoginFormStatus status = LoginFormStatus.Dirty,
    bool clear = false,
  }) {
    state = LoginFormModel(
      email: clear ? '' : emailController.value.text,
      password: clear ? '' : passwordController.value.text,
      status: status,
    );
  }

  String get email => emailController.value.text;
  String get password => passwordController.value.text;

  String? emailValidator(String? value) => formValidatorEmail(value);

  String? passwordValidator(String? value) => formValidatorPassword(value);

  void clear() {
    emailController.text = Env.debug ? Env.debugLoginEmail : "";
    passwordController.text = Env.debug ? Env.debugLoginPassword : "";
    _updateState(status: LoginFormStatus.Empty, clear: true);
  }

  Future<void> forgotPassword() async {
    final data = await PromptModalForgetPassword.show(
      title: "Reset Password",
      labelText: "Your email address",
      validator: formValidatorEmail,
    );

    if (data == null || data.isEmpty) return;

    final email = data.first;

    final success = await AuthService().requestPasswordReset(email: email);
    if (success) {
      Toast.message("Check your email");
    } else {
      Toast.error('check');
    }
  }

  void _splash(LoginSplashStep? step) => ref.read(loginSplashStepProvider.notifier).state = step;

  /// Keeps the splash up for at least [_splashMin] so it doesn't just flash.
  static const _splashMin = Duration(milliseconds: 1200);

  Future<void> submit() async {
    // Already signing in (the splash is up).
    if (state.isProcessing && ref.read(loginSplashStepProvider) != null) return;
    final started = DateTime.now();
    _updateState(status: LoginFormStatus.Processing);
    _splash(LoginSplashStep.checking);
    try {
      await _submit(started);
    } catch (_) {
      _splash(null);
      _updateState(status: LoginFormStatus.Error);
      rethrow;
    }
  }

  Future<void> _submit(DateTime started) async {
    // read(loadingProvider.notifier).start();

    final loginResult =
        await AuthService().login(email: email, password: password);

    if (loginResult != null) {
      // if (loginResult.twoFa) {
      //   ref
      //       .read(sessionStateNotifierProvider.notifier)
      //       .setMetaData({'email': email, 'password': password});

      //   singleton<AppRouter>().push(const TwoFactorConfirmationRoute());
      //   Toast.message(
      //       "A confirmation code has been sent to your phone number.");
      //   // read(loadingProvider.notifier).complete();
      //   _updateState(status: LoginFormStatus.Success);

      //   return;
      // }

      if (loginResult.token != null && loginResult.errorMsg == null) {
        await ref
            .read(sessionStateNotifierProvider.notifier)
            .setToken(loginResult.token!);
        // read(loadingProvider.notifier).complete();
        _splash(LoginSplashStep.access);

        final access = QueryObject(
            querysql: '/sp/ApiSignInAccessCtrlList/queryasync',
            params: {
              "UserType": "I",
              "SignIn": email,
              "EttyId": null,
            },
            showMsg: false);

        final loginCtrlRes =
            await ref.watch(ReturndatafreezedProvider(access).future);
        final currentCtrlVal =
            ref.read(userAccessControllerProvider.notifier).state;
        if (currentCtrlVal != null && currentCtrlVal.isEmpty) {
          if (loginCtrlRes.data != null) {
            final List<Accessmodel> toUseAccessCtrl =
            Accessmodel.fromJsonList(loginCtrlRes.data!);    
            
            AcxAuthAccess.pageDeniedList = toUseAccessCtrl.where((c){
              return c.accessRightInd == "D" && c.moduleType == "pg";
            }).toList();

              AcxAuthAccess.actionDeniedList = toUseAccessCtrl.where((c){
              return c.accessRightInd == "R" && c.moduleType == "pg";
            }).toList();
          // ref.read(isDeniedPageControllerProvider.notifier).state = toUseAccessCtrl.where((c){
          //     return c.accessRightInd == "D" && c.moduleType == "pg";
          //   }).toList();
          //   ref.read(isDeniedActionControllerProvider.notifier).state = toUseAccessCtrl.where((c){
          //     return c.accessRightInd == "D" && c.moduleType == "pa";
          //   }).toList();
            ref.read(userAccessControllerProvider.notifier).state =
                toUseAccessCtrl;
      
          }
        }

        _splash(LoginSplashStep.opening);
        final shown = DateTime.now().difference(started);
        if (shown < _splashMin) await Future<void>.delayed(_splashMin - shown);

        // Not awaited: push() only completes when the dashboard is popped,
        // which never happens on sign-out (it is replaced), so awaiting it
        // left the splash and the Processing status in place for the next
        // sign-in.
        singleton<AppRouter>().push(const DashboardContainer());
        _splash(null);
        Toast.message("Welcome back!");
        clear();
        _updateState(status: LoginFormStatus.Success);
      } else {
        // Sign-in refused (wrong details etc.): back to the form.
        _splash(null);
        _updateState(status: LoginFormStatus.Error);
        Toast.error(loginResult.errorMsg ?? 'Sign in failed. Check your user ID and password.');
      }

      // read(loadingProvider.notifier).complete();
  
    }
    else{
           _splash(null);
           _updateState(status: LoginFormStatus.Error);

          
      Toast.error();
    }

//   Future<void> submit() async {
//     _updateState(status: LoginFormStatus.Processing);

//     // read(loadingProvider.notifier).start();

//     final loginResult = await AuthService().login(email: email, password: password);

//     if (loginResult != null) {
//      if (loginResult.twoFa) {
//         ref.read(sessionStateNotifierProvider.notifier).setMetaData({'email': email, 'password': password});

//         singleton<AppRouter>().push(const TwoFactorConfirmationRoute());
//         Toast.message("A confirmation code has been sent to your phone number.");
//         // read(loadingProvider.notifier).complete();
//         _updateState(status: LoginFormStatus.Success);

//         return;
//       }

//       if (loginResult.token != null && loginResult.errorMsg == null) {
//         await ref.read(sessionStateNotifierProvider.notifier).setToken(loginResult.token!);
//         // read(loadingProvider.notifier).complete();
//   singleton<AppRouter>().push(const DashboardContainer());
//      Toast.message("Welcome back!");
//         clear();
//         _updateState(status: LoginFormStatus.Success);

//      final access = QueryObject(querysql: '/sp/ApiSignInAccessCtrlList/queryasync', params: {
//   "UserType": "I",
//   "SignIn": email,
//   "EttyId" : null,
// }, showMsg: true);

//     final loginCtrlRes = ref.watch(ReturndatafreezedProvider(access));
//       loginCtrlRes.when(data: (dv){

//   ref.read(userAccessControllerProvider.notifier).state = dv.data;

//       }, error: (o, s){

//       }, loading: (){
//         const Center(child: CircularProgressIndicator(),);
//       });
//       }
//          return;
//     }
//     // read(loadingProvider.notifier).complete();
//     _updateState(status: LoginFormStatus.Error);
//     Toast.error();
//   }
  }
}

final loginFormStateNotifierProvider =
    StateNotifierProvider<LoginFormProvider, LoginFormModel>((ref) {
  return LoginFormProvider(ref);
});
