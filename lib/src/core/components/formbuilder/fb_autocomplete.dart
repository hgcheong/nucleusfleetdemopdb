import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

class FbAutoComplete extends ConsumerWidget {
  const FbAutoComplete({
    super.key,
    required this.name,
    required this.label,
    this.lableStyle,
    this.initialValue,
    required this.keyField,
    required this.searchText,
    this.returnSelectedRef,
    this.inputIcon,
    required this.query,
  });

  final String name;
  final String label;
  final TextStyle? lableStyle;
  final String keyField;
  final String searchText;
  final String? initialValue;
  final Function? returnSelectedRef;
  final Icon? inputIcon;
  final QueryObject query;
  @override
  Widget build(BuildContext context, WidgetRef ref) => FbField(child: _buildField(context, ref));

  Widget _buildField(BuildContext context, WidgetRef ref) {
    final queryRes = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
        value: queryRes,
        data: (srcData) {
          if (srcData.data != null) {
            final List<String> listString =
                srcData.data!.map((e) => e[keyField] == null? "": e[keyField].toString()).toList();
            return FormBuilderField(
                name: name,
                builder: (FormFieldState<dynamic> field) {
                  return LayoutBuilder(
                    builder: (context, contraints) => RawAutocomplete<String>(
                      optionsViewBuilder: (context, onSelected, options) =>
                          Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(4.0)),
                          ),
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: 200,
                              width: contraints.biggest.width,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option =
                                      options.elementAt(index);
                                  final bool highlight =
                                      AutocompleteHighlightedOption.of(
                                              context) ==
                                          index;
                                  return InkWell(
                                    onTap: () => onSelected(option),
                                    child: Container(
                                      color: highlight
                                          ? Theme.of(context).focusColor
                                          : null,
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(option),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      fieldViewBuilder: ((context, textEditingController,
                          focusNode, onFieldSubmitted) {
                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          onEditingComplete: onFieldSubmitted,
                          decoration: InputDecoration(
                              labelText: label,
                              labelStyle: lableStyle,
                              suffixIcon: const Icon(Icons.search),
                              hintText: label),
                        );
                      }),
                      initialValue: TextEditingValue(
                          text: initialValue == null
                              ? ''
                              : initialValue?? ""),
                      optionsBuilder: (textEditingValue) {
                        field.didChange(textEditingValue.text);
                        if (textEditingValue.text == '') {
                          // return const Iterable.empty();
                          return listString;
                        }
                        return listString.where((va) {
                          return va
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                    ),
                  );
                });
          }
          return const Text("No Data");
        });
  }
}
