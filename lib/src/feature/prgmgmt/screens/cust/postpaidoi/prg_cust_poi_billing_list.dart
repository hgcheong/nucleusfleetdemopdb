import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap.dart';

const int wid=777;

@RoutePage()
class PrgCustPOIBillingList extends ConsumerWidget {
  const PrgCustPOIBillingList(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final thePaht = singleton<AppRouter>().currentPath;
    final toNav =
        '/prgmgmt/custsetup/$prgEttyId/postpaidoilanding/pppoibilllist/pppoibill/';
    final isList = thePaht.endsWith('list');
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                  child: Column(
                      //      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    Visibility(
                        visible: !isList,
                        child: const Flexible(flex: 1, child: AutoRouter())),
                    Flexible(
                      flex: 3,
                      child: AcxListButtonNavWrap(
                          querysql:
                              '/sp/ApiPrgCustPostpaidOICycleList/queryasync',
                          params: {'PrgEttyId': prgEttyId},
                          addNew: () {
                            singleton<AppRouter>().navigatePath('$toNav/new');
                          },
                          returnSelectedRef: (va) {
                            singleton<AppRouter>()
                                .navigatePath('$toNav${va['BillingId']}');
                          },
                          // deleteSelectedRef: (val) {
                          //   Toast.message('Deleting $val');
                          // },
                          displayfield: const ['Dscp'],
                          keyField: 'BillingId'),
                    )
                  ]))));
    });
  }
}
