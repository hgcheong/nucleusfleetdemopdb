import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmapext.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

class FbLibViewExt extends StatelessWidget {
  const FbLibViewExt({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    required this.keyField,
    required this.searchText,
    required this.datasrc,
    this.onClearPress,
    this.returnSelectedRef,
    this.inputIcon,
    this.showSearchBox = false,
    this.showClearBtn = true,
  });

  final String name;
  final String label;
  final String keyField;
  final String searchText;
  final String? initialValue;
  final Function? returnSelectedRef;
  final Function? onClearPress;
  final Returndata datasrc;
  final bool showSearchBox;
  final Icon? inputIcon;
  final bool showClearBtn;

  @override
  Widget build(BuildContext context) => FbField(child: _buildField(context));

  Widget _buildField(BuildContext context) {
    final openDropDownProgKey = GlobalKey<DropdownSearchState<dynamic>>();
    return FormBuilderField(
        name: name,
        builder: (FormFieldState<dynamic> field) {
          return SizedBox(
            height: DiboldTheme.fieldHeight,
            child: AcxSearchBoxMapExt(
              showClearBtn: showClearBtn,
              inputIcon: inputIcon,
              datasrc: datasrc,
              showSearchBox: showSearchBox,
              openDropDownProgKey: openDropDownProgKey,
              returnSelectedRef: (dynamic val) {
                // val != null
                //     ? field.didChange(val[keyField])
                //     : field.didChange(null);
                val != null
                    ? field.didChange(val[keyField])
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
              searchText: searchText,
              keyField: keyField,
            ),
          );
        });
  }
}
