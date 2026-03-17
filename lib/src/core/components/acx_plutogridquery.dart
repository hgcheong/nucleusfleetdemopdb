import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/utils/uiplutogridhelpers.dart';

class AcxTrinaGridQuery extends ConsumerWidget {
  const AcxTrinaGridQuery(
      {super.key,
      required this.query,
      required this.idField,
      this.onNew,
      required this.queryDel,
      this.onDelete,
      this.onRefresh,
      this.onSelected,
      this.exportTitle = "Report"});

  final QueryObject query;
  final QueryObject? queryDel;
  final String idField;
  final String exportTitle;
  final Function? onNew;
  final Function? onDelete;
  final Function? onRefresh;
  final Function? onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return buildDataTableQueryObject(ref, getGridConfig(context), query,
        queryDel, idField, List<Langkeypair>.empty(),
        onNew: onNew,
        onDelete: onDelete,
        onRefresh: onRefresh,
        onSelected: onSelected,
        exportTitle: exportTitle);
  }
}
