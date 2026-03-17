//generate formbuilder widget dynamically

import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/core/models/returndata/column_info.dart';

Widget buildGridView(Returndata srcReturnData, int crossAxisCount,
    List<Langkeypair>? langClmName) {
  //Grab first row only
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  Map<String, dynamic> theData = srcReturnData.data![0];
  List<Widget> list = [];
  theData.forEach((key, value) {
    final clm = clmInfo!.where((element) => element.data == key).first;
    list.add(getFbWidget(clm, key, value));
  });

  /*24 is for notification bar on Android*/
  const double itemHeight = 200;
  const double itemWidth = 50;
  return GridView.count(
    shrinkWrap: true,
    crossAxisCount: crossAxisCount,
    childAspectRatio: (itemWidth / itemHeight),
    children: list,
  );
  // return GridView.count(crossAxisCount: crossAxisCount).
}

Widget getFbWidget(ColumnInfo clmInfo, String key, dynamic value) {
  switch (clmInfo.dataType) {
    case 'nvarchar':
      return FbText(
        name: key,
        label: key,
        initialValue: value,
      );
    case 'varchar':
      return FbText(
        name: key,
        label: key,
        initialValue: value,
      );
    case 'date':
      return FbDateTimePicker(
        name: key,
        label: key,
        initialValue: value,
      );
    case 'datetime':
      return FbDateTimePicker(
        name: key,
        label: key,
        initialValue: value,
      );
    case 'bigint':
      return FbNumber(
        name: key,
        label: key,
        initialValue: value,
      );
    case 'smallint':
      return FbNumber(
        name: key,
        label: key,
        initialValue: value,
      );
    case 'decimal':
      // return TrinaColumnType.number(format: '##0.000');
      return FbNumber(
        name: key,
        label: key,
        initialValue: value,
      );
    case 'int':
      return FbNumber(
        name: key,
        label: key,
        initialValue: value,
      );
    case 'money':
      return FbNumber(
        name: key,
        label: key,
        initialValue: value,
      );
    default:
      return FbText(
        name: key,
        label: key,
        initialValue: value,
      );
  }
}
