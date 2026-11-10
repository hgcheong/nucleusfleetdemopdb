import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

class AcxListButtonNav extends HookConsumerWidget {
  const AcxListButtonNav({
    super.key,
    required this.querysql,
    required this.params,
    required this.returnSelectedRef,
    required this.displayfield,
    required this.keyField,
    this.deleteSelectedRef,
    this.addNew,
    this.selectedKey,
  });
  final String querysql;
  final List<String> displayfield;
  final Map<String, dynamic> params;
  final Function returnSelectedRef;
  final String keyField;
  final String? selectedKey;
  final Function? deleteSelectedRef;
  final Function? addNew;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final sSelectedKey = useState(selectedKey);
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
            toAdd.add(Align(
              alignment: Alignment.topCenter,
              child: Container(
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
                            return Text(returnData.data![i][element]);
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
                                  icon: const Icon(Icons.edit))
                            ],
                          ),
                        )
                      ]),
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

          Widget toReturnWidget = SizedBox(
            height: 150,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
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
