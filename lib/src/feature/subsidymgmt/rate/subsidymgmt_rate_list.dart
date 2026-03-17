import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';

import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap.dart';

const int wid=237;

@RoutePage()
class SubsidymgmtRateList extends StatelessWidget {
  const SubsidymgmtRateList(
      {super.key, @PathParam.inherit('subsId') this.subsId});

  final String? subsId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SelectableText('Define the Subsidy Rate of the Plan'),
        AcxListButtonNavWrap(
            keyField: 'SubsLocateId',
            querysql: '/sp/ApiPrgSubsLocateList/queryasync',
            params: {"SubsId": subsId},
            displayfield: const ['SubsSchemeDscp', 'Dscp'],
            addNew: () {
              singleton<AppRouter>().navigatePath('/subsidy/rate/$subsId/new');
            },
            returnSelectedRef: (val) {
              {
                // singleton<AppRouter>().navigatePath('/custenroll/cmpy/$custEttyId/detail/profile/$cmpyEttyId/address/adddtl/${val["AddrType"]}/${val["ContactId"]}');
              }
            }),
      ],
    );
    // return AutoTabsRouter.tabBar(routes: const [PrgMgmtSetupGenInfoRoute()], builder: (context, child, tabController) {
    //   return Column(children: [
    //     Expna
    //   ],)
    // },);
  }
}
