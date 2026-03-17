import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FbHiddenNumber extends StatelessWidget {
  const FbHiddenNumber({
    super.key,
    required this.name,
    this.initialValue,
  });

  final String name;
  final num? initialValue;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        initialValue: initialValue,
        builder: (field) => Container(),
        name: name);
  }
}
