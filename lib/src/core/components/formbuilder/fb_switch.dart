import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';

/// Yes/No switch field, stored as 'Y' / 'N'.
///
/// A plain Row (label + Switch) inside a borderless InputDecorator, instead
/// of FormBuilderSwitch's ListTile, so the label and switch stay centred
/// together at any zoom level. The decorator is kept only to show
/// validation errors under the row.
class FbSwitch extends StatelessWidget {
  const FbSwitch({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    this.onChanged,
  });

  final String name;
  final String label;
  final String? initialValue;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) => FbField(child: _buildField(context));

  Widget _buildField(BuildContext context) {
    return FormBuilderField<bool>(
      name: name,
      initialValue: initialValue == 'Y',
      onChanged: onChanged,
      valueTransformer: (value) {
        if (value == null) {
          return null;
        }
        return value == false ? 'N' : 'Y';
      },
      builder: (FormFieldState<bool> field) {
        return InputDecorator(
          isEmpty: false,
          // No outline: every border state is set to none (the theme
          // supplies outlines for enabled/focused/error, so `border` alone
          // isn't enough). No fill, and no horizontal padding, so the label
          // starts at the same left edge as the other fields' boxes.
          decoration: InputDecoration(
            isDense: true,
            filled: false,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 4),
            errorText: field.errorText,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Text(label)),
              const SizedBox(width: 12),
              Switch(
                value: field.value ?? false,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: field.widget.enabled
                    ? (v) => field.didChange(v)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
