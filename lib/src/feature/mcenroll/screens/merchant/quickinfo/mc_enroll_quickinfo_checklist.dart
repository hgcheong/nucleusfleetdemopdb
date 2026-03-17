import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=679;

@RoutePage()
class MchtEnrollQuickInfoCheckList extends ConsumerWidget {
  const MchtEnrollQuickInfoCheckList(
      {super.key, @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final queryObj = QueryObject(
        querysql: '/sp/ApiEnrlMchtOverviewChkList/queryasync',
        params: {"MchtEttyId": mchtEttyId},
        showMsg: false);
    final query = ref.watch(ReturndatafreezedProvider(queryObj));

    return AsyncValueWidget(
        value: query,
        data: (theData) {
          return SingleChildScrollView(
            child: SizedBox(
              height: 1280,
              child: AcxTrinaGridExtData(
                extData: theData,
                idField: 'Id',
                spName: 'ApiEnrlMchtOverviewChkList',
              ),
            ),
          );
        });
  }
}
