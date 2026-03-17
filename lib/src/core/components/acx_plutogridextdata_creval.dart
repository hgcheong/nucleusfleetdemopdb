import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/uiplutogridhelpers.dart';

class AcxTrinaGridExtDataCreEval extends ConsumerWidget {
  const AcxTrinaGridExtDataCreEval({
    super.key,
    this.showBorder = true,
    this.idField = '',
    this.gridLabel = '',
    this.onSelectedTap,
    this.onRefresh,
    this.onChanged,
    required this.extData,
    required this.keyinfo,
    required this.readOnlyColumn,
    required this.showColumn,
  });

  final bool showBorder;
  final String idField;
  final String gridLabel;
  final Function? onSelectedTap;
  final Returndata extData;
  final Function? onRefresh;
  final Function? onChanged;
  final List<Langkeypair> keyinfo;
  final List<String> readOnlyColumn;
  final List<String> showColumn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            onRefresh == null
                ? Container()
                : IconButton(
                    onPressed: () {
                      onRefresh!();
                    },
                    icon: const Icon(Icons.refresh)),
            sbw10
          ],
        ),
        extData.data == null
            ? const SizedBox(
                height: 500,
                child: Center(child: Text('No Data')),
              )
            : showBorder
                ? Card(
                    child: buildDataTableCreditEval(
                        extData,
                        getGridConfig(context),
                        idField,
                        keyinfo,
                        showColumn,
                        readOnlyColumn,
                        onChanged))
                : buildDataTableCreditEval(extData, getGridConfig(context),
                    idField, keyinfo, showColumn, readOnlyColumn, onChanged)

        //  child: Center(child: Text('on'))),
      ],
    );
  }
}
