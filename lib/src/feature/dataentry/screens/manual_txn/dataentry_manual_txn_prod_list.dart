import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap.dart';

const int wid=346;

@RoutePage()
class DataEntryManualTxnDtlProdList extends StatelessWidget {
  const DataEntryManualTxnDtlProdList(
      {super.key, @PathParam('txnId') this.txnId});

  final String? txnId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Scaffold(
      appBar: AppBar(
        title: const SelectableText("Product List"),
        automaticallyImplyLeading: false, centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AcxListButtonNavWrap(
            querysql: '/sp/ApiMnlTxnItemList /queryasync',
            params: {"TxnId": txnId},
            returnSelectedRef: (val) {
              ///dataentry/manual/itemdtl/txnId/prdId
              ///
              singleton<AppRouter>().navigatePath(
                  '/dataentry/manual/itemdtl/$txnId/${val.cells['PrdId']!.value.toString()}');
            },
            addNew: () {
              singleton<AppRouter>()
                  .navigatePath('/dataentry/manual/itemdtl/$txnId/new');
            },
            displayfield: const ['PrdDscp', 'TxnAmt'],
            keyField: 'PrdId',
          ),
        ),
      ),
    );
  }
}
