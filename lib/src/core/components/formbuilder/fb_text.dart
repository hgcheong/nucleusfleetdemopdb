import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';

class FbText extends StatelessWidget {
  const FbText(
      {super.key,
      required this.name,
      required this.label,
      this.initialValue,
      this.onChanged,
      this.maxLines,
      this.maxLength,
      this.keyboardType = TextInputType.text,
      this.readOnly = false,
      this.isReq = false
      });

  final String name;
  final String label;
  final String? initialValue;
  final bool readOnly;
  final bool isReq;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) => FbField(child: _buildField(context));

  Widget _buildField(BuildContext context) {
    return FormBuilderTextField(
      textInputAction: TextInputAction.go,
      name: name,
      readOnly: readOnly,
      initialValue: initialValue,
      maxLength: maxLength,
      onChanged: onChanged,
      keyboardType: keyboardType,
      validator: isReq == true
          ? FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(1),
            ])
          : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: isReq  == true ?  const TextStyle(color: DbColors.required):null,
     //   border: readOnly ? InputBorder.none : const UnderlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
