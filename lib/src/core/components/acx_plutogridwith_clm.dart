import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plugridextdatas3_provider.dart';
import 'package:nucleusv2/src/core/components/alert_dialogs.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/dialogs.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'package:nucleusv2/src/utils/uiplutogridhelpers.dart';
import 'package:trina_grid/trina_grid.dart';

class AcxTrinaGridWithColumn extends HookConsumerWidget {
  const AcxTrinaGridWithColumn({
    super.key,
    this.showCheckBox = false,
    this.showActions = false,
    this.isMultiSelect = false,
    this.useNav = true,
    required this.idField,
    this.navPrefix = '',
    this.gridLabel = '',
    required this.spName,
    required this.params,
    required this.querysql,
    this.onSelectedTap,
    this.onNew,
    this.onDelete,
    this.onFocus,
    this.actionItems,
  });
  final bool showCheckBox;
  final bool showActions;
  final bool isMultiSelect;
  final bool useNav;
  final String querysql;
  final String idField;
  final String navPrefix;
  final String gridLabel;
  final String spName;
  final Map<String, dynamic> params;
  final Function? onSelectedTap;
  final Function? onFocus;
  final Function? onNew;
  final Function? onDelete;
  final List<Widget>? actionItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theResult = useState<Returndata>(Returndata());
    final theClmName = useState<List<Langkeypair>>([]);
    final isLoading = useState<bool>(false);
    final currentRow = useState<TrinaRow>(TrinaRow(cells: {}));
    final futurel = useMemoized(() =>
        loadColumnName(context, ref, '/sp/ApiConstructLblName/queryasync', {
          "UserType": "I",
          "ObjName": spName,
          "ApplVer": null,
        }));
    final snp = useFuture(futurel, initialData: null);
    useEffect(() {
      final clm = snp.data;
      if (clm == null) {
        return;
      }
      if (!context.mounted) {
        return;
      }
      theClmName.value = clm;

      loadData(ref, querysql, params, isLoading).then((value) {
        if (context.mounted) {
          if(value.data==null){
                theResult.value = Returndata(
                data: null,
                columnInfo: value.columnInfo);
          }
              theResult.value = value;
          //         if(theResult.value.data !=null){
          //  if(theResult.value.data!.isNotEmpty){
          //   final TrinaRow setRow = TrinaRow.fromJson(theResult.value.data![0]);
          // ref.read(globalPlutoSelectedRow.notifier).state = setRow;
          //         }}
        }
      });

      return null;
    }, [snp.data]);

    List<Widget> toAdd = List.empty(growable: true);

    if (actionItems != null) {
      if (actionItems!.isNotEmpty) {
        toAdd = actionItems!;
      }
    }

    return isLoading.value == true
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Card(
                child: Column(
              children: [
                Row(children: [Text(gridLabel),]),
                Row(
                  children: [
           
                    IconButton(
                        onPressed: () async {
                          try {
                            isLoading.value = true;
                            theResult.value = await loadData(
                                ref, querysql, params, isLoading);
                            currentRow.value = TrinaRow(cells: {});
                          } catch (e) {
                            Toast.error(e.toString());
                          } finally {
                            isLoading.value = false;
                          }
                        },
                        icon: const Icon(Icons.refresh)),
                    onNew != null
                        ? IconButton(
                            onPressed: () async {
                              try {
                                //
                                if (useNav) {
                                  var urlNav = '$navPrefix/new';

                                  singleton<AppRouter>().pushPath(urlNav);
                                } else {
                                  onNew!();
                                }
                              } catch (e) {
                                showAlertDialog(
                                    context: context,
                                    title: 'Error Loading',
                                    content: e.toString());
                              } finally {
                                isLoading.value = false;
                              }
                            },
                            icon: const Icon(Icons.add))
                        : Container(),
                    onDelete == null
                        ? Container()
                        : IconButton(
                            onPressed: () async {
                              try {
                                bool confirmed = await ConfirmDialog.show(
                                  title: "Delete?",
                                  body: "Are you sure you want to Delete?",
                                  destructive: true,
                                  confirmText: "Yes",
                                  cancelText: "Cancel",
                                );

                                if (!confirmed) {
                                  return;
                                }

                                try {
                                  isLoading.value = true;

                                  final myCurrentRow = ref
                                      .read(globalPlutoSelectedRow.notifier)
                                      .state;
                                  onDelete!(myCurrentRow);

                                  theResult.value = await loadData(
                                      ref, querysql, params, isLoading);
                                  currentRow.value = TrinaRow(cells: {});
                                } catch (e) {
                                  Toast.error(e.toString());
                                } finally {
                                  isLoading.value = false;
                                }

                                //                  await  Future.delayed(
                                //   const Duration(seconds: 0),
                                //   () {

                                //    final myCurrentRow = ref.read(globalPlutoSelectedRow.notifier).state;
                                //       onDelete!(myCurrentRow);
                                //   },
                                // ).then((value) async {
                                //          try {
                                //         isLoading.value = true;
                                //         theResult.value = await loadData( ref, querysql, params, isLoading);
                                //       } catch (e) {
                                //         Toast.error(e.toString());
                                //       } finally {
                                //         isLoading.value = false;
                                //       }
                                // },);

                                //  onDelete!(currentRow);
                              } catch (e) {
                                //    showAlertDialog(context: context, title: 'Error Loading', content: e.toString());
                                Toast.message('Error Loading');
                              } finally {
                                isLoading.value = false;
                              }
                            },
                            icon: const Icon(Icons.delete)),
                    ...toAdd
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height - 250,
                    child: buildDataTableWithRef(
                        theResult.value,
                        getGridConfig(context),
                        idField,
                        navPrefix,
                        theClmName.value,
                        onSelectedTap,
                        useNav,
                        onFocus,
                        ref)),
              ],
            )),
          );
  }
}

class DeleteButtonGrid extends ConsumerWidget {
  const DeleteButtonGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String deleteId = ref.watch(s3SelectedRowProvider);
    return IconButton(
        onPressed: () async {
          try {
            Toast.message(deleteId);
            bool confirmed = await ConfirmDialog.show(
                title: 'Are you Sure to delete the file $deleteId');

            if (confirmed) {
              ApiService()
                  .postHttpReturnData('/s3/delete',
                      params: {'key': deleteId}, showMsg: true)
                  .then((value) {
                ref.read(s3ReloadProvider.notifier).state = DateTime.now();
              });
            }
          } catch (e) {
            Toast.error(e.toString());
          } finally {}
        },
        icon: const Icon(Icons.delete));
  }
}
