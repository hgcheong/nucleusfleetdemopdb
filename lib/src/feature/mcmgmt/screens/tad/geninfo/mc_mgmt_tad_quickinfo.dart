import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=753;

@RoutePage()
class MchtMgmtTadQuickInfo extends StatelessWidget {
  const MchtMgmtTadQuickInfo(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('tadId') this.tadId,
      @PathParam.inherit('tadEttyId') this.tadEttyId});

  final String? mchtEttyId;
  final String? tadId;
  final String? tadEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return MchtMgmtTadForm(
        mchtEttyId: mchtEttyId,
        tadEttyId: convStrNewOrNullToNull(tadEttyId),
        tadId: convStrNewOrNullToNull(tadId));
  }
}

class MchtMgmtTadForm extends ConsumerWidget {
  const MchtMgmtTadForm({
    super.key,
    this.mchtEttyId,
    this.tadId,
    this.tadEttyId,
  });

  final String? mchtEttyId;
  final String? tadId;
  final String? tadEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtMchtTadOverview/queryasync',
        params: {
          "MchtEttyId": mchtEttyId,
          //   "LocEttyId": locEttyId,
          //  "TadId":tadId,
          "TadEttyId": tadEttyId,
        },
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "LocNo": null,
      "LocName": null,
      "TadNo": null,
      "InstallDate": null,
      "Installer": null,
      "CrtionDate": null,
      "CrtBy": null,
      "FirstTxnDate": null,
      "LastTxnDate": null,
      "LastSttlmtDate": null,
      "CurrBatchNo": null,
      "CurrStan": null,
      "MchtEttyId": mchtEttyId,
      "LocEttyId": null,
      "TadId": tadId,
      "TadEttyId": tadEttyId
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return formData.when(
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Card(
                  child: ListView(
                    children: [
                      ListTile(
                          leading: const SelectableText('Tad No'),
                          title: SelectableText(formNewValue['TadNo'] ?? '')),
                      ListTile(
                          leading: const SelectableText('InstallDate'),
                          title: SelectableText(
                              formNewValue['InstallDate'] ?? '')),
                      ListTile(
                          leading: const SelectableText('Installer'),
                          title:
                              SelectableText(formNewValue['Installer'] ?? '')),
                      ListTile(
                          leading: const SelectableText('CrtionDate'),
                          title: SelectableText(
                              formNewValue['CrtionDate'].toString())),
                      ListTile(
                          leading: const SelectableText('CrtBy'),
                          title: SelectableText(formNewValue['CrtBy'] ?? '')),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Card(
                  child: ListView(
                    children: [
                      ListTile(
                          leading: const SelectableText('FirstTxnDate'),
                          title: SelectableText(
                              formNewValue['FirstTxnDate'] ?? '')),
                      ListTile(
                          leading: const SelectableText('LastTxnDate'),
                          title: SelectableText(
                              formNewValue['LastTxnDate'] ?? '')),
                      ListTile(
                          leading: const SelectableText('LastSttlmtDate'),
                          title: SelectableText(
                              formNewValue['LastSttlmtDate'] ?? '')),
                      ListTile(
                          leading: const SelectableText('CurrBatchNo'),
                          title: SelectableText(
                              formNewValue['CurrBatchNo'] ?? '')),
                      ListTile(
                          leading: const SelectableText('CurrStan'),
                          title:
                              SelectableText(formNewValue['CurrStan'] ?? '')),
                    ],
                  ),
                ),
              ),
              // const Spacer(
              //   flex: 5,

              // ),
              // const Flexible(
              //   flex: 1,
              //   child: Column(children: [
              //     AcxBackToList(listUrl: './././list')
              //   ]),
              // ),
            ],
          );
        },
        error: (x, e) => Center(child: Text(e.toString()),),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

final ettyIdDynamicChildProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "EttyId": null,
  };
});

class DynamicChild extends ConsumerWidget {
  const DynamicChild({
    super.key,
    required this.keyEttyId,
    required this.ettyProvider,
    required this.label,
    required this.name,
    required this.searchText,
    this.emptyMessage = "Please Create Record",
  });

  final String keyEttyId;
  final String emptyMessage;
  final String label;
  final String searchText;
  final StateProvider<Map<String, dynamic>> ettyProvider;
  final String name;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final val = ref.watch(ettyProvider);
    if (val["EttyId"] == null) {
      return FbHiddenText(name: name);
      // return Row(
      //   children: [
      //     Flexible(child: SelectableText(emptyMessage)),
      //     Flexible(
      //         child: FbHiddenText(
      //       name: name,
      //     )),
      //   ],
      // );
    }
    final queryObject = QueryObject(
        querysql: '/sp/ApiEnrlEttyList/queryasync',
        params: val,
        showMsg: false);
    final dataSrc = ref.watch(ReturndatafreezedProvider(queryObject));
    return AsyncValueWidget(
        value: dataSrc,
        data: (re) {
          if (re.data == null) {
            return SelectableText(emptyMessage);
          }
          if (re.data![0][keyEttyId] == null) {
            return Row(
              children: [
                SelectableText(emptyMessage),
                FbHiddenText(
                  name: name,
                ),
              ],
              // children: [
              //   Expanded(child: SelectableText(emptyMessage)),
              //   Expanded(
              //       child: FbHiddenText(
              //     name: name,
              //   )),
              // ],
            );
          } else {
            return FbLibViewExt(
              name: name,
              datasrc: re,
              initialValue: null,
              label: label,
              keyField: keyEttyId,
              searchText: searchText,
              returnSelectedRef: (Map<String, dynamic> val) {
                //  Toast.message(val.toString());
              },
            );
          }
        });
  }
}

final mchtEnrlBusnUnitProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {"BusnUnitEttyId": null, "LocEttyId": null};
});
