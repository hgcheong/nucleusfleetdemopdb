import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap_manual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=155;
@RoutePage()
class PrgCustCtrlTransLimitList extends ConsumerWidget {
  const PrgCustCtrlTransLimitList({
    super.key,
    @PathParam.inherit('prgEttyId') this.prgEttyId,
  });

  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final toNav = '/prgmgmt/custsetup/$prgEttyId/pctrllanding';
    final querySql = QueryObject(
        querysql: '/sp/ApiPrgCustTxnLimitList/queryasync',
        params: {'PrgEttyId': prgEttyId},
        showMsg: false);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(54.0),
        child: Column(
          children: [
            AcxListButtonNavWrapManual(
                query: querySql,
                addNew: () {
                  singleton<AppRouter>()
                      .navigatePath('$toNav/pcctrltranslimit/new');
                },
                returnSelectedRef: (val) {
                  singleton<AppRouter>().navigatePath(
                      '$toNav/pcctrltranslimit/${val['LimitId']}');
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
                        "PrgEttyId": prgEttyId,
                        "LimitId": val["LimitId"],
                      },
                      showMsg: false);
                  final resultDel =
                      ref.read(ReturndatafreezedProvider(queryDel).future);
                  resultDel.then((value) {
                    ref.invalidate(ReturndatafreezedProvider(querySql));
                    Toast.showresult(value);
                  });
                },
                displayfield: const ['TxnCtgryDscp', 'LimitTypeDscp'],
                keyField: 'LimitId'),
          ],
        ),
      ),
    );
  }
}
