import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.gr.dart';

final systemconfigTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/systemconfig",
    page: SystemConfigContainer.page,
    children: [
      AutoRoute(path:'site', page: SystemConfigSiteLanding.page, children:[
        AutoRoute(path:'list', page:SystemConfigSiteList.page,initial:true, maintainState: false),
        AutoRoute(path:'dtl/:siteId', page:SystemConfigSite.page)
      ]),
        AutoRoute(path:'logreq', page: SystemConfigLogReqSpLanding.page, children:[
        AutoRoute(path:'list', page:SystemConfigLogReqSpList.page,initial:true, maintainState: false),
        AutoRoute(path:'dtl/:Id', page:SystemConfigLogReqSp.page)
      ]),
      AutoRoute(
          path: 'txnschema',
          page: SystemConfigTxnSchemaList.page,
          children: [
            AutoRoute(path: 'txnschemadtl', page: SystemConfigTxnSchema.page),
            AutoRoute(path: 'txntestrun', page: SystemConfigTxnSchemaRun.page),
            AutoRoute(
                path: 'txnsetting',
                page: SystemConfigTxnSchemaSetting.page,
                children: [
                  AutoRoute(
                      path: 'newtiersetting',
                      page: SystemConfigTxnSchemaSettingNew.page),
                ]),
          ]),
      AutoRoute(path: 'txncode', page: SystemConfigTxnCodeList.page, children: [
        AutoRoute(path: 'txncodedtl', page: SystemConfigTxnCode.page),
      ]),
      AutoRoute(path: 'txnplan', page: SystemConfigTxnPlanList.page, children: [
        AutoRoute(
            path: 'txnplandtl',
            page: SystemConfigTxnPlan.page,
            children: [
              AutoRoute(
                  path: 'txnbillingentty',
                  page: SystemConfigTxnPlanBillingEntity.page),
              AutoRoute(
                  path: 'txncode',
                  page: SystemConfigTxnCodeList.page,
                  children: [
                    AutoRoute(
                        path: 'txncodetl', page: SystemConfigTxnCode.page),
                  ]),
            ]),
      ]),
      AutoRoute(
          path: 'reasoncode',
          page: SystemConfigReasonCodeList.page,
          children: [
            AutoRoute(path: 'reasoncodedtl', page: SystemConfigReasonCode.page)
          ]),
      AutoRoute(
          path: 'tadvendorlist',
          page: SystemConfigMakeModelVendorList.page,
          children: [
            AutoRoute(
                path: 'vendordtl',
                page: SystemConfigMakeModelVendor.page,
                children: [
                  AutoRoute(
                      path: 'tadmakemodellist',
                      page: SystemConfigMakeModelList.page,
                      children: [
                        AutoRoute(
                            path: 'tadmakemodeldtl',
                            page: SystemConfigMakeModel.page)
                      ])
                ])
          ]),
      AutoRoute(path: 'acctmgr', page: SystemConfigAccMgrList.page, children: [
        AutoRoute(path: 'acctmgrdtl', page: SystemConfigAccMgr.page)
      ]),
      AutoRoute(
          path: 'taxcategory',
          page: SystemConfigTaxCategoryList.page,
          children: [
            AutoRoute(
                path: 'taxcategorydtl', page: SystemConfigTaxCategory.page)
          ]),
      AutoRoute(
          path: 'productcode',
          page: SystemConfigProductCodeList.page,
          children: [
            AutoRoute(
                path: 'productcodedtl', page: SystemConfigProductCode.page)
          ]),
      AutoRoute(
          path: 'locgrouplist',
          page: SystemConfigLocationGroupList.page,
          children: [
            AutoRoute(path: 'locgroup', page: SystemConfigLocationGroup.page),
            AutoRoute(
                path: 'loclist',
                page: SystemConfigLocationList.page,
                children: [
                  AutoRoute(
                      path: 'loclistdtl', page: SystemConfigLocation.page),
                ]),
          ]),
      AutoRoute(
          path: 'prodgrouplist',
          page: SystemConfigProductGroupList.page,
          children: [
            AutoRoute(path: 'prodgroup', page: SystemConfigProductGroup.page),
            AutoRoute(
                path: 'prodlist',
                page: SystemConfigProductCodeList.page,
                children: [
                  AutoRoute(
                      path: 'prodlistdtl', page: SystemConfigProductCode.page)
                ])
          ]),
    ]);
