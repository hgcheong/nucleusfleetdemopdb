import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/debugger.dart';

class AcxDataText extends ConsumerWidget {
  const AcxDataText({
    super.key,
    required this.returnData,
  });

  final Returndata returnData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Debugger.log('Build Called');
    List<Widget> toReturn = [];
    for (var element in returnData.data!) {
      toReturn.add(Row(
        children: [
          Switch(value: false, onChanged: (t) {}),
          Visibility(child: Text(element['DocId'].toString())),
          Text(element['RpstryType'].toString()),
        ],
      ));
    }
    return Column(children: toReturn);
  }
}
