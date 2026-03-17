import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class FbDateTimePickerWithTime extends StatelessWidget {
  const FbDateTimePickerWithTime(
      {super.key,
      required this.name,
      required this.label,
      this.initialValue,
      this.onpress,
       this.labelStyle, 
       this.onreset,
      this.enabled = false});

  final String name;
  final String label;
  final String? initialValue;
  final bool enabled;
    final TextStyle? labelStyle;
  final Function()? onpress;
   final Function()? onreset;
  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      enabled: enabled,
      valueTransformer: (v) {
        if (v != null) {
          return v.toString();
        }
        return null;
      },
      name: name,
      format: DateFormat.yMMMEd(),
      initialEntryMode: DatePickerEntryMode.calendar,
      inputType: InputType.date,
        decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        labelStyle: labelStyle,
        suffix: onreset == null ? null:  IconButton(
              icon: const Icon(Icons.close),
              onPressed: onreset,
            ) ,
        suffixIcon: IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: onpress,
            ), 
      ),
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );
  }
}
