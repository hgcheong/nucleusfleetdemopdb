import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FbDateTimePicker extends StatelessWidget {
  const FbDateTimePicker({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    this.onpress,
    this.onreset,
    this.enabled = true,
    this.labelStyle,  this.formatTypeStr = 'yMMMEd'
  });

  final String name;
  final String label;
  final String? initialValue;
  final bool enabled;
  final Function()? onpress;
  final Function()? onreset;
  final TextStyle? labelStyle;
  final String formatTypeStr;
  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      
      valueTransformer: (v) {
        if (v != null) {
          if(v.runtimeType == String){
            return v;
          }
          if(formatTypeStr == 'yMMMEd'){
  return DateFormat('yMMMEd').format(v);
          } else{
            return DateFormat(formatTypeStr).format(v);
          }
        
        }
        return null;
      },
     // cancelText: "Clear",
      name: name,
      enabled: enabled,
      format: formatTypeStr == 'yMMMEd' ?  DateFormat.yMMMEd() : DateFormat(formatTypeStr),
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
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );
  }
}
