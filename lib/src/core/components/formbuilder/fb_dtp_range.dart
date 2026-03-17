import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FbDateTimePickerRange extends HookWidget {
  const FbDateTimePickerRange({
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
  
       final validationError = useState('');
    return FormBuilderDateRangePicker(
      
      firstDate: DateTime.now().subtract( const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      errorInvalidRangeText: validationError.value.isNotEmpty ? validationError.value : null,
      validator: (value) {
        if (value != null) {
          final difference = value.end.difference(value.start).inDays;
          if (difference > 90) {
            return 'The date range cannot exceed 90 days.';
          }
        }
        return null;
      },
         onChanged: (val) {
              if (val != null) {
                final difference = val.end.difference(val.start).inDays;
                if (difference > 90) {
                
                 
                    validationError.value = 'The date range cannot exceed 90 days.';
                  
                } else {
       
                    validationError.value = '';
                  
                }
              }
            },
      
  //     valueTransformer: (v) {
  //       if (v != null) {
  //         if(v.runtimeType == String){
  //           return v;
  //         }
  //         if(formatTypeStr == 'yMMMEd'){
  // return DateFormat('yMMMEd').format(v);
  //         } else{
  //           return DateFormat(formatTypeStr).format(v);
  //         }
        
  //       }
  //       return null;
  //     },
     // cancelText: "Clear",
      name: name,
      enabled: enabled,
      format: formatTypeStr == 'yMMMEd' ?  DateFormat.yMMMEd() : DateFormat(formatTypeStr),
      initialEntryMode: DatePickerEntryMode.calendar,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorText: validationError.value.isNotEmpty ? validationError.value : null,
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
    );
  }
}
