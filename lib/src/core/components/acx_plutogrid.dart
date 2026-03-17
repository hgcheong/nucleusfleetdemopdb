import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app/api_acxdatatable.dart';
import 'package:nucleusv2/src/core/app/api_acxlangkeyval.dart';
import 'package:nucleusv2/src/core/components/alert_dialogs.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'package:nucleusv2/src/utils/uiplutogridhelpers.dart';

class AcxTrinaGrid extends HookConsumerWidget {
  const AcxTrinaGrid(
      {super.key,
      this.showCheckBox = false,
      this.showActions = false,
      this.isMultiSelect = false,
      this.idField = '',
      this.navPrefix = '',
      this.gridLabel = '',
      required this.querysql,
      required this.params});
  final bool showCheckBox;
  final bool showActions;
  final bool isMultiSelect;
  final String querysql;
  final String idField;
  final String navPrefix;
  final String gridLabel;
  final Map<String, dynamic> params;

  Future<List<Langkeypair>> loadColumnName(
      BuildContext context,
      WidgetRef ref,
      String querysql,
      Map<String, dynamic> params,
      ValueNotifier<bool> isloading) async {
    try {
      isloading.value = true;
      return await ref
          .read(repoLangKeyValueProvider)
          .retrieveLangKey(querysql, params)
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

  Future<Returndata> loadData(
      BuildContext context,
      WidgetRef ref,
      String querysql,
      Map<String, dynamic> params,
      ValueNotifier<bool> isloading) async {
    try {
      isloading.value = true;
      return await ref
          .read(repoQueryProvider)
          .retrieveData(querysql, params)
          .onError((error, stackTrace) {
        if (context.mounted) {
          showAlertDialog(
              context: context, title: 'Error Loading', content: 'Failed');
        }

        return Returndata();
      });
    } catch (e) {
      showAlertDialog(
          context: context, title: 'Error Loading', content: e.toString());
      return Returndata();
    } finally {
      isloading.value = false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theResult = useState<Returndata>(Returndata());
    final isLoading = useState<bool>(false);
    useEffect(() {
      loadData(context, ref, querysql, params, isLoading)
          .then((value) => theResult.value = value);
      return null;
    }, const []);

    return isLoading.value == true
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            height: 1200,
            child: Column(
              children: [
                theResult.value.data == null
                    ? const SizedBox(
                        height: 500,
                      )
                    : Card(
                        child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    try {
                                      isLoading.value = true;
                                      theResult.value = await loadData(context,
                                          ref, querysql, params, isLoading);
                                    } catch (e) {
                                      Toast.error(e.toString());
                                    } finally {
                                      isLoading.value = false;
                                    }
                                  },
                                  icon: const Icon(Icons.refresh)),
                            ],
                          ),
                          buildDataTableSimple(theResult.value,
                              getGridConfig(context), idField, navPrefix),
                        ],
                      )),
                //  child: Center(child: Text('on'))),
              ],
            ),
          );
  }
}
