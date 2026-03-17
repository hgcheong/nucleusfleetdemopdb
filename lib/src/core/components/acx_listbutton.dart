import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

class AcxListButton extends HookConsumerWidget {
  const AcxListButton({
    super.key,
    required this.querysql,
    required this.params,
    required this.returnSelectedRef,
    required this.displayfield,
    required this.keyField,
    this.selectedKey,
  });
  final String querysql;
  final String displayfield;
  final Map<String, dynamic> params;
  final Function returnSelectedRef;
  final String keyField;
  final String? selectedKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sSelectedKey = useState(selectedKey);
    final value = ref.watch(
        ReturndataProvider(querysql: querysql, params: params, showMsg: false));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 75,
        width: MediaQuery.of(context).size.width / 2,
        child: AsyncValueWidget<Returndata>(
          data: (Returndata returnData) {
            if (returnData.data == null) {
              return const Text('No data');
            }
            List<Widget> toAdd = [];
            for (var i = 0; i < returnData.data!.length; i++) {
              toAdd.add(ElevatedButton(
                onPressed: () async {
                  sSelectedKey.value = returnData.data![i][keyField];
                  returnSelectedRef(returnData.data![i]);
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.card_giftcard,
                          color: sSelectedKey.value ==
                                  returnData.data![i][keyField]
                              ? Colors.black
                              : const Color.fromARGB(255, 192, 205, 215)),
                      Text(returnData.data![i][displayfield]),
                    ]),
              ));
              toAdd.add(const SizedBox(
                width: 2,
              ));
            }
            Row toReturnWidget = Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: toAdd,
            );
            return toReturnWidget;
          },
          value: value,
        ),
      ),
    );
  }
}

// SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: row,
//                         ),
