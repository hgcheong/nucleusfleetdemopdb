import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

class AcxListButtonNavWrapSelect extends HookConsumerWidget {
  const AcxListButtonNavWrapSelect({
    super.key,
    required this.querysql,
    required this.params,
    required this.returnSelectedRef,
    required this.displayfield,
    required this.keyField,
    required this.toWatch,
    this.filterField,
    this.filterValue,
    this.deleteSelectedRef,
    this.addNew,
    this.selectedKey,
  });
  final String querysql;
  final List<String> displayfield;
  final Map<String, dynamic> params;
  final Function returnSelectedRef;
  final String keyField;
  final String? filterField;
  final String? filterValue;
  final String? selectedKey;
  final Function? deleteSelectedRef;
  final Function? addNew;
  final StateProvider<Map<String, dynamic>> toWatch;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final sSelectedKey = useState(selectedKey);
    final selectedProgram = ref.watch(toWatch);
    final value = ref.watch(
        ReturndataProvider(querysql: querysql, params: params, showMsg: false));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AsyncValueWidget<Returndata>(
        data: (Returndata returnData) {
          if (returnData.data == null) {
            return const Text('No data');
          }
          List<Widget> toAdd = [];
          for (var i = 0; i < returnData.data!.length; i++) {
            if (filterField != null && filterValue != null) {
              if (returnData.data![i][filterField] != filterValue) {
                continue;
              }
            }
            String prgEttyId = returnData.data![i]['PrgEttyId'].toString();
            if (prgEttyId == selectedProgram['PrgEttyId'].toString()) {
              toAdd.add(Container(
                height: 110,
                width: 180.0,
                decoration: BoxDecoration(
                  color: DbColors.primary,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...displayfield.map((element) {
                          final val = returnData.data![i][element];

                          if (val != null) {
                            return Text(
                                returnData.data![i][element].toString());
                          } else {
                            return const Text('');
                          }
                        }),
                        // Text(returnData.data![i][displayfield]),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: DbColors.primary,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              deleteSelectedRef != null
                                  ? IconButton(
                                      onPressed: () {
                                        deleteSelectedRef!(returnData.data![i]);
                                      },
                                      icon: const Icon(Icons.delete))
                                  : Container(),
                              IconButton(
                                  onPressed: () {
                                    returnSelectedRef(returnData.data![i]);
                                  },
                                  icon: const Icon(Icons.water_drop))
                            ],
                          ),
                        )
                      ]),
                ),
              ));
            } else {
              toAdd.add(Container(
                height: 110,
                width: 180.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...displayfield.map((element) {
                          final val = returnData.data![i][element];

                          if (val != null) {
                            return Text(
                                returnData.data![i][element].toString());
                          } else {
                            return const Text('');
                          }
                        }),
                        // Text(returnData.data![i][displayfield]),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              deleteSelectedRef != null
                                  ? IconButton(
                                      onPressed: () {
                                        deleteSelectedRef!(returnData.data![i]);
                                      },
                                      icon: const Icon(Icons.delete))
                                  : Container(),
                              IconButton(
                                  onPressed: () {
                                    returnSelectedRef(returnData.data![i]);
                                  },
                                  icon: const Icon(Icons.water_drop))
                            ],
                          ),
                        )
                      ]),
                ),
              ));
            }

            toAdd.add(const SizedBox(
              width: 10,
            ));
          }

          addNew != null
              ? toAdd.add(Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      onPressed: () {
                        addNew!();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24),
                      ),
                      child: const Icon(
                        Icons.add,
                      )),
                ))
              : Container();

          Widget toReturnWidget = Container(
            padding: const EdgeInsets.all(30),
            // color: Colors.red,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              runSpacing: 5.0,
              spacing: 5.0,
              children: toAdd,
            ),
          );

          return toReturnWidget;
        },
        value: value,
      ),
    );
  }
}
