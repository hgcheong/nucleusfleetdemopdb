import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FbDateTimeText extends StatelessWidget {
  const FbDateTimeText({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    this.onChanged,
  });

  final String name;
  final String label;
  final DateTime? initialValue;
  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      enabled: false,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: initialValue.toString(),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
