import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap_manual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=460;

@RoutePage()
class CustEnrollCmpySecurityDepList extends ConsumerWidget {
  const CustEnrollCmpySecurityDepList({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final querySql = QueryObject(
        querysql: '/sp/ApiEnrlCrDepList/queryasync',
        params: {"CustEttyId": custEttyId, "CmpyEttyId": cmpyEttyId},
        showMsg: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: AcxListButtonNavWrapManual(
              query: querySql,
              keyField: 'DepId',
              displayfield: const [
                'CollateralTypeDscp',
                'SecurityRefNo',
                'SecuritySum',
                'ExpDate'
              ],
              addNew: () {
                singleton<AppRouter>().navigatePath(
                    '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/secdep/secdepdtl/new');
              },
              deleteSelectedRef: (val) async {
                bool confirmed = await ConfirmDialog.show(
                  title: "Delete?",
                  body: "Are you sure you want to Delete?",
                  destructive: true,
                  confirmText: "Yes",
                  cancelText: "Cancel",
                );

                if (!confirmed) {
                  return;
                }

                final queryDel = QueryObject(
                    querysql: '/sp/ApiPrgCustTxnLimitDel/queryasync',
                    params: {
                      "CustEttyId": custEttyId,
                      "CmpyEttyId": cmpyEttyId,
                      "DepId": val["DepId"],
                    },
                    showMsg: false);
                final resultDel =
                    ref.read(ReturndatafreezedProvider(queryDel).future);
                resultDel.then((value) {
                  ref.invalidate(ReturndatafreezedProvider(querySql));
                  Toast.showresult(value);
                });
              },
              returnSelectedRef: (val) {
                {
                  val = val == null ? 'new' : val["DepId"];

                  //http://localhost:64944/custenroll/cmpy/4/detail/5/secdep
                  singleton<AppRouter>().navigatePath(
                      '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/secdep/secdepdtl/$val');
                }
              }),
        ),
      ],
    );
  }
}
