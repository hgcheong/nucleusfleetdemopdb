import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/app/env.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_searchmain.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/feature/reportviewer/reports/fromdatetodateprt.dart';
import 'package:nucleusv2/src/feature/reportviewer/reports/merchantmisctxn.dart';
import 'package:nucleusv2/src/utils/auth_helpers.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/report_helpers.dart';
import 'package:nucleusv2/src/utils/toast.dart';

class ReportViewerOnScrnReports extends ConsumerWidget {
  const ReportViewerOnScrnReports(
      {super.key, this.url, this.filename, this.rptname});

  // static const List<PageRouteInfo> routes = [PrgmgmtmainTabRouter()];
  final String? url;
  final String? filename;
  final String? rptname;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rptViewerKey = GlobalKey<FormBuilderState>();
    var initialVal = {'LocEttyId': null};
    switch (rptname) {
case 'GLReconciliation':
  return FormBuilder(
          initialValue: initialVal,
          key: rptViewerKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    singleton<AppRouter>().maybePop();
                  },
                  child: const Icon(Icons.close)),
              Row(
                children: [
                  const Expanded(
                      child: FbDateTimePicker(
                          name: 'FromDate', label: 'From Date')),
                 fbFieldGap,
                  const Expanded(
                      child:
                          FbDateTimePicker(name: 'ToDate', label: 'To Date')),
                             IconButton(
                      onPressed: () {
                        Toast.newMessageDialog(
                            context, 'Loading Please Wait...');
                        rptViewerKey.currentState!.save();
                        DateTime fromDate = DateFormat.yMMMEd().parse(
                            rptViewerKey.currentState!.value['FromDate']);
                        DateTime dateTo = DateFormat.yMMMEd()
                            .parse(rptViewerKey.currentState!.value['ToDate']);
                        var toSend = EncryptHelpers.authEnc().encrypt(
                            'report=$rptname&FromDate=${DateFormat('dd MMM yyyy').format(fromDate)}&ToDate=${DateFormat('dd MMM yyyy').format(dateTo)}');
                        var rptData = toSend.base64;
                        var urlEncoded =
                            Uri.encodeComponent(rptData.toString());
                        final urlToPost = '${Env.ssrsBaseUrl}rpt=$urlEncoded';
                        launchInBrowser(Uri.parse(urlToPost));
                      },
                      icon: const Icon(Icons.print)),
                ],
              ),
            ],
          ),
        );

      case 'AdhocTxnQuery':
      
      ///api/sp/RpCustTxnList/excelasync
      ///
       return FormBuilder(
          initialValue: initialVal,
          key: rptViewerKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    singleton<AppRouter>().maybePop();
                  },
                  child: const Icon(Icons.close)),
              Row(
                children: [
                                    // Expanded(child: FbDateTimePickerRange(name: 'A', label: 'Range')),
                  const Expanded(
                      child: FbDateTimePicker(
                          name: 'FromDate', label: 'From Date')),
                 fbFieldGap,
                  const Expanded(
                      child:
                          FbDateTimePicker(name: 'ToDate', label: 'To Date')),
                  IconButton(
                      onPressed: () async {
                        Toast.newMessageDialog(
                            context, 'Loading Please Wait...');
                        rptViewerKey.currentState!.save();
                        DateTime fromDate = DateFormat.yMMMEd().parse(
                            rptViewerKey.currentState!.value['FromDate']);
                        DateTime dateTo = DateFormat.yMMMEd()
                            .parse(rptViewerKey.currentState!.value['ToDate']);
   await ApiService().excelDownload(
            '/sp/RpCustTxnList/excelasync',
            "${DateTime.now().toUtc().millisecondsSinceEpoch}.xlsx",
            params: {'FromDate':  DateFormat('yyyy-MM-dd').format(fromDate), 'ToDate': DateFormat('yyyy-MM-dd').format(dateTo)},
          ).then((v){
                       Toast.message('Done');
          });
                    },
                      icon: const Icon(Icons.download)),
                ],
              ),
            ],
          ),
        );

      case 'MerchantNew':
        return FormBuilder(
          key: rptViewerKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    singleton<AppRouter>().maybePop();
                  },
                  child: const Icon(Icons.close)),
              FbLibView(
                name: 'PrgEttyId',
                label: 'Program',
                params: const {},
                keyField: 'PrgEttyId',
                searchText: 'Program',
                querySql: '/sp/ApiPrgList/queryasync',
                returnSelectedRef: (val) {
                  rptViewerKey.currentState!
                      .patchValue({'PrgEttyId': val['PrgEttyId'].toString()});
                },
              ),
              AcxSearchMain(
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
                  }),
              Row(
                children: [
                  const Expanded(
                      child: FbDateTimePicker(
                          name: 'FromDate', label: 'Process Date')),
                  fbFieldGap, const Expanded(
                      child:
                          FbDateTimePicker(name: 'ToDate', label: 'To Date')),
                  IconButton(
                      onPressed: () {
                        rptViewerKey.currentState!.save();
                        Toast.message(
                            rptViewerKey.currentState!.value.toString());
                        var ettyId = rptViewerKey.currentState!.value['EttyId'];
                        DateTime curD = DateFormat.yMMMEd().parse(
                            rptViewerKey.currentState!.value['FromDate']);
                        showReport(rptname.toString(),
                            'EttyId=$ettyId&FromDate=${DateFormat('dd MMM yyyy').format(curD)}');
                      },
                      icon: const Icon(Icons.print)),
                ],
              ),
            ],
          ),
        );
      case 'CustomerPayment':
        return FromDateToDateRpt(
          rptViewerKey: rptViewerKey,
          initialVal: initialVal,
          rptname: rptname,
          filename: filename,
        ).build(context, ref);
      case 'CustomerSOA':
        return FormBuilder(
          initialValue: initialVal,
          key: rptViewerKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const FbHiddenText(name: 'LocEttyId'),
              ElevatedButton(
                  onPressed: () {
                    singleton<AppRouter>().maybePop();
                  },
                  child: const Icon(Icons.close)),
              AcxSearchMain(
                  // name: 'MchtEttyId',
                  searchAttr: 'Str',
                  label: 'Company Name',
                  params: const {},
                  keyField: 'CmpyEttyId',
                  searchText: 'Dscp',
                  showSearchBox: true,
                  refCd: 'CMPYNAME',
                  querysql: '/sp/ApiMgmtMainSearch/queryasync',
                  inputText: 'Company Name',
                  returnSelectedRef: (val) {
                    rptViewerKey.currentState!
                        .patchValue({'EttyId': val['CmpyEttyId'].toString()});
                  }),
              Row(
                children: [
                  const Expanded(
                      child: FbDateTimePicker(
                          name: 'FromDate', label: 'From Date')),
                  fbFieldGap, const Expanded(
                      child:
                          FbDateTimePicker(name: 'ToDate', label: 'To Date')),
                  IconButton(
                      onPressed: () async {
                        Toast.newMessageDialog(
                            context, 'Loading Please Wait...');
                        rptViewerKey.currentState!.save();
                        DateTime fromDate = DateFormat.yMMMEd().parse(
                            rptViewerKey.currentState!.value['FromDate']);
                        DateTime dateTo = DateFormat.yMMMEd()
                            .parse(rptViewerKey.currentState!.value['ToDate']);
                        var cmpyEttyId =
                            rptViewerKey.currentState!.value['CmpyEttyId'];
                        showReport(rptname.toString(),
                            'EttyId=$cmpyEttyId&FromDate=${DateFormat('dd MMM yyyy').format(fromDate)}&ToDate=${DateFormat('dd MMM yyyy').format(dateTo)}');
                      },
                      icon: const Icon(Icons.print)),
                ],
              ),
            ],
          ),
        );
   
      case 'MerchantSalesAnalysis':
        return FormBuilder(
          initialValue: initialVal,
          key: rptViewerKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const FbHiddenText(name: 'LocEttyId'),
              ElevatedButton(
                  onPressed: () {
                    singleton<AppRouter>().maybePop();
                  },
                  child: const Icon(Icons.close)),
              AcxSearchMain(
                  // name: 'MchtEttyId',
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
                        .patchValue({'LocEttyId': val['LocEttyId'].toString()});
                  }),
              Row(
                children: [
                  const Expanded(
                      child: FbDateTimePicker(
                          name: 'FromDate', label: 'From Date')),
                  fbFieldGap, const Expanded(
                      child:
                          FbDateTimePicker(name: 'ToDate', label: 'To Date')),
                  IconButton(
                      onPressed: () async {
                        Toast.newMessageDialog(
                            context, 'Loading Please Wait...');
                        rptViewerKey.currentState!.save();
                        DateTime fromDate = DateFormat.yMMMEd().parse(
                            rptViewerKey.currentState!.value['FromDate']);
                        DateTime dateTo = DateFormat.yMMMEd()
                            .parse(rptViewerKey.currentState!.value['ToDate']);
                        var locEttyId =
                            rptViewerKey.currentState!.value['LocEttyId'];
                        showReport(rptname.toString(),
                            'EttyId=$locEttyId&FromDate=${DateFormat('MM/dd/yyyy').format(fromDate)}&ToDate=${DateFormat('MM/dd/yyyy').format(dateTo)}');
                      },
                      icon: const Icon(Icons.print)),
                ],
              ),
            ],
          ),
        );

      case 'MerchantStatement':
      case 'MerchantSOA':
        return FormBuilder(
          initialValue: initialVal,
          key: rptViewerKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const FbHiddenText(name: 'LocEttyId'),
              ElevatedButton(
                  onPressed: () {
                    singleton<AppRouter>().maybePop();
                  },
                  child: const Icon(Icons.close)),
              AcxSearchMain(
                  // name: 'MchtEttyId',
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
                        .patchValue({'LocEttyId': val['LocEttyId'].toString()});
                  }),
              Row(
                children: [
                  const Expanded(
                      child: FbDateTimePicker(
                          name: 'FromDate', label: 'From Date')),
                  fbFieldGap, const Expanded(
                      child:
                          FbDateTimePicker(name: 'ToDate', label: 'To Date')),
                  IconButton(
                      onPressed: () async {
                        Toast.newMessageDialog(
                            context, 'Loading Please Wait...');
                        rptViewerKey.currentState!.save();
                        DateTime fromDate = DateFormat.yMMMEd().parse(
                            rptViewerKey.currentState!.value['FromDate']);
                        DateTime dateTo = DateFormat.yMMMEd()
                            .parse(rptViewerKey.currentState!.value['ToDate']);
                        var locEttyId =
                            rptViewerKey.currentState!.value['LocEttyId'];
                        var toSend = EncryptHelpers.authEnc().encrypt(
                            'report=$rptname&EttyId=$locEttyId&FromDate=${DateFormat('dd MMM yyyy').format(fromDate)}&ToDate=${DateFormat('dd MMM yyyy').format(dateTo)}');
                        var rptData = toSend.base64;
                        var urlEncoded =
                            Uri.encodeComponent(rptData.toString());
                        final urlToPost = '${Env.ssrsBaseUrl}rpt=$urlEncoded';
                        launchInBrowser(Uri.parse(urlToPost));
                      },
                      icon: const Icon(Icons.print)),
                ],
              ),
            ],
          ),
        );
      case 'MerchantSales':
      case 'MerchantReimbursement':
      case 'MerchantMiscTxn':
        return Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  singleton<AppRouter>().maybePop();
                },
                child: const Icon(Icons.close)),
            FbField(child: FormBuilderRadioGroup(
              name: 'switch',
              initialValue: 'MCHTNAME',
              onChanged: (val) {
                ref.read(rptSearchOptionProvider.notifier).state =
                    val.toString();
              },
              options: const [
                FormBuilderFieldOption(
                  value: 'MCHTNAME',
                  child: Text('Merchant'),
                ),
                FormBuilderFieldOption(
                  value: 'Location',
                  child: Text('Location'),
                )
              ],
            )),
            MerchantMiscTxn(
              rptViewerKey: rptViewerKey,
              initialVal: initialVal,
              rptname: rptname,
              filename: filename,
            ).build(context, ref),
          ],
        );

      case 'MerchantNIRD':
        return FormBuilder(
          initialValue: initialVal,
          key: rptViewerKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const FbHiddenText(name: 'LocEttyId'),
              ElevatedButton(
                  onPressed: () {
                    singleton<AppRouter>().maybePop();
                  },
                  child: const Icon(Icons.close)),
              FbLibView(
                  name: 'nird',
                  label: 'NIRD',
                  params: const {},
                  keyField: 'RefCd',
                  searchText: 'Dscp',
                  returnSelectedRef: (val) {
                    rptViewerKey.currentState!
                        .patchValue({'nird': val['RefCd'].toString()});
                  },
                  querySql: '/view/async/VwNird'),
              Row(
                children: [
                  const Expanded(
                      child: FbDateTimePicker(
                          name: 'FromDate', label: 'From Date')),
                  IconButton(
                      onPressed: () async {
                        Toast.newMessageDialog(
                            context, 'Loading Please Wait...');
                        rptViewerKey.currentState!.save();
                        DateTime fromDate = DateFormat.yMMMEd().parse(
                            rptViewerKey.currentState!.value['FromDate']);

                        var nird = rptViewerKey.currentState!.value['nird'];
                        showReport(rptname.toString(),
                            'Param1=$nird&FromDate=${DateFormat('MM/dd/yyyy').format(fromDate)}');
                      },
                      icon: const Icon(Icons.print)),
                ],
              ),
            ],
          ),
        );
      default:
        return Center(
            child: Column(
          children: [
            const Text('Unauthorised to View'),
            ElevatedButton(
                onPressed: () {
                  singleton<AppRouter>().maybePop();
                },
                child: const Icon(Icons.close))
          ],
        ));
    }
  }
}

Widget reportButton(
    {required BuildContext context,
    required GlobalKey<FormBuilderState> rptViewerKey,
    required String filename,
    String exportType = "PDF",
    required String reportnameAndParam}) {
  return IconButton(
      onPressed: () async {
        Toast.newMessageDialog(context, 'Loading Please Wait...');
        rptViewerKey.currentState!.save();
        await ApiService().ssrsDownload(
            "/sp/download/ssrs", "$filename.${exportType.toLowerCase()}",
            params: {
              "url": '${Env.ssrsBaseUrl}/$reportnameAndParam}&rs:Format=$exportType',
              "filename": filename
            }).then((val) {
          Toast.message('Done');
        }).onError((e, v) {
          Toast.message(e.toString());
        });
      },
      icon:
          Icon(exportType == "PDF" ? Icons.picture_as_pdf : Icons.table_view));
}
