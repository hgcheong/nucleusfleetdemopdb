import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/app/shared_enums.dart';
import 'package:nucleusv2/src/core/base_component.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/feature/auth/providers/two_factor_confirmation_form_provider.dart';

class TwoFactorConfirmation extends BaseComponent {
  TwoFactorConfirmation({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final formProvider = ref.read(twoFactorConfirmationFormProvider.notifier);
    final formModel = ref.watch(twoFactorConfirmationFormProvider);

    return Stack(
      alignment: Alignment.center,
      children: [
        Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                      decoration: const InputDecoration(
                        label: SelectableText("Confirmation Code"),
                      ),
                      keyboardType: TextInputType.phone,
                      controller: formProvider.codeController,
                      validator: formProvider.codeValidator),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            formProvider.submit();
                          },
                          label: "Confirm",
                          processing:
                              formModel.status == FormStatus.Processing),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
