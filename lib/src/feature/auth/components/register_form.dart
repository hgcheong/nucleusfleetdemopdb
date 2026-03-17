import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/app/shared_enums.dart';
import 'package:nucleusv2/src/core/base_component.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/feature/auth/providers/register_form_provider.dart';

class RegisterForm extends BaseComponent {
  RegisterForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final registerFormProvider =
        ref.read(registerFormStateNotifierProvider.notifier);
    final registerFormModel = ref.watch(registerFormStateNotifierProvider);

    return Form(
      key: _formKey,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: SelectableText("Your Name"),
                ),
                controller: registerFormProvider.nameController,
                validator: registerFormProvider.nameValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: SelectableText("Email"),
                ),
                controller: registerFormProvider.emailController,
                validator: registerFormProvider.emailValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: SelectableText("Phone Number"),
                ),
                controller: registerFormProvider.phoneNumberController,
                validator: registerFormProvider.phoneNumberValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: SelectableText("Username"),
                ),
                controller: registerFormProvider.usernameController,
                validator: registerFormProvider.usernameValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: SelectableText("Password"),
                ),
                controller: registerFormProvider.passwordController,
                validator: registerFormProvider.passwordValidator,
                obscureText: true,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    onPressed: registerFormModel.status == FormStatus.Empty
                        ? null
                        : () {
                            registerFormProvider.clear();
                          },
                    label: "Clear",
                    type: AppButtonType.Text,
                  ),
                  AppButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      registerFormProvider.submit();
                    },
                    label: "Register",
                    processing:
                        registerFormModel.status == FormStatus.Processing,
                    icon: Icons.how_to_reg,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
