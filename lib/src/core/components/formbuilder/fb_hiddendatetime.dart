import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FbHiddenDateTime extends StatelessWidget {
  const FbHiddenDateTime({
    super.key,
    required this.name,
    this.initialValue,
  });

  final String name;
  final DateTime? initialValue;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        initialValue: initialValue,
        builder: (field) => Container(),
        name: name);
  }
}
