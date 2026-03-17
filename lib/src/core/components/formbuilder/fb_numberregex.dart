import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FbNumberRegex extends StatelessWidget {
  const FbNumberRegex(
      {super.key,
      required this.name,
      required this.label,
      this.initialValue,
      this.onChanged,
      this.maxLength,
      this.regexStr =r'^-?[0-9]\d*(\.\d+)?$',
      this.readOnly = false});

  final String name;
  final String label;
  final String regexStr;
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
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      initialValue: initialValue?.toString(),
    inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(regexStr, dotAll: true)),
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
