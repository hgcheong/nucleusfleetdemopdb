import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';

class FbOptionExt extends StatelessWidget {
  const FbOptionExt({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    required this.dataext,
    this.orientation = OptionsOrientation.horizontal,
  });

  final String name;
  final String label;
  final String? initialValue;
  final OptionsOrientation orientation;
  final Returndata dataext;
  @override
  Widget build(BuildContext context) => FbField(child: _buildField(context));

  Widget _buildField(BuildContext context) {
    return FormBuilderRadioGroup<dynamic>(
      decoration: InputDecoration(
        labelText: label,
      ),
      initialValue: initialValue,
      orientation: orientation,
      name: name,
      activeColor: DbColors.primary,
      options: dataext.data!
          .toList()
          .map((lang) => FormBuilderFieldOption(
                value: lang['RefCd'],
                child: Text(lang['Dscp']),
              ))
          .toList(growable: false),
    );
  }
}
