import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/shared/acx_address_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=557;

@RoutePage()
class CustMgmtCmpyAddressList extends ConsumerWidget {
  const CustMgmtCmpyAddressList(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('cmpyEttyId') this.cmpyEttyId});

  final String? custEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtAddrList/queryasync',
        params: {"EttyId": cmpyEttyId},
        showMsg: false);
    return AcxAddressList(
        query: query,
        deleteSelectedRef: (val) {
          final queryDel = QueryObject(
              querysql: '/sp/ApiMgmtAddrDel/queryasync',
              params: {
                "EttyId": cmpyEttyId,
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
              '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/profile/address/adddtl/${val["AddrType"]}/${val["ContactId"]}/${val["AddrId"]}');
        });
  }
}

///custmgmt/cmpy/16/detail/84/profile/address
