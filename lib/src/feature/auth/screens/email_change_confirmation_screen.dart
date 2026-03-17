import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/centered_loader.dart';
import 'package:nucleusv2/src/feature/auth/providers/email_change_provider.dart';

const int wid=210;

@RoutePage()
class EmailChangeConfirmationScreen extends BaseStatefulScreen {
  final String token;

  const EmailChangeConfirmationScreen({
    super.key,
    @PathParam('token') required this.token,
  });

  @override
  EmailChangeConfirmationScreenState createState() =>
      EmailChangeConfirmationScreenState();
}

class EmailChangeConfirmationScreenState
    extends BaseScreenState<EmailChangeConfirmationScreen> {
  @override
  AppBar? appBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const SelectableText("Change Email"),
    );
  }

  Future<void> _confirm() async {
    ref.read(emailChangeProvider).changeEmail(widget.token);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _confirm);
  }

  @override
  Widget body(BuildContext context) {
    return const CenteredLoader();
  }
}
