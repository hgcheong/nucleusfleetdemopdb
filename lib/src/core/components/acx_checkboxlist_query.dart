import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

class AcxCheckBoxListQuery extends ConsumerWidget {
  const AcxCheckBoxListQuery({
    super.key,
    required this.query,
    required this.displayfield,
    required this.toolTipfield,
    required this.indicatorfield,
    required this.countField,
  });

  final QueryObject query;
  final List<String> displayfield;
  final String toolTipfield;
  final String indicatorfield;
  final String countField;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: value,
        data: (Returndata returnData) {
          if (returnData.data != null) {
            List<Widget> toAdd = [];
            for (var i = 0; i < returnData.data!.length; i++) {
              var toDisplay = "";

              for (var element in displayfield) {
                if (returnData.data![i][element] != null) {
                  toDisplay += returnData.data![i][element] + " ";
                }
              }
              toDisplay += "[${returnData.data![i][countField]}]";
              if (returnData.data![i][indicatorfield] != null) {
                toAdd.add(ListTile(
                  leading: Text(toDisplay, overflow: TextOverflow.ellipsis),
                  trailing: Tooltip(
                      message: returnData.data![i][toolTipfield],
                      child: Icon(returnData.data![i][indicatorfield] == 'YES'
                          ? Icons.check_box_outlined
                          : Icons.cancel)),
                ));
              }
            }

            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
              ),
              child: ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: toAdd),
            );
          }
          return const Text('No Record');
        });
  }
}
