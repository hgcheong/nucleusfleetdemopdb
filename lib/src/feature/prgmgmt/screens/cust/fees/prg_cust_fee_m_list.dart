import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap.dart';

const int wid=758;

@RoutePage()
class PrgCustFeeMediaList extends ConsumerWidget {
  const PrgCustFeeMediaList(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final toNav =
        '/prgmgmt/custsetup/$prgEttyId/pcfeelanding/pcfeemlist/pcfeem';
    return AcxListButtonNavWrap(
        querysql: '/sp/ApiPrgCustMediaFeeList/queryasync',
        params: {'PrgEttyId': prgEttyId},
        addNew: () {
          singleton<AppRouter>().navigatePath('$toNav/new');
        },
        returnSelectedRef: (va) {
          singleton<AppRouter>().navigatePath('$toNav/${va['MediaType']}');
        },
        displayfield: const ['MediaTypeDscp'],
        keyField: 'MediaType');
  }
}
