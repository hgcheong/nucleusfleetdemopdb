import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=514;

@RoutePage()
class CustEnrollMemberCtrlProdList extends ConsumerWidget {
  const CustEnrollMemberCtrlProdList({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('mbrEttyId') this.mbrEttyId,
  });

  final String? custEttyId;
  final String? mbrEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiEnrlMbrPrdAccptPrgList/queryasync',
        params: {"CustEttyId": custEttyId, "MbrEttyId": mbrEttyId},
        showMsg: false));
    final listData = ref.watch(listQuery);

    return AsyncValueWidget<Returndata>(
        value: listData,
        data: (dv) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 54.0),
                child: SelectableText(
                    'Define the allowable transaction Category and spending limit at Member level'),
              ),
              Expanded(
                child: AcxTrinaGridExtDataCheckBox(
                  idField: 'PrgEttyId',
                  spName: 'ApiEnrlMbrPrdAccptPrgList',
                  extData: dv,
                  isMultiSelect: true, 
                  onNew: () {
                      if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                    //     singleton<AppRouter>().navigatePath('$toNavUrl/new');
                           if(dv.data != null && dv.data![0]['PrgEttyId'] != null){
                      Toast.message('Only 1 Product Acceptance Record allowed per Member');
                      return;
                    }
                    singleton<AppRouter>().navigatePath(
                        '/custenroll/member/$custEttyId/detail/$mbrEttyId/control/prodaccpt/prodaccptsel');

                    //detail/:prgEttyId
                  },
                  onSelectedTap: (TrinaRow val) {
                    singleton<AppRouter>().navigatePath(
                        '/custenroll/member/$custEttyId/detail/$mbrEttyId/control/prodaccpt/detail/${val.cells['PrgEttyId']!.value.toString()}');
                  },
                ),
              ),
            ],
          );
        });
  }
}
