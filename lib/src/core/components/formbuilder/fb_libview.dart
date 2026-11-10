import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

class FbLibView extends StatelessWidget {
  const FbLibView({
    super.key,
    required this.name,
    required this.label,
    this.labelStyle,
    this.initialValue,
    required this.params,
    required this.keyField,
    required this.searchText,
    required this.querySql,
    this.returnSelectedRef,
    this.onClearPress,
    this.inputIcon,
       this.readOnly = false,
       this.showClearBtn = true
  });

  final String name;
  final String label;
  final TextStyle? labelStyle;
  final String keyField;
  final String searchText;
  final String querySql;
  final String? initialValue;
  final Icon? inputIcon;
  final Function? returnSelectedRef;
  final Function? onClearPress;
  final Map<String, dynamic> params;
  final bool readOnly;
  final bool showClearBtn;
  @override
  Widget build(BuildContext context) => FbField(child: _buildField(context));

  Widget _buildField(BuildContext context) {
   // final openDropDownProgKey = GlobalKey<DropdownSearchState<dynamic>>();
    return FormBuilderField(
        name: name,
        builder: (FormFieldState<dynamic> field) {
          return SizedBox(
            height: DiboldTheme.fieldHeight,
            child: AcxSearchBoxMap(
              readOnly: readOnly,
              showClearBtn: showClearBtn,
                   //       openDropDownProgKey: openDropDownProgKey,
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
                inputTextStyle:const TextStyle(fontSize: defaultFontSize),
                searchText: searchText,
                keyField: keyField,
                querysql: querySql,
                params: params),
          );
        });
  }
}
