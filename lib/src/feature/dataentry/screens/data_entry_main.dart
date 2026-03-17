import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/feature/dataentry/screens/manual_txn/dataentry_adjustment.dart';
import 'package:nucleusv2/src/feature/dataentry/screens/manual_txn/dataentry_payment.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrapext.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/dataentry/screens/manual_txn/dataentry_manual_provider.dart';

const int wid=224;

@RoutePage()
class DataEntryMain extends BaseScreen {
  const DataEntryMain({super.key});

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(context, ref);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(context, ref);
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("dataentry/main");
  }

  Widget buildView(BuildContext context, WidgetRef ref) {
    final querySql = QueryObject(
        params: const {},
        querysql: '/sp/ApiMnlTxnSmryList/queryasync',
        showMsg: false);
    final queryResult = ref.watch(ReturndatafreezedProvider(querySql));

    return AsyncValueWidget(
        value: queryResult,
        data: (theData) {
          return Scaffold(
            appBar: AppBar(
              title: const SelectableText('Data Entry'),
              automaticallyImplyLeading: false, centerTitle: false,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: 1280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            ref.invalidate(ReturndatafreezedProvider(querySql));
                          },
                          icon: const Icon(Icons.refresh)),
                    ),
                    Expanded(
                      flex: 10,
                      child: AcxListButtonNavWrapExt(
                        returnData: theData,
                        // querysql: '/sp/ApiMnlTxnSmryList/queryasync',
                        // params: const {},

                        returnSelectedRef: (val) {
                          ref.read(dataentryTxnIdProvider.notifier).state = '';
                          ref.read(adjustAcctIdProvider.notifier).state = val['AcctId'].toString();
                         ref.read(paymentAcctIdProvider.notifier).state = val['AcctId'].toString();
                          singleton<AppRouter>().navigatePath(
                              '/dataentry/manual/${val["TxnType"]}/list');
                        },
                        displayfield: const ['TxnTypeDscp', 'TotCnt'],
                        keyField: 'TxnType',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
