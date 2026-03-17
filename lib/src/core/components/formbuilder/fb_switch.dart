import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FbSwitch extends StatelessWidget {
  const FbSwitch({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    this.onChanged,
  });

  final String name;
  final String label;
  final String? initialValue;
  final Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return FormBuilderSwitch(
      decoration: InputDecoration.collapsed(
        hintText: label,
        border: InputBorder.none,
      ),
      name: name,
      onChanged: onChanged,
      title: Text(label),
      initialValue:  initialValue == 'Y'  ? true : false,
      valueTransformer: (value) {
        if(value == null){
          return null;
        }
        return value == false ? 'N' : 'Y';
      },
    );
  }
}
