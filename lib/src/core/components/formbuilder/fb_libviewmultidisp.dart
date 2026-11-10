import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmapmultidisp.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';

class FbLibViewMultiDisplay extends StatelessWidget {
  const FbLibViewMultiDisplay({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    required this.params,
    required this.keyField,
    required this.listsearchText,
    required this.querySql,
    this.returnSelectedRef,
    this.onClearPress,
    this.inputIcon,
  });

  final String name;
  final String label;
  final String keyField;
  final List<String> listsearchText;
  final String querySql;
  final String? initialValue;
  final Icon? inputIcon;
  final Function? returnSelectedRef;
  final Function? onClearPress;
  final Map<String, dynamic> params;

  @override
  Widget build(BuildContext context) => FbField(child: _buildField(context));

  Widget _buildField(BuildContext context) {
    final openDropDownProgKey = GlobalKey<DropdownSearchState<dynamic>>();
    return FormBuilderField(
        name: name,
        builder: (FormFieldState<dynamic> field) {
          return SizedBox(
            // No fixed height: a fixed 48px box was shorter than the
            // dropdown plus its floating label, so it spilled into the gap
            // below. The dropdown keeps a 48px minimum on its own.
            child: AcxSearchBoxMapMultiDisplay(
                openDropDownProgKey: openDropDownProgKey,
                inputIcon: inputIcon,
                showSearchBox: true,
                returnSelectedRef: (dynamic val) {
                  val != null
                      ? field.didChange(val[keyField].toString())
                      : field.didChange(null);
                  if (returnSelectedRef != null) {
                    returnSelectedRef!(val);
                  }
                },
                selectedRef: {
                  keyField: field.value,
                },
                onClearPress: () {
                  field.didChange(null);
                  if (onClearPress != null) {
                    onClearPress!();
                  }
                },
                inputText: label,
                listsearchText: listsearchText,
                keyField: keyField,
                querysql: querySql,
                params: params),
          );
        });
  }
}
