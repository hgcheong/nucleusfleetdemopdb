import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';

import 'package:trina_grid/trina_grid.dart';

const int wid=134;
@RoutePage()
class PrgMgmtMchtFeesTransList extends ConsumerWidget {
  const PrgMgmtMchtFeesTransList(
      {super.key, @PathParam('prgEttyId') this.prgEttyId});
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final thePaht = singleton<AppRouter>().currentPath;
    final isList = thePaht.endsWith('pmfeetranslist');

    // if (isAllowTabAccess(defaultTabAccess, wid)) {
      
    // }
      return SizedBox(
          height: 2000,
          child: Column(
            children: [
              isList == true
                  ? AcxTrinaGridWithColumn(
                      querysql: '/sp/ApiPrgMchtTxnFeeList/queryasync',
                      params: {"PrgEttyId": prgEttyId},
                      idField: 'FeeId',
                      navPrefix:
                          '/prgmgmt/mchtsetup/$prgEttyId/feesl/pmfeetransl/pmfeetrans',
                      spName: 'ApiPrgMchtTxnFeeList',
                      onNew: () {
                          if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                        singleton<AppRouter>().navigatePath(
                            '/prgmgmt/mchtsetup/$prgEttyId/feesl/pmfeetransl/pmfeetrans/new');
                      },
                      onSelectedTap: (TrinaRow val) {
                        // ref.read(prgNameProvider.notifier).state = val['PrgName'].value.toString();
                      },
                    )
                  : Container(),
              isList == true ? Container() : Container()
            ],
          ));
    } 
  }

