import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class FbTimePicker extends StatelessWidget {
  const FbTimePicker({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    this.onpress,
  });

  final String name;
  final String label;
  final String? initialValue;
  final Function()? onpress;
  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      valueTransformer: (v) {
        //Returning in 24hr format to conform to backend+

        if (v != null) {
          return DateFormat('HH:mm').format(v);
        }
        return null;
      },
      name: name,
      format: DateFormat('hh:mm a'),
      initialEntryMode: DatePickerEntryMode.input,
      inputType: InputType.time,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        suffixIcon: IconButton(
          icon: const Icon(Icons.close),
          onPressed: onpress,
        ),
      ),
      //initialTime: const TimeOfDay(hour: 8, minute: 0),
    );
  }
}
