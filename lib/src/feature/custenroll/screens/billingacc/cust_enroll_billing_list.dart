import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/feature/custenroll/screens/billingacc/cust_enroll_billing_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=274;

@RoutePage()
class CustEnrollBillingList extends ConsumerWidget {
  const CustEnrollBillingList(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});
  
  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }

    return ListView(children: [
      AcxTrinaGridWithColumn(
        querysql: '/sp/ApiEnrlCustBillingAcctList/queryasync',
        spName: 'ApiEnrlCustBillingAcctList',
        params: {"CustEttyId": custEttyId},
        idField: 'AcctId',
        navPrefix: '',
        onSelectedTap: (TrinaRow val) {
          final toPost = val.toJson();
          ref.read(billingAccDetailProvider.notifier).state = {
            "CustEttyId": toPost['CustEttyId'],
            "PrgEttyId": toPost['PrgEttyId'],
            "EttyId": toPost['EttyId'],
            "AcctId": toPost['AcctId'],
            "AcctType": toPost['AcctType'].toString(),
          };
          ref.read(billingAcctModelIdProvider.notifier).state = {
            "PrgEttyId": toPost['PrgEttyId'],
            "BillingType": toPost["BillingType"]
          };
          ref.read(pukalCustEnrollAccDetailProvider.notifier).state= 
       {
                  "CustEttyId": toPost['CustEttyId'],
                  "PrgEttyId": toPost['PrgEttyId'],
                  "EttyId": toPost['EttyId'],
                  "AcctId": toPost['AcctId'],
                  "AcctNo": toPost['AcctNo']
                };
          switch (toPost['AcctType']) {
            case 'POSTPAID':
              singleton<AppRouter>().navigatePath(
                  '/custenroll/billingAccount/$custEttyId/detail/${val.cells['AcctId']!.value.toString()}/accsetting/${val.cells['AcctType']!.value.toString()}/postpaid');
              break;
            case 'PREPAID':
              singleton<AppRouter>().navigatePath(
                  '/custenroll/billingAccount/$custEttyId/detail/${val.cells['AcctId']!.value.toString()}/accsetting/${val.cells['AcctType']!.value.toString()}/prepaid');
              break;
            default:
              Toast.message('Invalid Account Type');
          }
        },
        useNav: false,
      ),
    ]);
  }
}
