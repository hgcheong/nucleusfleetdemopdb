import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_acxdatatable.dart';
import 'package:nucleusv2/src/core/components/acx_searchmainprovider.dart';
import 'package:nucleusv2/src/core/components/alert_dialogs.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';

class AcxSearchMainExt extends ConsumerWidget {
  const AcxSearchMainExt(
      {required this.querysql,
      required this.params,
      required this.inputText,
      this.inputIcon,
      required this.returnSelectedRef,
      required this.searchText,
      required this.keyField,
      this.filterField,
      this.refCd,
      this.filterValue,
      this.searchAttr,
      this.selectedRef,
      this.showSearchBox = false,
      this.allowInputText = false,
      super.key});
  final String querysql;
  final Map<String, dynamic> params;
  final String inputText;
  final Icon? inputIcon;
  final dynamic selectedRef;
  final Function returnSelectedRef;
  final String searchText;
  final String keyField;
  final String? refCd;
  final String? searchAttr;
  final String? filterField;
  final String? filterValue;
  final bool showSearchBox;
  final bool allowInputText;
  dynamic getSelected() {
    return selectedRef;
  }

  dynamic setSelected(String? searchcode, List<dynamic> toSearch) {
    List<dynamic> toFd = toSearch;
    final found =
        toFd.where((element) => element[keyField].toString() == searchcode);
    if (found.isNotEmpty) {
      return found.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sSearch = ref.watch(mainSearchInput);
    final s1 = sSearch.split('|').elementAt(0);
    //   final s2 = sSearch.split('|').elementAt(1);
    final s3 = sSearch.split('|').last;
    final query = QueryObject(
        querysql: querysql, params: {"RefCd": s1, s3: sSearch}, showMsg: false);

    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          return DropdownSearch<dynamic>(
            popupProps: PopupProps.menu(
              showSearchBox: showSearchBox,
              disableFilter: true,
              searchFieldProps: TextFieldProps(
                autofocus: true,
                inputFormatters: searchAttr == "Str"
                    ? []
                    : [FilteringTextInputFormatter.digitsOnly],
                keyboardType: searchAttr == "Str"
                    ? TextInputType.text
                    : TextInputType.number,
              ),
            ),
            itemAsString: (dynamic u) => u['Dscp'].toString(),
            selectedItem: selectedRef == null
                ? null
                : setSelected(
                    selectedRef![keyField].toString(), theData.data!.toList()),
            onChanged: (val) {
            if (val != null) {
            Future.delayed(Duration(milliseconds: 200),(){
                returnSelectedRef(val);
            });
           
          }
            },
            dropdownBuilder: (context, selectedItem) {
              String textToShow = '';
              if (selectedItem != null) {
                textToShow = selectedItem['Dscp'].toString();
              }
              return Text(textToShow,style: TextStyle(fontSize: defaultDropDownSize),);
            },
     decoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(fontSize:defaultDropDownSize),
          decoration: InputDecoration(
            // Same height as every other form field (DiboldTheme.fieldHeight).
            isDense: true,
            constraints: const BoxConstraints(minHeight: DiboldTheme.fieldHeight),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyle(fontSize: defaultFloatlableSize),
          labelText: inputText,
          icon: inputIcon,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        )),
            compareFn: (i, s) => i.RefCd == s.RefCd,
            items: (filter, p)=>theData.data == null ? [] : theData.data!.toList(),
          );
        });
  }

  Future<List<dynamic>> loadData(
    BuildContext context,
    WidgetRef ref,
    String querysql,
    Map<String, dynamic> params,
  ) async {
    try {
      if (!params.containsKey('RefCd')) {
        return [];
      }

      if (filterField != null) {
        return await ref
            .read(repoQueryProvider)
            .retrieveAsListWithFilter(querysql, params, filterField.toString(),
                filterValue.toString(),false)
            .onError((error, stackTrace) {
          if (context.mounted) {
            showAlertDialog(
                context: context, title: 'Error Loading', content: 'Failed');
          }
          return [];
        });
      }
      return await ref
          .read(repoQueryProvider)
          .retrieveAsList(querysql, params,keyField,false)
          .onError((error, stackTrace) {
        // showAlertDialog(context: context, title: 'Error Loading line 144', content: 'Failed');
        return [];
      });
    } catch (e) {
      showAlertDialog(
          context: context,
          title: 'Error Loading line 148',
          content: e.toString());
      return [];
    } finally {
      //   isloading.value = false;
    }
  }
}

