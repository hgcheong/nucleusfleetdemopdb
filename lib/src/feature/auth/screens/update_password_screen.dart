import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/feature/auth/providers/update_password_form_provider.dart';

const int wid=214;

@RoutePage()
class UpdatePasswordScreen extends BaseStatefulScreen {
  final String token;

  const UpdatePasswordScreen({
    super.key,
    @PathParam('token') required this.token,
  });

  @override
  UpdatePasswordScreenState createState() => UpdatePasswordScreenState();
}

class UpdatePasswordScreenState extends BaseScreenState<UpdatePasswordScreen> {
  @override
  AppBar? appBar(BuildContext context) {
    return AppBar(
      title: const SelectableText("Update Password"),centerTitle: false,
    );
  }

  Future<void> _showDialog() async {
    ref.read(updatePasswordFormProvider).showDialog(widget.token);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _showDialog);
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _showDialog,
        child: const SelectableText("Update Password"),
      ),
    );
  }
}
