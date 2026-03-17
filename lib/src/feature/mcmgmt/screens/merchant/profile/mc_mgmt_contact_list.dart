import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/shared/acx_contact_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=741;

@RoutePage()
class MchtMgmtContactList extends ConsumerWidget {
  const MchtMgmtContactList({
    super.key,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
  });

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtContactList/queryasync',
        params: {"EttyId": mchtEttyId},
        showMsg: false);
    return AcxContactList(
        query: query,
        deleteSelectedRef: (val) {
          final queryDel = QueryObject(
              querysql: '/sp/ApiMgmtContactDel/queryasync',
              params: {
                "EttyId": mchtEttyId,
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
            singleton<AppRouter>().navigate(MchtMgmtContact(
                contactId: val["ContactId"].toString(),
                contactType: val["ContactType"].toString()));
            // singleton<AppRouter>().navigatePath('./contactdtl/${val["ContactType"]}/${val["ContactId"]}');
          }
        });
  }
}
