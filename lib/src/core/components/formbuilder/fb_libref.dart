import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';

class FbLibref extends StatelessWidget {
  const FbLibref({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    required this.params,
    this.inputIcon,
    // this.openDropDownProgKey,
    this.returnSelectedRef,
    this.onClearPress,
    this.readOnly = false
  });

  final String name;
  final String label;
  final String? initialValue;
  final Map<String, dynamic> params;
  final Icon? inputIcon;
  // final GlobalKey<DropdownSearchState<dynamic>>? openDropDownProgKey;
  final Function? returnSelectedRef;
  final Function? onClearPress;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
  //  final openDropDownProgKey = GlobalKey<DropdownSearchState<dynamic>>();
    return FormBuilderField(
        name: name,
        builder: (FormFieldState<dynamic> field) {
          return AcxSearchBoxMap(
              readOnly: readOnly,
           //   openDropDownProgKey: openDropDownProgKey,
              inputIcon: inputIcon,
              showSearchBox: true,
              returnSelectedRef: (dynamic val) {
                val != null
                    ? field.didChange(val['RefCd'])
                    : field.didChange(null);
                if (returnSelectedRef != null) {
                  returnSelectedRef!(val);
                }
              },
              selectedRef: {
                'RefCd': field.value,
              },
              onClearPress: () {
                field.didChange(null);
                if (onClearPress != null) {
                  onClearPress!();
                }
              },
              
              inputText: label,
              searchText: 'Dscp',
              keyField: 'RefCd',
              querysql: librefquerysql,
              params: params);
        });

    // return FormBuilderField(
    //     name: name,
    //     builder: (FormFieldState<dynamic> field) {
    //       return AcxSearchBox(
    //           returnSelectedRef: (Libref? val) {
    //             val != null
    //                 ? field.didChange(val.refCd)
    //                 : field.didChange(null);
    //           },
    //           selectedRef: Libref(refCd: initialValue),
    //           inputText: label,
    //           querysql: librefquerysql,
    //           params: params);
    //     });
  }
}
