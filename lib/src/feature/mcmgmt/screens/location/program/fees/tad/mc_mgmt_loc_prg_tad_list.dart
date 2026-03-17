import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap_manual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=862;

@RoutePage()
class MchtMgmtLocPrgTadList extends ConsumerWidget {
  const MchtMgmtLocPrgTadList({
    super.key,
    @PathParam.inherit('prgEttyId') this.prgEttyId,
    @PathParam.inherit('locEttyId') this.locEttyId,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
    @PathParam.inherit('billingEttyType') this.billingEttyType,
    @PathParam.inherit('accptId') this.accptId,
  });
  final String? locEttyId;
  final String? prgEttyId;
  final String? billingEttyType;
  final String? accptId;
  final String? mchtEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtLocTadFeeList/queryasync',
        params: {"PrgEttyId": prgEttyId, "LocEttyId": locEttyId},
        showMsg: false);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(54.0),
        child: Column(
          children: [
            AcxListButtonNavWrapManual(
                query: query,
                addNew: () {
                  singleton<AppRouter>().navigatePath(
                      "/mcmgmt/loc/$mchtEttyId/prgdtl/$locEttyId/$prgEttyId/$billingEttyType/$accptId/fees/tad/dtltad/new");
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
                      querysql: '/sp/ApiMgmtLocTadFeeDel/queryasync',
                      params: {
                        "PrgEttyId": prgEttyId,
                        "LocEttyId": locEttyId,
                        "FeeId": val["FeeId"],
                      },
                      showMsg: false);
                  final resultDel =
                      ref.read(ReturndatafreezedProvider(queryDel).future);
                  resultDel.then((value) {
                    ref.invalidate(ReturndatafreezedProvider(query));
                    Toast.showresult(value);
                  });
                },
                returnSelectedRef: (va) {
                  // singleton<AppRouter>().navigatePath("/mcmgmt/loc/$mchtEttyId/prgdtl/$locEttyId/$prgEttyId/$billingEttyType/$accptId/fees/tad/dtltad/$toNavdetail/${va['FeeId']}");
                  // singleton<AppRouter>().navigatePath('$toNavdetail/${va['FeeId']}');

                  singleton<AppRouter>()
                      .navigatePath("./dtltad/${va['FeeId']}");
                },
                displayfield: const [
                  'Dscp',
                  'BillingFreqDscp',
                  'MnMDscp',
                  'VendorDscp'
                ],
                keyField: 'FeeId'),
          ],
        ),
      ),
    );
  }
}
