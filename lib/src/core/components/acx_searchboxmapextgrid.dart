import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

class AcxSearchBoxMapExtGrid extends StatelessWidget {
  const AcxSearchBoxMapExtGrid(
      {required this.inputText,
      this.inputIcon,
      required this.returnSelectedRef,
      required this.searchText,
      required this.keyField,
      this.filterField,
      this.filterValue,
      this.selectedRef,
      this.showSearchBox = true,
      this.allowInputText = false,
      this.openDropDownProgKey,
      required this.datasrc,
      super.key});

  final String inputText;
  final Icon? inputIcon;
  final dynamic selectedRef;
  final Function returnSelectedRef;
  final String searchText;
  final String keyField;
  final String? filterField;
  final String? filterValue;
  final bool showSearchBox;
  final bool allowInputText;
  final GlobalKey<DropdownSearchState<dynamic>>? openDropDownProgKey;
  final Returndata datasrc;
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
  Widget build(BuildContext context) {
    return DropdownSearch<dynamic>(
      key: openDropDownProgKey,
      suffixProps: DropdownSuffixProps(
 clearButtonProps: const ClearButtonProps(
  
        isVisible: true,
      ),
      ),
     
      popupProps: PopupProps.menu(
          searchFieldProps: const TextFieldProps(autofocus: true),
          itemBuilder: (c, t, x,g) {
            return const Text('Tesitng');
          },
          showSearchBox: showSearchBox,
          title: IconButton(
              onPressed: () {
                context.maybePop();
              },
              icon: const Icon(Icons.arrow_drop_up))),
      itemAsString: (dynamic u) => u[searchText].toString(),
      selectedItem: selectedRef == null
          ? null
          : setSelected(
              selectedRef![keyField].toString(), datasrc.data!.toList()),
      onChanged: (val) {
           if (val != null) {
            Future.delayed(Duration(milliseconds: 200),(){
                returnSelectedRef(val);
            });
           
          }
      },
      decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
        hintText: 'Enter Something',
        contentPadding: const EdgeInsets.all(10.0),
        labelText: inputText,
        //    icon: inputIcon,
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
      )),
      items:(f,p)=> datasrc.data!.toList(),
      compareFn: (i, s) => i.refCd == s.refCd,
    );
  }
}
