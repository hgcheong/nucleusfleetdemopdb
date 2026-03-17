import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FbNumber1to100 extends StatelessWidget {
  const FbNumber1to100(
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
    RegExp pattern = RegExp(r'^[1-9][0-9]?$|^100$');
    return FormBuilderTextField(
      name: name,
      readOnly: readOnly,
      onChanged: onChanged,
      maxLength: maxLength,
      initialValue: initialValue?.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(pattern),
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
