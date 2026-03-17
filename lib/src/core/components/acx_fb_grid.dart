import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

class AcxFbGrid extends ConsumerWidget {
  final String querysql;
  final Map<String, dynamic> params;
  final bool showMsg;
  final String idField;
  final String gridTitle;
final Function? onSelected;
  const AcxFbGrid( {super.key, 
    required this.querysql,
    required this.params,
    required this.idField,
    this.showMsg = false,
    this.gridTitle = 'Data Grid',
    this.onSelected
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureData = AcxReturnDataService().retrieve(
     querysql,
    params,
      showMsg: showMsg,
    );
    return FutureBuilder<Returndata>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
        //    Future.delayed(Duration(milliseconds: 100), () {
        //     ref.read(isLoadingProvider.notifier).state = false;
        //  });
        
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData)  {
        //  Future.delayed(Duration(milliseconds: 100), () {
        //     ref.read(isLoadingProvider.notifier).state = false;
        //  });
        

          return SizedBox(
            height: 1280,
            child: AcxTrinaGridExtDatawExport(
              gridTitle: gridTitle,
              extData: snapshot.data!,
              idField: idField,
              onSelected: onSelected
            ),
          );
        } else {
        //   Future.delayed(Duration(milliseconds: 100), () {
        //     ref.read(isLoadingProvider.notifier).state = false;
        //  });
        
          return const Center(child: Text('No Data'));
        }
      },
    ); 
  }
}

final isLoadingProvider = StateProvider<bool>((ref) => false);