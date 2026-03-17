import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/cust_mgmt_billing_provider.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/statement/statement_controller.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/transaction/transaction_controller.dart';

import 'package:trina_grid/trina_grid.dart';

const int wid=305;

@RoutePage()
class CustMgmtBillingList extends ConsumerWidget {
  const CustMgmtBillingList(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return SingleChildScrollView(
      child: SizedBox(
        height: 1280,
        child: Column(
          children: [
            AcxTrinaGridWithColumn(
              querysql: '/sp/ApiMgmtCustBillingAcctList/queryasync',
              spName: 'ApiMgmtCustBillingAcctList',
              params: {"CustEttyId": custEttyId},
              idField: 'AcctId',
              navPrefix: '',
              onFocus: (TrinaRow val) {
                ref.read(apiMgmtCustBillingAcctList.notifier).state = val;
              },
              useNav: false,
              onSelectedTap: (TrinaRow val) {
                final toPost = val.toJson();

                ref.read(pukalCustMgmtAccDetailProvider.notifier).state = {
                  "CustEttyId": toPost['CustEttyId'],
                  "PrgEttyId": toPost['PrgEttyId'],
                  "EttyId": toPost['EttyId'],
                  "AcctId": toPost['AcctId'],
                  "AcctNo": toPost['AcctNo']
                };
                ref.read(billingAcctMgmtModelIdProvider.notifier).state = {
                  "PrgEttyId": toPost['PrgEttyId'],
                  "BillingType": toPost["BillingType"]
                };
                ref.read(billingCustMgmtAccDetailProvider.notifier).state = {
                  "CustEttyId": toPost['CustEttyId'],
                  "PrgEttyId": toPost['PrgEttyId'],
                  "EttyId": toPost['EttyId'],
                  "AcctId": toPost['AcctId'],
                  "AcctType": toPost['AcctType'].toString(),
                };

                ref.read(txnCustMgmtAccDetailProvider.notifier).state = {
                  "CustEttyId": toPost['CustEttyId'],
                  "PrgEttyId": toPost['PrgEttyId'],
                  "EttyId": toPost['EttyId'],
                  "AcctId": toPost['AcctId'],
                  // "FromDate":"20240724",
                  // "ToDate":"20240730"
                };
                ref.read(txnSearchContorllerProvider.notifier).state = {
                  "CustEttyId": toPost['CustEttyId'],
                  "EttyId": toPost['EttyId'],
                  "PrgEttyId": toPost['PrgEttyId'],
                  "AcctId": toPost['AcctId'],
                };
                //txnSearchPostedContorllerProvider
                     ref.read(txnSearchPostedContorllerProvider.notifier).state = {
                  "CustEttyId": toPost['CustEttyId'],
                  "EttyId": toPost['EttyId'],
                  "PrgEttyId": toPost['PrgEttyId'],
                  "AcctId": toPost['AcctId'],
                };

                //txnSearchContorllerUnbilledProvider
               ref.read(txnSearchContorllerUnbilledProvider.notifier).state = {
                  "CustEttyId": toPost['CustEttyId'],
                  "EttyId": toPost['EttyId'],
                  "PrgEttyId": toPost['PrgEttyId'],
                  "AcctId": toPost['AcctId'],
                };

                ref.read(txnSearchOltpContorllerProvider.notifier).state = {
                  "CustEttyId": toPost['CustEttyId'],
                  "EttyId": toPost['EttyId'],
                  "AcctId": toPost['AcctId'],
                  "TxnInd": "0"
                };
                //txnSearchContorllerProvider
                ref.read(statementSearchContorllerProvider.notifier).state = {
                  "AcctId": toPost['AcctId'],
                  "PrgEttyId": toPost['PrgEttyId'],
                  "CustEttyId": toPost['CustEttyId']
                };

                switch (toPost['AcctType']) {
                  case 'POSTPAID':
                    singleton<AppRouter>().navigatePath(
                        '/custmgmt/billingAccount/$custEttyId/detail/${val.cells['AcctId']!.value.toString()}/accsetting/${val.cells['AcctType']!.value.toString()}/postpaid');
                    break;
                  case 'PREPAID':
                    singleton<AppRouter>().navigatePath(
                        '/custmgmt/billingAccount/$custEttyId/detail/${val.cells['AcctId']!.value.toString()}/accsetting/${val.cells['AcctType']!.value.toString()}/prepaid');
                    break;
                  default:
                    Toast.message('Invalid Account Type');
                }
                // final theTitle = getTitle(ref, {
                //   "CustEttyId": custEttyId,
                // },  AppBarTitleType.management);
                // theTitle.then((value) {
                //   singleton<AppRouter>().navigatePath('./dtl/${val.cells['AcctType']!.value}/${val.cells['PrgEttyId']!.value}/${val.cells['EttyId']!.value}/${val.cells['AcctId']!.value}');
                //   ref.read(appBarTitleProvider.notifier).state = value.toString();
                // });
              },
            ),
          ],
        ),
      ),
    );
  }
}
