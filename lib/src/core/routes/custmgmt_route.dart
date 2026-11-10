import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final custmgmtTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/custmgmt",
    page: CustMgmtContainer.page,
    maintainState: false,
    children: [
       AutoRoute(
                      path: 'subsidy2',
                      page: CustmgmtSubsidy2Landing.page,
                      maintainState: false,
                      children: [
                        
                        AutoRoute(
                            path: 'list',
                            page: CustmgmtSubsidy2List.page,
                            maintainState: false,
                            initial: true),
                            AutoRoute(path:'cbp/:chargeType/:prgEttyId/:cbId',
                            page:CustmgmtSubsidy2CustLanding.page,children:[
AutoRoute(

                            path: 'cbplist',
                            page: CustmgmtSubsidy2CustList.page,
                            initial:true,
                            maintainState: false),
                            AutoRoute(
                          path: 'cbpdtl/:cbPrgEttyId/:ettyId/:cbQuoId',
                          usesPathAsKey: true,
                          page: CustMgmtSubsidy2.page,
                          maintainState: false,
                        ),
                            ]),]),
      AutoRoute(
          path: 'main', page: CustMgmtListRoute.page, maintainState: false),
      // AutoRoute(
      //   path: 'pending/:custEttyId',
      //   page: CustMgmtNewRoute.page,
      //   maintainState: false,
      //   usesPathAsKey: true,
      // ),
      AutoRoute(
          path: 'billingAccount/:custEttyId',
          page: CustMgmtBillingLanding.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                maintainState: false,
                page: CustMgmtBillingListLanding.page,
                initial: true,
                children: [
                  AutoRoute(path: '', page: CustMgmtBillingList.page)
                ]),
            AutoRoute(
                path: 'detail/:acctId',
                page: CustMgmtBillingDetailLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'accsetting/:acctType',
                      usesPathAsKey: true,
                      maintainState: false,
                      page: CustMgmtBillingAccSettingLanding.page,
                      children: [
                        AutoRoute(
                            path: 'prepaid',
                            maintainState: false,
                            page: CustMgmtBillingAccPrePaid.page),
                        AutoRoute(
                            path: 'postpaid',
                            maintainState: false,
                            initial: true,
                            page: CustMgmtBillingAccPostPaid.page),
                        AutoRoute(
                            path: 'pukal',
                            maintainState: false,
                            page: CustMgmtPukal.page),
                        AutoRoute(
                            path: 'autopay',
                            maintainState: false,
                            page: CustMgmtBillingAutoPay.page),
                        AutoRoute(
                            path: 'statement',
                            page: CustMgmtStatementLanding.page,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: 'summary',
                                  page: CustMgmtStatementSummary.page,
                                  maintainState: false,
                                  initial: true),
                              AutoRoute(
                                  path: 'dtl',
                                  page: CustMgmtStatementDetail.page,
                                  maintainState: false),
                            ]),
                        AutoRoute(
                          path: 'dtl',
                          page: CustMgmtStatementDetail.page,
                          maintainState: false,
                        ),
                        AutoRoute(
                            path: 'txn',
                            page: CustMgmtTxnLanding.page,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: 'oltp',
                                  page: CustMgmtTxnOltpLanding.page,
                                  maintainState: false),
                              AutoRoute(
                                  path: 'posted',
                                  maintainState: false,
                                  page: CustMgmtTxnPostedLanding.page,
                                  initial: true),
                                           AutoRoute(
                                  path: 'billed',
                                  maintainState: false,
                                  page: CustMgmtTxnBilledLanding.page),
                                      AutoRoute(
                                  path: 'unbilled',
                                  maintainState: false,
                                  page: CustMgmtTxnUnBilledLanding.page)
                            ]),
                      ]),
                ])
          ]),
      AutoRoute(
          path: 'media/:custEttyId',
          page: CustMgmtMediaLanding.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                page: CustMgmtMediaListLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: '',
                      page: CustMgmtMediaList.page,
                      maintainState: false,
                      initial: true),
                  AutoRoute(
                      path: 'addOn',
                      page: CustMgmtMediaListAddOn.page,
                      maintainState: false),
                        AutoRoute(
                      path: 'checklist',
                      page: CustMgmtMediaListAddOnCheckList.page,
                      maintainState: false),
                          AutoRoute(
                      path: 'activate',
                      page: CustMgmtMediaListActivation.page,
                      maintainState: false),
                ]),
            AutoRoute(
                path: 'selmedia',
                page: CustMgmtMediaSelectTab.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'detail',
                      page: CustMgmtMediaSelect.page,
                      maintainState: false)
                ]),
            AutoRoute(
                path: 'selsub',
                page: CustMgmtMediaSubSelectTab.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'detail',
                      page: CustMgmtMediaSubSelect.page,
                      maintainState: false)
                ]),
            AutoRoute(
                path: 'detailAddOn/:mediaCtgry/:prgEttyId/:mbrEttyId/:mediaId',
                usesPathAsKey: true,
                page: CustMgmtMediaDetailAddOnCardLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                    path: 'prop',
                    page: CustMgmtMediaAddOnCardProperties.page,
                    maintainState: false,
                  ),
                  AutoRoute(
                      path: 'design',
                      page: CustMgmtMediaAddOnCardDesign.page,
                      maintainState: false),
           
                ]),
            AutoRoute(
                path: 'detail/:mediaEttyId/:issId/:mbrEttyId/:prgEttyId',
                usesPathAsKey: true,
                page: CustMgmtMediaDetailanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                    path: 'prop',
                    page: CustMgmtMediaInfo.page,
                    maintainState: false,
                  ),
                  AutoRoute(
                      path: 'design',
                      page: CustMgmtMediaProperties.page,
                      maintainState: false),
                                  AutoRoute(
                      path: 'balance',
                      page: CustMgmtMediaBalance.page,
                      maintainState: false),
                ]),
            // AutoRoute(
            //     path: 'mediaholder',
            //     page: CustMgmtCustRoute.page,
            //     maintainState: false),
            // AutoRoute(
            //     path: 'subscription',
            //     page: CustMgmtCustRoute.page,
            //     maintainState: false,
            //     children: [
            //       AutoRoute(
            //           path: 'mediaprop/:prgEttyId',
            //           usesPathAsKey: true,
            //           page: CustMgmtCustRoute.page,
            //           maintainState: false),
            //       AutoRoute(
            //           path: 'carddesign/:prgEttyId',
            //           usesPathAsKey: true,
            //           page: CustMgmtCustRoute.page,
            //           maintainState: false),
            //     ]),
          ]),
      AutoRoute(
          path: 'member/:custEttyId',
          usesPathAsKey: true,
          page: CustMgmtMemberLanding.page,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                page: CustMgmtMemberListLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: '',
                      page: CustMgmtMemberList.page,
                      maintainState: false,
                      initial: true)
                ]),
            AutoRoute(
                path: 'detail/:mbrEttyId',
                page: CustMgmtMemberDetailLanding.page,
                usesPathAsKey: true,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'quickinfo',
                      page: CustMgmtMemberQuickInfoLanding.page,
                      initial: true,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustMgmtMemberQuickInfo.page,
                            maintainState: false,
                            initial: true)
                      ]),
                  AutoRoute(
                      path: 'memberinfo',
                      page: CustMgmtMemberInfoLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'membership',
                            page: CustMgmtMemberInfo.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'personal',
                            page: CustMgmtMemberInfoPersonal.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'vehicleinfo',
                            page: CustMgmtMemberInfoVehicle.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'address',
                      page: CustMgmtMemberAddressLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustMgmtMemberAddressList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'adddtl/:addrType/:contactId/:addrId',
                            usesPathAsKey: true,
                            page: CustMgmtMemberAddress.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'contact',
                      page: CustMgmtMemberContactLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustMgmtMemberContactList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'contactdtl/:contactType/:contactId',
                            usesPathAsKey: true,
                            page: CustMgmtMemberContact.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'control',
                      page: CustMgmtMemberCtrlLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'translimt',
                            page: CustMgmtMbrCtrlTxnListLanding.page,
                            maintainState: false,
                            initial: true,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustMgmtMemberCtrlTransList.page,
                                  maintainState: false,
                                  initial: true),
                              AutoRoute(
                                  path: 'translimtsel',
                                  page: CustMgmtMemberCtrlTransSelect.page,
                                  maintainState: false),
                              AutoRoute(
                                path: 'detail/:prgEttyId/:limitId',
                                page: CustMgmtMemberCtrlTrans.page,
                                usesPathAsKey: true,
                                maintainState: false,
                              )
                            ]),
                        AutoRoute(
                            path: 'locaccpt',
                            page: CustMgmtMbrCtrlLocListLanding.page,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustMgmtMemberCtrlLocList.page,
                                  initial: true,
                                  maintainState: false),
                              AutoRoute(
                                  path: 'locaccptsel',
                                  page: CustMgmtMemberCtrlLocListSelect.page,
                                  maintainState: false),
                              AutoRoute(
                                  path: 'detail/:prgEttyId/:accptId',
                                  usesPathAsKey: true,
                                  page: CustMgmtMemberCtrlLoc.page,
                                  maintainState: false)
                            ]),
                        AutoRoute(
                            path: 'prodaccpt',
                            page: CustMgmtMbrCtrlProdListLanding.page,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustMgmtMemberCtrlProdList.page,
                                  maintainState: false),
                              AutoRoute(
                                  path: 'prodaccptsel',
                                  page: CustMgmtMemberCtrlProdSelect.page,
                                  maintainState: false),
                              AutoRoute(
                                path: 'detail/:prgEttyId',
                                maintainState: false,
                                usesPathAsKey: true,
                                page: CustMgmtMemberCtrlProd.page,
                              )
                            ]),
                      ]),
                ]),
          ]),
      AutoRoute(
          path: 'costcen/:custEttyId',
          usesPathAsKey: true,
          page: CustMgmtCostCenter.page,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                page: CustMgmtCostCenterList.page,
                initial: true,
                maintainState: false),
            AutoRoute(
                path: 'profile/:costCtrEttyId',
                usesPathAsKey: true,
                page: CustMgmtCostCentreProfileLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'geninfo',
                      page: CustMgmtCostCentreProfileGenInfo.page,
                      maintainState: false),
                                      AutoRoute(
                          path: 'address',
                          page: CustMgmtCostAddressLanding.page,
                          maintainState: false,
                          children: [
                            AutoRoute(
                                path: '',
                                page: CustMgmtCostAddressList.page,
                                maintainState: false),
                            AutoRoute(
                                path: 'adddtl/:addrType/:contactId/:addrId',
                                usesPathAsKey: true,
                                page: CustMgmtCostAddress.page,
                                maintainState: false),
                          ]),
                      AutoRoute(
                          path: 'contact',
                          page: CustMgmtCostContactLanding.page,
                          maintainState: false,
                          children: [
                            AutoRoute(
                                path: '',
                                page: CustMgmtCostContactList.page,
                                maintainState: false),
                            AutoRoute(
                                path: 'contactdtl/:contactType/:contactId',
                                usesPathAsKey: true,
                                maintainState: false,
                                page: CustMgmtCostContact.page),
                          ]),
                ]),
          ]),
      AutoRoute(
          path: 'cmpy/:custEttyId',
          page: CustMgmtCmpy.page,
          maintainState: false,
          usesPathAsKey: true,
          children: [
            AutoRoute(
                path: 'list',
                page: CustMgmtCmpyListLanding.page,
                maintainState: false,
                initial: true,
                children: [
                  AutoRoute(
                      path: '',
                      page: CustMgmtCompanyList.page,
                      maintainState: false,
                      initial: true)
                ]),
            AutoRoute(
                path: 'detail/:cmpyEttyId',
                page: CustMgmtCustCmpyLanding.page,
                usesPathAsKey: true,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'creval',
                      page: CustMgmtCmpyCtrlCrEvaLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'main',
                            page: CustMgmtCmpyCtrlCrEvaListLanding.page,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustMgmtCmpyCtrlCrEvaList.page,
                                  initial: true),
                              AutoRoute(
                                  path: 'detail/:crscoreId',
                                  page: CustMgmtCmpyCtrlCrEvaDetail.page,
                                  maintainState: false,
                                  usesPathAsKey: true)
                            ])
                      ]),
                  AutoRoute(
                      path: 'secdep',
                      page: CustMgmtCmpySecurityDepLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'list',
                            page: CustMgmtCmpySecurityDepList.page,
                            maintainState: false,
                            initial: true),
                        AutoRoute(
                            path: 'secdepdtl/:depId',
                            usesPathAsKey: true,
                            page: CustMgmtCmpySecurityDep.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'program',
                      page: CustMgmtCmpyProgramLanding.page,
                      maintainState: false,
                      children: [
                        RedirectRoute(path: '', redirectTo: 'list'),
                        AutoRoute(
                          path: 'list',
                          page: CustMgmtCmpyProgramList.page,
                          maintainState: false,
                        ),
                        AutoRoute(
                          path: 'select/:prgEttyId/:accptId',
                          usesPathAsKey: true,
                          page: CustMgmtCmpyProgramSelect.page,
                          maintainState: false,
                        ),
                      ]),
                  AutoRoute(
                      path: 'control',
                      page: CustMgmtCmpyCtrlLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'translimt',
                            page: CustMgmtCmpyCtrlTxnListLanding.page,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustMgmtCmpyCtrlTxnList.page,
                                  maintainState: false),
                              AutoRoute(
                                  path: 'translimtsel',
                                  page: CustMgmtCmpyCtrlTxnSelect.page,
                                  maintainState: false),
                              AutoRoute(
                                path: 'detail/:prgEttyId/:limitId',
                                usesPathAsKey: true,
                                page: CustMgmtCmpyCtrlTxn.page,
                                maintainState: false,
                              )
                            ]),
                        AutoRoute(
                            path: 'locaccpt',
                            page: CustMgmtCmpyCtrlLocListLanding.page,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustMgmtCmpyCtrlLocList.page,
                                  maintainState: false),
                              AutoRoute(
                                  path: 'locaccptsel',
                                  page: CustMgmtCmpyCtrlLocSelect.page,
                                  maintainState: false),
                              AutoRoute(
                                  path: 'detail/:prgEttyId/:accptId',
                                  usesPathAsKey: true,
                                  page: CustMgmtCmpyCtrlLoc.page,
                                  maintainState: false)
                            ])
                      ]),
                  AutoRoute(
                    path: 'profile',
                    page: CustMgmtCmpyProfileLanding.page,
                    maintainState: false,
                    initial: true,
                    children: [
                      AutoRoute(
                          path: 'geninfo',
                          page: CustMgmtCmpyProfileGenInfo.page,
                          maintainState: false,
                          initial: true),
                                         AutoRoute(
                      path: 'director',
                      page: CustMgmtCmpyDirectorLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustMgmtCmpyDirectorList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'directordtl/:indvdId',
                            usesPathAsKey: true,
                            page: CustMgmtCmpyDirector.page,
                            maintainState: false),
                      ]),
                      AutoRoute(
                          path: 'address',
                          page: CustMgmtCmpyAddressLanding.page,
                          maintainState: false,
                          children: [
                            AutoRoute(
                                path: '',
                                page: CustMgmtCmpyAddressList.page,
                                maintainState: false),
                            AutoRoute(
                                path: 'adddtl/:addrType/:contactId/:addrId',
                                usesPathAsKey: true,
                                page: CustMgmtCmpyAddress.page,
                                maintainState: false),
                          ]),
                      AutoRoute(
                          path: 'contact',
                          page: CustMgmtCmpyContactLanding.page,
                          maintainState: false,
                          children: [
                            AutoRoute(
                                path: '',
                                page: CustMgmtCmpyContactList.page,
                                maintainState: false),
                            AutoRoute(
                                path: 'contactdtl/:contactType/:contactId',
                                usesPathAsKey: true,
                                maintainState: false,
                                page: CustMgmtCmpyContact.page),
                          ]),
                    ],
                  ),
                  AutoRoute(
                      path: 'subsidy',
                      page: CustMgmtCmpySubsidyLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'quota',
                            page: CustMgmtCmpySubsidyList.page,
                            maintainState: false,
                            initial: true),
                        AutoRoute(
                          path: 'quotadtl/:quotaId',
                          usesPathAsKey: true,
                          page: CustMgmtCmpySubsidy.page,
                          maintainState: false,
                        ),
                        AutoRoute(
                          path: 'quotadash/:quotaId',
                          usesPathAsKey: true,
                          page: CustMgmtCmpySubsidyDashboardView.page,
                          maintainState: false,
                        )
                      ]),
                ]),
          ]),
      AutoRoute(
          path: 'cust/new', page: CustMgmtNewRoute.page, maintainState: false),
      AutoRoute(
          path: 'custprg/:custEttyId/:prgEttyId/:billingEttyType',
          usesPathAsKey: true,
          page: CustMgmtCustPrgDetailRoute.page,
          maintainState: false,
          children: [
            // AutoRoute(path: 'detail/:prgId', page: CustMgmtProgramDtlLanding.page,
            AutoRoute(
                path: ':accptId/billing',
                page: CustMgmtBillingEntityLanding.page,
                maintainState: false,
                initial: true,
                children: [
                  AutoRoute(
                      path: 'billingentity',
                      page: CustMgmtBillingEntity.page,
                      maintainState: false),
                ]),
            AutoRoute(
                path: 'fees',
                page: CustMgmtProgramFeeLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'media',
                      page: CustMgmtProgramFeeMediaLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            maintainState: false,
                            page: CustMgmtProgramFeeMediaList.page),
                        AutoRoute(
                            path: 'mediadtl/:mediaType',
                            usesPathAsKey: true,
                            maintainState: false,
                            page: CustMgmtProgramFeeMedia.page),
                      ]),
                  AutoRoute(
                      path: 'trans',
                      page: CustMgmtProgramFeeTransLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'list',
                            maintainState: false,
                            page: CustMgmtProgramFeeTransList.page,
                            initial: true),
                        AutoRoute(
                            path: 'dtl/:feeId',
                            usesPathAsKey: true,
                            page: CustMgmtProgramFeeTrans.page,
                            maintainState: false)
                      ]),
                ]),
            AutoRoute(
                path: 'discandreb',
                page: CustMgmtProgramDisRebLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'list',
                      maintainState: false,
                      page: CustMgmtProgramDisRebPlanList.page,
                      initial: true),
                  AutoRoute(
                      path: 'dtl/:txnCtgry/:mediaType/:rebateId',
                      usesPathAsKey: true,
                      maintainState: false,
                      page: CustMgmtProgramDisRebPlan.page)
                ])
          ]),
      AutoRoute(
          path: 'cust/:custEttyId',
          usesPathAsKey: true,
          page: CustMgmtCustRoute.page,
          maintainState: false,
          children: [
            AutoRoute(
              path: 'dashboard',
              page: CustMgmtDashBoard.page,
              maintainState: false,
              initial: true,
            ),
            AutoRoute(
                path: 'quickinfo',
                page: CustMgmtQuickInfoLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'overview',
                      page: CustMgmtQuickInfoOverView.page,
                      maintainState: false,
                      initial: true),
                  AutoRoute(
                      path: 'checklist',
                      page: CustMgmtQuickInfoCheckList.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'apprvhist',
                      page: CustMgmtQuickInfoApprvHist.page,
                      maintainState: false),
                ]),
            AutoRoute(
                path: 'profile',
                page: CustMgmtProfileLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'geninfo',
                      page: CustMgmtProfileGenInfo.page,
                      maintainState: false,
                      initial: true),
                       AutoRoute(
                      path: 'director',
                      page: CustMgmtDirectorLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustMgmtDirectorList.page,
                            maintainState: false),
                                      AutoRoute(
                            path: 'directordtl/:indvdId',
                            usesPathAsKey: true,
                            page: CustMgmtDirector.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'address',
                      page: CustMgmtAddressLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustMgmtAddressList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'adddtl/:addrType/:contactId/:addrId',
                            usesPathAsKey: true,
                            page: CustMgmtAddress.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'contact',
                      page: CustMgmtContactLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustMgmtContactList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'contactdtl/:contactType/:contactId',
                            usesPathAsKey: true,
                            maintainState: false,
                            page: CustMgmtContact.page),
                      ]),
                ]),
            AutoRoute(
                path: 'program',
                page: CustMgmtProgramLanding.page,
                maintainState: false,
                children: [
                  RedirectRoute(path: '', redirectTo: 'list'),
                  AutoRoute(
                    path: 'list',
                    page: CustMgmtProgramList.page,
                    maintainState: false,
                  ),
                  AutoRoute(
                    path: 'select/:prgEttyId',
                    usesPathAsKey: true,
                    page: CustMgmtProgramSelect.page,
                    maintainState: false,
                  ),
                ]),
            AutoRoute(
                path: 'events',
                page: CustMgmtEventLanding.page,
                maintainState: false),
                                  AutoRoute(
                      path: 'subsidy',
                      page: CustMgmtSubsidyLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'quota',
                            page: CustMgmtSubsidyList.page,
                            maintainState: false,
                            initial: true),
                        AutoRoute(
                          path: 'quotadtl/:quotaId',
                          usesPathAsKey: true,
                          page: CustMgmtSubsidy.page,
                          maintainState: false,
                        ),
                        AutoRoute(
                          path: 'quotadash/:quotaId',
                          usesPathAsKey: true,
                          page: CustMgmtSubsidyDashboardView.page,
                          maintainState: false,
                        )
                      ]),
            AutoRoute(
                path: 'docs',
                page: CustMgmtDocLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'appl',
                      page: CustMgmtDocAppl.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'invs',
                      page: CustMgmtDocInvs.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'comm',
                      page: CustMgmtDocComm.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'bank',
                      page: CustMgmtDocBank.page,
                      maintainState: false),
                ]),
          ])
    ]);
