import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/shared/acx_contact_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=560;

@RoutePage()
class CustMgmtCostContactList extends ConsumerWidget {
  const CustMgmtCostContactList(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('costCtrEttyId') this.costCtrEttyId});

  final String? custEttyId;
  final String? costCtrEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtContactList/queryasync',
        params: {"EttyId": costCtrEttyId},
        showMsg: false);
    return AcxContactList(
        query: query,
        deleteSelectedRef: (val) {
          final queryDel = QueryObject(
              querysql: '/sp/ApiMgmtContactDel/queryasync',
              params: {
                "EttyId": costCtrEttyId,
                "ContactId": val['ContactId'],
                "ContactType": val['ContactType']
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
          {
            singleton<AppRouter>().navigatePath(
                '/custmgmt/costcen/$custEttyId/profile/$costCtrEttyId/contact/contactdtl/${val["ContactType"]}/${val["ContactId"]}');
          }
        });
  }
}
