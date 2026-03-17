import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FbHiddenText extends StatelessWidget {
  const FbHiddenText({
    super.key,
    required this.name
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        builder: (field) => Container(),
        name: name);
  }
}
