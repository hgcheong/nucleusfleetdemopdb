import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/report_helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class FromDateToDateRpt extends ConsumerWidget {
  const FromDateToDateRpt(
      {super.key,
      required this.rptViewerKey,
      required this.initialVal,
      this.filename,
      this.rptname,
      this.miscParam = "&Param1=null&Param2=null&"});

  final GlobalKey<FormBuilderState> rptViewerKey;
  final Map<String, dynamic> initialVal;
  final String? filename;
  final String? rptname;
  final String? miscParam;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormBuilder(
      initialValue: initialVal,
      key: rptViewerKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              const Expanded(
                  child:
                      FbDateTimePicker(name: 'FromDate', label: 'From Date')),
              const Expanded(
                  child: FbDateTimePicker(name: 'ToDate', label: 'To Date')),

              IconButton(
                  onPressed: () async {
                    Toast.newMessageDialog(context, 'Loading Please Wait...');
                    rptViewerKey.currentState!.save();
                    DateTime fromDate = DateFormat.yMMMEd()
                        .parse(rptViewerKey.currentState!.value['FromDate']);
                    DateTime dateTo = DateFormat.yMMMEd()
                        .parse(rptViewerKey.currentState!.value['ToDate']);
                    var locEttyId =
                        rptViewerKey.currentState!.value['LocEttyId'];
                    showReport(rptname.toString(),
                        'Param1=null&Param2=null&EttyId=$locEttyId&FromDate=${DateFormat('MM/dd/yyyy').format(fromDate)}&ToDate=${DateFormat('MM/dd/yyyy').format(dateTo)}');
                  },
                  icon: const Icon(Icons.print)),
            ],
          ),
        ],
      ),
    );
  }
}
