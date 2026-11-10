import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';

class FbChoiceChipOptionExt extends StatelessWidget {
  const FbChoiceChipOptionExt({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    required this.dataext,
    this.orientation = OptionsOrientation.horizontal,
    required this.keyField,
    required this.displayField,
    required this.iconList,
  });

  final String name;
  final String label;
  final String? initialValue;
  final String keyField;
  final String displayField;
  final OptionsOrientation orientation;
  final Returndata dataext;
  final Map<String, Icon> iconList;
  @override
  Widget build(BuildContext context) => FbField(child: _buildField(context));

  Widget _buildField(BuildContext context) {
    return dataext.data == null
        ? const Text('No Data')
        : FormBuilderChoiceChips<dynamic>(
            // labelPadding: const EdgeInsets.all(20),
            decoration: InputDecoration(
              labelText: label,
            ),
            initialValue: initialValue,
            name: name,
            options: dataext.data!.toList().map((lang) {
              Icon? theIcon = iconList.containsKey(lang[keyField]) == true
                  ? iconList[lang[keyField]]
                  : const Icon(Icons.cancel);
              return FormBuilderChipOption(
                value: lang[keyField],
                child: Column(children: [Text(lang[displayField]), theIcon!]),
                //  child: iconList.containsKey(lang[keyField]) == true ? iconList[lang[keyField]] : const Icon(Icons.cancel),
              );
            }).toList(growable: false),
          );
  }
}
