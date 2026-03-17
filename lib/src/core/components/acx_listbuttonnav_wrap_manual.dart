import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/dialogs.dart';

//With external query object so that I can refresh it
class AcxListButtonNavWrapManual extends ConsumerWidget {
  const AcxListButtonNavWrapManual(
      {super.key,
      required this.returnSelectedRef,
      required this.displayfield,
      required this.keyField,
      this.filterField,
      this.filterValue,
      this.deleteSelectedRef,
      this.addNew,
      this.selectedKey,
      required this.query});
  final List<String> displayfield;
  final Function returnSelectedRef;
  final String keyField;
  final String? filterField;
  final String? filterValue;
  final String? selectedKey;
  final Function? deleteSelectedRef;
  final Function? addNew;
  final QueryObject query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(ReturndatafreezedProvider(query));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AsyncValueWidget<Returndata>(
        data: (Returndata returnData) {
          if (returnData.data == null) {
                        return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbw54,
                const Text('No Record'),
                addNew != null
                    ? Align(
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
                      )
                    : Container()
              ],
            );
          }
          if (returnData.data![0][keyField] == null) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbw54,
                const Text('No Record'),
                addNew != null
                    ? Align(
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
                      )
                    : Container()
              ],
            );
          }
          List<Widget> toAdd = [];
          for (var i = 0; i < returnData.data!.length; i++) {
            if (filterField != null && filterValue != null) {
              if (returnData.data![i][filterField] != filterValue) {
                continue;
              }
            }
            
            toAdd.add(SizedBox(
              height: 150,
              width: 250.0,
              child: Card(
                child: Column(
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Column(
                            children: [
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
                              })
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [returnData.data![i]["ContactId"] == null? Container():
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
                        IconButton(
                            onPressed: () {
                              returnSelectedRef(returnData.data![i]);
                            },
                            icon: const Icon(Icons.edit))
                      ],
                    ),
                  ],
                ),
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
            child: SingleChildScrollView(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                runSpacing: 5.0,
                spacing: 5.0,
                children: toAdd,
              ),
            ),
          );

          return toReturnWidget;
        },
        value: value,
      ),
    );
  }
}
