import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FbNumber extends StatelessWidget {
  const FbNumber(
      {super.key,
      required this.name,
      required this.label,
      this.initialValue,
      this.onChanged,
      this.maxLength,
      this.showCounter = false,
      this.readOnly = false});

  final String name;
  final String label;
  final bool readOnly;
  final bool showCounter;
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
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'(\d*\.?\d*$)')),
      ],
      decoration: InputDecoration(
        labelText: label,
        counterText: showCounter ? null : '',
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
