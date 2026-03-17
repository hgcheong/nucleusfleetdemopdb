import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FbHiddenSwitch extends StatelessWidget {
  const FbHiddenSwitch({
    super.key,
       required this.initialValue,
    required this.name
  });

  final String name;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
     return FormBuilderField(
        builder: (field) => Container(),
        name: name);
  }
}
