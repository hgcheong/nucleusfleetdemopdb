import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_acxdatatable.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/alert_dialogs.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/core/models/vw_schd_billing_item/vw_schd_billing_item.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';

class AcxSearchBoxView extends HookConsumerWidget {
  final String querysql;
  final Map<String, dynamic> params;
  final String inputText;
  final Icon? inputIcon;
  final VwSchdBillingItem? selectedRef;
  final Function returnSelectedRef;

  const AcxSearchBoxView(
      {required this.querysql,
      required this.params,
      required this.inputText,
      this.inputIcon,
      required this.returnSelectedRef,
      this.selectedRef,
      super.key});

  VwSchdBillingItem? getSelected() {
    return selectedRef;
  }

  VwSchdBillingItem? setSelected(String? searchcode, Returndata toSearch) {
    if (searchcode == null || toSearch.data == null || searchcode == 'null') {
      return null;
    }
    List<VwSchdBillingItem> toFd =
        VwSchdBillingItem.fromJsonList(toSearch.data!.toList());
    final found = toFd.where((element) => element.id.toString() == searchcode);
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
    return DropdownSearch<VwSchdBillingItem>(

      suffixProps: DropdownSuffixProps( clearButtonProps: const ClearButtonProps(
        
        isVisible: true,
      ),),
     
      popupProps: PopupProps.bottomSheet(
          showSearchBox: true,
          title: IconButton(
              onPressed: () {
                singleton<AppRouter>().maybePop();
              },
              icon: const Icon(Icons.arrow_drop_up))),
      itemAsString: (VwSchdBillingItem u) => u.dscp.toString(),
      selectedItem: selectedRef == null
          ? null
          : setSelected(selectedRef!.id.toString(), theResult.value),
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
      compareFn: (i, s) => i.dscp == s.dscp,
      items: (filter, infiniteScrollProps) {
        return loadVwSchduleItem(context, ref, querysql, params, isLoading);
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
      isloading.value = true;
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
      isloading.value = false;
    }
  }

  Future<List<VwSchdBillingItem>> loadVwSchduleItem(
      BuildContext context,
      WidgetRef ref,
      String querysql,
      Map<String, dynamic> params,
      ValueNotifier<bool> isloading) async {
    try {
      isloading.value = true;
      return await ref
          .read(repoQueryProvider)
          .retrieveVwShcd(querysql, params)
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
      isloading.value = false;
    }
  }

  // Future<Returndata> loadData(
  //     BuildContext context,
  //     WidgetRef ref,
  //     String querysql,
  //     Map<String, dynamic> params,
  //     ValueNotifier<bool> isloading) async {
  //   try {
  //     isloading.value = true;
  //     return await ref
  //         .read(repoQueryProvider)
  //         .retrieveData(querysql, params)
  //         .onError((error, stackTrace) {
  //       showAlertDialog(
  //           context: context, title: 'Error Loading', content: 'Failed');
  //       return Returndata();
  //     });
  //   } catch (e) {
  //     showAlertDialog(
  //         context: context, title: 'Error Loading', content: e.toString());
  //     return Returndata();
  //   } finally {
  //     isloading.value = false;
  //   }
  // }
}
