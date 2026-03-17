import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_acxdatatable.dart';
import 'package:nucleusv2/src/core/components/alert_dialogs.dart';

class AcxSearchBoxMapMultiDisplay extends HookConsumerWidget {
  const AcxSearchBoxMapMultiDisplay(
      {required this.querysql,
      required this.params,
      required this.inputText,
      this.inputIcon,
      required this.returnSelectedRef,
      required this.listsearchText,
      required this.keyField,
      this.filterField,
      this.filterValue,
      this.selectedRef,
      this.showSearchBox = false,
      this.allowInputText = false,
      this.onClearPress,
      this.openDropDownProgKey,
      super.key});
  final String querysql;
  final Map<String, dynamic> params;
  final String inputText;
  final Icon? inputIcon;
  final dynamic selectedRef;
  final Function returnSelectedRef;
  final Function? onClearPress;
  final List<String> listsearchText;
  final String keyField;
  final String? filterField;
  final String? filterValue;
  final bool showSearchBox;
  final bool allowInputText;
  final GlobalKey<DropdownSearchState<dynamic>>? openDropDownProgKey;
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

    if (openDropDownProgKey != null) {
      return DropdownSearch<dynamic>(

        key: openDropDownProgKey,
                popupProps: PopupProps.menu(
            searchFieldProps: const TextFieldProps(autofocus: true),
            showSearchBox: showSearchBox,
            itemBuilder: (context, item, isSelected,g) {
              return toView(
                  context, item, isSelected, listsearchText, keyField);
            },
            title: IconButton(
                onPressed: () {
                  context.maybePop();
                },
                icon: const Icon(Icons.arrow_drop_up))),
        suffixProps: DropdownSuffixProps(
          
 clearButtonProps: ClearButtonProps(
      icon: IconButton(onPressed: (){
          if (onClearPress != null) {
                onClearPress!();
              }
  }, icon: Icon(Icons.close)),
            isVisible: true,
            // onPressed: () {
            //   if (onClearPress != null) {
            //     onClearPress!();
            //   }
            //   if (openDropDownProgKey != null) {
            //     if (openDropDownProgKey!.currentState != null) {
            //       openDropDownProgKey!.currentState!.changeSelectedItem(null);
            //     }
            //   }
            // }),
        ),),
       
        itemAsString: (dynamic u) {
          var toDisplay = "";
          for (var element in listsearchText) {
   
            if (u[element] != null){
              toDisplay += "${u[element]} ";
            }else{
              toDisplay +=" ";
            }
          }
      //    toDisplay = u[keyField].toString();
        //       toDisplay = u[listsearchText[0]].toString();
          return toDisplay.trimRight();
        },
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

        decoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(fontSize:defaultDropDownSize),
          decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyle(fontSize: defaultFloatlableSize),
          labelText: inputText,
          icon: inputIcon,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        )),
        compareFn: (i, s) => i[keyField] == s[keyField],
        items: (filter ,p) {
          return loadData(context, ref, querysql, params, isLoading);
        },
      );
    } else {
      return DropdownSearch<dynamic>(
suffixProps: DropdownSuffixProps( clearButtonProps: const ClearButtonProps(
          isVisible: true,
        ),),
       
        popupProps: PopupProps.menu(
          searchFieldProps: const TextFieldProps(autofocus: true),
          showSearchBox: showSearchBox,
          title: IconButton(
              onPressed: () {
                context.maybePop();
              },
              icon: const Icon(Icons.arrow_drop_up)),
          itemBuilder: (context, item, isSelected,g) {
            return toView(context, item, isSelected, listsearchText, keyField);
          },
        ),
        itemAsString: (dynamic u) {
          var toDisplay = "";
          // for (var element in listsearchText) {
          //   if(u[element]!=null){
          //     toDisplay += "${u[element]} ";
          //   }
         toDisplay = u[listsearchText[0]].toString();
         // }
          return toDisplay.trimRight();
        },
        
        selectedItem: selectedRef == null
            ? null
            : setSelected(selectedRef![keyField].toString(), theResult.value),
        onChanged: (val) {
          if (val != null) {
            returnSelectedRef(val);
          }
        },

        decoratorProps: 
        DropDownDecoratorProps(
          baseStyle: TextStyle(fontSize: defaultFontSize),
            decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: inputText,
          labelStyle: TextStyle(fontSize: defaultFontSize),
          
          icon: inputIcon,
          // filled: true,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        )),
        compareFn: (i, s) => i[keyField] == s[keyField],
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

String getItemAsString(dynamic u, List<String> listsearchText) {
  var toDisplay = "";


  for (var i = 1; i < listsearchText.length; i++) {
       if(u[listsearchText[i]]!=null){
              toDisplay += "${u[listsearchText[i]]} ";
            }
  }   

  // for (var element in listsearchText) {
  //           if(u[element]!=null){
  //             toDisplay += "${u[element]} ";
  //           }
  // }

  return toDisplay.trimRight();
}

String getAbbrString(String input) {
  final splt = input.trim().split(' ').map((l) => l[0]).take(2).join();
  return splt;
}

Widget toView(
   dynamic context,dynamic item,dynamic isSelected, List<String> listsearchText, String keyField) {
  final toDisplay = getItemAsString(item, listsearchText);
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
      //  title: Text(item[listsearchText[0]].toString(),style: TextStyle(fontSize: defaultFontSize),),
          title: Text(item[listsearchText[0]].toString()),
        subtitle: Text(toDisplay),
        leading: CircleAvatar(
          child: Text(getAbbrString(item[listsearchText[0]].toString())),
        ),
      ));
}
