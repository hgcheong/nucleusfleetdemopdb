import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=322;

@RoutePage()
class CustMgmtMediaList extends StatelessWidget {
  const CustMgmtMediaList(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return CustMgmtMediaListGrid(custEttyId: custEttyId);
  }
}

class CustMgmtMediaListGrid extends HookConsumerWidget {
  const CustMgmtMediaListGrid({
    super.key,
    this.custEttyId,
  });
  final String? custEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtMediaList/queryasync',
        params: {
          "CustEttyId": custEttyId,
        },
        showMsg: false));
    final listData = ref.watch(listQuery);
    return AsyncValueWidget<Returndata>(
        value: listData,
        data: (dv) {
          return AcxTrinaGridExtDataCheckBox(
            onRefresh: (){
              ref.invalidate(listQuery);
            },
            idField: 'MediaEttyId',
            spName: 'ApiMgmtMediaList',
            extData: dv,
            isMultiSelect: false,
            onSelectedTap: (TrinaRow val) {
              singleton<AppRouter>().navigatePath(
                  '/custmgmt/media/$custEttyId/detail/${val.cells['MediaEttyId']!.value.toString()}/${val.cells['IssId']!.value.toString()}/${val.cells['MbrEttyId']!.value.toString()}/${val.cells['PrgEttyId']!.value.toString()}');
            },
          );
        });
  }
}
