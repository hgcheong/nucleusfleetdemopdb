import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_acxdatatable.dart';
import 'package:nucleusv2/src/core/components/alert_dialogs.dart';
import 'package:nucleusv2/src/core/models/libref/libref.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/helpers.dart';

class AcxSearchBox extends HookConsumerWidget {
  final String querysql;
  final Map<String, dynamic> params;
  final String inputText;
  final Icon? inputIcon;
  final Libref? selectedRef;
  final Function returnSelectedRef;
  const AcxSearchBox(
      {required this.querysql,
      required this.params,
      required this.inputText,
      this.inputIcon,
      required this.returnSelectedRef,
      this.selectedRef,
      super.key});

  Libref? getSelected() {
    return selectedRef;
  }

  Libref? setSelected(String? searchcode, Returndata toSearch) {
    if (searchcode == null || toSearch.data == null || searchcode == 'null') {
      return null;
    }
    List<Libref> toFd = Libref.fromJsonList(toSearch.data!.toList());
    final found = toFd.where((element) => element.refCd == searchcode);
    if (found.isNotEmpty) {
      return found.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState<bool>(false);
    final theResult = useState<Returndata>(Returndata());

    // final _openDropDownProgKey = GlobalKey<DropdownSearchState<Libref>>();
    useEffect(() {
      loadData(ref, querysql, params, isLoading).then((value) {
        if (!context.mounted) {
          return;
        }
        theResult.value = value;
      });
      return null;
    }, [theResult]);
    return DropdownSearch<Libref>(

    suffixProps:DropdownSuffixProps(
      clearButtonProps: const ClearButtonProps(
        isVisible: true,
      ),
    ) ,
      
      popupProps: PopupProps.menu(
          searchFieldProps: const TextFieldProps(autofocus: true),
          showSearchBox: true,
          title: IconButton(
              onPressed: () {
                context.maybePop();
              },
              icon: const Icon(Icons.arrow_drop_up))),
      itemAsString: (Libref u) => u.toString(),
      selectedItem: selectedRef == null
          ? null
          : setSelected(selectedRef!.refCd.toString(), theResult.value),
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
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyle(fontSize: defaultFloatlableSize),
          labelText: inputText,
          icon: inputIcon,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        )),
      
      compareFn: (i, s) => i.refCd == s.refCd,
      items: (filter, p) {
        return loadLibref(context, ref, querysql, params, isLoading);
      },
    );
  }

  Future<List<dynamic>> loadOnlyData(
      BuildContext context,
      WidgetRef ref,
      String querysql,
      Map<String, dynamic> params,
      ValueNotifier<bool> isloading) async {
    try {
      // isloading.value = true;
      return await ref
          .read(repoQueryProvider)
          .retrieveAsList(querysql, params,'RefCd',false)
          .onError((error, stackTrace) {
        if (context.mounted) {
          showAlertDialog(
              context: context, title: 'Error Loading', content: 'Failed');
        }
        return Returndata().data!;
      });
    } catch (e) {
      showAlertDialog(
          context: context, title: 'Error Loading', content: e.toString());
      return Returndata().data!;
    } finally {
      //    isloading.value = false;
    }
  }

  Future<List<Libref>> loadLibref(
      BuildContext context,
      WidgetRef ref,
      String querysql,
      Map<String, dynamic> params,
      ValueNotifier<bool> isloading) async {
    try {
      // isloading.value = true;
      return await ref
          .read(repoQueryProvider)
          .retrieveLibref(querysql, params)
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
    } finally {
      //    isloading.value = false;
    }
  }
}
