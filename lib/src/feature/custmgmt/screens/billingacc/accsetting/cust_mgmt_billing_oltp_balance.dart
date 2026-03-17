import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/accsetting/cust_mgmt_billing_acc_cre_bal_dialog.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/accsetting/cust_mgmt_billing_acc_cre_temp_bal_dialog.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class CustMgmtBillingOLTPBalance extends ConsumerWidget {
  const CustMgmtBillingOLTPBalance(
      {super.key,
      this.custEttyId,
      this.ettyId,
      this.acctId,
      this.prgEttyId,
      this.overdueAmt,
      this.openCredit});

  final String? custEttyId;
  final String? ettyId;
  final String? acctId;
  final String? prgEttyId;
  final String? overdueAmt;
  final String? openCredit;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> formValue = {
      "CrLimit": 0.0000,
      "MaxCrBal": 0.0000,
      "TmpCrLimit": 0.0000,
      "AcctBal": 0.0000,
      "AvbleBal": 0.0000
    };
    final qryObj = QueryObject(
        querysql: '/sp/RpeDrivewayAcctBal/queryasyncoltp',
        params: {"CustEttyId": custEttyId, "EttyId": ettyId, "AcctId": acctId},
        showMsg: false);
    final qryResult = ref.watch(ReturndatafreezedProvider(qryObj));
    return AsyncValueWidget(
      data: (theData) {
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Credit Exposure', style: TextStyle(fontSize: defaultDropDownSize),),
            Row(
              children: [
                const Expanded(
                    child: FbText(
                  name: 'CrLimit',
                  label: 'Credit Limit',
                   readOnly: true,
                )),
                IconButton(
                    onPressed: () async {
                      await showAcxDialog(
                          context,
                          CustMgmgtBillingAccCreBalDialog(
                            custEttyId: custEttyId,
                            acctId: acctId,
                            prgEttyId: prgEttyId,
                            ettyId: ettyId,
                          ));

                      ref.invalidate(ReturndatafreezedProvider(qryObj));
                    },
                    icon: const Icon(Icons.play_arrow))
              ],
            ),
            Row(
              children: [
                 Expanded(
                    child:
                        FbText(name: 'TmpCrLimit', label: 'Temp Credit Limit', initialValue: formValue["TmpCrLimit"].toString(),readOnly: true,)),
                IconButton(
                    onPressed: () async {
                      await showAcxDialog(
                          context,
                          CustMgmgtBillingAccTempCreBalDialog(
                            custEttyId: custEttyId,
                            acctId: acctId,
                            prgEttyId: prgEttyId,
                            ettyId: ettyId,
                          ));
                    },
                    icon: const Icon(Icons.play_arrow))
              ],
            ),
            FbText(
              label: 'Max Credit Balance',
              name: 'MaxCrBal',
              readOnly: true,
              initialValue: formValue["MaxCrBal"].toString(),
            ),
            FbText(
              label: 'Account Balance',
              name: 'AcctBal',
               readOnly: true,
              initialValue: formValue["AcctBal"].toString(),
            ),
            FbText(
              label: 'Available Balance',
              name: 'AvbleBal',
               readOnly: true,
              initialValue: formValue["AvbleBal"].toString(),
            ),
          ],
        );
      },
      value: qryResult,
    );
  }
}
