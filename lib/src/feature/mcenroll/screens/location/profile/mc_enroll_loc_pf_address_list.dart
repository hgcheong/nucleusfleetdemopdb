import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/shared/acx_address_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=655;

@RoutePage()
class MchtEnrlLocationProfileAddressList extends ConsumerWidget {
  const MchtEnrlLocationProfileAddressList(
      {super.key,
      @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? locEttyId;
  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiEnrlAddrList/queryasync',
        params: {"EttyId": locEttyId},
        showMsg: false);
    return AcxAddressList(
        query: query,
        deleteSelectedRef: (val) {
          final queryDel = QueryObject(
              querysql: '/sp/ApiEnrlAddrDel/queryasync',
              params: {
                "EttyId": locEttyId,
                "AddrType": val['AddrType'],
                "ContactId": val['ContactId']
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
              '/mcenroll/loc/$mchtEttyId/detail/$locEttyId/profile/address/adddtl/${val["AddrType"]}/${val["ContactId"]}/${val["AddrId"]}');
        });
  }
}
