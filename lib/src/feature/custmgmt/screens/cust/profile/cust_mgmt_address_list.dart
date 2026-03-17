import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/shared/acx_address_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=597;

@RoutePage()
class CustMgmtAddressList extends ConsumerWidget {
  const CustMgmtAddressList({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  });

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtAddrList/queryasync',
        params: {"EttyId": custEttyId},
        showMsg: false);
    return AcxAddressList(
        query: query,
        deleteSelectedRef: (val) {
          final queryDel = QueryObject(
              querysql: '/sp/ApiMgmtAddrDel/queryasync',
              params: {
                "EttyId": custEttyId,
                "AddrType": val['AddrType'],
                "ContactId":val['ContactId']
              },
              showMsg: false);
          final resultDel =
              ref.read(ReturndatafreezedProvider(queryDel).future);
          resultDel.then((value) {
            ref.invalidate(ReturndatafreezedProvider(query));
            Toast.showresult(value);
          });
        },
        returnSelectedRef: (val) {
          singleton<AppRouter>().navigatePath(
              '/custmgmt/cust/$custEttyId/profile/address/adddtl/${val["AddrType"]}/${val["ContactId"]}/${val["AddrId"]}');
        });
  }
}
