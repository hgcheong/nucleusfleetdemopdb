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

class AcxSearchBoxMapWithInput extends HookConsumerWidget {
  const AcxSearchBoxMapWithInput(
      {required this.querysql,
      required this.params,
      required this.inputText,
      this.inputIcon,
      required this.returnSelectedRef,
      required this.searchText,
      required this.keyField,
      this.filterField,
      this.filterValue,
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
  final String? filterField;
  final String? filterValue;
  final bool showSearchBox;
  final bool allowInputText;
  dynamic getSelected() {
    return selectedRef;
  }

  bool isNotSelected() {
    return selectedRef == null;
  }

  dynamic setSelected(String? searchcode, List<dynamic> toSearch) {
    // if (searchcode == null || toSearch.data == null || searchcode == 'null') {
    //   return null;
    // }
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
    final userEditTextController = useTextEditingController(text: '');
    useEffect(() {
      loadData(context, ref, querysql, params, isLoading).then((value) {
        if (!context.mounted) {
          return;
        }
        theResult.value = value;
      });
      return null;
    }, [theResult]);

    return DropdownSearch<dynamic>(

      suffixProps: DropdownSuffixProps(
   clearButtonProps: const ClearButtonProps(
    
        isVisible: true,
      ),
      ),
   

      popupProps: PopupProps.menu(
          onDismissed: () {
            if (userEditTextController.text != '') {
              returnSelectedRef(
                userEditTextController.text,
              );
            }
          },
          showSearchBox: showSearchBox,
          searchFieldProps: TextFieldProps(
            autofocus: true,
            controller: userEditTextController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  userEditTextController.clear();
                },
              ),
            ),
          ),
          title: IconButton(
              onPressed: () {
                context.maybePop();
              },
              icon: const Icon(Icons.arrow_drop_up))),

      itemAsString: (dynamic u) => u[searchText].toString(),
      //   selectedItem: selectedRef == null ? null : setSelected(selectedRef![keyField].toString(), theResult.value),
      selectedItem: selectedRef == null
          ? null
          : setSelected(selectedRef![keyField].toString(), theResult.value),
      onChanged: (val) {
          if (val != null) {
            Future.delayed(Duration(milliseconds: 200),(){
                returnSelectedRef(val);
            });
           
          }
      },
      dropdownBuilder: (context, selectedItem) {
        if (selectedItem == null) {
          return Text(
            userEditTextController.text,
          );
        } else {
          return Text(selectedItem[keyField].toString(),style: TextStyle(fontSize: defaultDropDownSize),);
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
      items: (filter, infiniteScrollProps) {
        return loadData(context, ref, querysql, params, isLoading);
      },
    );
  }

  Future<List<dynamic>> loadData(
      BuildContext context,
      WidgetRef ref,
      String querysql,
      Map<String, dynamic> params,
      ValueNotifier<bool> isloading) async {
    try {
      //    isloading.value = true;
      if (filterField != null) {
        return await ref
            .read(repoQueryProvider)
            .retrieveAsListWithFilter(querysql, params, filterField.toString(),
                filterValue.toString(),false)
            .onError((error, stackTrace) {
          if (context.mounted) {
            showAlertDialog(
                context: context,
                title: 'Error Loading',
                content: 'Failed $error.toString()');
          }

          return [];
        });
      }

      return await ref
          .read(repoQueryProvider)
          .retrieveAsList(querysql, params,keyField,false)
          .onError((error, stackTrace) {
        if (context.mounted) {
          showAlertDialog(
              context: context,
              title: 'Error Loading',
              content: 'Failed $error.toString()');
        }

        return [];
      });
    } catch (e) {
      showAlertDialog(
          context: context, title: 'Error Loading', content: e.toString());
      return [];
    } finally {
      //  isloading.value = false;
    }
  }
}
