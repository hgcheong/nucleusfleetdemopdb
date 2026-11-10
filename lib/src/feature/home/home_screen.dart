import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/config/constants/breakpoints.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_searchmain.dart';
import 'package:nucleusv2/src/core/components/acx_searchmainprovider.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/cust_mgmt_billing_provider.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/statement/statement_controller.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/transaction/transaction_controller.dart';
import 'package:nucleusv2/src/feature/home/_line_chart.dart';
import 'package:nucleusv2/src/feature/home/line_chart_5.dart';
import 'package:nucleusv2/src/feature/home/pie_chart_sample1.dart';
import 'package:nucleusv2/src/feature/home/pie_chart_sample2.dart';
import 'package:nucleusv2/src/feature/home/pie_chart_sample3.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';

const int wid=169;

@RoutePage()
class HomeScreen extends BaseScreen {
  const HomeScreen({super.key})
      : super(
          includeMainDrawer: true,
        );

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return columnInfo(context);
    // final tabC1 = useTabController(initialLength: 1);
    // return BuildViewInfo(
    //   tabC1: tabC1,
    //   isMobile: true,
    // );
  }

  @override
  Widget sideBar() {
    return provideSideBar("");
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final tabC1 = useTabController(initialLength: 1);

    return BuildViewInfo(
      tabC1: tabC1,
      isMobile: false,
    );
  }
}

class BuildViewInfo extends HookConsumerWidget {
  const BuildViewInfo({
    super.key,
    required TabController tabC1,
    required this.isMobile,
  })  : _tabC1 = tabC1,
        super();

  final TabController _tabC1;
  final bool isMobile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Row(
      children: [
        Expanded(
            flex: 6,
            child: Container(
              color: secondaryColor,
              child: Column(
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 12,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TabBar(
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            controller: _tabC1,
                            tabs: const [
                              Tab(icon: Icon(Icons.deblur)),
                            ],
                          ),
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Container(
                      //     color: bgColor,
                      //     child: IconButton(
                      //       onPressed: () {
                      //         //  Mcht
                      //         ref.read(menuSideTabSelectProvider.notifier).state = "Mcht";
                      //       },
                      //       icon: const Icon(Icons.save),
                      //       padding: const EdgeInsets.only(left: 2, right: 20),
                      //       constraints: const BoxConstraints(),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )),
                  Expanded(
                    flex: 12,
                    child: SizedBox(
                      height: 1280,
                      child: TabBarView(
                        controller: _tabC1,
                        children: [
                          mainInfo(isMobile, context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}

Widget mainInfo(bool isMobile, BuildContext context) {
  final tabCM = useTabController(initialLength: 1);

  return Column(
    children: [
      Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            controller: tabCM,
            tabs: const [
              Tab(icon: Icon(Icons.bar_chart_sharp)),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 10,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 1280,
            child:
                TabBarView(controller: tabCM, children: [columnInfo(context)]),
          ),
        ),
      ),
    ],
  );
}

Widget columnInfo(BuildContext context) {
  if (!BreakPoints.useMobileLayout(context)) {
    ListView(
      children: const [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 300,
                child: Card(
                    child: LineChartSample5(
                        //     isShowingMainData: false,
                        )),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 300,
                child: Card(
                    child: MyLineChart(
                  isShowingMainData: false,
                )),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 300,
                child: Card(
                  child: PieChartSample1(),
                ),
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 300,
                child: Card(child: PieChartSample3()),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 300,
                child: Card(
                  child: PieChartSample2(),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  return ListView(
    children: const [
      SizedBox(
        height: 300,
        child: LineChartSample5(
            //     isShowingMainData: false,
            ),
      ),
      SizedBox(
        height: 300,
        child: Card(
            child: MyLineChart(
          isShowingMainData: false,
        )),
      ),
      SizedBox(
        height: 300,
        child: Card(
          child: PieChartSample1(),
        ),
      ),
      SizedBox(height: 300, child: Card(child: PieChartSample3())),
      SizedBox(
        height: 300,
        child: Card(
          child: PieChartSample2(),
        ),
      ),
    ],
  );
}

class VwAttrForm extends HookConsumerWidget {
  const VwAttrForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formMainSearchKey = GlobalKey<FormBuilderState>();
    final queryOptions =
        QueryObject(querysql: '/view/async/VwAttr', params: {}, showMsg: false);
    final sSearch = ref.watch(mainSearchSearchFieldProvider);
    final s1 = sSearch.split('|').elementAt(0);
    final s2 = sSearch.split('|').elementAt(1);
    final s3 = sSearch.split('|').elementAt(2);
    final queryOptionValue = ref.watch(ReturndatafreezedProvider(queryOptions));
    var formNewValue = {
      "RefType": "SEARCH",
      "RefCd": "$s1|$s2|${s3 == 'Str' ? 1 : 0}",
      "Dscp": "MERCHANT NAME",
      "BitInd": 1,
      "Sts": "A"
    };
    return queryOptionValue.when(
        error: (error, stackTrace) => Center(child: Text(error.toString()),),
        data: (afterOptionData) {
          // formNewValue['RefCd'] = aam;
          return SizedBox(
            width: 500,
            height: MediaQuery.of(context).size.height - 2,
            child: FormBuilder(
              key: formMainSearchKey,
              initialValue: formNewValue,
              child: FbField(child: FormBuilderRadioGroup<dynamic>(
                onChanged: (val) {
                  ref.read(mainSearchSearchFieldProvider.notifier).state =
                      "${val.toString().split('|').first}|${val.toString().split('|').elementAt(1)}|${val.toString().split('|').last == "1" ? "Str" : "Int"}";
                  //  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  Scaffold.of(context).closeEndDrawer();
                  // ref.read(showHideOptionsProvider.notifier).state = false;
                },
                decoration: const InputDecoration(
                  labelText: 'Search Filter',
                ),
                name: 'RefCd',
                activeColor: Colors.green,
                options: afterOptionData.data!
                    .toList()
                    .map((lang) => FormBuilderFieldOption(
                          value:
                              '${lang['RefCd']}|${lang['Dscp'].toString()}|${lang['BitInd'].toString()}',
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: SelectableText(lang['Dscp'].toString())),
                        ))
                    .toList(growable: false),
              )),
            ),
          );
        },
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}

class MainSearchComponent extends ConsumerWidget {
  const MainSearchComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final sSearchField = ref.watch(mainSearchSearchFieldProvider);
    final s1 = sSearchField.split('|').first;
    final s2 = sSearchField.split('|').elementAt(1);
    final s3 = sSearchField.split('|').last;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //  crossAxisAlignment: Crosa,
      children: [

        Expanded(
          flex: 8,
          child: AcxSearchMain(
              label: '',
              returnSelectedRef: (Map<String, dynamic> val) {
                String refCd = val['RefCd'];
                //  final ettyId = val['EttyId'];
                switch (refCd) {
                  case 'EMA':
                    switchTypeNav(val, ref);
                    break;
                  case 'MOB':
                    switchTypeNav(val, ref);

                    break;
                    //Will Redirect to Accounts page base on postpaid prepaid
                  case 'ACCTNO':
                    final custEttyId = val['CustEttyId'];
                    final ettyId = val['CmpyEttyId'];
                    final acctType = val['AcctType'];
                    final acctId = val['AcctId'];
                    final acctNo = val['AcctNo'];
                    final prgEttyId = val['PrgEttyId'];
                    final billingType = val['BillingType'];
                    final theTitle = getTitle(ref, {"CustEttyId": custEttyId},
                        AppBarTitleType.management);
                              theTitle.then((value) {

                      ref.read(appBarTitleProvider.notifier).state =
                          value.toString();
                      ref.read(menuSideTabSelectProvider.notifier).state =
                          S.current.tabBillingAccount;
                      ref.read(menuMainDrawerSelectProvider.notifier).state =
                          "";
                ref.read(pukalCustMgmtAccDetailProvider.notifier).state = {
                  "CustEttyId": custEttyId,
                  "PrgEttyId": prgEttyId,
                  "EttyId": ettyId,
                  "AcctId": acctId,
                  "AcctNo": acctNo
                };
                ref.read(billingAcctMgmtModelIdProvider.notifier).state = {
                  "PrgEttyId": prgEttyId,
                  "BillingType": billingType
                };
                ref.read(billingCustMgmtAccDetailProvider.notifier).state = {
                  "CustEttyId": custEttyId,
                  "PrgEttyId": prgEttyId,
                  "EttyId": ettyId,
                  "AcctId": acctId,
                  "AcctType": acctType,
                };

                ref.read(txnCustMgmtAccDetailProvider.notifier).state = {
                  "CustEttyId": custEttyId,
                  "PrgEttyId": prgEttyId,
                  "EttyId": ettyId,
                  "AcctId": acctId,

                };
                ref.read(txnSearchContorllerProvider.notifier).state = {
                  "CustEttyId": custEttyId,
                  "PrgEttyId":prgEttyId,
                  "EttyId": ettyId,
                  "AcctId": acctId,
                };

                ref.read(txnSearchContorllerUnbilledProvider.notifier).state={
                  "CustEttyId": custEttyId,
                  "PrgEttyId":prgEttyId,
                  "EttyId": ettyId,
                  "AcctId": acctId,
                };
                ref.read(txnSearchOltpContorllerProvider.notifier).state = {
                  "CustEttyId": custEttyId,
                  "EttyId": ettyId,
                  "AcctId": acctId,
                  "TxnInd": "0"
                };
                //txnSearchContorllerProvider
                ref.read(statementSearchContorllerProvider.notifier).state = {
                  "AcctId": acctId,
                  "PrgEttyId": prgEttyId,
                  "CustEttyId": custEttyId
                };
                          ///custmgmt/billingAccount/528/detail/160/accsetting/POSTPAID/postpaid
                          ///billingAccount/528/detail/160/accsetting/POSTPAID/postpaid
   
                    var navUrl = '/custmgmt/billingAccount/$custEttyId/detail/$acctId/accsetting/${acctType.toUpperCase()}/${acctType.toLowerCase()}';

                      singleton<AppRouter>().navigatePath(navUrl);

                    });

                    break;
                  case 'CUSTNAME':
                  case 'CUSTNO':
                    final custEttyId = val['CustEttyId'];
                    final theTitle = getTitle(ref, {"CustEttyId": custEttyId},
                        AppBarTitleType.management);
                    theTitle.then((value) {
                      ref.read(appBarTitleProvider.notifier).state =
                          value.toString();
                      ref.read(menuSideTabSelectProvider.notifier).state =
                          "Customer";
                      ref.read(menuMainDrawerSelectProvider.notifier).state =
                          "";
                      singleton<AppRouter>().navigatePath(
                          '/custmgmt/cust/$custEttyId/dashboard');
                    });

                    break;
                  case 'PICNAME':
                    final custEttyId = val['CustEttyId'];
                    final theTitle = getTitle(ref, {"CustEttyId": custEttyId},
                        AppBarTitleType.management);
                    theTitle.then((value) {
                      ref.read(appBarTitleProvider.notifier).state =
                          value.toString();

                      ref.read(menuSideTabSelectProvider.notifier).state =
                          "Customer";
                      ref.read(menuMainDrawerSelectProvider.notifier).state =
                          "";
                      singleton<AppRouter>().navigatePath(
                          '/custmgmt/cust/$custEttyId/profile/contact');

                      ///custmgmt/cust/528/profile/geninfo
                    });

                    break;
                  case 'CMPYNAME':
                    final cmpyEttyId = val['CmpyEttyId'];
                    final custEttyId = val['CustEttyId'];
                    final theTitle = getTitle(ref, {"CustEttyId": custEttyId},
                        AppBarTitleType.management);
                    theTitle.then((value) {
                      ref.read(appBarTitleProvider.notifier).state =
                          value.toString();
                      ref.read(menuSideTabSelectProvider.notifier).state =
                          "Company";
                      ref.read(menuMainDrawerSelectProvider.notifier).state =
                          "";

                      singleton<AppRouter>().navigatePath(
                          '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/profile/geninfo');
                    });

                    break;
                  case 'MEDIANO':
                    final custEttyId = val['CustEttyId'];
                    final mediaEttyId = val['MediaEttyId'];
                    final issId = val['IssId'];
                    final prgEttyId = val['PrgEttyId'];
                    final mbrEttyId = val['MbrEttyId'];
                    final theTitle = getTitle(ref, {"MediaEttyId": mediaEttyId},
                        AppBarTitleType.management);
                    theTitle.then((value) {
                      ref.read(menuMainDrawerSelectProvider.notifier).state =
                          "";
                      ref.read(menuSideTabSelectProvider.notifier).state =
                          "Media";
                      singleton<AppRouter>().navigatePath(
                          '/custmgmt/media/$custEttyId/detail/$mediaEttyId/$issId/$mbrEttyId/$prgEttyId');
                    });
                    break;
                  case 'VHCRGSNO':
                    final custEttyId = val['CustEttyId'];
                    final mbrEttyId = val['MbrEttyId'];
                    final theTitle = getTitle(ref, {"MbrEttyId": mbrEttyId},
                        AppBarTitleType.management);
                    theTitle.then((value) {
                      ref.read(menuSideTabSelectProvider.notifier).state =
                          "Member";
                      ref.read(menuMainDrawerSelectProvider.notifier).state =
                          "";
                      singleton<AppRouter>().navigatePath(
                          '/custmgmt/member/$custEttyId/detail/$mbrEttyId/memberinfo/vehicleinfo');
                    });
                    break;
                  case 'MBRNAME':
                    final custEttyId = val['CustEttyId'];
                    final mbrEttyId = val['MbrEttyId'];
                    final theTitle = getTitle(ref, {"MbrEttyId": mbrEttyId},
                        AppBarTitleType.management);
                    theTitle.then((value) {
                      ref.read(menuSideTabSelectProvider.notifier).state =
                          "Member";
                      ref.read(menuMainDrawerSelectProvider.notifier).state =
                          "";
                      singleton<AppRouter>().navigatePath(
                          '/custmgmt/member/$custEttyId/detail/$mbrEttyId/memberinfo/personal');
                    });
                    break;

                  case 'RGSNAME':
                    final custEttyId = val['CustEttyId'];
                    final cmpyEttyId = val['CmpyEttyId'];
                    final mchtEttyId = val['MchtEttyId'];
                    final locEttyId = val['LocEttyId'];
                    final ettyType = val['EttyType'];

                    switch (ettyType) {
                      case "MERCHANT":
                        final theTitle = getTitle(
                            ref,
                            {"MchtEttyId": mchtEttyId},
                            AppBarTitleType.management);
                        theTitle.then((value) {
                          ref.read(appBarTitleProvider.notifier).state =
                              value.toString();
                          ref.read(menuSideTabSelectProvider.notifier).state =
                              "Merchant";
                          ref
                              .read(menuMainDrawerSelectProvider.notifier)
                              .state = "";
                          singleton<AppRouter>().navigatePath(
                              '/mcmgmt/mcht/$mchtEttyId/profile/geninfo');
                        });
                        break;
                      case "LOCATION":
                        final theTitle = getTitle(
                            ref,
                            {"MchtEttyId": mchtEttyId},
                            AppBarTitleType.management);
                        theTitle.then((value) {
                          ref.read(appBarTitleProvider.notifier).state =
                              value.toString();
                          ref.read(menuSideTabSelectProvider.notifier).state =
                              "Location";
                          ref
                              .read(menuMainDrawerSelectProvider.notifier)
                              .state = "";
                          singleton<AppRouter>().navigatePath(
                              '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/profile');
                        });
                        break;
                      case "CUSTOMER":
                        final theTitle = getTitle(
                            ref,
                            {"CustEttyId": custEttyId},
                            AppBarTitleType.management);
                        theTitle.then((value) {
                          ref.read(appBarTitleProvider.notifier).state =
                              value.toString();
                          ref.read(menuSideTabSelectProvider.notifier).state =
                              "Customer";
                          ref
                              .read(menuMainDrawerSelectProvider.notifier)
                              .state = "";
                          singleton<AppRouter>().navigatePath(
                              '/custmgmt/cust/$custEttyId/profile/geninfo');
                        });
                        break;
                      case "COMPANY":
                        final theTitle = getTitle(
                            ref,
                            {"CustEttyId": custEttyId},
                            AppBarTitleType.management);
                        theTitle.then((value) {
                          ref.read(appBarTitleProvider.notifier).state =
                              value.toString();
                          ref.read(menuSideTabSelectProvider.notifier).state =
                              "Company";
                          ref
                              .read(menuMainDrawerSelectProvider.notifier)
                              .state = "";
                          singleton<AppRouter>().navigatePath(
                              '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/profile/geninfo');
                        });
                        break;

                      default:
                    }
                    break;
                  case 'EMAIL':
                  case 'MOBILENO':
                  case 'CONTACTNO':
                   
               
                    final contactType = val['ContactType'];
                    final contactId = val['ContactId'];

                    final custEttyId = val['CustEttyId'];
                    final cmpyEttyId = val['CmpyEttyId'];
                    final costCtrEttyId = val['CostCtrEttyId'];
                    final mbrEttyId = val['MbrEttyId'];
                    final indvdId = val['IndvdId'];

                    final mchtEttyId = val['MchtEttyId'];
                //    final busnUnitEttyId = val['BusnUnitEttyId'];
                    final locEttyId = val['LocEttyId'];

                    if(locEttyId!=null){
                                final theTitle = getTitle(
                            ref,
                            {"MchtEttyId": mchtEttyId},
                            AppBarTitleType.management);
                        theTitle.then((value) {
                          ref.read(appBarTitleProvider.notifier).state =
                              value.toString();
                          ref.read(menuSideTabSelectProvider.notifier).state =
                              "Location";
                          ref
                              .read(menuMainDrawerSelectProvider.notifier)
                              .state = "";
                            if (indvdId == null || indvdId == 0) {
                                     singleton<AppRouter>().navigatePath(
                              '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/profile/contact/contactdtl/$contactType/$contactId');
                            }else{
                              ///director/directordtl/240
        singleton<AppRouter>().navigatePath(
                              '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/profile/director/directordtl/$indvdId');
                            }
                  
                        });
                        return;
                    }

                    if (mchtEttyId!=null){
                                   final theTitle = getTitle(
                            ref,
                            {"MchtEttyId": mchtEttyId},
                            AppBarTitleType.management);
                        theTitle.then((value) {
                          ref.read(appBarTitleProvider.notifier).state =
                              value.toString();
                          ref.read(menuSideTabSelectProvider.notifier).state =
                              "Merchant";
                          ref
                              .read(menuMainDrawerSelectProvider.notifier);
                                    if (indvdId == null || indvdId == 0) {
      singleton<AppRouter>().navigatePath(
                              '/mcmgmt/mcht/$mchtEttyId/profile/contact/contactdtl/$contactType/$contactId');
                            }else{
                          singleton<AppRouter>().navigatePath(
                              '/mcmgmt/mcht/$mchtEttyId/profile/director/directordtl/$indvdId');
                            
                            }
                        });
                        return;
                    }

                    if(mbrEttyId!=null){
                             final theTitle = getTitle(
                            ref,
                            {"CustEttyId": custEttyId},
                            AppBarTitleType.management);
                        theTitle.then((value) {
                          ref.read(appBarTitleProvider.notifier).state =
                              value.toString();
                          ref.read(menuSideTabSelectProvider.notifier).state =
                              "Member";
                          ref
                              .read(menuMainDrawerSelectProvider.notifier)
                              .state = "";
                                if (indvdId == null || indvdId == 0) {
                                              singleton<AppRouter>().navigatePath(
                              '/custmgmt/member/$custEttyId/detail/$mbrEttyId/contact/contactdtl/$contactType/$contactId');
                                }else{
                                            singleton<AppRouter>().navigatePath(
                              '/custmgmt/member/$custEttyId/detail/$mbrEttyId/director/directordtl/$indvdId');
                                } 
              
                        });
                        return;
                    }
                    ///custmgmt/costcen/903/profile/905/contact
                    if(costCtrEttyId !=null){
                                       final theTitle = getTitle(
                            ref,
                            {"CustEttyId": custEttyId},
                            AppBarTitleType.management);
                        theTitle.then((value) {
                          ref.read(appBarTitleProvider.notifier).state =
                              value.toString();
                          ref.read(menuSideTabSelectProvider.notifier).state =
                              "Cost Center";
                          ref
                              .read(menuMainDrawerSelectProvider.notifier)
                              .state = "";
                                if (indvdId == null || indvdId == 0) {
      singleton<AppRouter>().navigatePath(
                              '/custmgmt/costcen/$custEttyId/detail/$costCtrEttyId/contact/contactdtl/$contactType/$contactId');
                                }
                                else{
      singleton<AppRouter>().navigatePath(
                              '/custmgmt/costcen/$custEttyId/detail/$costCtrEttyId/director/directordtl/$indvdId');
                                }
                    
                        });
                        return;
                    }

                    if(cmpyEttyId !=null){
                               final theTitle = getTitle(
                            ref,
                            {"CustEttyId": custEttyId},
                            AppBarTitleType.management);
                        theTitle.then((value) {
                          ref.read(appBarTitleProvider.notifier).state =
                              value.toString();
                          ref.read(menuSideTabSelectProvider.notifier).state =
                              "Company";
                          ref
                              .read(menuMainDrawerSelectProvider.notifier)
                              .state = "";
                                     if (indvdId == null || indvdId == 0) {
       singleton<AppRouter>().navigatePath(
                              '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/profile/contact/contactdtl/$contactType/$contactId');
                                     }
                                     else{
       singleton<AppRouter>().navigatePath(
                              '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/profile/director/directordtl/$indvdId');
                                     }
                   
                        });
                        return;
                    }

                    if(custEttyId !=null){
                                  final theTitle = getTitle(
                            ref,
                            {"CustEttyId": custEttyId},
                            AppBarTitleType.management);
                        theTitle.then((value) {
                          ref.read(appBarTitleProvider.notifier).state =
                              value.toString();
                          ref.read(menuSideTabSelectProvider.notifier).state =
                              "Customer";
                          ref
                              .read(menuMainDrawerSelectProvider.notifier)
                              .state = "";
                                   if (indvdId == null || indvdId == 0) {
                                       singleton<AppRouter>().navigatePath(
                              '/custmgmt/cust/$custEttyId/profile/contact/contactdtl/$contactType/$contactId');
                                   }
                                   else{
   singleton<AppRouter>().navigatePath(
                              '/custmgmt/cust/$custEttyId/profile/director/directordtl/$indvdId');
                                   }
                       
                        });
                        return;
                    }
                      break;
                  case 'MCHTNAME':
                  case 'MCHTNO':

                    ///mcmgmt/mcht/id/quickinfo/overview
                    final mchtEttyId = val['MchtEttyId'];
                    final theTitle = getTitle(ref, {"MchtEttyId": mchtEttyId},
                        AppBarTitleType.management);
                    theTitle.then((value) {
                      ref.read(appBarTitleProvider.notifier).state =
                          value.toString();
                      ref.read(menuSideTabSelectProvider.notifier).state =
                          "Merchant";
                      ref.read(menuMainDrawerSelectProvider.notifier).state =
                          "";
                      singleton<AppRouter>().navigatePath(
                          '/mcmgmt/mcht/$mchtEttyId/quickinfo/overview');
                    });

                    break;
                  case 'LOCNO':
                  case 'MID':
                  case 'LOCSITEID':
                  case 'LOCSITENAME':
                  case 'LOCNAME':
                    final locEttyId = val['LocEttyId'];
                    final mchtEttyId = val['MchtEttyId'];

                    final theTitle = getTitle(ref, {"LocEttyId": locEttyId},
                        AppBarTitleType.management);
                    theTitle.then((value) {
                      ref.read(appBarTitleProvider.notifier).state =
                          value.toString();
                      ref.read(menuSideTabSelectProvider.notifier).state =
                          "Location";
                      ref.read(menuMainDrawerSelectProvider.notifier).state =
                          "";

                      ///nucleusfleet/mcmgmt/loc/55/detail/57/quickinfo/overview
                      singleton<AppRouter>().navigatePath(
                          '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/profile/geninfo');
                    });
                    break;
                         case 'TID':
                   
                    final mchtEttyId = val['MchtEttyId'];
                    final tadEttyId = val['TadEttyId'];
                    final tadId = val['TadId'];
                  // TadEttyId, TadId
                    final theTitle = getTitle(ref, {"TadEttyId": tadEttyId},
                        AppBarTitleType.management);
                    theTitle.then((value) {
                      ref.read(appBarTitleProvider.notifier).state =
                          value.toString();
                      ref.read(menuSideTabSelectProvider.notifier).state =
                          "TAD";
                      ref.read(menuMainDrawerSelectProvider.notifier).state =
                          "";

                      /////mcmgmt/tad/824/geninfo/827/28/main
                      singleton<AppRouter>().navigatePath(
                          '/mcmgmt/tad/$mchtEttyId/geninfo/$tadEttyId/$tadId/main');
                    });
                    break;
                  default:
                }
              },
              // selectedRef:  {'TxnPlan': txn},
              inputText: 'Search $s2',
              inputIcon: const Icon(Icons.search),
              querysql: '/sp/ApiMgmtMainSearch/queryasync',
              searchText: s2,
              keyField: 'EttyId',
              searchAttr: s3,
              refCd: s1,
              showSearchBox: true,
              params: const {}),
        ),

        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
//                          if(showHideOptionsV == false){

//                 //           showAcxDialog(context, Row(
//                 //             children: [

//                 //              const  Expanded(flex:8, child: VwAttrForm()),
//                 //                Expanded(flex: 1, child:    TextButton(
//                 //   onPressed: (){

//                 //   },
//                 //   child:const  SelectableText('DISMISS'),
//                 // ),)
//                 //             ],
//                 //           ));
// //  ScaffoldMessenger.of(context).showMaterialBanner(

// //               // ignore: prefer_const_constructors
// //               // MaterialBanner(content:   SingleChildScrollView(child: SizedBox(
// //               //   height: 1280,
// //               //   child: const VwAttrForm())),
// //                        MaterialBanner(

// //                         content: const VwAttrForm(),
// //                actions: [
// //                  TextButton(
// //                   onPressed: (){
// //                         ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
// //                      ref.read(showHideOptionsProvider.notifier).state = false;
// //                   },
// //                   child: const SelectableText('DISMISS'),
// //                 )
// //               ],));
//                          } else{
//                                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
//                          }
//                                                  showHideOptionsV == false ? ref.read(showHideOptionsProvider.notifier).state = true : ref.read(showHideOptionsProvider.notifier).state = false;
              },
              icon: const Icon(Icons.filter_list)),
        ),
      ],
    );
  }

  void switchTypeNav(Map<String, dynamic> val, WidgetRef ref) {
    final custEttyId = val['CustEttyId'];
    final cmpyEttyId = val['CmpyEttyId'];
    //    final costCtrEttyId = val['CostCtrEttyId'];
    final mbrEttyId = val['MbrEttyId'];
    final mchtEttyId = val['MchtEttyId'];
    //     final busnUnitEttyId = val['BusnUnitEttyId'];
    final locEttyId = val['LocEttyId'];
    final contactType = val['ContactType'];

    switch (contactType) {
      case "MCHT":
        final theTitle = getTitle(
            ref, {"MchtEttyId": mchtEttyId}, AppBarTitleType.management);
        theTitle.then((value) {
          ref.read(appBarTitleProvider.notifier).state = value.toString();
          ref.read(menuSideTabSelectProvider.notifier).state = "Merchant";
          ref.read(menuMainDrawerSelectProvider.notifier).state = "";
          singleton<AppRouter>()
              .navigatePath('/mcmgmt/mcht/$mchtEttyId/profile/contact');
        });
        break;
      case "LOC":
        final theTitle = getTitle(
            ref, {"MchtEttyId": mchtEttyId}, AppBarTitleType.management);
        theTitle.then((value) {
          ref.read(appBarTitleProvider.notifier).state = value.toString();
          ref.read(menuSideTabSelectProvider.notifier).state = "Location";
          ref.read(menuMainDrawerSelectProvider.notifier).state = "";
          singleton<AppRouter>().navigatePath(
              '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/profile/contact');
        });
        break;
      case "PIC":
        final theTitle = getTitle(
            ref, {"CustEttyId": custEttyId}, AppBarTitleType.management);
        theTitle.then((value) {
          ref.read(appBarTitleProvider.notifier).state = value.toString();
          ref.read(menuSideTabSelectProvider.notifier).state = "Customer";
          ref.read(menuMainDrawerSelectProvider.notifier).state = "";
          singleton<AppRouter>()
              .navigatePath('/custmgmt/cust/$custEttyId/profile/contact');
        });
        break;
      case "BILLING":
        final theTitle = getTitle(
            ref, {"CustEttyId": custEttyId}, AppBarTitleType.management);
        theTitle.then((value) {
          ref.read(appBarTitleProvider.notifier).state = value.toString();
          ref.read(menuSideTabSelectProvider.notifier).state =   S.current.tabBillingAccount;
          ref.read(menuMainDrawerSelectProvider.notifier).state = "";
          singleton<AppRouter>().navigatePath(
              '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/profile/contact');
        });
        break;
      case "MBR":
        final theTitle = getTitle(
            ref, {"CustEttyId": custEttyId}, AppBarTitleType.management);
        theTitle.then((value) {
          ref.read(appBarTitleProvider.notifier).state = value.toString();
          ref.read(menuSideTabSelectProvider.notifier).state = "Member";
          ref.read(menuMainDrawerSelectProvider.notifier).state = "";
          singleton<AppRouter>().navigatePath(
              '/custmgmt/member/$custEttyId/detail/$mbrEttyId/contact');
        });
        break;
      default:
    }
  }
}
