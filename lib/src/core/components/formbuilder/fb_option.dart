import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

class FbOption extends ConsumerWidget {
  const FbOption({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    this.querysql = '/sp/GetLibRef/queryasyncnouser',
    required this.params,
    this.orientation = OptionsOrientation.horizontal,
  });

  final String name;
  final String label;
  final String querysql;
  final String? initialValue;
  final OptionsOrientation orientation;
  final Map<String, dynamic> params;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryOptions =
        QueryObject(querysql: querysql, params: params, showMsg: false);
    final queryOptionValue = ref.watch(ReturndatafreezedProvider(queryOptions));
    return AsyncValueWidget<Returndata>(
        value: queryOptionValue,
        data: (options) {
          return FormBuilderRadioGroup<dynamic>(
            decoration: InputDecoration(
              labelText: label,
            ),
            initialValue: initialValue,
            orientation: orientation,
            name: name,
            activeColor: Colors.green,
            options: options.data == null? [FormBuilderFieldOption(
                      value: 'No Data',
                      child: Text('No Data'),
                    )]: options.data!
                .toList()
                .where((l) => l['RefCd'] != 'PROD')
                .map((lang) => FormBuilderFieldOption(
                      value: lang['RefCd'],
                      child: Text(lang['Dscp']),
                    ))
                .toList(growable: false),
            // options: options.data!
            //     .toList()
            //     .map((lang) => FormBuilderFieldOption(
            //           value: lang['RefCd'],
            //           child: Text(lang['Dscp']),
            //         ))
            //     .toList(growable: false),
          );
        });
  }
}
