import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/shared/acx_directorship_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=484;

@RoutePage()
class MchtEnrlLocationProfileDirectorList extends ConsumerWidget {
  const MchtEnrlLocationProfileDirectorList({
    super.key,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId,
  });

  final String? mchtEttyId;
    final String? locEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiEnrlCmpyDirectorshipList/queryasync',
        params: {"EttyId": locEttyId},
        showMsg: false);
    return AcxDirectorShipList(
        query: query,
        deleteSelectedRef: (val) {
          final queryDel = QueryObject(
              querysql: '/sp/ApiEnrlAddrDel/queryasync',
              params: {
                "EttyId": mchtEttyId,
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
                         '/mcenroll/loc/$mchtEttyId/detail/$locEttyId/profile/director/directordtl/${val["IndvdId"]}');
    
        });
  }
}
