import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';


class FbDateTimePickerYear extends HookWidget {
   const FbDateTimePickerYear({
    super.key,
    required this.name,
    required this.label,
    required this.initialValue,
    this.onpress,
    this.onreset,
    this.enabled = true,
    this.labelStyle,  this.formatTypeStr = 'yyyy'
  });

  final String name;
  final String label;
  final DateTime initialValue;
  final bool enabled;
  final Function()? onpress;
  final Function()? onreset;
  final TextStyle? labelStyle;
  final String formatTypeStr;
  @override
  Widget build(BuildContext context) {
    final sel = useState(initialValue);
    final vsss = useTextEditingController(text:DateFormat('yyyy').format( DateTime.now() ));
    return FormBuilderField(
      name: name,
      builder: (FormFieldState<dynamic> field) { 
return Row(
        children: [
          Expanded(
            child: TextField(
              onTap: (){
                  showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Select Year"),
                  content: SizedBox( // Need to use container to add size constraint.
                    width: 300,
                    height: 300,
                    child: YearPicker(
                      firstDate: DateTime(DateTime.now().year - 10, 1),
                      lastDate: DateTime(DateTime.now().year + 10, 1),
                      // save the selected date to _selectedDate DateTime variable.
                      // It's used to set the previous selected date when
                      // re-showing the dialog.
                      selectedDate: sel.value,
                      onChanged: (DateTime dateTime) {
                        // close the dialog when year is selected.
                      
                        Navigator.pop(context);
                        vsss.value = TextEditingValue(text:DateFormat('yyyy').format(dateTime));
                        field.didChange(DateFormat('yyyy').format(dateTime));
                          sel.value = dateTime;
                        // Do something with the dateTime selected.
                        // Remember that you need to use dateTime.year to get the year
                      },
                    ),
                  ),
                );
              },
            );
              },
              readOnly: true,
              controller: vsss,
              decoration: InputDecoration(
                    labelText: label,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                      )),
        ],
      );
       },
  
    );

}
}
