import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final custenrollTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
     duration: Duration(milliseconds: defaultTransTime),
    path: "/custenroll",
    page: CustEnrollContainer.page,
    maintainState: false,
    children: [
    AutoRoute(
                      path: 'subsidy2',
                      page: CustEnrollSubsidy2Landing.page,
                      maintainState: false,
                      children: [
                        
                        AutoRoute(
                            path: 'list',
                            page: CustEnrollSubsidy2List.page,
                            maintainState: false,
                            initial: true),
                            AutoRoute(path:'cbp/:chargeType/:prgEttyId/:cbId',
                            page:CustEnrollSubsidy2CustLanding.page,children:[
AutoRoute(

                            path: 'cbplist',
                            page: CustEnrollSubsidy2CustList.page,
                            initial:true,
                            maintainState: false),
                            AutoRoute(
                          path: 'cbpdtl/:cbPrgEttyId/:ettyId/:cbQuoId',
                          usesPathAsKey: true,
                          page: CustEnrollSubsidy2.page,
                          maintainState: false,
                        ),
                            ]),]),
      AutoRoute(
          path: 'main', page: CustEnrollListRoute.page, meta:const {"SetupId":6000}, maintainState: false),
      // AutoRoute(
      //   path: 'pending/:custEttyId',
      //   page: CustEnrollNewRoute.page,meta:const {"SetupId":6001},
      //   maintainState: false,
      //   usesPathAsKey: true,
      // ),
      AutoRoute(
          path: 'billingAccount/:custEttyId',
          page: CustEnrollBillingLanding.page,meta:const {"SetupId":6002},
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                maintainState: false,
                page: CustEnrollBillingListLanding.page,meta:const {"SetupId":6003},
                initial: true,
                children: [
                  AutoRoute(path: '', page: CustEnrollBillingList.page,meta:const {"SetupId":6004},)
                ]),
            AutoRoute(
                path: 'detail/:acctId',
                page: CustEnrollBillingDetailLanding.page,meta:const {"SetupId":6005},
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'accsetting/:acctType',
                      usesPathAsKey: true,
                      maintainState: false,
                      page: CustEnrollBillingAccSettingLanding.page,meta:const {"SetupId":6006},
                      children: [
                        AutoRoute(
                            path: 'prepaid',
                            maintainState: false,                           
                            page: CustEnrollBillingAccPrePaid.page,meta: const {"SetupId":6007},),
                        AutoRoute(
                            path: 'postpaid',
                            maintainState: false,
                            initial: true,
                            page: CustEnrollBillingAccPostPaid.page,meta: const {"SetupId":6008},),
                        AutoRoute(
                            path: 'autopay',
                            maintainState: false,
                            page: CustEnrollBillingAutoPay.page,meta: const {"SetupId":6009},),
                               AutoRoute(
                            path: 'pukal',
                            maintainState: false,
                            page: CustEnrollPukal.page,meta: const {"SetupId":6009},),
                            //CustEnrollPukal
                      ]),
                  // AutoRoute(path: 'autopay', page: CustEnrollBillingAutoPayLanding.page, children: [
                  //   AutoRoute(path: '', page: CustEnrollBillingAutoPay.page),
                  // ]),
                ])
          ]),
      AutoRoute(
          path: 'media/:custEttyId',
          page: CustEnrollMediaLanding.page,meta: const {"SetupId":6010},
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                page: CustEnrollMediaListLanding.page,meta: const {"SetupId":6010},
                maintainState: false,
                children: [
                  AutoRoute(
                      path: '',
                      page: CustEnrollMediaList.page,meta: const {"SetupId":6011},
                      maintainState: false,
                      initial: true)
                ]),
            AutoRoute(
                path: 'selmedia',
                page: CustEnrollMediaSelectTab.page,meta: const {"SetupId":6012},
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'detail',
                      page: CustEnrollMediaSelect.page,meta: const {"SetupId":6013},
                      maintainState: false)
                ]),
            AutoRoute(
                path: 'selsub',
                page: CustEnrollMediaSubSelectTab.page,meta: const {"SetupId":6014},
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'detail',
                      page: CustEnrollMediaSubSelect.page,meta: const {"SetupId":6015},
                      maintainState: false)
                ]),
            AutoRoute(
                path: 'detail/:mediaCtgry/:prgEttyId/:mbrEttyId/:mediaEttyId',
                usesPathAsKey: true,
                page: CustEnrollMediaDetailanding.page,meta: const {"SetupId":6016},
                maintainState: false,
                children: [
                  AutoRoute(
                    path: 'prop',
                    page: CustEnrollMediaProperties.page,meta: const {"SetupId":6017},
                    maintainState: false,
                  ),
                  AutoRoute(
                      path: 'design',
                      page: CustEnrollMediaDesign.page,meta: const {"SetupId":6018},
                      maintainState: false),
                ]),
            // AutoRoute(
            //     path: 'mediaholder',
            //     page: CustEnrollCustRoute.page,meta: const {"SetupId":6019},
            //     maintainState: false),
            // AutoRoute(
            //     path: 'subscription',
            //     page: CustEnrollCustRoute.page,meta: const {"SetupId":6020},
            //     maintainState: false,
            //     children: [
            //       AutoRoute(
            //           path: 'mediaprop/:prgEttyId',
            //           usesPathAsKey: true,
            //           page: CustEnrollCustRoute.page,meta: const {"SetupId":6021},
            //           maintainState: false),
            //       AutoRoute(
            //           path: 'carddesign/:prgEttyId',
            //           usesPathAsKey: true,
            //           page: CustEnrollCustRoute.page,meta: const {"SetupId":6022},
            //           maintainState: false),
            //     ]),
          ]),
      AutoRoute(
          path: 'member/:custEttyId',
          usesPathAsKey: true,
          page: CustEnrollMemberLanding.page,meta: const {"SetupId":6023},
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                page: CustEnrollMemberListLanding.page,meta: const {"SetupId":6024},
                maintainState: false,
                children: [
                  AutoRoute(
                      path: '',
                      page: CustEnrollMemberList.page,meta: const {"SetupId":6025},
                      maintainState: false,
                      initial: true)
                ]),
            AutoRoute(
                path: 'detail/:mbrEttyId',
                page: CustEnrollMemberDetailLanding.page,meta: const {"SetupId":6026},
                usesPathAsKey: true,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'memberinfo',
                      page: CustEnrollMemberInfoLanding.page,meta: const {"SetupId":6027},
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'membership',
                            page: CustEnrollMemberInfo.page,meta: const {"SetupId":6028},
                            maintainState: false),
                        AutoRoute(
                            path: 'personal',
                            page: CustEnrollMemberInfoPersonal.page,meta: const {"SetupId":6029},
                            maintainState: false),
                        AutoRoute(
                            path: 'vehicleinfo',
                            page: CustEnrollMemberInfoVehicle.page,meta: const {"SetupId":6030},
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'address',
                      page: CustEnrollMemberAddressLanding.page,meta: const {"SetupId":6031},
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustEnrollMemberAddressList.page,meta: const {"SetupId":6032},
                            maintainState: false),
                        AutoRoute(
                            path: 'adddtl/:addrType/:contactId/:addrId',
                            usesPathAsKey: true,
                            page: CustEnrollMemberAddress.page,meta: const {"SetupId":6033},
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'contact',
                      page: CustEnrollMemberContactLanding.page,meta: const {"SetupId":6034},
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustEnrollMemberContactList.page,meta: const {"SetupId":6035},
                            maintainState: false),
                        AutoRoute(
                            path: 'contactdtl/:contactType/:contactId',
                            usesPathAsKey: true,
                            page: CustEnrollMemberContact.page,meta: const {"SetupId":6036},
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'control',
                      page: CustEnrollMemberCtrlLanding.page,meta: const {"SetupId":6037},
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'translimt',
                            page: CustEnrollMbrCtrlTxnListLanding.page,meta: const {"SetupId":6038},
                            maintainState: false,
                            initial: true,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustEnrollMemberCtrlTransList.page,meta: const {"SetupId":6039},
                                  maintainState: false,
                                  initial: true),
                              AutoRoute(
                                  path: 'translimtsel',
                                  page: CustEnrollMemberCtrlTransSelect.page,meta: const {"SetupId":6040},
                                  maintainState: false),
                              AutoRoute(
                                path: 'detail/:prgEttyId/:limitId',
                                page: CustEnrollMemberCtrlTrans.page,meta: const {"SetupId":6041},
                                usesPathAsKey: true,
                                maintainState: false,
                              )
                            ]),
                        AutoRoute(
                            path: 'locaccpt',
                            page: CustEnrollMbrCtrlLocListLanding.page,meta: const {"SetupId":6042},
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustEnrollMemberCtrlLocList.page,meta: const {"SetupId":6043},
                                  initial: true,
                                  maintainState: false),
                              AutoRoute(
                                  path: 'locaccptsel',
                                  page: CustEnrollMemberCtrlLocListSelect.page,meta: const {"SetupId":6044},
                                  maintainState: false),
                              AutoRoute(
                                  path: 'detail/:prgEttyId/:accptId',
                                  usesPathAsKey: true,
                                  page: CustEnrollMemberCtrlLoc.page,meta: const {"SetupId":6045},
                                  maintainState: false)
                            ]),
                        AutoRoute(
                            path: 'prodaccpt',
                            page: CustEnrollMbrCtrlProdListLanding.page,meta: const {"SetupId":6046},
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustEnrollMemberCtrlProdList.page,meta: const {"SetupId":6047},
                                  maintainState: false),
                              AutoRoute(
                                  path: 'prodaccptsel',
                                  page: CustEnrollMemberCtrlProdSelect.page,meta: const {"SetupId":6048},
                                  maintainState: false),
                              AutoRoute(
                                path: 'detail/:prgEttyId',
                                maintainState: false,
                                usesPathAsKey: true,
                                page: CustEnrollMemberCtrlProd.page,meta: const {"SetupId":6049},
                              )
                            ]),
                      ]),
                ]),
          ]),
      AutoRoute(
          path: 'costcen/:custEttyId',
          usesPathAsKey: true,
          page: CustEnrollCostCenter.page,meta: const {"SetupId":6050},
          maintainState: false,
          children: [
            AutoRoute(
                path: 'list',
                page: CustEnrollCostCenterList.page,meta: const {"SetupId":6051},
                initial: true,
                maintainState: false),
            AutoRoute(
                path: 'profile/:costCtrEttyId',
                usesPathAsKey: true,
                page: CustEnrollCostCentreProfileLanding.page,meta: const {"SetupId":6052},
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'geninfo',
                      page: CustEnrollCostCentreProfileGenInfo.page,meta: const {"SetupId":6053},
                      maintainState: false),
                                      AutoRoute(
                          path: 'address',
                          page: CustEnrollCostAddressLanding.page,
                          maintainState: false,
                          children: [
                            AutoRoute(
                                path: '',
                                page: CustEnrollCostAddressList.page,
                                maintainState: false),
                            AutoRoute(
                                path: 'adddtl/:addrType/:contactId/:addrId',
                                usesPathAsKey: true,
                                page: CustEnrollCostAddress.page,
                                maintainState: false),
                          ]),
                      AutoRoute(
                          path: 'contact',
                          page: CustEnrollCostContactLanding.page,
                          maintainState: false,
                          children: [
                            AutoRoute(
                                path: '',
                                page: CustEnrollCostContactList.page,
                                maintainState: false),
                            AutoRoute(
                                path: 'contactdtl/:contactType/:contactId',
                                usesPathAsKey: true,
                                maintainState: false,
                                page: CustEnrollCostContact.page),
                          ]),
                ]),
          ]),
      AutoRoute(
          path: 'cmpy/:custEttyId',
          page: CustEnrollCmpy.page,meta: const {"SetupId":6054},
          maintainState: false,
          usesPathAsKey: true,
          children: [
            AutoRoute(
                path: 'list',
                page: CustEnrollCmpyListLanding.page,meta: const {"SetupId":6055},
                maintainState: false,
                initial: true,
                children: [
                  AutoRoute(
                      path: '',
                      page: CustEnrollCompanyList.page,meta: const {"SetupId":6056},
                      maintainState: false,
                      initial: true)
                ]),
            AutoRoute(
                path: 'detail/:cmpyEttyId',
                page: CustEnrollCustCmpyLanding.page,meta: const {"SetupId":6057},
                usesPathAsKey: true,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'creval',
                      page: CustEnrollCmpyCtrlCrEvaLanding.page,meta: const {"SetupId":6058},
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'main',
                            page: CustEnrollCmpyCtrlCrEvaListLanding.page,meta: const {"SetupId":6059},
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustEnrollCmpyCtrlCrEvaList.page,meta: const {"SetupId":6060},
                                  initial: true),
                              AutoRoute(
                                  path: 'detail/:crscoreId',
                                  page: CustEnrollCmpyCtrlCrEvaDetail.page,meta: const {"SetupId":6061},
                                  maintainState: false,
                                  usesPathAsKey: true)
                            ]),
                      ]),
                  AutoRoute(
                      path: 'secdep',
                      page: CustEnrollCmpySecurityDepLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'list',
                            page: CustEnrollCmpySecurityDepList.page,
                            maintainState: false,
                            initial: true),
                        AutoRoute(
                            path: 'secdepdtl/:depId',
                            usesPathAsKey: true,
                            page: CustEnrollCmpySecurityDep.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'program',
                      page: CustEnrollCmpyProgramLanding.page,
                      maintainState: false,
                      children: [
                        RedirectRoute(path: '', redirectTo: 'list'),
                        AutoRoute(
                          path: 'list',
                          page: CustEnrollCmpyProgramList.page,
                          maintainState: false,
                        ),
                        AutoRoute(
                          path: 'select/:prgEttyId/:accptId',
                          usesPathAsKey: true,
                          page: CustEnrollCmpyProgramSelect.page,
                          maintainState: false,
                        ),
                      ]),
                  AutoRoute(
                      path: 'control',
                      page: CustEnrollCmpyCtrlLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'translimt',
                            page: CustEnrollCmpyCtrlTxnListLanding.page,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustEnrollCmpyCtrlTxnList.page,
                                  maintainState: false),
                              AutoRoute(
                                  path: 'translimtsel',
                                  page: CustEnrollCmpyCtrlTxnSelect.page,
                                  maintainState: false),
                              AutoRoute(
                                path: 'detail/:prgEttyId/:limitId',
                                usesPathAsKey: true,
                                page: CustEnrollCmpyCtrlTxn.page,
                                maintainState: false,
                              )
                            ]),
                        AutoRoute(
                            path: 'locaccpt',
                            page: CustEnrollCmpyCtrlLocListLanding.page,
                            maintainState: false,
                            children: [
                              AutoRoute(
                                  path: '',
                                  page: CustEnrollCmpyCtrlLocList.page,
                                  maintainState: false),
                              AutoRoute(
                                  path: 'locaccptsel',
                                  page: CustEnrollCmpyCtrlLocSelect.page,
                                  maintainState: false),
                              AutoRoute(
                                  path: 'detail/:prgEttyId/:accptId',
                                  usesPathAsKey: true,
                                  page: CustEnrollCmpyCtrlLoc.page,
                                  maintainState: false)
                            ])
                      ]),
                  AutoRoute(
                    path: 'profile',
                    page: CustEnrollCmpyProfileLanding.page,
                    maintainState: false,
                    initial: true,
                    children: [
                      AutoRoute(
                          path: 'geninfo',
                          page: CustEnrollCmpyProfileGenInfo.page,
                          maintainState: false,
                          initial: true),
                                  AutoRoute(
                      path: 'director',
                      page: CustEnrollCmpyDirectorLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustEnrollCmpyDirectorList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'directordtl/:indvdId',
                            usesPathAsKey: true,
                            page: CustEnrollCmpyDirector.page,
                            maintainState: false),
                      ]),
                      AutoRoute(
                          path: 'address',
                          page: CustEnrollCmpyAddressLanding.page,
                          maintainState: false,
                          children: [
                            AutoRoute(
                                path: '',
                                page: CustEnrollCmpyAddressList.page,
                                maintainState: false),
                            AutoRoute(
                                path: 'adddtl/:addrType/:contactId/:addrId',
                                usesPathAsKey: true,
                                page: CustEnrollCmpyAddress.page,
                                maintainState: false),
                          ]),
                      AutoRoute(
                          path: 'contact',
                          page: CustEnrollCmpyContactLanding.page,
                          maintainState: false,
                          children: [
                            AutoRoute(
                                path: '',
                                page: CustEnrollCmpyContactList.page,
                                maintainState: false),
                            AutoRoute(
                                path: 'contactdtl/:contactType/:contactId',
                                usesPathAsKey: true,
                                maintainState: false,
                                page: CustEnrollCmpyContact.page),
                          ]),
                    ],
                  ),
                  AutoRoute(
                      path: 'subsidy',
                      page: CustEnrollCmpySubsidyLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'quota',
                            page: CustEnrollCmpySubsidyList.page,
                            maintainState: false,
                            initial: true),
                        AutoRoute(
                          path: 'quotadtl/:quoId',
                          usesPathAsKey: true,
                          page: CustEnrollCmpySubsidy.page,
                          maintainState: false,
                        )
                      ]),
                ]),
          ]),
      AutoRoute(
          path: 'cust/new',
          page: CustEnrollNewRoute.page,
          maintainState: false),
      AutoRoute(
          path: 'custprg/:custEttyId/:prgEttyId/:billingEttyType',
          usesPathAsKey: true,
          page: CustEnrollCustPrgDetailRoute.page,
          maintainState: false,
          children: [
            // AutoRoute(path: 'detail/:prgId', page: CustEnrollProgramDtlLanding.page,
            AutoRoute(
                path: 'billing',
                page: CustEnrollBillingEntityLanding.page,
                maintainState: false,
                initial: true,
                children: [
                  AutoRoute(
                      path: 'billingentity',
                      page: CustEnrollBillingEntity.page,
                      maintainState: false),
                ]),
            AutoRoute(
                path: 'fees',
                page: CustEnrollProgramFeeLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'media',
                      page: CustEnrollProgramFeeMediaLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            maintainState: false,
                            page: CustEnrollProgramFeeMediaList.page),
                        AutoRoute(
                            path: 'mediadtl/:mediaType',
                            usesPathAsKey: true,
                            maintainState: false,
                            page: CustEnrollProgramFeeMedia.page),
                      ]),
                  AutoRoute(
                      path: 'trans',
                      page: CustEnrollProgramFeeTransLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'list',
                            maintainState: false,
                            page: CustEnrollProgramFeeTransList.page,
                            initial: true),
                        AutoRoute(
                            path: 'dtl/:feeId',
                            usesPathAsKey: true,
                            page: CustEnrollProgramFeeTrans.page,
                            maintainState: false)
                      ]),
                ]),
            AutoRoute(
                path: 'discandreb',
                page: CustEnrollProgramDisRebLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'list',
                      maintainState: false,
                      page: CustEnrollProgramDisRebPlanList.page,
                      initial: true),
                  AutoRoute(
                      path: 'dtl/:txnCtgry/:mediaType/:rebateId',
                      usesPathAsKey: true,
                      maintainState: false,
                      page: CustEnrollProgramDisRebPlan.page)
                ])
          ]),
      AutoRoute(
          path: 'cust/:custEttyId',
          usesPathAsKey: true,
          page: CustEnrollCustRoute.page,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'quickinfo',
                page: CustEnrollQuickInfoLanding.page,
                maintainState: false,
                initial: true,
                children: [
                  AutoRoute(
                      path: 'overview',
                      page: CustEnrollQuickInfoOverView.page,
                      maintainState: false,
                      initial: true),
                  AutoRoute(
                      path: 'checklist',
                      page: CustEnrollQuickInfoCheckList.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'apprvhist',
                      page: CustEnrollQuickInfoApprvHist.page,
                      maintainState: false),
                ]),
            AutoRoute(
                path: 'profile',
                page: CustEnrollProfileLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'geninfo',
                      page: CustEnrollProfileGenInfo.page,
                      maintainState: false,
                      initial: true),
                  AutoRoute(
                      path: 'director',
                      page: CustEnrollDirectorLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustEnrollDirectorList.page,
                            maintainState: false),
                                      AutoRoute(
                            path: 'directordtl/:indvdId',
                            usesPathAsKey: true,
                            page: CustEnrollDirector.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'address',
                      page: CustEnrollAddressLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustEnrollAddressList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'adddtl/:addrType/:contactId/:addrId',
                            usesPathAsKey: true,
                            page: CustEnrollAddress.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'contact',
                      page: CustEnrollContactLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: CustEnrollContactList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'contactdtl/:contactType/:contactId',
                            usesPathAsKey: true,
                            maintainState: false,
                            page: CustEnrollContact.page),
                      ]),
                ]),
            AutoRoute(
                path: 'criskctrl',
                page: CustEnrollCrditRiskLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'creditrisksettting',
                      maintainState: false,
                      page: CustEnrollRiskSetting.page),
                  // AutoRoute(path: 'secdep', page: CustEnrollSecurityDepLanding.page, maintainState: false, children: [
                  //   AutoRoute(path: '', page: CustEnrollSecurityDepList.page, maintainState: false),
                  //   AutoRoute(path: 'secdepdtl/:depId', usesPathAsKey: true, page: CustEnrollSecurityDep.page, maintainState: false),
                  // ]),
                ]),
            AutoRoute(
                path: 'program',
                page: CustEnrollProgramLanding.page,
                maintainState: false,
                children: [
                  RedirectRoute(path: '', redirectTo: 'list'),
                  AutoRoute(
                    path: 'list',
                    page: CustEnrollProgramList.page,
                    maintainState: false,
                  ),
                  AutoRoute(
                    path: 'select/:prgEttyId',
                    usesPathAsKey: true,
                    page: CustEnrolProgramSelect.page,
                    maintainState: false,
                  ),
                ]),
            AutoRoute(
                path: 'events',
                page: CustEnrlEventLanding.page,
                maintainState: false),
              AutoRoute(
                      path: 'subsidy',
                      page: CustEnrollSubsidyLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'quota',
                            page: CustEnrollSubsidyList.page,
                            maintainState: false,
                            initial: true),
                        AutoRoute(
                          path: 'quotadtl/:quoId',
                          usesPathAsKey: true,
                          page: CustEnrollSubsidy.page,
                          maintainState: false,
                        )
                      ]),
            AutoRoute(
                path: 'docs',
                page: CustEnrollDocLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'appl',
                      page: CustEnrollDocAppl.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'invs',
                      page: CustEnrollDocInvs.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'comm',
                      page: CustEnrollDocComm.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'bank',
                      page: CustEnrollDocBank.page,
                      maintainState: false),
                ]),
          ])
    ]);
