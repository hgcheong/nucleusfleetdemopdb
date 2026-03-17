import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final mcmgmtTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/mcmgmt",
    page: MchtMgmtContainer.page,
    children: [
      AutoRoute(
          path: 'tad/:mchtEttyId',
          page: MchtMgmtTadLanding.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'status/:tadEttyId/:tadId',
                page: MchtMgmtTADProfileStatusLanding.page,
                children: [
                  AutoRoute(
                      path: '',
                      page: MchtMgmtTADProfileStatus.page,
                      initial: true)
                ]),
            AutoRoute(
                path: 'list',
                page: MchtMgmtTadListLanding.page,
                maintainState: false,
                initial: true,
                children: [
                  AutoRoute(path: '', 
                  maintainState: false,
                  page: MchtMgmtTadList.page, initial: true)
                ]),
            AutoRoute(
                path: 'geninfo/:tadEttyId/:tadId',
                page: MchtMgmtTadGenInfoLanding.page,
                usesPathAsKey: true,
                maintainState: false,
                children: [
                  AutoRoute(
                    path: 'main',
                    page: MchtMgmtTadGenInfo.page,
                    usesPathAsKey: true,
                    maintainState: false,
                  ),
                  AutoRoute(
                      path: '',
                      page: MchtMgmtTadQuickInfo.page,
                      usesPathAsKey: true,
                      maintainState: false,
                      initial: true)
                ]),
          ]),
      AutoRoute(
          path: 'appuser/:mchtEttyId',
          page: MchtMgmtOnlineAccessLanding.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'new',
                page: MchtMgmtOnlineAccessNewLanding.page,
                children: [
                  AutoRoute(
                      path: 'main',
                      page: MchtMgmtOnlineAccessNew.page,
                      initial: true)
                ]),
            AutoRoute(
                path: 'list',
                page: MchtMgmtOnlineAccessListLanding.page,
                children: [
                  AutoRoute(
                      path: '',
                      page: MchtMgmtOnlineAccessList.page,
                      initial: true)
                ])
          ]),
      AutoRoute(
          path: 'reimburse/:mchtEttyId',
          page: MchtReimburseListLanding.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
              path: 'list',
              page: MchtMgmtReimburseList.page,
              usesPathAsKey: true,
              maintainState: false,
            )
          ]),
      AutoRoute(
          path: 'billingAccount/:mchtEttyId',
          page: MchtMgmtBillingLanding.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                page: MchtMgmtBillingListLanding.page,
                children: [
                  AutoRoute(
                      path: '', page: MchtMgmtBillingList.page, initial: true)
                ]),
            AutoRoute(
                path: 'status/:prgEttyId/:ettyId/:acctId',
                page: MchtMgmtBillingAcctStatusLanding.page,
                children: [
                  AutoRoute(
                      path: '',
                      page: MchtMgmtBillingAcctStatus.page,
                      initial: true)
                ]),
            AutoRoute(
                path: 'dtl/:prgEttyId/:ettyId/:acctId',
                usesPathAsKey: true,
                maintainState: false,
                page: MchtMgmtBillingDetailLanding.page,
                children: [
                  AutoRoute(
                      path: 'account',
                      page: McMgmtBillingAccountInfo.page,
                      initial: true),
                  AutoRoute(
                      path: 'settlement',
                      page: MchtMgmtSettlementLanding.page,
                      children: [
                        AutoRoute(
                            path: 'summary',
                            page: MchtMgmtSettlementSummary.page,
                            initial: true),
                        AutoRoute(
                            path: 'dtl', page: MchtMgmtSettlementDetail.page),
                      ]),
                  AutoRoute(
                      path: 'txn',
                      page: MchtMgmtTxnLanding.page,
                      children: [
                        AutoRoute(
                            path: 'recent',
                            page: MchtMgmtTxnRecentLanding.page),
                        AutoRoute(
                          path: 'posted',
                          page: MchtMgmtTxnPostedLanding.page,
                          initial: true,
                        ),
                        AutoRoute(
                            path: 'oltp',
                            page: MchtMgmtTxnOltpLanding.page,
                            maintainState: false),
                      ]),
                  AutoRoute(path: 'autopay', page: MchtMgmtBillingAutoPay.page),
                ]),
          ]),
      AutoRoute(
          path: 'loc/:mchtEttyId',
          page: MchtMgmtLocationLanding.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'status/:locEttyId',
                page: MchtMgmtLocationProfileStatusLanding.page,
                children: [
                  AutoRoute(
                      path: '',
                      page: MchtMgmtLocationProfileStatus.page,
                      initial: true)
                ]),
            AutoRoute(
                path: 'list',
                page: MchtMgmtLocationListLanding.page,
                children: [
                  AutoRoute(path: '', page: MchtMgmtLocationList.page)
                ]),
            AutoRoute(
                path: 'billing',
                page: MchtMgmtBillingDetailLanding.page,
                children: [
                  AutoRoute(
                    path: 'autopay',
                    page: MchtMgmtBillingAutoPay.page,
                  ),
                ]),
            AutoRoute(
                path: 'detail/:locEttyId',
                usesPathAsKey: true,
                maintainState: false,
                page: MchtMgmtLocationDetailLanding.page,
                children: [
                  AutoRoute(
                      path: 'quickinfo',
                      page: MchtMgmtLocQuickInfoLanding.page,
                      children: [
                        AutoRoute(
                            path: 'overview',
                            page: MchtMgmtLocQuickInfoOverView.page)
                      ]),
                  AutoRoute(
                      path: 'profile',
                      page: MchtMgmtLocationPofileLanding.page,
                      children: [
                        AutoRoute(
                            path: 'geninfo',
                            page: MchtMgmtLocationProfileGenInfo.page),
                                       AutoRoute(
                      path: 'director',
                      page: MchtMgmtLocationProfileDirectorLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: MchtMgmtLocationProfileDirectorList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'directordtl/:indvdId',
                            usesPathAsKey: true,
                            page: MchtMgmtLocationProfileDirector.page,
                            maintainState: false),
                      ]),
                        AutoRoute(
                            path: 'address',
                            page: MchtMgmtLocationProfileAddressLanding.page,
                            children: [
                              AutoRoute(
                                  path: '',
                                  usesPathAsKey: true,
                                  maintainState: false,
                                  page: MchtMgmtLocationProfileAddressList.page,
                                  initial: true),
                              AutoRoute(
                                  path: 'adddtl/:addrType/:contactId/:addrId',
                                  usesPathAsKey: true,
                                  maintainState: false,
                                  page: MchtMgmtLocationProfileAddress.page),
                            ]),
                        AutoRoute(
                            path: 'contact',
                            page: MchtMgmtLocationProfileContactLanding.page,
                            children: [
                              AutoRoute(
                                  path: '',
                                  usesPathAsKey: true,
                                  maintainState: false,
                                  page: MchtMgmtLocationProfileContactList.page,
                                  initial: true),
                              AutoRoute(
                                  path: 'contactdtl/:contactType/:contactId',
                                  usesPathAsKey: true,
                                  maintainState: false,
                                  page: MchtMgmtLocationProfileContact.page),
                            ]),
                      ]),
                  AutoRoute(
                      path: 'program',
                      page: MchtMgmtocPrgLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                          initial: true,
                          path: '',
                          page: MchtMgmtocPrgList.page,
                          maintainState: false,
                        ),
                        AutoRoute(
                          path: 'select/:prgEttyId/:accptId',
                          usesPathAsKey: true,
                          page: MchtMgmtocPrgSelection.page,
                          maintainState: false,
                        ),
                      ]),
                ]),
            AutoRoute(
                path: 'prgdtl/:locEttyId/:prgEttyId/:billingEttyType/:accptId',
                page: MchtMgmtocPrgDetailLanding.page,
                usesPathAsKey: true,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'fees',
                      page: MchtMgmtLocPrgFeesLanding.page,
                      usesPathAsKey: true,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'tad',
                            page: MchtMgmtLocPrgTadLanding.page,
                            maintainState: false,
                            usesPathAsKey: true,
                            children: [
                              AutoRoute(
                                  path: 'list',
                                  page: MchtMgmtLocPrgTadList.page,
                                  initial: true,
                                  maintainState: false,
                                  usesPathAsKey: true),
                              AutoRoute(
                                path: 'dtltad/:feeId',
                                usesPathAsKey: true,
                                maintainState: false,
                                page: MchtMgmtLocPrgTad.page,
                              ),
                            ]),
                        AutoRoute(
                            path: 'trans',
                            page: MchtMgmtLocPrgTransLanding.page,
                            maintainState: false,
                            usesPathAsKey: true,
                            children: [
                              AutoRoute(
                                  path: 'list',
                                  page: MchtMgmtLocPrgTransList.page,
                                  initial: true,
                                  maintainState: false,
                                  usesPathAsKey: true),
                              AutoRoute(
                                path: 'dtltxn/:feeId',
                                usesPathAsKey: true,
                                maintainState: false,
                                page: MchtMgmtLocPrgTrans.page,
                              ),
                            ]),
                      ]),
                  AutoRoute(
                      path: 'transplan',
                      page: MchtMgmtLocPrgTranPlanLanding.page,
                      children: [
                        AutoRoute(
                            path: 'tp',
                            page: MchtMgmtLocPrgTpTransLanding.page,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: 'list',
                                  maintainState: false,
                                  page: MchtMgmtLocPrgTpTransList.page,
                                  initial: true),
                              AutoRoute(
                                  path: 'dtl/:poe/:txnMsgCd/:msgTypePlanId',
                                  maintainState: false,
                                  usesPathAsKey: true,
                                  page: MchtMgmtLocPrgTpTrans.page)
                            ]),
                      ]),
                  AutoRoute(
                      path: 'control',
                      page: MchtMgmtLocPrgControlLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'list',
                            page: MchtMgmtLocPrgControlListLanding.page,
                            initial: true,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: MchtMgmtLocPrgControlList.page,
                                  maintainState: false,
                                  initial: true)
                            ]),
                        AutoRoute(
                            path: 'select/:txnCtgry/:accptId2',
                            usesPathAsKey: true,
                            maintainState: false,
                            page: MchtMgmtLocPrgControlSelectLanding.page,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: MchtMgmtLocPrgControlSelection.page,
                                  initial: true)
                            ])
                      ]),
                ])
          ]),
      AutoRoute(
          path: 'bu/:mchtEttyId',
          usesPathAsKey: true,
          maintainState: false,
          page: MchtMgmtBusinessUnitLanding.page,
          children: [
            AutoRoute(
                path: 'list',
                page: MchtMgmtBusinessUnitListLanding.page,
                maintainState: true,
                children: [
                  AutoRoute(path: '', page: MchtMgmtBusinessUnitList.page)
                ]),
            AutoRoute(
                path: 'bumain/:busnUnitEttyId',
                page: MchtMgmtBusinessUnitGenInfoLanding.page,
                usesPathAsKey: true,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'geninfo',
                      maintainState: false,
                      page: MchtMgmtBusinessUnitGenInfo.page)
                ]),
          ]),
      AutoRoute(
          path: 'mcht/:mchtEttyId',
          usesPathAsKey: true,
          maintainState: false,
          page: MchtMgmtMerchantRoute.page,
          children: [
            AutoRoute(
                path: 'quickinfo',
                page: MchtMgmtQuickInfoLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'overview',
                      page: MchtMgmtQuickInfoOverView.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'checklist', page: MchtMgmtQuickInfoCheckList.page),
                  AutoRoute(
                      path: 'apprvhist', page: MchtMgmtQuickInfoApprvHist.page),
                ]),
            AutoRoute(
                path: 'profile',
                page: MchtMgmtProfileLanding.page,
                initial: true,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'geninfo',
                      page: MchtMgmtProfileGenInfo.page,
                      initial: true,
                      maintainState: false),
                  AutoRoute(
                      path: 'address',
                      page: MchtMgmtAddressLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: MchtMgmtAddressList.page,
                            maintainState: false,
                            initial: true),
                        AutoRoute(
                            path: 'adddtl/:addrType/:contactId/:addrId',
                            usesPathAsKey: true,
                            page: MchtMgmtAddress.page,
                            maintainState: false),
                      ]),
                            AutoRoute(
                      path: 'director',
                      page: MchtMgmtDirectorLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: MchtMgmtDirectorList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'directordtl/:indvdId',
                            usesPathAsKey: true,
                            page: MchtMgmtDirector.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'contact',
                      page: MchtMgmtContactLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: MchtMgmtContactList.page,
                            maintainState: false,
                            initial: true),
                        AutoRoute(
                            path: 'contactdtl/:contactType/:contactId',
                            usesPathAsKey: true,
                            maintainState: false,
                            page: MchtMgmtContact.page),
                      ]),
                ]),
            AutoRoute(
                path: 'events',
                page: MchtMgmtEventLanding.page,
                maintainState: false),
            AutoRoute(path: 'docs', page: MchtMgmtDocLanding.page, children: [
              AutoRoute(path: 'appl', page: MchtMgmtDocAppl.page),
              AutoRoute(path: 'invs', page: MchtMgmtDocInvs.page),
              AutoRoute(path: 'comm', page: MchtMgmtDocComm.page),
              AutoRoute(path: 'bank', page: MchtMgmtDocBank.page),
            ]),
          ])
    ]);
