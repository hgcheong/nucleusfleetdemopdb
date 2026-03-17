import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/app.dart';
import 'package:nucleusv2/src/core/app/session_provider.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/feature/auth/services/auth_service.dart';
import 'package:nucleusv2/src/utils/toast.dart';

class EmailChangeProvider {
  Ref ref;
  EmailChangeProvider(this.ref);

  Future<void> changeEmail(String token) async {
    final success = await AuthService().completeEmailChange(token: token);

    if (success) {
      await ref.read(sessionStateNotifierProvider.notifier).refreshUser();
      Toast.message("Email updated successfully.");
    } else {
      Toast.error("A problem occurred and your email was not updated.");
    }

    AutoRouter.of(rootNavigatorKey.currentContext!)
        .push(const DashboardContainer());
  }
}

final emailChangeProvider = Provider(
  (ref) => EmailChangeProvider(ref),
);
