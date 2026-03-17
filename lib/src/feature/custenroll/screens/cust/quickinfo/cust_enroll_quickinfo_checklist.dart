import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatav2.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=495;

@RoutePage()
class CustEnrollQuickInfoCheckList extends ConsumerWidget {
  const CustEnrollQuickInfoCheckList(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final queryObject = QueryObject(
        params: {"CustEttyId": custEttyId},
        querysql: '/sp/ApiEnrlCustOverviewChkList/queryasync',
        showMsg: false);
    final queryData = ref.watch(ReturndatafreezedProvider(queryObject));
    return AsyncValueWidget(
        value: queryData,
        data: (extDat) {
          return SingleChildScrollView(
              child: SizedBox(
            height: 1280,
            child: AcxTrinaGridExtv2(
              onRefresh: () {
                ref.invalidate(ReturndatafreezedProvider(queryObject));
              },
              extData: extDat,
              idField: 'Id',

            ),
          ));
        });
  }
}
