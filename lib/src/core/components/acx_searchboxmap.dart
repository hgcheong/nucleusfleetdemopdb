// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_acxdatatable.dart';
import 'package:nucleusv2/src/core/components/alert_dialogs.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';

class AcxSearchBoxMap extends HookConsumerWidget {
  const AcxSearchBoxMap(
      {required this.querysql,
      required this.params,
      required this.inputText,
      this.inputTextStyle,
      this.inputIcon,
      required this.returnSelectedRef,
      required this.searchText,
      required this.keyField,
      this.filterField,
      this.filterValue,
      this.selectedRef,
      this.showSearchBox = false,
      this.allowInputText = false,
      this.sortbyKeyField = false,
      this.readOnly = false,
      this.showClearBtn = true,
      this.onClearPress,
  //    this.openDropDownProgKey,
      super.key});
  final String querysql;
  final Map<String, dynamic> params;
  final String inputText;
    final TextStyle? inputTextStyle;
  final Icon? inputIcon;
  final dynamic selectedRef;
  final Function returnSelectedRef;
  final Function? onClearPress;
  final String searchText;
  final String keyField;
  final String? filterField;
  final String? filterValue;
  final bool showSearchBox;
  final bool allowInputText;
  final bool sortbyKeyField;
  final bool readOnly;
  final bool showClearBtn;

  //final GlobalKey<DropdownSearchState<dynamic>>? openDropDownProgKey;
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
  Widget build(BuildContext context, WidgetRef ref) =>
      FbFieldIfNeeded(child: _buildBox(context, ref));

  Widget _buildBox(BuildContext context, WidgetRef ref) {
    final isLoading = useState<bool>(false);
    final theResult = useState<List<dynamic>>([]);

    useEffect(() {
      loadData(context, ref, querysql, params, isLoading).then((value) {
        if (!context.mounted) {
          return;
        }
  

          theResult.value = value;
      
      });
      return null;
    }, [theResult]);

   // if (openDropDownProgKey != null) {
        if (1==2) {
      return DropdownSearch<dynamic>(
        enabled: !readOnly,
     //   key: openDropDownProgKey,
              dropdownBuilder: (context, selectedItem) {
    String textToShow = '';
        if (selectedItem != null) {
          textToShow = selectedItem[searchText] ?? '';
        }
        return Text(textToShow,style: TextStyle(fontSize: defaultDropDownSize),);
      },
      
      suffixProps: readOnly? DropdownSuffixProps(): DropdownSuffixProps(
clearButtonProps: ClearButtonProps(
  icon: IconButton(onPressed: (){
          if (onClearPress != null) {
                onClearPress!();
              }
  }, icon: Icon(Icons.close)),
            isVisible: readOnly||showClearBtn==false ? false: true,
            
            // onPressed: () {
            //   if (onClearPress != null) {
            //     onClearPress!();
            //   }
            //   if (openDropDownProgKey != null) {
            //     if (openDropDownProgKey!.currentState != null) {
            //       openDropDownProgKey!.currentState!.changeSelectedItem(null);
            //     }
            //   }
            // }
            ),
      ),
        
        popupProps: PopupProps.menu(
         searchFieldProps: const TextFieldProps(autofocus: true),
            showSearchBox: showSearchBox,
            title: IconButton(
                onPressed: () {
                  context.maybePop();
                },
                icon: const Icon(Icons.arrow_drop_up))),
        itemAsString: (dynamic u) => u[searchText] ?? "",
        selectedItem: selectedRef == null
            ? null
            : setSelected(selectedRef![keyField].toString(), theResult.value),   //selectedRef![keyField].toString()
        onChanged: (val) {
          if (val != null) {
            Future.delayed(Duration(milliseconds: 200),(){
                returnSelectedRef(val);
            });
           
          }
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
        compareFn: (i, s) => i.refCd == s.refCd,
        items: (ilter,p) {
          return loadData(context, ref, querysql, params, isLoading);
        },
      );
    } else {
      return DropdownSearch<dynamic>(
           enabled: !readOnly,
suffixProps: DropdownSuffixProps(  clearButtonProps: ClearButtonProps(
    icon: IconButton(onPressed: (){
          if (onClearPress != null) {
                onClearPress!();
              }
  }, icon: Icon(Icons.close)),
                 isVisible: readOnly||showClearBtn==false ? false: true,
        ),),
      
                      dropdownBuilder: (context, selectedItem) {
    String textToShow = '';
        if (selectedItem != null) {
          textToShow = selectedItem[searchText].toString();
        }
      return Text(textToShow,style: TextStyle(fontSize: defaultDropDownSize),);
      },
        popupProps: PopupProps.menu(
    
            searchFieldProps: const TextFieldProps(autofocus: true),
            showSearchBox: showSearchBox,
            title: IconButton(
                onPressed: () {
                 context.maybePop();
                },
                icon: const Icon(Icons.arrow_drop_up))),
        itemAsString: (dynamic u) => u[searchText].toString(),
        selectedItem: selectedRef == null
            ? null
            : setSelected(selectedRef![keyField].toString(), theResult.value),
        //   selectedItem: selectedRef == null? null:null,

        onChanged: (val) {
          if (val != null) {
                 Future.delayed(Duration(milliseconds: 200),(){
                returnSelectedRef(val);
            });
          }
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
        compareFn: (i, s) => i.refCd == s.refCd,
        items: (filter, p) {
          return loadData(context, ref, querysql, params, isLoading);
        },
      );
    }
  } 



  Future<List<dynamic>> loadData(
      BuildContext context,
      WidgetRef ref,
      String querysql,
      Map<String, dynamic> params,
      ValueNotifier<bool> isloading) async {
    try {
      // isloading.value = true;
      if (filterField != null) {
        return await ref
            .read(repoQueryProvider)
            .retrieveAsListWithFilter(querysql, params, filterField.toString(),
                filterValue.toString(),sortbyKeyField)
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
          .retrieveAsList(querysql, params,keyField,sortbyKeyField)
          .onError((error, stackTrace) {
        if (context.mounted) {
          showAlertDialog(
              context: context, title: 'Error Loading', content: 'Failed');
        }

        return [];
      });
    } catch (e) {
      showAlertDialog(
          context: context, title: 'Error Loading', content: e.toString());
      return [];
    } finally {}
  }
}
