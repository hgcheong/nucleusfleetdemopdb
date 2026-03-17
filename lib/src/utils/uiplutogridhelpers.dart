import 'dart:convert';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/core/models/returndata/column_info.dart';
import 'package:nucleusv2/src/core/models/returndata/output.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:pdf/pdf.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:pdf/widgets.dart' as pw;


TrinaGridConfiguration getGridConfig(BuildContext context) {
  var brightness = Theme.of(context).brightness;
  return brightness == Brightness.dark
      ? defaultDarkPlutoConfig
      : defaultWhitePlutoConfig;
}

Brightness getBrigthness(BuildContext context) {
  return Theme.of(context).brightness;
}

//Custom Table for User Access Control
Widget buildDataTableExtUserControl(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    Set<TrinaRow> checkedItem,
    String idField,
    List<Langkeypair> langClmName,
    {Function? onSelected,
    Function? onChecked,
    Function? onCheckAll,
    bool useCheckBox = true,
    String? checkIndicatorField}) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;
late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;
  if (srcReturnData.data != null) {}

  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });
      colCnt = int.tryParse(colCnt0.value.toString());
    }
    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }

  if (clmInfo != null && data == null) {
    return TrinaGrid(
        noRowsWidget: const SelectableText('No Data'),
        mode: TrinaGridMode.select,
        configuration: defaultPlutoConfig,
        columns: getColumns(
          clmInfo,
          colCnt!,
          langClmName,
        ),
        rows: const []);
  }

  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return TrinaGrid(
          noRowsWidget: const SelectableText('No Data'),
          mode: TrinaGridMode.select,
          configuration: defaultPlutoConfig,
          columns: getColumns(
            clmInfo,
            colCnt!,
            langClmName,
          ),
          rows: const []);
    }
    checkedItem.clear();
    final allRows = getRowsCheckBox(
        data, clmInfo, colCnt!, checkIndicatorField, checkedItem);

    return TrinaGrid(
      key: UniqueKey(),
      mode: TrinaGridMode.normal,
      configuration: defaultPlutoConfig,
      columns: getColumnsUserControl(
          clmInfo,
          colCnt,
          langClmName,
          useCheckBox: useCheckBox,
          checkIndicatorField),
      rows: allRows,
      onChanged: (TrinaGridOnChangedEvent event) {
        checkedItem.add(event.row);
      },
      onRowChecked: (TrinaGridOnRowCheckedEvent event) {
        if (event.isAll) {
          if (event.isChecked!) {
            for (var element in allRows) {
              element.cells[checkIndicatorField]!.value = 'Y';
            }
            checkedItem.addAll(allRows);
          } else {
            for (var element in allRows) {
              element.cells[checkIndicatorField]!.value = 'N';
            }
            checkedItem.addAll(allRows);
            //  checkedItem.clear();
          }
        } else {
          final toUpdateField = checkedItem.where((v) {
            return v.cells[idField] == event.row!.cells[idField];
          });
          //if Empty add it witch checked state else just update it
          if (toUpdateField.isEmpty) {
            var toAddRow = event.row!;
            toAddRow.cells[checkIndicatorField]!.value =
                event.isChecked == true ? 'Y' : 'N';
            checkedItem.add(toAddRow);
          } else {
            toUpdateField.first.cells[checkIndicatorField]!.value =
                event.isChecked == true ? 'Y' : 'N';
          }
        }

        if (onCheckAll != null) {
          onCheckAll(event);
        }

        if (onChecked != null) {
          if (event.row != null) {
            onChecked(event.row);
          }
        }
      },
      onRowDoubleTap: (event) {
        if (onSelected != null) {
          //To be consistent with the delete we return as Plutorow instead of as Map<String, dynamic>
          //  onSelected(event.row.cells);

          onSelected(event.row);
        }
      },
      onLoaded: (TrinaGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
          stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
      },
    );
  } else {
    return const Center(child: CircularProgressIndicator());
  }
}

Widget buildDataTableExtCheckOrUnCheck(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    Set<TrinaRow> checkedItem,
    String idField,
    List<Langkeypair> langClmName,
    {Function? onSelected,
    Function? onChecked,
    Function? onCheckAll,
    bool useCheckBox = true,
    String? checkIndicatorField}) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;
late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;
  if (srcReturnData.data != null) {}

  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });
      colCnt = int.tryParse(colCnt0.value.toString());
    }
    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }

  if (clmInfo != null && data == null) {
    return TrinaGrid(
        noRowsWidget: const SelectableText('No Data'),
        mode: TrinaGridMode.select,
        configuration: defaultPlutoConfig,
        columns: getColumns(
          clmInfo,
          colCnt!,
          langClmName,
        ),
        rows: const []);
  }

  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return TrinaGrid(
          noRowsWidget: const SelectableText('No Data'),
          mode: TrinaGridMode.select,
          configuration: defaultPlutoConfig,
          columns: getColumns(
            clmInfo,
            colCnt!,
            langClmName,
          ),
          rows: const []);
    }
    checkedItem.clear();
    final allRows = getRowsCheckBox(
        data, clmInfo, colCnt!, checkIndicatorField, checkedItem);

    return TrinaGrid(
      key: UniqueKey(),
      mode: TrinaGridMode.select,
      configuration: defaultPlutoConfig,
      columns:
          getColumns(clmInfo, colCnt, langClmName, useCheckBox: useCheckBox),
      rows: allRows,
      onRowChecked: (TrinaGridOnRowCheckedEvent event) {
        if (event.isAll) {
          if (event.isChecked!) {
            for (var element in allRows) {
              element.cells[checkIndicatorField]!.value = 'Y';
            }
            checkedItem.addAll(allRows);
          } else {
            for (var element in allRows) {
              element.cells[checkIndicatorField]!.value = 'N';
            }
            checkedItem.addAll(allRows);
            //  checkedItem.clear();
          }
        } else {
          final toUpdateField = checkedItem.where((v) {
            return v.cells[idField] == event.row!.cells[idField];
          });
          //if Empty add it witch checked state else just update it
          if (toUpdateField.isEmpty) {
            var toAddRow = event.row!;
            toAddRow.cells[checkIndicatorField]!.value =
                event.isChecked == true ? 'Y' : 'N';
            checkedItem.add(toAddRow);
          } else {
            toUpdateField.first.cells[checkIndicatorField]!.value =
                event.isChecked == true ? 'Y' : 'N';
          }
        }

        if (onCheckAll != null) {
          onCheckAll(event);
        }

        if (onChecked != null) {
          if (event.row != null) {
            onChecked(event.row);
          }
        }
      },
      onRowDoubleTap: (event) {
        if (onSelected != null) {
          //To be consistent with the delete we return as Plutorow instead of as Map<String, dynamic>
          //  onSelected(event.row.cells);

          onSelected(event.row);
        }
      },
      onLoaded: (TrinaGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
          stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
      },
    );
  } else {
    return const Center(child: CircularProgressIndicator());
  }
}

Widget buildDataTableExtCheckBox(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    Set<TrinaRow> checkedItem,
    String idField,
    List<Langkeypair> langClmName,
    {Function? onSelected,
    Function? onChecked,
    Function? onCheckAll,
    bool useCheckBox = true,
    String? checkIndicatorField}) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;
late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;
  if (srcReturnData.data != null) {}

  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });
      colCnt = int.tryParse(colCnt0.value.toString());
    }
    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }

  if (clmInfo != null && data == null) {
    return TrinaGrid(
        noRowsWidget: const SelectableText('No Data'),
        mode: TrinaGridMode.select,
        configuration: defaultPlutoConfig,
        columns: getColumns(
          clmInfo,
          colCnt!,
          langClmName,
        ),
        rows: const []);
  }

  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return TrinaGrid(
          noRowsWidget: const SelectableText('No Data'),
          mode: TrinaGridMode.select,
          configuration: defaultPlutoConfig,
          columns: getColumns(
            clmInfo,
            colCnt!,
            langClmName,
          ),
          rows: const []);
    }
    checkedItem.clear();
    final allRows = getRowsCheckBox(
        data, clmInfo, colCnt!, checkIndicatorField, checkedItem);

    return TrinaGrid(
      key: UniqueKey(),
      mode: TrinaGridMode.select,
      configuration: defaultPlutoConfig,
      columns:
          getColumns(clmInfo, colCnt, langClmName, useCheckBox: useCheckBox),
      rows: allRows,
      onRowChecked: (TrinaGridOnRowCheckedEvent event) {
        if (event.isAll) {
          if (event.isChecked!) {
            checkedItem.addAll(allRows);
          } else {
            checkedItem.clear();
          }
        } else {
          if (event.isChecked!) {
            final isExist = checkedItem.where((v) {
              return v == event.row!;
            });
            if (isExist.isEmpty) {
              checkedItem.add(event.row!);
            } else {
              checkedItem.remove(event.row!);
            }
          } else {
            checkedItem.remove(event.row!);
          }
        }

        if (onCheckAll != null) {
          onCheckAll(event);
        }

        if (onChecked != null) {
          if (event.row != null) {
            onChecked(event.row);
          }
        }
      },
      onRowDoubleTap: (event) {
        if (onSelected != null) {
          //To be consistent with the delete we return as Plutorow instead of as Map<String, dynamic>
          //  onSelected(event.row.cells);

          onSelected(event.row);
        }
      },
      onLoaded: (TrinaGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
          stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
      },
    );
  } else {
    return const Center(child: CircularProgressIndicator());
  }
}

Widget buildDataTableSimple(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    String idField,
    String navPrefix) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;
  late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;
  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });
      colCnt = int.tryParse(colCnt0.value.toString());
    }
    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }

  if (clmInfo != null && data != null) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 600,
          child: TrinaGrid(
            mode: TrinaGridMode.select,
            configuration: defaultPlutoConfig,
            columns: getColumns(clmInfo, colCnt!, []),
            rows: getRows(data, clmInfo, colCnt, null),
            onRowDoubleTap: (event) {
              var urlNav =
                  '$navPrefix/${event.row.cells[idField]!.value.toString()}';
              singleton<AppRouter>().pushPath(urlNav);
            },
            onLoaded: (TrinaGridOnLoadedEvent event) {
                stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
          stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
            },
          ),

          // rows: []),
        ),
      ],
    );
  } else {
    return const Center(child: CircularProgressIndicator());
  }
}

Widget buildDataTableWithRef(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    String idField,
    String navPrefix,
    List<Langkeypair> langClmName,
    Function? onSelected,
    bool useNav,
    Function? onFocus,
    WidgetRef ref) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;
  late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;
  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });
      colCnt = int.tryParse(colCnt0.value.toString());
    }
    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }

  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return TrinaGrid(
          noRowsWidget: const SelectableText('No Data'),
          mode: TrinaGridMode.select,
          configuration: defaultPlutoConfig,
          columns: getColumns(
            clmInfo,
            colCnt!,
            langClmName,
          ),
          rows: const []);
    }
    return TrinaGrid(
      mode: TrinaGridMode.selectWithOneTap,
      configuration: defaultPlutoConfig,
      columns: getColumns(
        clmInfo,
        colCnt!,
        langClmName,
      ),
      onSelected: (event) {
        ref.read(globalPlutoSelectedRow.notifier).state = event.row!;
        if (onFocus != null) {
          onFocus(event.row);
        }
      },
      rows: getRowsWithRef(data, clmInfo, colCnt, ref),
      onRowDoubleTap: (event) {
        if (useNav) {
          var urlNav =
              '$navPrefix/${event.row.cells[idField]!.value.toString()}';
          singleton<AppRouter>().pushPath(urlNav);
        } else {
          if (onSelected != null) {
            onSelected(event.row);
          }
        }
      },
      onLoaded: (TrinaGridOnLoadedEvent event) {
   
           stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
          stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  if(stateManager.gridKey.currentContext !=null){
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  }

  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
        
      },
    );
  } else {
    if (data == null && clmInfo != null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.select,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

Widget buildDataTable(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    String idField,
    String navPrefix,
    List<Langkeypair> langClmName,
    Function? onSelected,
    bool useNav,
    Function? onFocus) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;
  late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;
  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });
      colCnt = int.tryParse(colCnt0.value.toString());
    }
    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }

  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return TrinaGrid(
          noRowsWidget: const SelectableText('No Data'),
          mode: TrinaGridMode.select,
          configuration: defaultPlutoConfig,
          columns: getColumns(
            clmInfo,
            colCnt!,
            langClmName,
          ),
          rows: const []);
    }
    return TrinaGrid(
      mode: TrinaGridMode.selectWithOneTap,
      configuration: defaultPlutoConfig,
      columns: getColumns(
        clmInfo,
        colCnt!,
        langClmName,
      ),
      onSelected: (event) {
        if (onFocus != null) {
          onFocus(event.row);
        }
      },
      rows: getRows(data, clmInfo, colCnt, null),
      onRowDoubleTap: (event) {
        if (useNav) {
          var urlNav =
              '$navPrefix/${event.row.cells[idField]!.value.toString()}';
          singleton<AppRouter>().pushPath(urlNav);
        } else {
          if (onSelected != null) {
            onSelected(event.row);
          }
        }
      },
      onLoaded: (TrinaGridOnLoadedEvent event) {
         stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
          stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
      },
    );
  } else {
    if (data == null && clmInfo != null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.select,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

Widget buildDataTableExtActionItems(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    String idField,
    String navPrefix,
    List<Langkeypair> langClmName,
    bool useNav,
    {Function? onSelected,
    Function? onChecked,
    Function? onCheckAll,
    Function? onPopUp,
    List<Map<String, dynamic>>? popMenuItems,
    bool useCheckBox = false,
    Icon? popUpIcon}) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;

late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;

  
  if (srcReturnData.data != null) {}

  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });
      colCnt = int.tryParse(colCnt0.value.toString());
    }

    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }

  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.select,
            configuration: defaultPlutoConfig,
            columns: getColumnsActionItems(clmInfo, colCnt!, langClmName,
                idField, onPopUp, popMenuItems!.toList(),
                popUpIcon: popUpIcon),
            rows: const []),
      );
    }
    return SizedBox(
      height: 1280,
      child: Column(
        children: [
          // SelectableText(data.toString()),
          // ElevatedButton(onPressed: () {}, child: const SelectableText('ONT')),
          SizedBox(
            height: 1280,
            child: TrinaGrid(
              //    key: UniqueKey(),
              mode: TrinaGridMode.select,
              
              configuration: defaultPlutoConfig,
              columns: getColumnsActionItems(
                  clmInfo,
                  colCnt!,
                  langClmName,
                  useCheckBox: useCheckBox,
                  idField,
                  onPopUp,
                  popMenuItems!.toList(),
                  popUpIcon: popUpIcon),
              rows: getRows(data, clmInfo, colCnt, null),
              onRowChecked: (TrinaGridOnRowCheckedEvent event) {
                if (onCheckAll != null) {
                  onCheckAll(event);
                }
                  
                if (onChecked != null) {
                  if (event.row != null) {
                    onChecked(event.row);
                  }
                }
              },
              onRowDoubleTap: (event) {
                // if (useNav) {
                //   var urlNav =
                //       '$navPrefix/${event.row.cells[idField]!.value.toString()}';
                //   singleton<AppRouter>().pushNamed(urlNav);
                // } else {
                //   if (onSelected != null) {
                //     onSelected(event.row.cells);
                //   }
                // }
                  
                if (onSelected != null) {
                  //changed to by row instead of cells like extcheckbox
                  onSelected(event.row);
                }
              },
              onLoaded: (TrinaGridOnLoadedEvent event) {
                stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
          stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
              },
            ),
          ),
        ],
      ),
    );
  } else {
    if (data == null && clmInfo != null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.select,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

Widget buildDataTableExt(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    String idField,
    String navPrefix,
    List<Langkeypair> langClmName,
    bool useNav,
    {Function? onSelected,
    Function? onFocus,
    Function? onChecked,
    Function? onCheckAll,
    bool useCheckBox = false}) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;

late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;
  if (srcReturnData.data != null) {}

  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });
      colCnt = int.tryParse(colCnt0.value.toString());
    }

    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }
// late TrinaGridStateManager stateManager;
  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.selectWithOneTap,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
    return Column(children: [
      Expanded(
        child: TrinaGrid(
          mode: TrinaGridMode.selectWithOneTap,
          configuration: defaultPlutoConfig,
          columns: getColumns(clmInfo, colCnt!, langClmName,
              useCheckBox: useCheckBox),
          rows: getRows(data, clmInfo, colCnt, null),
          onRowChecked: (TrinaGridOnRowCheckedEvent event) {
            if (onCheckAll != null) {
              onCheckAll(event);
            }

            if (onChecked != null) {
              if (event.row != null) {
                onChecked(event.row);
              }
            }
          },

          // onSelected: (event) {
          //   if(onFocus != null){
          //       onFocus(event.row);
          //   }

          // },
          onRowDoubleTap: (event) {
            // if (useNav) {
            //   var urlNav =
            //       '$navPrefix/${event.row.cells[idField]!.value.toString()}';
            //   singleton<AppRouter>().pushNamed(urlNav);
            // } else {
            //   if (onSelected != null) {
            //     onSelected(event.row.cells);
            //   }
            // }

            if (onSelected != null) {
              //changed to by row instead of cells like extcheckbox
              onSelected(event.row);
            }
          },
          onLoaded: (TrinaGridOnLoadedEvent event) {
              stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
          stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
            // stateManager = event.stateManager;
          },
        ),
      ),
    ]);
  } else {
    if (data == null && clmInfo != null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.selectWithOneTap,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
    return const Center(
      child: SizedBox(),
    );
  }
}


Widget buildDataTableExtUniqueKey(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    String idField,
    String navPrefix,
    List<Langkeypair> langClmName,
    bool useNav,
    {Function? onSelected,
    Function? onFocus,
    Function? onChecked,
    Function? onCheckAll,
    bool useCheckBox = false}) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;

late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;
  if (srcReturnData.data != null) {}

  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });
      colCnt = int.tryParse(colCnt0.value.toString());
    }

    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }
// late TrinaGridStateManager stateManager;
  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.selectWithOneTap,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
    return Column(children: [
      Expanded(
        child: TrinaGrid(
          key: UniqueKey(),
          mode: TrinaGridMode.selectWithOneTap,
          configuration: defaultPlutoConfig,
          columns: getColumns(clmInfo, colCnt!, langClmName,
              useCheckBox: useCheckBox),
          rows: getRows(data, clmInfo, colCnt, null),
          onRowChecked: (TrinaGridOnRowCheckedEvent event) {
            if (onCheckAll != null) {
              onCheckAll(event);
            }

            if (onChecked != null) {
              if (event.row != null) {
                onChecked(event.row);
              }
            }
          },

          // onSelected: (event) {
          //   if(onFocus != null){
          //       onFocus(event.row);
          //   }

          // },
          onRowDoubleTap: (event) {
            // if (useNav) {
            //   var urlNav =
            //       '$navPrefix/${event.row.cells[idField]!.value.toString()}';
            //   singleton<AppRouter>().pushNamed(urlNav);
            // } else {
            //   if (onSelected != null) {
            //     onSelected(event.row.cells);
            //   }
            // }

            if (onSelected != null) {
              //changed to by row instead of cells like extcheckbox
              onSelected(event.row);
            }
          },
          onLoaded: (TrinaGridOnLoadedEvent event) {
              stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
          stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
            // stateManager = event.stateManager;
          },
        ),
      ),
    ]);
  } else {
    if (data == null && clmInfo != null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.selectWithOneTap,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
    return const Center(
      child: SizedBox(),
    );
  }
}

Widget buildEmptyDtaTable( Returndata srcReturnData,   TrinaGridConfiguration defaultPlutoConfig){
    final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
      final List<Output>? outputParam = srcReturnData.output;
  int? colCnt = 0;
    int? msgId = 0;
  int? returnValue = 0;
  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });

      colCnt = colCnt0.value == null
          ? clmInfo!.length
          : int.tryParse(colCnt0.value.toString());
    }

    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }
return TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.selectWithOneTap,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo!,
              colCnt!,
               List<Langkeypair>.empty(),
            ),
            rows: const []);
}

Widget buildDataTableExtV2(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    String idField,
    List<Langkeypair> langClmName,
    {Function? onSelected,
       Function? onNew,
   Function? onDelete,
   Function? onRefresh,
    bool useCheckBox = false,
   final List<AppButtonWithFunction>? appButtons,
    final List<IconWithFunction>? iconButtons,
    String exportTitle = '',
    String gridTitle = ''}) {
   List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
   List<dynamic>? data = srcReturnData.data;
   List<Output>? outputParam = srcReturnData.output;
  late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;

  if (srcReturnData.data != null) {}
     List<IconButton> toAddIconButton = List.empty(growable: true);
          if (iconButtons != null) {
            if (iconButtons.isNotEmpty) {
              for (var element in iconButtons.toList()) {
                toAddIconButton.add(IconButton(
                  onPressed: (){
                    if(useCheckBox){
element.func(stateManager.checkedRows);
                    }else{
element.func(stateManager.currentSelectingRows);
                    }
                    
                  },
                  icon: element.icon
                ));
              }
            }
          } 
       List<AppButton> toAddAppButton = List.empty(growable: true);
          if (appButtons != null) {
            if (appButtons.isNotEmpty) {
              for (var element in appButtons.toList()) {
                toAddAppButton.add(AppButton(
                  onPressed: (){
                    if(useCheckBox){
element.func(stateManager.checkedRows);
                    }else{
element.func(stateManager.currentSelectingRows);
                    }
                    
                  },
                  icon: element.btn.icon,
                  label: element.btn.label,    
                ));
              }
            }
          } 
  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });

      colCnt = colCnt0.value == null
          ? clmInfo!.length
          : int.tryParse(colCnt0.value.toString());
    }

    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }
  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Flexible(
              flex:1,
              child: Row(children: [    SelectableText(gridTitle),
                        onRefresh == null
                        ? Container()
                        : IconButton(
                            onPressed: () {      
                               //      stateManager.removeAllRows(notify: true);
                               // stateManager.appendRows(getRows(data, clmInfo, colCnt!, null));             
                              onRefresh();
                         
                            },
                            icon: const Icon(Icons.refresh)),
                    onNew == null
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              onNew();
                            },
                            icon: const Icon(Icons.add)),
                        ...toAddIconButton,
                        ...toAddAppButton,],),
            ),
          Flexible(
            flex: 11,
            child: TrinaGrid(
                noRowsWidget: const SelectableText('No Data'),
                mode: TrinaGridMode.selectWithOneTap,
                configuration: defaultPlutoConfig,
                columns: getColumns(
                  clmInfo,
                  colCnt!,
                  langClmName,
                ),
                rows: const []),
          ),
        ],
      );
    }
      return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    Flexible(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [    SelectableText(gridTitle),
          onRefresh == null
                      ? Container()
                      : IconButton(
                          onPressed: () {      
                             //      stateManager.removeAllRows(notify: true);
                             // stateManager.appendRows(getRows(data, clmInfo, colCnt!, null));             
                            onRefresh();
                       
                          },
                          icon: const Icon(Icons.refresh)),
                  onNew == null
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            onNew();
                          },
                          icon: const Icon(Icons.add)),
                  onDelete == null
                      ? Container()
                      : IconButton(
                          onPressed: () async {
                            try {
                               if(useCheckBox){
                                  if(stateManager.checkedRows.isEmpty){
                                      Toast.message('Please check row to delete');
                                    return;
                                  }
                               }
                              bool confirmed = await ConfirmDialog.show(
                                title: "Delete?",
                                body: "Are you sure you want to Delete?",
                                destructive: true,
                                confirmText: "Yes",
                                cancelText: "Cancel",
                              );

                              if (!confirmed) {
                                return;
                              }

                                  if(useCheckBox){
onDelete(stateManager.checkedRows);
                    }else{
onDelete(stateManager.currentSelectingRows);
                    }

                            } catch (e) {
                              Toast.message('Error Loading');
                            } finally {}
                          },
                          icon: const Icon(Icons.delete)),
          ...toAddIconButton,
          ...toAddAppButton,],),
      
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz),
            onSelected: (String value) {
              switch (value) {
                case 'Filter On':
                  stateManager.setShowColumnFilter(true);
                  break;
                case 'Filter Off':
                  stateManager.setShowColumnFilter(false);
                  break;
                case 'PDF':
                      exportToPdf(stateManager, gridTitle);
                  break;
                case 'Export CSV':
                  exportToCsv(stateManager, exportTitle);
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Export CSV','PDF', 'Filter On', 'Filter Off'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: SelectableText(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    ),
    Flexible(
     flex: 11,
      child: TrinaGrid(
        key: UniqueKey(),
        mode: TrinaGridMode.selectWithOneTap,   
        noRowsWidget:
            const SizedBox(height: 100, child: SelectableText('No Data')),
        configuration: defaultPlutoConfig,
        columns: getColumns(clmInfo, colCnt!, langClmName,
                useCheckBox: useCheckBox),
        rows: getRows(data, clmInfo, colCnt, null),

        onRowDoubleTap: (event) {
          if (onSelected != null) {
            //changed to by row instead of cells like extcheckbox
            onSelected(event.row);
          }
        },
        onLoaded: (TrinaGridOnLoadedEvent event) {
           stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
        },
      ),
    ),
  ]);

  }else {
    if (data == null && clmInfo != null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.selectWithOneTap,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
    return const Center(
      child: SizedBox(),
    );
  }

}

Widget buildDataTableExtV3(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    String idField,
    List<Langkeypair> langClmName,
    {Function? onSelected,
       Function? onNew,
   Function? onDelete,
   Function? onRefresh,
    bool useCheckBox = false,
    List<AppButtonWithFunction>? appButtons,
    final List<IconWithFunction>? iconButtons,
    String exportTitle = '',
    String gridTitle = '',
    required TrinaGridStateManager stateManager}) {
   List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
   List<dynamic>? data = srcReturnData.data;
   List<Output>? outputParam = srcReturnData.output;
  
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;

  if (srcReturnData.data != null) {}
     List<IconButton> toAddIconButton = List.empty(growable: true);
          if (iconButtons != null) {
            if (iconButtons.isNotEmpty) {
              for (var element in iconButtons.toList()) {
                toAddIconButton.add(IconButton(
                  onPressed: (){
                    if(useCheckBox){
element.func(stateManager.checkedRows);
                    }else{
element.func(stateManager.currentSelectingRows);
                    }
                    
                  },
                  icon: element.icon
                ));
              }
            }
          } 
       List<AppButton> toAddAppButton = List.empty(growable: true);
          if (appButtons != null) {
            if (appButtons.isNotEmpty) {
              for (var element in appButtons.toList()) {
                toAddAppButton.add(AppButton(
                  onPressed: (){
                    if(useCheckBox){
element.func(stateManager.checkedRows);
                    }else{
element.func(stateManager.currentSelectingRows);
                    }
                    
                  },
                  icon: element.btn.icon,
                  label: element.btn.label,    
                ));
              }
            }
          } 
  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });

      colCnt = colCnt0.value == null
          ? clmInfo!.length
          : int.tryParse(colCnt0.value.toString());
    }

    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }
  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.selectWithOneTap,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
      return Column(children: [
    Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [    SelectableText(gridTitle),
          onRefresh == null
                      ? Container()
                      : IconButton(
                          onPressed: () {      
                             //      stateManager.removeAllRows(notify: true);
                             // stateManager.appendRows(getRows(data, clmInfo, colCnt!, null));             
                            onRefresh();
                       
                          },
                          icon: const Icon(Icons.refresh)),
                  onNew == null
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            onNew();
                          },
                          icon: const Icon(Icons.add)),
                  onDelete == null
                      ? Container()
                      : IconButton(
                          onPressed: () async {
                            try {
                               if(useCheckBox){
                                  if(stateManager.checkedRows.isEmpty){
                                      Toast.message('Please check row to delete');
                                    return;
                                  }
                               }
                              bool confirmed = await ConfirmDialog.show(
                                title: "Delete?",
                                body: "Are you sure you want to Delete?",
                                destructive: true,
                                confirmText: "Yes",
                                cancelText: "Cancel",
                              );

                              if (!confirmed) {
                                return;
                              }

                                  if(useCheckBox){
onDelete(stateManager.checkedRows);
                    }else{
onDelete(stateManager.currentSelectingRows);
                    }

                            } catch (e) {
                              Toast.message('Error Loading');
                            } finally {}
                          },
                          icon: const Icon(Icons.delete)),
          ...toAddIconButton,
          ...toAddAppButton,],),
      
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz),
            onSelected: (String value) {
              switch (value) {
                case 'Filter On':
                  stateManager.setShowColumnFilter(true);
                  break;
                case 'Filter Off':
                  stateManager.setShowColumnFilter(false);
                  break;
                case 'PDF':
                      exportToPdf(stateManager, gridTitle);
                  break;
                case 'Export CSV':
                  exportToCsv(stateManager, exportTitle);
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Export CSV','PDF', 'Filter On', 'Filter Off'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: SelectableText(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    ),
    Expanded(
     flex: 11,
      child: TrinaGrid(
        mode: TrinaGridMode.select,   
        noRowsWidget:
            const SizedBox(height: 100, child: SelectableText('No Data')),
        configuration: defaultPlutoConfig,
        columns: getColumns(clmInfo, colCnt!, langClmName,
                useCheckBox: useCheckBox),
        rows: getRows(data, clmInfo, colCnt, null),

        onRowDoubleTap: (event) {
          if (onSelected != null) {
            //changed to by row instead of cells like extcheckbox
            onSelected(event.row);
          }
        },
        onLoaded: (TrinaGridOnLoadedEvent event) {
           stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
        },
      ),
    ),
  ]);

  }else {
    if (data == null && clmInfo != null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.select,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
    return const Center(
      child: SizedBox(),
    );
  }

}

Widget buildDataTableExtwExport(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    String idField,
    String navPrefix,
    List<Langkeypair> langClmName,
    bool useNav,
    {Function? onSelected,
    Function? onFocus,
    Function? onChecked,
    Function? onCheckAll,
    bool useCheckBox = false,
    List<AppButtonWithFunction>? appButtons,
    String exportTitle = '',
    String gridTitle = ''}) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;
  late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;
  if (srcReturnData.data != null) {}
       List<AppButton> toAddAppButton = List.empty(growable: true);
          if (appButtons != null) {
            if (appButtons.isNotEmpty) {
              for (var element in appButtons.toList()) {
                toAddAppButton.add(AppButton(
                  onPressed: (){
                    element.func(stateManager.currentRow);
                  },
                  icon: element.btn.icon,
                  label: element.btn.label,    
                ));
              }
            }
          }
  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });

      colCnt = colCnt0.value == null
          ? clmInfo!.length
          : int.tryParse(colCnt0.value.toString());
    }

    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }
  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.selectWithOneTap,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
      return Column(children: [
    Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [    SelectableText(gridTitle),
          ...toAddAppButton,],),
      
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz),
            onSelected: (String value) {
              switch (value) {
                case 'Filter On':
                  stateManager.setShowColumnFilter(true);
                  break;
                case 'Filter Off':
                  stateManager.setShowColumnFilter(false);
                  break;
                case 'PDF':
                      exportToPdf(stateManager, gridTitle);
                  break;
                case 'Export CSV':
                  exportToCsv(stateManager, exportTitle);
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Export CSV','PDF', 'Filter On', 'Filter Off'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: SelectableText(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    ),
    Expanded(
     flex: 11,
      child: TrinaGrid(
        mode: TrinaGridMode.selectWithOneTap,
        noRowsWidget:
            const SizedBox(height: 100, child: SelectableText('No Data')),
        configuration: defaultPlutoConfig,
        columns: getColumns(clmInfo, colCnt!, langClmName,
                useCheckBox: useCheckBox),
        rows: getRows(data, clmInfo, colCnt, null),
        onRowChecked: (TrinaGridOnRowCheckedEvent event) {
          if (onCheckAll != null) {
            onCheckAll(event);
          }

          if (onChecked != null) {
            if (event.row != null) {
              onChecked(event.row);
            }
          }
        },
        onSelected: (event) {
          if (onFocus != null) {
            onFocus(event.row);
          }
        },
        onRowDoubleTap: (event) {
          // if (useNav) {
          //   var urlNav =
          //       '$navPrefix/${event.row.cells[idField]!.value.toString()}';
          //   singleton<AppRouter>().pushNamed(urlNav);
          // } else {
          //   if (onSelected != null) {
          //     onSelected(event.row.cells);
          //   }
          // }

          if (onSelected != null) {
            //changed to by row instead of cells like extcheckbox
            onSelected(event.row);
          }
        },
        onLoaded: (TrinaGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
        },
      ),
    ),
  ]);

  }else {
    if (data == null && clmInfo != null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.select,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
    return const Center(
      child: SizedBox(),
    );
  }

}

Widget buildDataTableCreditEval(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    String idField,
    List<Langkeypair> langClmName,
    List<String> showColumn,
    List<String> readOnlyColumn,
    Function? onChanged) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;

late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  int? msgId = 0;
  int? returnValue = 0;
  if (srcReturnData.data != null) {}

  if (outputParam != null) {
    if (outputParam
        .where((element) => element.parameter == '@ColCnt')
        .isEmpty) {
      colCnt = clmInfo!.length;
    } else {
      final colCnt0 = outputParam.singleWhere((Output element) {
        return element.parameter == '@ColCnt';
      });
      colCnt = int.tryParse(colCnt0.value.toString());
    }

    final msgId0 = outputParam.singleWhere((Output element) {
      return element.parameter == '@MsgId';
    });
    msgId = int.tryParse(msgId0.value.toString());

    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error $msgId in Retriveing Data');
  }

  if (clmInfo != null && data != null) {
    if (data[0][idField] == null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.select,
            configuration: defaultPlutoConfig,
            columns: getColumnsCreEval(
                clmInfo, colCnt!, langClmName, showColumn, readOnlyColumn),
            rows: const []),
      );
    }
    return SizedBox(
      height: 1280,
      child: Column(
        children: [
          // SelectableText(data.toString()),
          // ElevatedButton(onPressed: () {}, child: const SelectableText('ONT')),
          Expanded(
            child: TrinaGrid(
              //key: UniqueKey(),
              mode: TrinaGridMode.normal,
              // rowColorCallback: (rowColorContext) {
              //   if (rowColorContext.row.cells['RefCd']!.value.toString().toUpperCase() == 'SUBTOTAL') {
              //     return Colors.blue.shade900;
              //   } else {
              //   //  return bgColor;
              //   }
              // },
              onChanged: (TrinaGridOnChangedEvent eva) {
                if (onChanged != null) {
                  onChanged(eva);
                }
              },
              configuration: defaultPlutoConfig,
              columns: getColumnsCreEval(
                  clmInfo, colCnt!, langClmName, showColumn, readOnlyColumn),
              rows: getRows(data, clmInfo, colCnt, null),
              onRowDoubleTap: (event) {
                //
              },
              onLoaded: (TrinaGridOnLoadedEvent event){
                  stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
          stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
              },
            ),
          ),
        ],
      ),
    );
  } else {
    if (data == null && clmInfo != null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.select,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt!,
              langClmName,
            ),
            rows: const []),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

Widget buildDataTableExtS3(
    Returndata srcReturnData,
    TrinaGridConfiguration defaultPlutoConfig,
    String idField,
    String navPrefix,
    List<Langkeypair> langClmName,
    bool useNav,
    {Function? onRowDoubleTap,
    required Function onSelected,
    Function? onChecked,
    Function? onCheckAll,
    bool useCheckBox = false}) {
  final List<ColumnInfo>? clmInfo = srcReturnData.columnInfo;
  final List<dynamic>? data = srcReturnData.data;
  final List<Output>? outputParam = srcReturnData.output;

late TrinaGridStateManager stateManager;
  int? colCnt = 0;
  // int? msgId = 0;
  int? returnValue = 0;
  if (srcReturnData.data != null) {}

  if (outputParam != null) {
    colCnt = clmInfo!.length;
    final thereturnValue = outputParam.singleWhere((Output element) {
      return element.parameter == '@Return_Value';
    });
    returnValue = int.tryParse(thereturnValue.value.toString());
  }

  if (returnValue != 0) {
    return ErrorWidget.withDetails(message: 'Error  in Retriveing Data');
  }

  if (clmInfo != null && data != null) {
    return TrinaGrid(
      key: UniqueKey(),
      mode: TrinaGridMode.selectWithOneTap,
      configuration: defaultPlutoConfig,
      columns:
          getColumnsS3(clmInfo, colCnt, langClmName, useCheckBox: useCheckBox),
      rows: getRowsS3(data, clmInfo, colCnt),
      onRowChecked: (TrinaGridOnRowCheckedEvent event) {
        if (onCheckAll != null) {
          onCheckAll(event);
        }

        if (onChecked != null) {
          if (event.row != null) {
            onChecked(event.row);
          }
        }
      },
      onSelected: (event) {
        onSelected(event.row);
      },
      onRowDoubleTap: (event) {
        if (onRowDoubleTap != null) {
          onRowDoubleTap(event.row);
        }
      },
      onLoaded: (TrinaGridOnLoadedEvent event) {
         stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
          stateManager.addListener(() {
          stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
  for (var col in stateManager.columns) {
    stateManager.autoFitColumn(
      stateManager.gridKey.currentContext!,
      col,
    );
  }
  stateManager.setColumnSizeConfig(
    const TrinaGridColumnSizeConfig(
      resizeMode: TrinaResizeMode.normal,
    ),
  );
});
      },
    );
  } else {
    if (data == null && clmInfo != null) {
      return SizedBox(
        height: 300,
        child: TrinaGrid(
            noRowsWidget: const SelectableText('No Data'),
            mode: TrinaGridMode.select,
            configuration: defaultPlutoConfig,
            columns: getColumns(
              clmInfo,
              colCnt,
              langClmName,
            ),
            rows: const []),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

List<TrinaColumn> getColumnsCreEval(
    List<ColumnInfo> clminfo,
    int colCnt,
    List<Langkeypair> langclmName,
    List<String> showColumn,
    List<String> readOnlyColumn) {
  List<TrinaColumn> toReturn = [];
  for (var i = 0; i < clminfo.length; i++) {
    TrinaColumnType theClmType = getColumnType(clminfo[i]);
    final fieldName = clminfo[i].data.toString();
    final isReadyOnly = readOnlyColumn.where((element) => element == fieldName);
    final isToShow = showColumn.where((element) => element == fieldName);
    toReturn.add(TrinaColumn(
        title: langclmName.isEmpty
            ? clminfo[i].title.toString().replaceAll('Media', 'Card')
            : langclmName
                .singleWhere(
                  (element) =>
                      element.keyVal.toString() == clminfo[i].title.toString(),
                  orElse: () {
                    return Langkeypair(
                        keyVal: clminfo[i].data.toString(),
                        fieldNm: clminfo[i].data.toString());
                  },
                )
                .fieldNm
                .toString(),
        field: clminfo[i].data.toString(),
        readOnly: isReadyOnly.isNotEmpty,
        width: fieldName == 'Reference' || fieldName == 'Remark' ? 400 : 150,
        textAlign: theClmType.isNumber
            ? TrinaColumnTextAlign.right
            : TrinaColumnTextAlign.left,
        hide: isToShow.isEmpty,
        type: theClmType));
  }

  return toReturn;
}

List<TrinaColumn> getColumnsUserControl(List<ColumnInfo> clminfo, int colCnt,
    List<Langkeypair> langclmName, String? accessind,
    {bool useCheckBox = false}) {
  List<TrinaColumn> toReturn = [];
  for (var i = 0; i < clminfo.length; i++) {
    TrinaColumnType theClmType = clminfo[i].title.toString() == accessind
        ? TrinaColumnType.select(['W', 'R', 'D'])
        : getColumnType(clminfo[i]);

    toReturn.add(TrinaColumn(
        enableRowChecked: i == 0 ? useCheckBox : false,
        title: langclmName.isEmpty
            ? clminfo[i].title.toString().replaceAll('Media', 'Card')
            : langclmName
                .singleWhere(
                  (element) =>
                      element.keyVal.toString() == clminfo[i].title.toString(),
                  orElse: () {
                    return Langkeypair(
                        keyVal: clminfo[i].data.toString(),
                        fieldNm: clminfo[i].data.toString());
                  },
                )
                .fieldNm
                .toString(),
        field: clminfo[i].data.toString(),
        width: clminfo[i].title.toString() == 'Description' ? 350 : 250,
        readOnly: clminfo[i].title.toString() == accessind ? false : true,
        textAlign: theClmType.isNumber
            ? TrinaColumnTextAlign.right
            : TrinaColumnTextAlign.left,
        hide: i > colCnt - 1 ? true : false,
        type: theClmType));
  }

  return toReturn;
}

List<TrinaColumn> getColumns(
    List<ColumnInfo> clminfo, int colCnt, List<Langkeypair> langclmName,
    {bool useCheckBox = false}) {
  List<TrinaColumn> toReturn = [];
  for (var i = 0; i < clminfo.length; i++) {
    TrinaColumnType theClmType = getColumnType(clminfo[i]);

    toReturn.add(TrinaColumn(
        enableRowChecked: i == 0 ? useCheckBox : false,
        title: langclmName.isEmpty
            ? clminfo[i].title.toString().replaceAll('Media', 'Card').replaceAll('AuthCardNo', 'Driver Card')
            : langclmName
                .singleWhere(
                  (element) =>
                      element.keyVal.toString() == clminfo[i].title.toString(),
                  orElse: () {
                    return Langkeypair(
                        keyVal: clminfo[i].data.toString(),
                        fieldNm: clminfo[i].data.toString());
                  },
                )
                .fieldNm
                .toString(),
        field: clminfo[i].data.toString(),
        width: clminfo[i].title.toString() == 'Description' ? 350 : 250,
        textAlign: theClmType.isNumber
            ? TrinaColumnTextAlign.right
            : TrinaColumnTextAlign.left,
        hide: i > colCnt - 1 ? true : false,
        type: theClmType));
  }

  return toReturn;
}

List<TrinaColumn> getColumnsActionItems(
    List<ColumnInfo> clminfo,
    int colCnt,
    List<Langkeypair> langclmName,
    String idField,
    Function? onPopUp,
    List<Map<String, dynamic>> popMenuItems,
    {bool useCheckBox = false,
    Icon? popUpIcon}) {
  List<TrinaColumn> toReturn = [];
  for (var i = 0; i < clminfo.length; i++) {
    TrinaColumnType theClmType = getColumnType(clminfo[i]);

    toReturn.add(TrinaColumn(
        enableRowChecked: i == 0 ? useCheckBox : false,
        title: langclmName.isEmpty
            ? clminfo[i].title.toString().replaceAll('Media', 'Card')
            : langclmName
                .singleWhere(
                  (element) =>
                      element.keyVal.toString() == clminfo[i].title.toString(),
                  orElse: () {
                    return Langkeypair(
                        keyVal: clminfo[i].data.toString(),
                        fieldNm: clminfo[i].data.toString());
                  },
                )
                .fieldNm
                .toString(),
        field: clminfo[i].data.toString(),
        textAlign: theClmType.isNumber
            ? TrinaColumnTextAlign.right
            : TrinaColumnTextAlign.left,
        hide: i > colCnt - 1 ? true : false,
        type: theClmType));
  }
  toReturn.add(TrinaColumn(
      width: 60,
      title: '',
      field: idField,
      type: TrinaColumnType.text(),
      enableFilterMenuItem: false,
      enableSorting: false,
      enableSetColumnsMenuItem: false,
      frozen: TrinaColumnFrozen.end,

      renderer: (rendererContext) {
        return PopupMenuButton(
          icon: popUpIcon,
          // onSelected: (val) async {
          //   switch (val) {
          //     case 'REQ':
          //       await showDialog(
          //         barrierDismissible: false,
          //         context: context,
          //         builder: (context) {
          //           return Dialog(
          //               child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: SizedBox(
          //               width: 400,
          //               height: 200,
          //               child: Card(
          //                 child: Column(children: [
          //                   const SelectableText(
          //                     'Media Replacement',
          //                     style: hdrStyle,
          //                   ),
          //                   const Expanded(
          //                     child: FbText(
          //                       label: 'Media Number',
          //                       name: 'mdn',
          //                     ),
          //                   ),
          //                   const Expanded(child: FbDateTimePicker(name: 'expiry', label: 'Expiry Date')),
          //                   IconButton(
          //                       onPressed: () {
          //                         singleton<AppRouter>().pop();
          //                       },
          //                       icon: const Icon(Icons.save))
          //                 ]),
          //               ),
          //             ),
          //           ));
          //         },
          //       );
          //       break;
          //     case 'PIN':
          //       await showDialog(
          //         barrierDismissible: false,
          //         context: context,
          //         builder: (context) {
          //           return Dialog(
          //               child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: SizedBox(
          //               width: 400,
          //               height: 200,
          //               child: Card(
          //                 child: Column(children: [
          //                   const SelectableText(
          //                     'Forgotten your PIN',
          //                     style: hdrStyle,
          //                   ),
          //                   const Expanded(
          //                     child: FbText(
          //                       label: 'Media Number',
          //                       name: 'mdn',
          //                     ),
          //                   ),
          //                   const SelectableText('PIN will be sent to registered Email'),
          //                   const Expanded(child: FbText(name: 'confirm', label: 'Confirm Email')),
          //                   IconButton(onPressed: () {}, icon: const Icon(Icons.save))
          //                 ]),
          //               ),
          //             ),
          //           ));
          //         },
          //       );
          //     default:
          //   }
          // },
          itemBuilder: (context) {
            return <PopupMenuEntry<String>>[
              ...popMenuItems.map((v) {
                return PopupMenuItem<String>(
                  onTap: () async {
                    onPopUp!({"value": v["value"], "row": rendererContext.row});
                  },
                  value: v["value"],
                  child: SelectableText(v["text"]),
                );
              })
              //   PopupMenuItem<String>(
              //     onTap: () async {
              //       onPopUp!(rendererContext.row);
              //     },
              //     value: 'REQ',
              //     child: const SelectableText('Media Replacement'),
              //   ),
              //   PopupMenuItem<String>(
              //     onTap: () async {
              //         onPopUp!(rendererContext.row);
              //     },
              //     value: 'PIN',
              //     child: const SelectableText('Forgot PIN'),
              //   ),
            ];
          },
        );
      }));
  return toReturn;
}

TrinaColumnType getColumnType(ColumnInfo clminfo) {
  switch (clminfo.dataType) {
    case 'nvarchar':
      return TrinaColumnType.text();
    case 'varchar':
      return TrinaColumnType.text();
    case 'date':
      return TrinaColumnType.date(format:'yyyy-MM-dd');
    case 'datetime':
      return TrinaColumnType.date(format: 'yyyy-MM-dd');
    case 'time':
      return TrinaColumnType.time();
    case 'bigint':
      return TrinaColumnType.text();
    case 'decimal':
      return TrinaColumnType.number(format: '##0.000');
    case 'int':
      return TrinaColumnType.number();
    case 'money':
      return TrinaColumnType.number(format: '##0.00');
    default:
      return TrinaColumnType.text();
  }
}

List<TrinaRow> getRowsCheckBox(List<dynamic> data, List<ColumnInfo> clminfo,
    int colCnt, String? checkIndicatorField, Set<TrinaRow> checkedItem) {
  final List<TrinaRow> rows = [];
  // final dateFormat = DateFormat.yMMMEd();
  // final timeFormat = DateFormat.Hms();
  for (var g = 0; g < data.length; g++) {
    Map<String, TrinaCell> cells = {};
    for (var i = 0; i < clminfo.length; i++) {
      // var theVal = data[g][clminfo[i].data] == null
      //     ? ''
      //     : (clminfo[i].dataType == 'date') || (clminfo[i].dataType == 'datetime') == true
      //         ? '${dateFormat.format(DateTime.parse(data[g][clminfo[i].data]))} ${timeFormat.format(DateTime.parse(data[g][clminfo[i].data]))}'
      //         : data[g][clminfo[i].data].toString();

      var theVal = data[g][clminfo[i].data] ?? '';
          // : (clminfo[i].dataType == 'date') == true
          //     ? dateFormat.format(DateTime.parse(data[g][clminfo[i].data]))
          //     : (clminfo[i].dataType == 'datetime') == true
          //         ? '${dateFormat.format(DateTime.parse(data[g][clminfo[i].data]))} ${timeFormat.format(DateTime.parse(data[g][clminfo[i].data]))}'
          //         : (clminfo[i].dataType == 'time') == true
          //             ? data[g][clminfo[i].data].toString().substring(0, 11)
          //             : data[g][clminfo[i].data].toString();

      if (checkIndicatorField != null &&
          clminfo[i].data.toString() == checkIndicatorField) {
        //   theVal = '';
      }
      cells[clminfo[i].data.toString()] = TrinaCell(value: theVal);
    }
    //something not right here
    // for (var i = 0; i < clminfo.length; i++) {
    //   var theVal = data[g][clminfo[i].title] == null
    //       ? ''
    //       : (clminfo[i].dataType == 'date') || (clminfo[i].dataType == 'datetime') == true
    //           ? '${dateFormat.format(DateTime.parse(data[g][clminfo[i].title]))} ${timeFormat.format(DateTime.parse(data[g][clminfo[i].title]))}'
    //           : data[g][clminfo[i].title].toString();
    //   cells[clminfo[i].title.toString()] = TrinaCell(value: theVal);
    // }

    if (checkIndicatorField != null) {
      final isChecked = data[g][checkIndicatorField] == 'Y' ? true : false;
      final rowToAdd = TrinaRow(cells: cells, checked: isChecked);
//Disabling the below as we are only concerned with check or uncheck. So we will add any rows with check or uncheck instead onf just check rows
// if(isChecked){
//   checkedItem.add(rowToAdd);
// }
      rows.add(rowToAdd);
    } else {
      rows.add(TrinaRow(cells: cells));
    }
  }
  return rows;
}

List<TrinaRow> getRows(List<dynamic> data, List<ColumnInfo> clminfo, int colCnt,
    String? checkIndicatorField) {
  final List<TrinaRow> rows = [];
  // final dateFormat = DateFormat.yMMMEd();
  // final timeFormat = DateFormat.Hms();
  for (var g = 0; g < data.length; g++) {
    Map<String, TrinaCell> cells = {};
    for (var i = 0; i < clminfo.length; i++) {
      var theVal = data[g][clminfo[i].data] ?? '';
          //
          //  (clminfo[i].dataType == 'date') == true
          //     ? dateFormat.format(DateTime.parse(data[g][clminfo[i].data]))
          //     : (clminfo[i].dataType == 'datetime') == true
          //         ? '${dateFormat.format(DateTime.parse(data[g][clminfo[i].data]))} ${timeFormat.format(DateTime.parse(data[g][clminfo[i].data]))}'
          //         : (clminfo[i].dataType == 'time') == true
          //             ? data[g][clminfo[i].data].toString().substring(0, 11)
                  //    : data[g][clminfo[i].data].toString();
 //  : data[g][clminfo[i].data].toString();
      cells[clminfo[i].data.toString()] = TrinaCell(value: theVal);
    }
    if (checkIndicatorField != null) {
      final isChecked = data[g][checkIndicatorField] == 'Y' ? true : false;
      rows.add(TrinaRow(cells: cells, checked: isChecked));
    } else {
      rows.add(TrinaRow(cells: cells));
    }
  }
  return rows;
}

List<TrinaRow> getRowsWithRef(
    List<dynamic> data, List<ColumnInfo> clminfo, int colCnt, WidgetRef ref) {
  final List<TrinaRow> rows = [];
  // final dateFormat = DateFormat.yMMMEd();
  // final timeFormat = DateFormat.jms();
  for (var g = 0; g < data.length; g++) {
    Map<String, TrinaCell> cells = {};
    for (var i = 0; i < clminfo.length; i++) {
      var theVal = data[g][clminfo[i].data] ?? '';
          // : (clminfo[i].dataType == 'date') ||
          //         (clminfo[i].dataType == 'datetime') == true
          //     ? '${dateFormat.format(DateTime.parse(data[g][clminfo[i].data]))} ${timeFormat.format(DateTime.parse(data[g][clminfo[i].data]))}'
           
      cells[clminfo[i].data.toString()] = TrinaCell(value: theVal);
    }

    rows.add(TrinaRow(cells: cells));
  }
  if (rows.isNotEmpty) {
    Future.delayed(Duration.zero).then((val) {
      ref.read(globalPlutoSelectedRow.notifier).state = rows[0];
    });
  }
  return rows;
}

List<TrinaColumn> getColumnsS3(
    List<ColumnInfo> clminfo, int colCnt, List<Langkeypair> langclmName,
    {bool useCheckBox = false}) {
  List<TrinaColumn> toReturn = [];
  toReturn.add(TrinaColumn(
      field: 'File', title: 'File Name', type: TrinaColumnType.text()));
  for (var i = 0; i < clminfo.length; i++) {
    TrinaColumnType theClmType = getColumnType(clminfo[i]);
    toReturn.add(TrinaColumn(
        enableRowChecked: i == 0 ? useCheckBox : false,
        title: langclmName
            .singleWhere(
              (element) =>
                  element.keyVal.toString() == clminfo[i].title.toString(),
              orElse: () {
                return Langkeypair(
                    keyVal: clminfo[i].title.toString(),
                    fieldNm: clminfo[i].title.toString());
              },
            )
            .fieldNm
            .toString(),
        field: clminfo[i].data.toString(),
        textAlign: theClmType.isNumber
            ? TrinaColumnTextAlign.right
            : TrinaColumnTextAlign.left,
        hide: clminfo[i].title.toString() == 'key'
            ? true
            : i > colCnt - 1
                ? true
                : false,
        type: theClmType));
  }

  return toReturn;
}

TrinaColumnType getColumnTypeS3(ColumnInfo clminfo) {
  if (clminfo.dataType == null) return TrinaColumnType.text();
  switch (clminfo.dataType) {
    case 'nvarchar':
      return TrinaColumnType.text();
    case 'varchar':
      return TrinaColumnType.text();
    case 'date':
      return TrinaColumnType.text();
    case 'datetime':
      return TrinaColumnType.text();
    case 'bigint':
      return TrinaColumnType.number();
    case 'decimal':
      return TrinaColumnType.number(format: '##0.000');
    case 'int':
      return TrinaColumnType.number();
    case 'money':
      return TrinaColumnType.number(format: '##0.000');
    default:
      return TrinaColumnType.text();
  }
}

List<TrinaRow> getRowsS3(
    List<dynamic> data, List<ColumnInfo> clminfo, int colCnt) {
  final List<TrinaRow> rows = [];
  // final dateFormat = DateFormat.yMMMEd();
  // final timeFormat = DateFormat.jms();
  for (var g = 0; g < data.length; g++) {
    Map<String, TrinaCell> cells = {};
    for (var i = 0; i < clminfo.length; i++) {
      // var theVal = data[g][clminfo[i].data] == null
      //     ? ''
      //     : clminfo[i].data == 'lastModified'
      //         ? '${dateFormat.format(DateTime.parse(data[g][clminfo[i].data]))} ${timeFormat.format(DateTime.parse(data[g][clminfo[i].data]))}'
      //         : data[g][clminfo[i].data].toString();
      // cells[clminfo[i].data.toString()] = TrinaCell(value: theVal);

      var theVal = data[g][clminfo[i].data] ?? '';
          // : clminfo[i].data == 'lastModified'
          //     ? '${dateFormat.format(DateTime.parse(data[g][clminfo[i].data]))} ${timeFormat.format(DateTime.parse(data[g][clminfo[i].data]))}'
          //     : data[g][clminfo[i].data].toString();
      //clminfo[i].data ==  'key' ? data[g][clminfo[i].data].toString().split('/').last :

      cells[clminfo[i].data.toString()] = TrinaCell(value: theVal);
      if (clminfo[i].data == 'key') {
        cells['File'] = TrinaCell(
            value: data[g][clminfo[i].data].toString().split('/').last);
      }
      //    var theVal = data[g][clminfo[i].data] == null
      //     ? ''
      //     : clminfo[i].data ==  'key' ? data[g][clminfo[i].data].toString().split('/').last : clminfo[i].data == 'lastModified'
      //         ? '${dateFormat.format(DateTime.parse(data[g][clminfo[i].data]))} ${timeFormat.format(DateTime.parse(data[g][clminfo[i].data]))}'
      //         : data[g][clminfo[i].data].toString();
      // cells[clminfo[i].data.toString()] = TrinaCell(value: theVal);
    }
    rows.add(TrinaRow(cells: cells));
  }
  return rows;
}

void exportToCsv(TrinaGridStateManager stateManager, String title) async {
  var resstr = await TrinaGridExportCsv().export(stateManager: stateManager);
  var exported = const Utf8Encoder()
      .convert(resstr);

  // use file_saver from pub.dev
  await FileSaver.instance
      .saveFile(name: "$title.csv", bytes: exported, ext: ".csv");
}
     PdfColor flutterToPdfColor(Color color) {
          return PdfColor.fromInt(
              // ignore: deprecated_member_use
              color.value); // compatibility with Flutter 3.27
        }
void exportToPdf(TrinaGridStateManager stateManager, String title) async {

  Color headerColor = Color.fromRGBO(255, 6, 4, 1);
  Color textColor = Colors.black;
  //  final format = PdfPageFormat.a4.landscape;
  //          final themeData = pw.ThemeData(
  //         tableHeader: pw.TextStyle(
  //           color: flutterToPdfColor(headerColor),
  //         ),
  //         defaultTextStyle: pw.TextStyle(
  //           color: flutterToPdfColor(textColor),
  //           fontSize: 10,
  //         ),
  //       );



  
var resstr = await TrinaGridExportPdf().export(stateManager: stateManager,
title:title,
pageTheme: pw.PageTheme(
                pageFormat: PdfPageFormat.a4.landscape,
                orientation: pw.PageOrientation.landscape,
                margin: pw.EdgeInsets.only(top: 20,left:2, right: 2,bottom: 10),
                 clip: false
          //     theme: themeData,
              ),
    pdfSettings: TrinaGridExportPdfSettings(
              title: title,
              cellAlignment: pw.Alignment.topLeft,
              pageTheme: pw.PageTheme(
                orientation: pw.PageOrientation.landscape,
          //     theme: themeData,
              ),
              cellStyle: pw.TextStyle(
                color: flutterToPdfColor(textColor),
                fontSize: 6,
              ),
              cellDecoration: (index, data, rowNum) {
                return pw.BoxDecoration(
                  border: pw.Border.all(
                    color: const PdfColor.fromInt(0x000000),
                    width: 0.5,
                  ),
                );
              },
              headerCellDecoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color:const PdfColor.fromInt(0x000000),
                  width: 0.5,
                ),
              ),
              headerStyle: pw.TextStyle(
                fontSize: 6,
                color: flutterToPdfColor(Colors.white),
              ),
              headerDecoration: pw.BoxDecoration(
                color: flutterToPdfColor(headerColor),
              ),
            ));


  await FileSaver.instance
      .saveFile(name: "$title.pdf", bytes: resstr, ext: ".pdf");
  // final themeData = pluto_grid_export.ThemeData.withFont(
  //   base: pluto_grid_export.Font.ttf(
  //     await rootBundle.load('assets/fonts/open_sans/OpenSans-Regular.ttf'),
  //   ),
  //   bold: pluto_grid_export.Font.ttf(
  //     await rootBundle.load('assets/fonts/open_sans/OpenSans-Bold.ttf'),
  //   ),
  // );

  // var plutoGridPdfExport = pluto_grid_export.TrinaGridDefaultPdfExport(
  //   title: title,
  //   creator: "BHP",
  //   format: pluto_grid_export.PdfPageFormat.a4.landscape,
  //   themeData: themeData,
  // );

  // await pluto_grid_export.Printing.sharePdf(
  //   bytes: await plutoGridPdfExport.export(stateManager),
  //   filename: plutoGridPdfExport.getFilename(),
  // );
}

Widget buildDataTableQueryObject(
    WidgetRef ref,
    TrinaGridConfiguration defaultPlutoConfig,
    QueryObject query,
    QueryObject? queryDel,
    String idField,
    List<Langkeypair> langClmName,
    {Function? onSelected,
    Function? onFocus,
    Function? onChecked,
    Function? onCheckAll,
    Function? onNew,
    Function? onRefresh,
    Function? onDelete,
    bool useCheckBox = false,
    String exportTitle = "Export Report"}) {
  late TrinaGridStateManager stateManager;
  return FutureBuilder<Returndata>(
    future: loadDataQueryObject(
      ref,
      query,
    ),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final srcReturnData = snapshot.data;
        final List<ColumnInfo>? clmInfo = srcReturnData!.columnInfo;
        final List<dynamic>? data = srcReturnData.data;
        final List<Output>? outputParam = srcReturnData.output;

        int? colCnt = 0;
        int? msgId = 0;
        int? returnValue = 0;
        if (srcReturnData.data != null) {}

        if (outputParam != null) {
          if (outputParam
              .where((element) => element.parameter == '@ColCnt')
              .isEmpty) {
            colCnt = clmInfo!.length;
          } else {
            final colCnt0 = outputParam.singleWhere((Output element) {
              return element.parameter == '@ColCnt';
            });
            colCnt = int.tryParse(colCnt0.value.toString());
          }

          final msgId0 = outputParam.singleWhere((Output element) {
            return element.parameter == '@MsgId';
          });
          msgId = int.tryParse(msgId0.value.toString());

          final thereturnValue = outputParam.singleWhere((Output element) {
            return element.parameter == '@Return_Value';
          });
          returnValue = int.tryParse(thereturnValue.value.toString());
        }

        if (returnValue != 0) {
          return ErrorWidget.withDetails(
              message: 'Error $msgId in Retriveing Data');
        }
        // TrinaGridStateManager? stateManager;

        if (clmInfo != null && data != null) {
          if (data[0][idField] == null) {
            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    onRefresh == null
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              onRefresh();
                            },
                            icon: const Icon(Icons.refresh)),
                    onNew == null
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              onNew();
                            },
                            icon: const Icon(Icons.add)),
                    onDelete == null
                        ? Container()
                        : IconButton(
                            onPressed: () async {
                              try {
                                if(stateManager.currentRow ==null){
                                  Toast.message('Please select row');
                                  return;
                                }

                                bool confirmed = await ConfirmDialog.show(
                                  title: "Delete?",
                                  body: "Are you sure you want to Delete?",
                                  destructive: true,
                                  confirmText: "Yes",
                                  cancelText: "Cancel",
                                );

                                if (!confirmed) {
                                  return;
                                }
                                onDelete(stateManager.currentRow);
                              } catch (e) {
                                //    showAlertDialog(context: context, title: 'Error Loading', content: e.toString());
                                Toast.message('Error Loading');
                              } finally {}
                            },
                            icon: const Icon(Icons.delete)),
                    sbw10
                  ],
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: 1280,
                    child: TrinaGrid(
                        noRowsWidget: const SelectableText('No Data'),
                        mode: TrinaGridMode.select,
                        configuration: defaultPlutoConfig,
                        columns: getColumns(
                          clmInfo,
                          colCnt!,
                          langClmName,
                        ),
                        rows: const []),
                  ),
                ),
              ],
            );
          }
          return ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                onRefresh == null
                    ? Container()
                    : IconButton(
                        onPressed: () {
                          loadDataQueryObject(
                            ref,
                            query,
                          ).then((val) {
                            stateManager.removeAllRows(notify: false);
                            stateManager.appendRows(
                              getRows(val.data!, clmInfo, colCnt!, null),
                            );
                          });

                          onRefresh();
                        },
                        icon: const Icon(Icons.refresh)),
                onNew == null
                    ? Container()
                    : IconButton(
                        onPressed: () {
                          onNew();
                        },
                        icon: const Icon(Icons.add)),
                onDelete == null
                    ? Container()
                    : IconButton(
                        onPressed: () async {
                               if(stateManager.currentRow ==null){
                                  Toast.message('Please select row');
                                  return;
                                }
                          bool confirmed = await ConfirmDialog.show(
                            title: "Delete?",
                            body: "Are you sure you want to Delete?",
                            destructive: true,
                            confirmText: "Yes",
                            cancelText: "Cancel",
                          );

                          if (!confirmed) {
                            return;
                          }
                          var toDelete = stateManager.currentRow!;
                          List<String> listDelete =
                              queryDel!.params.keys.toList();

                          var queryParam =
                              getMapTrinaCell(toDelete.cells, listDelete);
                          var queryDelete = QueryObject(
                              querysql: queryDel.querysql,
                              params: queryParam,
                              showMsg: false);

                          await loadDataQueryObject(ref, queryDelete)
                              .then((val) {
                            loadDataQueryObject(ref, query)
                                .then((valAfterDelete) {
                              stateManager.removeAllRows(notify: false);

                              stateManager.appendRows(
                                getRows(valAfterDelete.data!, clmInfo, colCnt!,
                                    null),
                              );
                            });
                          });
                        },
                        icon: const Icon(Icons.delete)),
                sbw10,
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    switch (value) {
                      case 'Filter On':
                        stateManager.setShowColumnFilter(true);
                        break;
                      case 'Filter Off':
                        stateManager.setShowColumnFilter(false);
                        break;
                      case 'PDF':
                        exportToPdf(stateManager, exportTitle);
                        break;
                      case 'CSV':
                        exportToCsv(stateManager, exportTitle);
                        break;
                      default:
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'PDF', 'CSV', 'Filter On', 'Filter Off'}
                        .map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: SelectableText(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            //   Expanded(
            //     flex:1,
            //     child: Row(children: [

            //          Expanded(child: ElevatedButton(onPressed: () async {

            //                   bool confirmed = await ConfirmDialog.show(
            //                 title: "Delete?",
            //                 body: "Are you sure you want to Delete?",
            //                 destructive: true,
            //                 confirmText: "Yes",
            //                 cancelText: "Cancel",
            //               );

            //               if (!confirmed) {
            //                 return;
            //               }
            //                 var toDelete = stateManager!.currentRow!;
            //                 List<String> listDelete = queryDel!.params.keys.toList();

            //                 var queryParam = getMapTrinaCell(toDelete.cells, listDelete);
            //   var queryDelete =  QueryObject(querysql: queryDel.querysql, params: queryParam, showMsg: false);

            //  await loadDataQueryObject(ref, queryDelete).then((val){

            //     loadDataQueryObject(ref, query).then((valAfterDelete){

            //         stateManager!.removeAllRows(notify: false);

            //         stateManager!.appendRows( getRows(valAfterDelete.data!, clmInfo, colCnt!),);

            //        });
            //   });

            //      },
            //     child: const SelectableText('Delete'),)),
            //       Expanded(child: ElevatedButton(onPressed: () {

            //         onNew!();
            //      },
            //     child: const SelectableText('Add'),)),
            //       Expanded(child: ElevatedButton(onPressed: () {

            //     loadDataQueryObject(ref, query,  ).then((val){
            //     stateManager!.removeAllRows(notify: false);
            //         stateManager!.appendRows( getRows(val.data!, clmInfo, colCnt!),);
            //        });

            //      },
            //     child: const SelectableText('Refresh'),))],),
            //   ),

            SingleChildScrollView(
              child: SizedBox(
                height: 1280,
                child: TrinaGrid(
                  noRowsWidget: const Center(
                    child: SelectableText('No Rows'),
                  ),
                  mode: TrinaGridMode.multiSelect,
                  configuration: defaultPlutoConfig,
                  columns: getColumns(clmInfo, colCnt!, langClmName,
                      useCheckBox: useCheckBox),
                  rows: getRows(data, clmInfo, colCnt, null),
                  onRowChecked: (TrinaGridOnRowCheckedEvent event) {
                    if (onCheckAll != null) {
                      onCheckAll(event);
                    }

                    if (onChecked != null) {
                      if (event.row != null) {
                        onChecked(event.row);
                      }
                    }
                  },
                  onSelected: (event) {
                      stateManager.clearCurrentCell();
                    if (onFocus != null) {
                      onFocus(event.row);
                    }
                  },
                  onRowDoubleTap: (event) {
                    if (onSelected != null) {
                      onSelected(event.row);
                    }
                  },
                  onLoaded: (TrinaGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                  },
                ),
              ),
            ),
          ]);
        }
      } else if (snapshot.hasError) {
        return SelectableText('${snapshot.error}');
      }

      // By default, show a loading spinner.
      return const Center(child: CircularProgressIndicator());
    },
  );
}

//I Want to create Table with checkbox
