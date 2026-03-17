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

const int wid=463;

@RoutePage()
class CustEnrollSubsidyList extends HookWidget {
  const CustEnrollSubsidyList({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  //  @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
  });

  final String? custEttyId;
  final String? cmpyEttyId=null;
  @override
  Widget build(BuildContext context) {
    return SubSidyQuotaList(custEttyId:  custEttyId.toString());
  }
}

class SubSidyQuotaList extends HookConsumerWidget {
  const SubSidyQuotaList({
    super.key,
    this.custEttyId,
  });
  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final query = QueryObject(
        querysql: '/sp/ApiEnrlCmpySubsList/queryasync',
        params: {"CustEttyId": custEttyId, "CmpyEttyId": null},
        showMsg: false);
    final listData = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
        value: listData,
        data: (dv) {
          return SingleChildScrollView(
            child: SizedBox(
              height: 1280,
              child: AcxTrinaGridExtData(
                spName: 'ApiEnrlCmpySubsList',
                extData: dv,
                idField: 'QuoId',
                useCheckBox: false,
                onNew: (){
                  singleton<AppRouter>().navigatePath(
                          '/custenroll/cust/$custEttyId/subsidy/quotadtl/new');
                },
                         onDelete: (ValueNotifier<TrinaRow> val) {
                
                  
              if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                            Toast.message("Action Not Authorised");
                            return;
                          }
                            final queryDel = QueryObject(
                querysql: '/sp/ApiEnrlCmpySubsDel/queryasync',
                params: {
                  "CustEttyId": custEttyId,
                  "CmpyEttyId": null,
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
                onSelectedTap: (TrinaRow val) {
                  singleton<AppRouter>().navigatePath(
                      '/custenroll/cust/$custEttyId/subsidy/quotadtl/${val.cells["QuoId"]!.value}');
                  //singleton<AppRouter>().navigatePath('/subsidy/detail/${val["SubId"].value}/prg');
                },
              ),
            ),
          );
        });
  }
}
