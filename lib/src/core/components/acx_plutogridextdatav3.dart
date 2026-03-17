import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

typedef MyBuilder = void Function(BuildContext context, void Function(QueryObject val) methodA);


class AcxTrinaGridExtv3 extends StatefulWidget {
  const AcxTrinaGridExtv3({super.key,required this.extData,
   required this.checkIndicatorField, this.onSelected,
   required this.builder, this.onNew, this.onDelete, this.gridTitle = '',this.useCheckBox = false,
   this.onRefresh, this.appButtons, this.iconButtons});
  final Returndata extData;
  final String checkIndicatorField;
  final Function? onSelected;
  final Function? onNew;
  final Function? onDelete;
  final Function? onRefresh;
  final MyBuilder builder;
  final String gridTitle;
 final bool useCheckBox;
    final List<AppButtonWithFunction>? appButtons;
    final List<IconWithFunction>? iconButtons;
  @override
  State<AcxTrinaGridExtv3> createState() => _AcxTrinaGridExtv3State();
}

class _AcxTrinaGridExtv3State extends State<AcxTrinaGridExtv3> {
 final List<TrinaColumn> columns = [];
  final List<TrinaRow> rows = [];
  final  List<Langkeypair> langClmName = [];
  late TrinaGridStateManager stateManager;
  @override
  void initState() {
    super.initState();
  int? colCnt = 0;
 //  int? msgId = 0;
   int? returnValue = 0;
  if (widget.extData.data != null) {}
  if(widget.extData.output !=null){
         colCnt = getOutputValue(widget.extData.output, '@ColCnt');
       //  msgId = getOutputValue(widget.extData.output, '@MsgId');
        returnValue = getOutputValue(widget.extData.output, '@Return_Value');
        if(returnValue !=0){
          
        }
  }
  

   columns.addAll(getColumns(
            widget.extData.columnInfo!,
            colCnt!,
            langClmName,
            useCheckBox: widget.useCheckBox
          ));
    if(widget.extData.data!=null){
rows.addAll(getRows(widget.extData.data!, widget.extData.columnInfo!, colCnt, null));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Do not add columns or rows here.

       widget.builder.call(context, methodA);     
            List<IconButton> toAddIconButton = List.empty(growable: true);
          if (widget.iconButtons != null) {
            if (widget.iconButtons!.isNotEmpty) {
              for (var element in widget.iconButtons!.toList()) {
                toAddIconButton.add(IconButton(
                  onPressed: (){
                    if(widget.useCheckBox){
element.func(stateManager.checkedRows);
                    }else{
                      
element.func(stateManager.currentRow);
                    }
                    
                  },
                  icon: element.icon
                ));
              }
            }
          } 
       List<AppButton> toAddAppButton = List.empty(growable: true);
          if (widget.appButtons != null) {
            if (widget.appButtons!.isNotEmpty) {    
              for (var element in widget.appButtons!.toList()) {
                toAddAppButton.add(AppButton(
                  onPressed: (){
                    if(widget.useCheckBox){
element.func(stateManager.checkedRows);
                    }else{
element.func(stateManager.currentRow);
                    }
                    
                  },
                  icon: element.btn.icon,
                  label: element.btn.label,    
                ));
              }
            }
          } 
     return Column(children: [
    Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [    SelectableText(widget.gridTitle),
          widget.onRefresh == null
                      ? Container()
                      : IconButton(
                          onPressed: () {      
                             //      stateManager.removeAllRows(notify: true);
                             // stateManager.appendRows(getRows(data, clmInfo, colCnt!, null));             
                            widget.onRefresh!();
                       
                          },
                          icon: const Icon(Icons.refresh)),
                  widget.onNew == null
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            widget.onNew!();
                          },
                          icon: const Icon(Icons.add)),
                  widget.onDelete == null
                      ? Container()
                      : IconButton(
                          onPressed: () async {
                            try {
                               if(widget.useCheckBox){
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

                                  if(widget.useCheckBox){
widget.onDelete!(stateManager.checkedRows);
                    }else{
widget.onDelete!(stateManager.currentRow);
                    }

                            } catch (e) {
                              Toast.message('Error Loading $e');
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
                      exportToPdf(stateManager, widget.gridTitle);
                  break;
                case 'Export CSV':
                  exportToCsv(stateManager, widget.gridTitle);
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
       key: UniqueKey(), 
        mode: TrinaGridMode.select,   
        noRowsWidget:
            const SizedBox(height: 100, child: SelectableText('No Data')),
        configuration: getGridConfig(context),
        columns: columns,
        rows: rows,
        
        onRowDoubleTap: (event) {
          if (widget.onSelected != null) {
            //changed to by row instead of cells like extcheckbox
            widget.onSelected!(event.row);
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
  }
   void methodA(QueryObject qo) async {
       var rtn = await AcxReturnDataService().retrieve(
                            qo.querysql,
                            qo.params
                            );
        int? colCnt = 0;
        stateManager.removeAllRows(notify: false);
         if(widget.extData.output !=null){
        colCnt = getOutputValue(widget.extData.output, '@ColCnt');
         }
        if(rtn.data!=null){
       stateManager.appendRows(getRows(rtn.data!, rtn.columnInfo!,colCnt! , null));   
        }

  }
}
