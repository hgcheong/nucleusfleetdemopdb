import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class AcxListButtonNavWrap extends HookConsumerWidget {
  const AcxListButtonNavWrap(
      {super.key,
      required this.querysql,
      required this.params,
      required this.returnSelectedRef,
      required this.displayfield,
      required this.keyField,
      this.filterField,
      this.filterValue,
      this.deleteSelectedRef,
      this.addNew,
      this.selectedKey,
      this.editIcon = Icons.edit});
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
  final IconData editIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final sSelectedKey = useState(selectedKey);
    final query =
        QueryObject(querysql: querysql, params: params, showMsg: false);
    final value = ref.watch(ReturndatafreezedProvider(query));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AsyncValueWidget<Returndata>(
        data: (Returndata returnData) {
          if (returnData.data == null) {
            return const Text('No data');
          }
          if (returnData.data![0][keyField] == null) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbw54,
                const Text('No Record'),
                ElevatedButton(
                    onPressed: () {
                      addNew!();
                    },
                    child: const Icon(Icons.add))
              ],
            );
          }
          List<Widget> toAdd = [];

          for (var i = 0; i < returnData.data!.length; i++) {
            // if (filterField != null && filterValue != null) {
            //   if (returnData.data![i][filterField] != filterValue) {
            //     continue;
            //   }
            // }

            if (filterField == null) {
              // continue;
            } else {
              if (filterValue == "!null") {
                if (returnData.data![i][filterField] != null) {
                } else {
                  continue;
                }
              } else {
                if (returnData.data![i][filterField] != filterValue) {
                  continue;
                }
              }
            }

            toAdd.add(SizedBox(
              height: 150,
              width: 300.0,
              child: Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // IconButton(onPressed: (){
                      //   ref.invalidate(ReturndatafreezedProvider(query));
                      // }, icon: const Icon(Icons.refresh)
                      // ),
                      ...displayfield.map((element) {
                        final val = returnData.data![i][element];

                        if (val != null) {
                          return Text(
                            returnData.data![i][element].toString(),
                            overflow: TextOverflow.ellipsis,
                          );
                        } else {
                          return const Text('');
                        }
                      }),
                      // Text(returnData.data![i][displayfield]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          deleteSelectedRef != null
                              ? IconButton(
                                  onPressed: () async {
                                    bool confirmed = await ConfirmDialog.show(
                                        title:
                                            'Are you Sure to delete the record?');

                                    if (confirmed) {
                                      deleteSelectedRef!(returnData.data![i]);
                                    }
                                  },
                                  icon: const Icon(Icons.delete))
                              : Container(),
                          Flexible(
                            child: IconButton(
                                onPressed: () async {
                                  returnSelectedRef(returnData.data![i]);
                                },
                                icon: Icon(editIcon)),
                          )
                        ],
                      )
                    ]),
              ),
            ));
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      ref.invalidate(ReturndatafreezedProvider(query));
                    },
                    icon: const Icon(Icons.refresh)),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: toAdd,
                ),
              ],
            ),
          );

          return toReturnWidget;
        },
        value: value,
      ),
    );
  }
}
