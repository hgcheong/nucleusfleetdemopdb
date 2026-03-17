import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchbox.dart';
import 'package:nucleusv2/src/core/models/libref/libref.dart';
import 'package:nucleusv2/src/feature/auth/components/register_form.dart';

const int wid=218;

@RoutePage()
class BulkMediaProdNew extends BaseScreen {
  const BulkMediaProdNew(@PathParam('bulkid') this.bulkid, {super.key})
      : super(
          includeMainDrawer: true,
        );

  final String? bulkid;
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }

  @override
  Widget sideTab() {
    return provideSideTab("custenroll/main");
  }

  @override
  Widget sideBar() {
    return provideSideBar("bulkmedia/main");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custenroll/main");
  }
}

Widget buildView() {
  return Scaffold(
    body: const SingleChildScrollView(
      child: SizedBox(
        height: 1024,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(height: 2000, child: CustEnrollForm()
                  // AcxTrinaGrid(
                  //   querysql: '/sp/ApiPrgList/queryasync',
                  //   params: {},
                  //   idField: 'PrgEttyId',
                  //   navPrefix: '/prgmgmt/setup',
                  // ),
                  ),
            ),
          ],
        ),
      ),
    ),
    appBar: AppBar(
      title: const SelectableText('Customer Enrolment'),
      automaticallyImplyLeading: false, centerTitle: false,
    ),
  );
}

class BuildViewInfo extends HookWidget {
  const BuildViewInfo({
    super.key,
    required TabController tabC1,
    required this.isMobile,
  })  : _tabC1 = tabC1,
        super();

  final TabController _tabC1;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const SizedBox(
        //   width: 50,
        //   height: double.infinity,
        //   child: SideTab(),
        // ),
        Expanded(
            flex: 6,
            child: Container(
              color: secondaryColor,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.blue,
                    child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: Placeholder()),
                          Expanded(child: Placeholder()),
                          Expanded(child: Placeholder()),
                        ]),
                  )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 12,
                        child: Align(
                          //      alignment: Alignment.centerRight,
                          child: TabBar(
                            isScrollable: true,
                            controller: _tabC1,
                            tabs: const [
                              Tab(icon: Icon(Icons.abc)),
                              Tab(icon: Icon(Icons.directions_transit)),
                              Tab(icon: Icon(Icons.directions_car)),
                              Tab(icon: Icon(Icons.abc)),
                              Tab(icon: Icon(Icons.directions_transit)),
                              Tab(icon: Icon(Icons.directions_car)),
                              Tab(icon: Icon(Icons.abc)),
                              Tab(icon: Icon(Icons.directions_transit)),
                              Tab(icon: Icon(Icons.directions_car)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: bgColor,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.save),
                            padding: const EdgeInsets.only(left: 2, right: 20),
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ),
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
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
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
  final tabCM = useTabController(initialLength: 3);
  return Column(
    children: [
      Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            controller: tabCM,
            tabs: const [
              Tab(icon: Icon(Icons.abc)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 10,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 1280,
            child: TabBarView(controller: tabCM, children: [
              columnInfo(isMobile),
              columnInfo(isMobile),
              columnInfo(isMobile)
            ]),
          ),
        ),
      ),
    ],
  );
}

Widget columnInfo(bool isMobile) {
  if (isMobile) {
    return const Form(
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Placeholder(),
            ),
          ),
          Expanded(
            child: Card(
              child: Placeholder(),
            ),
          )
        ],
      ),
    );
  }
  return Form(
    child: Column(
      children: [
        const Expanded(
          child: Card(
            child: TheSubMitForm(),
          ),
        ),
        Expanded(
          child: Card(child: RegisterForm()),
        )
      ],
    ),
  );
}

class TheSubMitForm extends HookConsumerWidget {
  const TheSubMitForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Form(
      child: Column(
        children: [
          const TextField(),
          const TextField(),
          ElevatedButton(
              onPressed: () async {
                //  final data = await CategoryService().listDynamic();
              },
              child: const SelectableText('ShowMe')),
        ],
      ),
    );
  }
}

class CustEnrollForm extends ConsumerWidget {
  const CustEnrollForm({
    super.key,
    this.custEttyId,
  });

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final custEnrollFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formNewValue = {
      "CustEttyId": null,
      "CmpyName": null,
      "RgstionDate": DateTime.now(),
      "RgstionNo": null,
      "RgstionName": null,
      "FirstName": null,
      "LastName": null,
      "FullName":null,
      "Dsgntion": null,
      "Title": null,
      "ApplRef": null,
      "ApplSrc": null,
      "TaxCtgry": null,
      "TaxNo": null,
      "SubmtDate": DateTime.now(),
      "AcctMgrName": null,
      "AcctMgrContactNo": null,
      "Email": null,
      "MobileNo1": null,
      "MobileNo2": null,
      "MobileNo3": null,
      "OfficeContactNo": null,
      "OfficeExtNo": null,
      "SrcRef": null
    };
    final query = QueryObject(
        querysql: '/sp/ApiEnrlCust/queryasync',
        params: {"CustEttyId": custEttyId == 'new' ? null : custEttyId},
        showMsg: false);
    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: custEnrollFormKey,
            initialValue: formNewValue,
            child: Row(
              children: [
                const FbHiddenText(name: 'CustEttyId'),
                //    "Title": null,
                const FbHiddenText(name: 'Title'),
                //   "TaxCtgry": null,
                const FbHiddenText(name: 'TaxCtgry'),
                const FbHiddenText(name: 'TaxNo'),
                const FbHiddenText(name: 'AcctMgrContactNo'),
                const FbHiddenText(name: 'SrcRef'),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText('Customer Info'),
                      const  FbText(
                          name: 'CmpyName',
                          label: 'Company Name',                   
                        ),
                       const FbText(
                          name: 'RgstionName',
                          label: 'Business Registration Name'   
                        ),
                       const FbText(
                          name: 'RgstionNo',
                          label: 'Business Registration No',
                 
                        ),
                        const SelectableText('Person In Charge'),
                        FbText(label: 'name', name: 'FullName',),
                       const FbHiddenText(
                          name: 'FirstName',  
                        ),
                       const FbHiddenText(
                          name: 'LastName',
                       //     label: 'LastName',
                        ),
                        FormBuilderField(
                            name: 'Dsgntion',
                            builder: (FormFieldState<dynamic> field) {
                              return AcxSearchBox(
                                  returnSelectedRef: (Libref? val) {
                                    val != null
                                        ? field.didChange(val.refCd)
                                        : field.didChange(null);
                                  },
                                  selectedRef: Libref(
                                      refCd:
                                          formNewValue['Dsgntion'].toString()),
                                  inputText: 'Designation',
                                  querysql: '/sp/GetLibRef/queryasyncnouser',
                                  params: const {
                                    "RefType": "Dsgntion",
                                    "BitInd": null
                                  });
                            }),
                       const FbText(
                          name: 'MobileNo1',
                           label: 'Mobile No.1', 
                        ),
                           const FbText(
                          name: 'MobileNo2',
                           label: 'Mobile No.2', 
                        ),
                           const FbText(
                          name: 'MobileNo3',
                           label: 'Mobile No.3', 
                        ),
                       const FbText(
                          name: 'Work Email',
                          label: 'Work Email Address',
                        ),
                           const FbText(
                          name: 'PersonalEmail',
                          label: 'Personal Email Address',
                        ),
                       const Row(
                          children: [
                            Expanded(
                              child: FbText(
                                name: 'OfficeContactNo',
                                label: 'Phone No.',
                              ),
                            ),
                            Expanded(
                              child: FbText(
                                name: 'OfficeExtNo',
                                 label: 'Extension'
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText('Application Info'),
                       const FbText(
                          name: 'ApplRef',
                          label: 'Application Reference',
                        ),
                        FormBuilderField(
                            name: 'ApplSrc',
                            builder: (FormFieldState<dynamic> field) {
                              return AcxSearchBox(
                                  returnSelectedRef: (Libref? val) {
                                    val != null
                                        ? field.didChange(val.refCd)
                                        : field.didChange(null);
                                  },
                                  selectedRef: Libref(
                                      refCd:
                                          formNewValue['ApplSrc'].toString()),
                                  inputText: 'Application Source',
                                  querysql: '/sp/GetLibRef/queryasyncnouser',
                                  params: const {
                                    "RefType": "APPLSRC",
                                    "BitInd": null
                                  });
                            }),
                        const FbDateTimePicker(name: 'SubmtDate', label: 'Submission Date',),
                      const FbDateTimePicker(name: 'RgstionDate', label: 'Registration Date',),
                        FbAutoComplete(
                            initialValue: formNewValue['AcctMgrName'],
                            name: 'AcctMgrName',
                            label: 'Account Manager',
                            keyField: 'AcctMgrName',
                            searchText: 'AccMgrName',
                            query: QueryObject(
                                querysql: '/view/async/VwAcctMgrCust',
                                params: const {},
                                showMsg: false)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    AcxSaveButtonManual(
                      onSave: () {
                               if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                        custEnrollFormKey.currentState!.save();
                        Map<String, dynamic> toPost = convertFormValueToSave(
                            custEnrollFormKey.currentState!.value,
                            theData.columnInfo);
                        final querySave = QueryObject(
                            querysql:
                                '/sp/ApiPrgCustPostpaidBFChrgSave/queryasync?logId=${convStrNewOrNullToNull(custEttyId) ?? 0}',
                            params: toPost,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((Returndata value) {
                          Toast.showresult(value);
                          if (isSuccess(value.message)) {
                            if (context.mounted) {
                              String afterSavedPath = getAfterSavePath(
                                  context, value.output, '@CustEttyId');
                              singleton<AppRouter>()
                                  .navigatePath(afterSavedPath)
                                  .then(((val) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                              }));
                            }
                          }
                        });
                      },
                    ),   sbh10,
                    AcxAuditLogReqBtn('ApiPrgCustPostpaidBFChrgSave',ettyId: custEttyId.toString(),)
              
                  ]),
                )
              ],
            ));
      },
    );
  }
}
