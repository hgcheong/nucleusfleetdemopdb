import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/src/core/components/acx_searchmain.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/report_helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class MerchantMiscTxn extends ConsumerWidget {
  const MerchantMiscTxn(
      {super.key,
      required this.rptViewerKey,
      required this.initialVal,
      this.filename,
      this.rptname});

  final GlobalKey<FormBuilderState> rptViewerKey;
  final Map<String, dynamic> initialVal;
  final String? filename;
  final String? rptname;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var my = ref.watch(rptSearchOptionProvider);

    return FormBuilder(
      initialValue: initialVal,
      key: rptViewerKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const FbHiddenText(name: 'EttyId'),
          my == 'MCHTNAME'
              ? AcxSearchMain(
                  searchAttr: 'Str',
                  label: 'Merchant',
                  params: const {},
                  keyField: 'MchtEttyId',
                  searchText: 'Dscp',
                  showSearchBox: true,
                  refCd: 'MCHTNAME',
                  querysql: '/sp/ApiMgmtMainSearch/queryasync',
                  inputText: 'Merchant Name',
                  returnSelectedRef: (val) {
                    rptViewerKey.currentState!
                        .patchValue({'EttyId': val['MchtEttyId'].toString()});
                  })
              : AcxSearchMain(
                  searchAttr: 'Str',
                  label: 'Location',
                  params: const {},
                  keyField: 'LocEttyId',
                  searchText: 'Dscp',
                  showSearchBox: true,
                  refCd: 'LOCNAME',
                  querysql: '/sp/ApiMgmtMainSearch/queryasync',
                  inputText: 'Location Name',
                  returnSelectedRef: (val) {
                    rptViewerKey.currentState!
                        .patchValue({'EttyId': val['LocEttyId'].toString()});
                  }),
          Row(
            children: [
              const Expanded(
                  child:
                      FbDateTimePicker(name: 'FromDate', label: 'From Date')),
              fbFieldGap, const Expanded(
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

final rptSearchOptionProvider = StateProvider<String>((ref) {
  return "MCHTNAME";
});
