import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/app/loading_provider.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/utils/dialogs.dart';
import 'package:nucleusv2/src/feature/auth/services/auth_service.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'package:nucleusv2/src/utils/validation.dart';

class UpdatePasswordFormProvider {
  Ref ref;
  UpdatePasswordFormProvider(this.ref);

  Future<void> showDialog(String token) async {
    final data = await PromptModal.show(
      title: "Update Password",
      validator: formValidatorPassword,
      labelText: "Confirm New Password",
      obscureText: true,
      confirmText: "Update",
    );

    if (data == null || data.isEmpty) {
      return;
    }

    final password = data.first;

    ref.read(loadingProvider.notifier).start();

    final success = await AuthService().completePasswordReset(
      password: password,
      token: token,
    );
    if (success) {
      ref.read(loadingProvider.notifier).complete();
      singleton<AppRouter>().push(const LoginRoute());
      Toast.message("Password updated successfully");
      return;
    } else {
      Toast.error();
    }
    ref.read(loadingProvider.notifier).complete();
  }
}

final updatePasswordFormProvider = Provider(
  (ref) => UpdatePasswordFormProvider(ref),
);
