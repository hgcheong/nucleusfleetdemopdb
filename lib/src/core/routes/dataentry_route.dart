import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final dataentryTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/dataentry",
    page: DataEntryContainer.page,
    children: [
      AutoRoute(path: 'main', page: DataEntryMain.page, maintainState: false),
      AutoRoute(
          path: 'manual/:txnType',
          page: DataEntryManualTxnLanding.page,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'pukalfiles',
                page: DataEntryPukalFileLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'in',
                      page: DataEntryPukalFileIn.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'out',
                      page: DataEntryPukalFileOut.page,
                      maintainState: false),
                ]),
            AutoRoute(
              path: 'list',
              page: DataEntryManualTxnList.page,
              usesPathAsKey: true,
              maintainState: false,
            ),
            AutoRoute(
                usesPathAsKey: true,
                path: 'dtl/:txnId',
                page: DataEntryManualTxn.page,
                maintainState: false),
            AutoRoute(
                usesPathAsKey: true,
                path: 'sale/:txnId',
                page: DataEntrySaleTxn.page,
                maintainState: false),
            AutoRoute(
                usesPathAsKey: true,
                path: 'payment/:txnId',
                page: DataEntryPaymentTxn.page,
                maintainState: false),
            AutoRoute(
                usesPathAsKey: true,
                path: 'fee/:txnId',
                page: DataEntryFeeTxn.page,
                maintainState: false),
            AutoRoute(
                usesPathAsKey: true,
                path: 'adjust/:txnId',
                page: DataEntryAdjustmentTxn.page,
                maintainState: false),
            AutoRoute(
                usesPathAsKey: true,
                path: 'pukal/:txnId',
                page: DataEntryPukalTxn.page,
                maintainState: false),
            AutoRoute(
                usesPathAsKey: true,
                path: 'item/:txnId',
                page: DataEntryManualTxnDtlProdList.page),
            AutoRoute(
                usesPathAsKey: true,
                path: 'itemdtl/:txnId/:prdId',
                page: DataEntryManualTxnDtlProd.page),
          ]),
    ]);

// Swichts
// 1)Manual Transaciton Type
// 	a)ApiMnlTxnList ->
// 2)Manual Transaciton Type
// 	a)ApiMnlTxnList ->
// 3)Manual Transaciton Type
// 	a)ApiMnlTxnList - >
// 4)Suspended Transaction Type

// 5)Batched Transaction Type

// 4)
