import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
const int wid=697;

@RoutePage()
class McMgmtBillingAccountInfo extends ConsumerWidget {
  const McMgmtBillingAccountInfo(
      {super.key,
      @PathParam.inherit('ettyId') this.ettyId,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('acctId') this.acctId,
      @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? ettyId;
  final String? mchtEttyId;
  final String? prgEttyId;
  final String? acctId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return MchtMgmtBilingAccountInfo(
        ettyId: convStrNewOrNullToNull(ettyId),
        mchtEttyId: mchtEttyId,
        prgEttyId: convStrNewOrNullToNull(prgEttyId),
        acctId: convStrNewOrNullToNull(acctId));
  }
}

class MchtMgmtBilingAccountInfo extends ConsumerWidget {
  const MchtMgmtBilingAccountInfo(
      {super.key, this.ettyId, this.mchtEttyId, this.prgEttyId, this.acctId});

  final String? ettyId;
  final String? mchtEttyId;
  final String? prgEttyId;
  final String? acctId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mcmgmtBillingAccountInfoKey = GlobalKey<FormBuilderState>();
    var querySql = QueryObject(
        querysql: '/sp/ApiMgmtMchtAcct/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "MchtEttyId": mchtEttyId,
          "EttyId": ettyId
        },
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "PrgDscp": null,
      "BillingTo": null,
      "BillingName": null,
      "BillingLevelDscp": null,
      "BillingTypeDscp": null,
      "AcctTypeDscp": null,
      "AcctBal": null,
      "AcctStsDscp": null,
      "AcctSts": null,
      "PrgEttyId": prgEttyId,
      "MchtEttyId": mchtEttyId,
      "EttyId": ettyId,
      "AcctId": acctId,
      "AcctNo": null,
      "AcctType": null,
      "BillingEttyType": null
    };

    final formData = ref.watch(ReturndatafreezedProvider(querySql));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: mcmgmtBillingAccountInfoKey,
            initialValue: formNewValue,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SelectableText(
                          'Account Info',
                          //      style: hdrStyle,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: ListView(
                          children: [
                            // const Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: SelectableText(
                            //     'Location Info',
                            //     style: hdrStyle,
                            //   ),
                            // ),
                            const ListTile(
                              title:
                                  FbText(name: 'AcctNo', label: 'Account No'),
                            ),
                            const ListTile(
                              title: FbText(
                                  name: 'BillingName', label: 'Account Holder'),
                            ),
                            const ListTile(
                              title: FbText(
                                  name: 'BillingTo', label: 'Billing To'),
                            ),

                            const ListTile(
                              title: FbText(
                                  name: 'BillingLevelDscp',
                                  label: 'Billing Level'),
                            ),
                            const ListTile(
                              title: FbText(
                                  name: 'BillingTypeDscp',
                                  label: 'Billing Level Description'),
                            ),
                            const ListTile(
                              title: FbText(
                                  name: 'AcctType', label: 'Type of Account'),
                            ),
                            const ListTile(
                              title: FbText(name: 'PrgDscp', label: 'Program'),
                            ),
                            const ListTile(
                              title: FbText(
                                  name: 'AcctBal', label: 'Account Balance'),
                            ),
                            // ListTile(
                            //   title: const Row(
                            //     children: [
                            //       Expanded(
                            //         child: FbText(
                            //           name: 'AcctStsDscp',
                            //           label: 'Status',
                            //           readOnly: true,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            //   trailing: IconButton(
                            //       onPressed: () async {
                            //         await showAcxDialog(
                            //             context,
                            //             AcxStatusDialog(
                            //               stsType: StatusType.acctSts,
                            //               ettyId: ettyId,
                            //               acctNo:
                            //                   formNewValue['AcctNo'].toString(),
                            //             ));

                            //         ref.invalidate(
                            //             ReturndatafreezedProvider(querySql));
                            //       },
                            //       icon: const Icon(Icons.arrow_right)),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
         
              ],
            ));
      },
    );
  }
}
