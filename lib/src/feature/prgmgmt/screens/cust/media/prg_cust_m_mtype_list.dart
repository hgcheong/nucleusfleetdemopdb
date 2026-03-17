import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap.dart';

const int wid=765;

@RoutePage()
class PrgCustMediaMTypeList extends ConsumerWidget {
  const PrgCustMediaMTypeList(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final toNav =
        '/prgmgmt/custsetup/$prgEttyId/pcmlanding/pcmmtypelist/pcmmtype';

    return AcxListButtonNavWrap(
        querysql: '/sp/ApiPrgCustMediaTypeList/queryasync',
        params: {'PrgEttyId': prgEttyId},
        addNew: () {
          singleton<AppRouter>().navigatePath('$toNav/new');
        },
        returnSelectedRef: (va) {
          singleton<AppRouter>().navigatePath('$toNav/${va['MediaTypeId']}');
        },
        displayfield: const ['PrgDscp', 'MediaTypeDscp'],
        keyField: 'MediaTypeId');
  }
}
