import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FbNumber1to100withDecimal extends StatelessWidget {
  const FbNumber1to100withDecimal(
      {super.key,
      required this.name,
      required this.label,
      this.initialValue,
      this.onChanged,
      this.maxLength,
      this.readOnly = false});

  final String name;
  final String label;
  final bool readOnly;
  final num? initialValue;
  final int? maxLength;
  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      readOnly: readOnly,
      onChanged: onChanged,
      maxLength: maxLength,
      initialValue: initialValue?.toString(),
    inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^(\d{1,2})?\.?\d{0,2}')),
    ],
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

//inputFormatters: <TextInputFormatter>[
// for below version 2 use this
//  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// // for version 2 and greater youcan also use this
//  FilteringTextInputFormatter.digitsOnly
