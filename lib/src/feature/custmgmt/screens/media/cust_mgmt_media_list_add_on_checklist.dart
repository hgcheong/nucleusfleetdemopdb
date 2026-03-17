import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatav2.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=324;

@RoutePage()
class CustMgmtMediaListAddOnCheckList extends StatelessWidget {
  const CustMgmtMediaListAddOnCheckList(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Center(
      child: CustMgmtMediaListAddOnCheckListGrid(custEttyId: custEttyId),
    );
  }
}

class CustMgmtMediaListAddOnCheckListGrid extends HookConsumerWidget {
  const CustMgmtMediaListAddOnCheckListGrid({
    super.key,
    this.custEttyId,
  });
  final String? custEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      final queryObject = ReturndatafreezedProvider(QueryObject(
        params: {"CustEttyId": custEttyId},
        querysql: '/sp/ApiMgmtCustMediaAddOnChkList/queryasync',
        showMsg: false));
    final queryData = ref.watch(queryObject);
    return AsyncValueWidget<Returndata>(
        value: queryData,
        data: (dv) {
          return AcxTrinaGridExtv2(
          
               onRefresh: (){
              ref.invalidate(queryObject);
            },
            idField: 'Id',  
            extData: dv,
          );
        });
  }
}
