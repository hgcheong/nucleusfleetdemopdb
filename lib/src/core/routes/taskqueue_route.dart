import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

// {

//       "WfCd": "CUSTCRASSESS",
//       "WfPrcsId": 1,
//       "UsrId": 3
// }
final taskqueyTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/taskqueue",
    page: TaskQueueContainer.page,
    children: [
      AutoRoute(path: 'summary', page: TaskQueueSummary.page),
      AutoRoute(
          path: 'main/:wfcd/:wfprcsid/:wfgrpid',
          page: TaskQueueListLanding.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                page: TaskQueueList.page,
                usesPathAsKey: true,
                maintainState: false),
            AutoRoute(
                path: 'dtl:wftaskid',
                page: TaskQueueDetail.page,
                usesPathAsKey: true,
                maintainState: false),
          ]),
      AutoRoute(
          path: 'custapprv',
          page: TaskQueueCustApprovalList.page,
          children: [
            AutoRoute(path: 'custapprvdtl', page: TaskQueueCustApproval.page)
          ]),
      AutoRoute(
          path: 'mchtapprv',
          page: TaskQueueMerchantApprovalList.page,
          children: [
            AutoRoute(
                path: 'mchtapprvdtl', page: TaskQueueMerchantApproval.page),
          ]),
      AutoRoute(
          path: 'transapprv',
          page: TaskQueueTxnApprovalList.page,
          children: [
            AutoRoute(path: 'transapprvdtl', page: TaskQueueTxnApproval.page),
          ]),
      AutoRoute(
        path: 'statusapprv',
        page: TaskQueueStsApproval.page,
      ),
      AutoRoute(path: 'creditlimitapprv', page: TaskQueueCreditLimitApprv.page),
      AutoRoute(path:'crcoldtl/:id',page: CreditCollectionDtlLanding.page, maintainState:false,usesPathAsKey: true, children:[
         AutoRoute(path:'task', page: CreditCollectionDtlTask.page, maintainState:false,),
        AutoRoute(path:'acct', page: CreditCollectionDtlAcct.page, maintainState:false,),
        AutoRoute(path:'contact', page: CreditCollectionDtlAcctContact.page, maintainState:false,),
        AutoRoute(path:'overdue', page: CreditCollectionDtlAcctOverDue.page, maintainState:false,)
      ]),
      AutoRoute(
          path: 'creditcollection',
          page: CreditCollectionLanding.page,
          children: [
            AutoRoute(path: 'search', page: CreditCollecitonSearch.page),
            AutoRoute(path: 'event', page: CreditCollectionEventList.page)
          ]),
      AutoRoute(path: 'apprvhist', page: TaskQueueApprovalHistory.page),
    ]);
