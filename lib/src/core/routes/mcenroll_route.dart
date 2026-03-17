import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final mcenrollTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/mcenroll",
    page: MchtEnrlContainer.page,
    children: [
      AutoRoute(path: 'main', page: MchtEnrollListRoute.page, maintainState: false, usesPathAsKey:true),
      AutoRoute(
          path: 'pending/:mchtEttyId',
          page: MchtEnrollNewRoute.page,
          maintainState: false,
          usesPathAsKey: true),
      AutoRoute(
          path: 'tad/:mchtEttyId',
          page: MchtEnrlTadLanding.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                page: MchtEnrlTadListLanding.page,
                maintainState: false,
                initial: true,
                children: [
                  AutoRoute(path: '', page: MchtEnrlTadList.page, initial: true)
                ]),
            AutoRoute(
                path: 'geninfo/:tadEttyId/:tadId',
                page: MchtEnrlTadGenInfoLanding.page,
                usesPathAsKey: true,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: '',
                      maintainState: false,
                      page: MchtEnrlTadGenInfo.page,
                      initial: true)
                ]),
          ]),
      AutoRoute(
          path: 'billingAccount/:mchtEttyId',
          page: MchtEnrlBillingLanding.page,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                maintainState: false,
                page: MchtEnrlBillingListLanding.page,
                children: [
                  AutoRoute(path: '', page: MchtEnrlBillingList.page)
                ]),
            AutoRoute(
                path: 'autoPayment/:prgEttyId/:ettyId',
                page: MchtEnrlBillingAutoPayLanding.page,
                usesPathAsKey: true,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'dtl',
                      maintainState: false,
                      page: MchtEnrlBillingAutoPay.page,
                      initial: true)
                ]),
          ]),
      AutoRoute(
          path: 'loc/:mchtEttyId',
          page: MchtEnrlLocationLanding.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                page: MchtEnrlLocationListLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                    path: '',
                    page: MchtEnrlLocationList.page,
                    maintainState: false,
                  )
                ]),
            AutoRoute(
                path: 'billing',
                page: MchtEnrlBillingDetailLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                    path: 'autopay',
                    maintainState: false,
                    page: MchtEnrlBillingAutoPay.page,
                  ),
                ]),
            AutoRoute(
                path: 'detail/:locEttyId',
                usesPathAsKey: true,
                page: MchtEnrlLocationDetailLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'profile',
                      maintainState: false,
                      page: MchtEnrlLocationPofileLanding.page,
                      children: [
                        AutoRoute(
                            path: 'geninfo',
                            maintainState: false,
                            page: MchtEnrlLocationProfileGenInfo.page),
                                       AutoRoute(
                      path: 'director',
                      page: MchtEnrlLocationProfileDirectorLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: MchtEnrlLocationProfileDirectorList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'directordtl/:indvdId',
                            usesPathAsKey: true,
                            page: MchtEnrlLocationProfileDirector.page,
                            maintainState: false),
                      ]),
                        AutoRoute(
                            path: 'address',
                            maintainState: false,
                            page: MchtEnrlLocationProfileAddressLanding.page,
                            children: [
                              AutoRoute(
                                  path: '',
                                  maintainState: false,
                                  initial: true,
                                  page:
                                      MchtEnrlLocationProfileAddressList.page),
                              AutoRoute(
                                  path: 'adddtl/:addrType/:contactId/:addrId',
                                  maintainState: false,
                                  usesPathAsKey: true,
                                  page: MchtEnrlLocationProfileAddress.page),
                            ]),
                        AutoRoute(
                            path: 'contact',
                            maintainState: false,
                            page: MchtEnrlLocationProfileContactLanding.page,
                            children: [
                              AutoRoute(
                                  path: '',
                                  maintainState: false,
                                  page:
                                      MchtEnrlLocationProfileContactList.page),
                              AutoRoute(
                                  path: 'contactdtl/:contactType/:contactId',
                                  maintainState: false,
                                  usesPathAsKey: true,
                                  page: MchtEnrlLocationProfileContact.page),
                            ]),
                      ]),
                  AutoRoute(
                      path: 'program',
                      page: MchtEnrlocPrgLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                          initial: true,
                          path: '',
                          page: MchtEnrlocPrgList.page,
                          maintainState: false,
                        ),
                        AutoRoute(
                          path: 'select/:prgEttyId/:accptId',
                          usesPathAsKey: true,
                          page: MchtEnrlocPrgSelection.page,
                          maintainState: false,
                        ),
                      ]),
                ]),
            AutoRoute(
                path: 'prgdtl/:locEttyId/:prgEttyId/:billingEttyType/:accptId',
                page: MchtEnrlocPrgDetailLanding.page,
                usesPathAsKey: true,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'fees',
                      page: MchtEnrlLocPrgFeesLanding.page,
                      usesPathAsKey: true,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'tad',
                            page: MchtEnrlLocPrgTadLanding.page,
                            maintainState: false,
                            usesPathAsKey: true,
                            children: [
                              AutoRoute(
                                  path: 'list',
                                  page: MchtEnrlLocPrgTadList.page,
                                  initial: true,
                                  maintainState: false,
                                  usesPathAsKey: true),
                              AutoRoute(
                                path: 'dtltad/:feeId',
                                usesPathAsKey: true,
                                maintainState: false,
                                page: MchtEnrlLocPrgTad.page,
                              ),
                            ]),
                        AutoRoute(
                            path: 'trans',
                            page: MchtEnrlLocPrgTransLanding.page,
                            maintainState: false,
                            usesPathAsKey: true,
                            children: [
                              AutoRoute(
                                  path: 'list',
                                  page: MchtEnrlLocPrgTransList.page,
                                  initial: true,
                                  maintainState: false,
                                  usesPathAsKey: true),
                              AutoRoute(
                                path: 'dtltxn/:feeId',
                                usesPathAsKey: true,
                                maintainState: false,
                                page: MchtEnrlLocPrgTrans.page,
                              ),
                            ]),
                      ]),
                  AutoRoute(
                      path: 'transplan',
                      page: MchtEnrlLocPrgTranPlanLanding.page,
                      children: [
                        AutoRoute(
                            path: 'tp',
                            page: McEnrollLocPrgTpTransLanding.page,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: 'list',
                                  maintainState: false,
                                  page: McEnrollLocPrgTpTransList.page,
                                  initial: true),
                              AutoRoute(
                                  path: 'dtl/:poe/:txnMsgCd/:msgTypePlanId',
                                  maintainState: false,
                                  usesPathAsKey: true,
                                  page: McEnrollLocPrgTpTrans.page)
                            ]),
                      ]),
                  AutoRoute(
                      path: 'control',
                      page: MchtEnrlLocPrgControlLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'list',
                            page: MchtEnrlLocPrgControlListLanding.page,
                            initial: true,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: '',
                                  maintainState: false,
                                  page: MchtEnrlLocPrgControlList.page,
                                  initial: true)
                            ]),
                        AutoRoute(
                            path: 'select/:txnCtgry/:accptId2',
                            page: MchtEnrlLocPrgControlSelectLanding.page,
                            usesPathAsKey: true,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: '',
                                  maintainState: false,
                                  page: MchtEnrlLocPrgControlSelection.page,
                                  initial: true)
                            ])
                      ]),
                ])
          ]),
      AutoRoute(
          path: 'bu/:mchtEttyId',
          usesPathAsKey: true,
          maintainState: false,
          page: MchtEnrlBusinessUnitLanding.page,
          children: [
            AutoRoute(
                path: 'list',
                page: MchtEnrlBusinessUnitListLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(path: '', page: MchtEnrlBusinessUnitList.page)
                ]),
            AutoRoute(
                path: 'bumain/:busnUnitEttyId',
                page: MchtEnrlBusinessUnitGenInfoLanding.page,
                usesPathAsKey: true,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'geninfo',
                      maintainState: false,
                      initial: true,
                      page: MchtEnrlBusinessUnitGenInfo.page)
                ]),
          ]),
      AutoRoute(
          path: 'mcht/:mchtEttyId',
          usesPathAsKey: true,
          maintainState: false,
          page: MchtEnrlMerchantRoute.page,
          children: [
            AutoRoute(
                path: 'quickinfo',
                maintainState: false,
                page: MchtEnrlQuickInfoLanding.page,
                children: [
                  AutoRoute(
                      path: 'overview',
                      maintainState: false,
                      page: MchtEnrlQuickInfoOverView.page),
                  AutoRoute(
                      path: 'checklist',
                      maintainState: false,
                      page: MchtEnrollQuickInfoCheckList.page),
                  AutoRoute(
                      maintainState: false,
                      path: 'apprvhist',
                      page: MchtEnrlQuickInfoApprvHist.page),
                ]),
            AutoRoute(
                path: 'profile',
                page: MchtEnrlProfileLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'geninfo',
                      maintainState: false,
                      page: MchtEnrlProfileGenInfo.page),
                  AutoRoute(
                      path: 'address',
                      maintainState: false,
                      page: MchtEnrlAddressLanding.page,
                      children: [
                        AutoRoute(
                            path: '',
                            initial: true,
                            maintainState: false,
                            page: MchtEnrlAddressList.page),
                        AutoRoute(
                            path: 'adddtl/:addrType/:contactId/:addrId',
                            maintainState: false,
                            usesPathAsKey: true,
                            page: MchtEnrlAddress.page),
                      ]),
                            AutoRoute(
                      path: 'director',
                      page: MchtEnrlDirectorLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: MchtEnrlDirectorList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'directordtl/:indvdId',
                            usesPathAsKey: true,
                            page: MchtEnrlDirector.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'contact',
                      page: MchtEnrlContactLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            maintainState: false,
                            page: MchtEnrlContactList.page),
                        AutoRoute(
                            path: 'contactdtl/:contactType/:contactId',
                            maintainState: false,
                            usesPathAsKey: true,
                            page: MchtEnrlContact.page),
                      ]),
                ]),
            AutoRoute(path: 'docs', page: MchtEnrlDocLanding.page, children: [
              AutoRoute(path: 'appl', page: MchtEnrlDocAppl.page),
              AutoRoute(path: 'invs', page: MchtEnrlDocInvs.page),
              AutoRoute(path: 'comm', page: MchtEnrlDocComm.page),
              AutoRoute(path: 'bank', page: MchtEnrlDocBank.page),
            ]),
          ])
    ]);
