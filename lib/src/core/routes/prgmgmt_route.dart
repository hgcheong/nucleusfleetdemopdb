import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final prgmgmtTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/prgmgmt",
    page: PrgMgmtContainer.page,
    children: [
      AutoRoute(
          path: 'setup/:prgEttyId',
          page: PrgMgmtSetupRoute.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            AutoRoute(
              path: 'pgeninfo',
              page: PrgMgmtSetupGenInfo.page,
              usesPathAsKey: true,
              maintainState: false,
            ),
            AutoRoute(
              path: 'ponlineblock',
              page: PrgMgmtSetupOnlineBlock.page,
              maintainState: false,
            ),
            AutoRoute(
              path: 'ponlinelist',
              page: PrgMgmtSetupOnlineList.page,
              maintainState: false,
            ),
            AutoRoute(
              path: 'ponline',
              page: PrgMgmtSetupOnline.page,
              maintainState: false,
            ),
          ]),
      AutoRoute(
          path: 'custsetup/:prgEttyId',
          page: PrgMgmtCustSetupRoute.page,
          usesPathAsKey: true,
          maintainState: false,
          children: [
            RedirectRoute(
              path: '',
              redirectTo: "/pppbflanding",
            ),
            AutoRoute(
                path: 'pppbflanding',
                page: PrgCustPbfLanding.page,
                maintainState: false,
                children: [
                  RedirectRoute(path: '', redirectTo: "/pppbfbilllist"),
                  AutoRoute(
                      path: 'pppbfbilllist',
                      page: PrgCustPbfBillingLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: PrgCustPbfBillingList.page,
                            maintainState: false,
                            initial: true),
                        AutoRoute(
                            path: 'pppbfbill/:billingId',
                            page: PrgCustPbfBilling.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'pppbfdeliqsts',
                      page: PrgCustPbfDelinqSts.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'pppbffinlpc',
                      page: PrgCustPbfFinLpc.page,
                      maintainState: false),
                  AutoRoute(
                      path: 'pppbfpaypty',
                      page: PrgCustPbfPayPriority.page,
                      maintainState: false),
                ]),
            AutoRoute(
                path: 'pppcrelanding',
                page: PrgCustPrePaidLanding.page,
                children: [
                  AutoRoute(
                      path: 'ppcre',
                      page: PrgCustPrePaidCredit.page,
                      maintainState: false),
                ]),
            AutoRoute(
                path: 'postpaidoilanding',
                page: PrgCustPOILanding.page,
                children: [
                  AutoRoute(
                      path: 'pppoibilllist',
                      page: PrgCustPOIBillingLanding.page,
                      children: [
                        AutoRoute(
                          path: '',
                          page: PrgCustPOIBillingList.page,
                          maintainState: false,
                        ),
                        AutoRoute(
                            path: 'pppoibill/:billingId',
                            usesPathAsKey: true,
                            page: PrgCustPOIBilling.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'pppoifinlpc',
                      page: PrgCustPOIFinLpc.page,
                      maintainState: false),
                ]),
            AutoRoute(
                path: 'paylanding',
                page: PrgCustPymtLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'paycustbank',
                      page: PrgCustPymtBank.page,
                      maintainState: false),
                ]),
            AutoRoute(
                path: 'pcmlanding',
                page: PrgCustMediaLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'pcmmtypelist',
                      page: PrgCustMediaMTypeLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: PrgCustMediaMTypeList.page,
                            initial: true,
                            maintainState: false),
                        AutoRoute(
                            path: 'pcmmtype/:mediaTypeId',
                            usesPathAsKey: true,
                            page: PrgCustMediaMType.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                    path: 'pcmnumrangeadd',
                    page: PrgCustMediaNumRangeAdd.page,
                    maintainState: false,
                  ),
                  AutoRoute(
                    path: 'pcmnumrange',
                    page: PrgCustMediaNumRange.page,
                    maintainState: false,
                  ),
                ]),
            AutoRoute(
                path: 'pcfeelanding',
                page: PrgCustFeeLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'pcfeemlist',
                      page: PrgCustFeeMediaLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: PrgCustFeeMediaList.page,
                            maintainState: false),
                        AutoRoute(
                            path: 'pcfeem/:mediaType',
                            usesPathAsKey: true,
                            page: PrgCustFeeMedia.page,
                            maintainState: false),
                      ]),
                  AutoRoute(
                      path: 'pcfeemtranslist',
                      page: PrgCustFeeTransLanding.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: '',
                            page: PrgCustFeeTransList.page,
                            initial: true,
                            maintainState: false),
                        AutoRoute(
                            path: 'pcfeemtrans/:feeId',
                            usesPathAsKey: true,
                            page: PrgCustFeeTrans.page,
                            maintainState: false),
                      ]),
                ]),
            AutoRoute(
                path: 'pcdislanding',
                page: PrgCustDiscRebLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'pcdisplanaddloc',
                      maintainState: false,
                      page: PrgCustDiscRebPlanAddLoc.page),
                  AutoRoute(
                      path: '',
                      maintainState: false,
                      page: PrgCustDiscRebPlanListLanding.page,
                      initial: true,
                      children: [
                        AutoRoute(
                            path: 'pcdisplanlist',
                            maintainState: false,
                            page: PrgCustDiscRebPlanList.page)
                      ]),
                  AutoRoute(
                      path: 'pcdisplan/:rebateId',
                      maintainState: false,
                      usesPathAsKey: true,
                      page: PrgCustDiscRebPlan.page),
                ]),
            AutoRoute(
                path: 'pctrllanding',
                maintainState: false,
                page: PrgCustCtrlLanding.page,
                children: [
                  AutoRoute(
                      path: 'pcctrltranslimitlist',
                      maintainState: false,
                      page: PrgCustCtrlTransLimitListLanding.page,
                      initial: true,
                      children: [
                        AutoRoute(
                            path: '',
                            maintainState: false,
                            page: PrgCustCtrlTransLimitList.page,
                            initial: true),
                      ]),
                  AutoRoute(
                      path: 'pcctrltranslimit/:limitId',
                      usesPathAsKey: true,
                      maintainState: false,
                      page: PrgCustCtrlTransLimitLanding.page,
                      children: [
                        AutoRoute(
                            path: '',
                            maintainState: false,
                            page: PrgCustCtrlTransLimit.page,
                            initial: true),
                      ]),
                ])
          ]),
      AutoRoute(
          path: 'mchtsetup/:prgEttyId',
          usesPathAsKey: true,
          page: PrgMgmtMchtSetupRoute.page,
          maintainState: false,
          children: [
            AutoRoute(
                path: 'billingl',
                page: PrgMgmtMchtBillLanding.page,
                maintainState: false,
                initial: true,
                children: [
                  AutoRoute(
                      path: 'pmbillingautop',
                      page: PrgMgmtMchtBillAutoPay.page,
                      initial: true),
                ]),
            AutoRoute(
                path: 'tranplan',
                page: PrgMgmtMchtTpLanding.page,
                maintainState: false,
                children: [
                  AutoRoute(
                      path: 'tp',
                      page: PrgMgmtMchtTpTransLanding.page,
                      initial: true,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'list',
                            page: PrgMgmtMchtTpTransList.page,
                            initial: true,
                            maintainState: false),
                        AutoRoute(
                            path: 'dtl/:poe/:txnMsgCd/:msgTypePlanId',
                            usesPathAsKey: true,
                            page: PrgMgmtMchtTpTrans.page,
                            maintainState: false),
                      ]),
                ]),
            AutoRoute(
                path: 'feesl',
                page: PrgMgmtMchtFeesLanding.page,
                maintainState: false,
                children: [
                  // RedirectRoute(path: '', redirectTo: "/pmfeetadlist"),
                  AutoRoute(
                      path: '',
                      page: PrgMgmtMchtFeesTadLanding.page,
                      maintainState: false,
                      initial: true,
                      children: [
                        AutoRoute(
                          path: 'pmfeetadlist',
                          page: PrgMgmtMchtFeesTadList.page,
                          maintainState: false,
                          initial: true,
                        ),
                        AutoRoute(
                            path: 'pmfeetad/:feeId',
                            usesPathAsKey: true,
                            page: PrgMgmtMchtFeesTad.page,
                            maintainState: false),
                      ]),

                  AutoRoute(
                      path: 'pmfeetransl',
                      page: PrgMgmtMchtTransl.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                            path: 'pmfeetranslist',
                            page: PrgMgmtMchtFeesTransList.page,
                            initial: true,
                            maintainState: false),
                        AutoRoute(
                            path: 'pmfeetrans/:feeId',
                            usesPathAsKey: true,
                            page: PrgMgmtMchtFeesTrans.page,
                            maintainState: false),
                      ]),
                ])
          ]),
      AutoRoute(path: 'main', page: PrgMgmtListRoute.page, maintainState: false)
    ]);
