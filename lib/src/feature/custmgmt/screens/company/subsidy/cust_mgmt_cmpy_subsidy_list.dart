import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdata.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=572;

@RoutePage()
class CustMgmtCmpySubsidyList extends HookWidget {
  const CustMgmtCmpySubsidyList({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context) {
    return SubSidyQuotaList(custEttyId: custEttyId, cmpyEttyId: cmpyEttyId);
  }
}

// Widget mainInfo(BuildContext context, String custEttyId, cmpyEttyId) {
//   final tabCM = useTabController(initialLength: 1);
//   return Column(
//     children: [
//       Expanded(
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: TabBar(
//             isScrollable: true,
//             controller: tabCM,
//             labelColor: tabBarColor,
//             dividerColor: Colors.transparent,
//             tabs: [
//               Tab(text: S.of(context).tabSubsidyQuota),
//             ],
//           ),
//         ),
//       ),
//       Expanded(
//         flex: 10,
//         child: SizedBox(
//           height: 1280,
//           child: TabBarView(controller: tabCM, children: [
//             SubSidyQuotaList(
//               custEttyId: custEttyId,
//               cmpyEttyId: cmpyEttyId,
//             )
//           ]),
//         ),
//       ),
//     ],
//   );
// }

class SubSidyQuotaList extends HookConsumerWidget {
  const SubSidyQuotaList({
    super.key,
    this.custEttyId,
    this.cmpyEttyId,
  });
  final String? custEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkedItem = useState<Set<TrinaRow>>(<TrinaRow>{});
    final query = QueryObject(
        querysql: '/sp/ApiMgmtCmpySubsList/queryasync',
        params: {"CustEttyId": custEttyId, "CmpyEttyId": cmpyEttyId},
        showMsg: false);
    final listData = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
        value: listData,
        data: (dv) {
          return SingleChildScrollView(
            child: SizedBox(
              height: 1280,
              child: AcxTrinaGridExtData(
                spName: 'ApiMgmtCmpySubsList',
                extData: dv,
                idField: 'QuotaId',
                useCheckBox: false,
                onNew: () {
                    if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                  singleton<AppRouter>().navigatePath(
                      '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/subsidy/quotadtl/new');
                },
                onDelete: (ValueNotifier<TrinaRow> val) {
                    if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                  final queryDel = QueryObject(
                      querysql: '/sp/ApiMgmtCmpySubsDel/queryasync',
                      params: {
                        "CustEttyId": custEttyId,
                        "CmpyEttyId": cmpyEttyId,
                        "QuotaId": val.value.cells["QuotaId"]!.value.toString()
                      },
                      showMsg: false);
                  final resultDel =
                      ref.read(ReturndatafreezedProvider(queryDel).future);
                  resultDel.then((value) {
                    ref.invalidate(ReturndatafreezedProvider(query));
                    Toast.showresult(value);
                  });
                },
                onRefresh: () {
                  ref.invalidate(ReturndatafreezedProvider(query));
                },
                onSelectedTap: (TrinaRow val) {
                  singleton<AppRouter>().navigatePath(
                      '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/subsidy/quotadtl/${val.cells["QuotaId"]!.value}');
                  //singleton<AppRouter>().navigatePath('/subsidy/detail/${val["SubId"].value}/prg');
                },
                onCheckedAll: (TrinaGridOnRowCheckedEvent v) {
                  if (v.isAll) {
                    if (v.isChecked!) {
                      if (dv.data != null) {
                        final theD = dv;
                        checkedItem.value.addAll(getRows(theD.data!,
                            theD.columnInfo!, theD.columnInfo!.length, null));
                      }
                    } else {
                      checkedItem.value.clear();
                    }
                  }
                },
                onChecked: (TrinaRow? rw) {
                  if (rw!.checked!) {
                    checkedItem.value.add(rw);
                  } else {
                    checkedItem.value.remove(rw);
                  }
                },
              ),
            ),
          );
        });
  }
}
