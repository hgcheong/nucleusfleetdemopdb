import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/shared/acx_contact_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=487;

@RoutePage()
class CustEnrollContactList extends ConsumerWidget {
  const CustEnrollContactList({
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
        querysql: '/sp/ApiEnrlContactList/queryasync',
        params: {"EttyId": custEttyId},
        showMsg: false);
    return AcxContactList(
        query: query,
        deleteSelectedRef: (val) {
          final queryDel = QueryObject(
              querysql: '/sp/ApiEnrlContactDel/queryasync',
              params: {
                "EttyId": custEttyId,
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
                '/custenroll/cust/$custEttyId/profile/contact/contactdtl/${val["ContactType"]}/${val["ContactId"]}');
          }
        });
  }
}
