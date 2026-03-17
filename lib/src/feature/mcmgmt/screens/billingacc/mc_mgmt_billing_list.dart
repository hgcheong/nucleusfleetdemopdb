import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/feature/mcmgmt/screens/billingacc/transaction/transaction_controller.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=375;

@RoutePage()
class MchtMgmtBillingList extends ConsumerWidget {
  const MchtMgmtBillingList(
      {super.key, @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return SingleChildScrollView(
      child: AcxTrinaGridWithColumn(
        querysql: '/sp/ApiMgmtMchtBillingAcctList/queryasync',
        spName: 'ApiMgmtMchtBillingAcctList',
        params: {"MchtEttyId": mchtEttyId},
        idField: 'AcctId',
        navPrefix: '',
        useNav: false,
        onSelectedTap: (TrinaRow val) {
          final toPost = val.toJson();
          final theTitle = getTitle(
              ref,
              {
                "MchtEttyId": mchtEttyId,
              },
              AppBarTitleType.management);
          theTitle.then((value) {
            singleton<AppRouter>().navigatePath(
                './dtl/${val.cells['PrgEttyId']!.value}/${val.cells['EttyId']!.value}/${val.cells['AcctId']!.value}');
            ref.read(appBarTitleProvider.notifier).state = value.toString();
            //txnSearchMchtContorllerProvider
            ref.read(txnSearchMchtContorllerProvider.notifier).state = {
              "EttyId": toPost['EttyId'],
              "AcctId": toPost['AcctId'],
              "MchtEttyId": mchtEttyId
            };
            ref.read(txnSearchMchtOltpContorllerProvider.notifier).state = {
              "EttyId": toPost['EttyId'],
              "AcctId": toPost['AcctId'],
              "TxnInd": "0"
            };
          });
        },
      ),
    );
  }
}
