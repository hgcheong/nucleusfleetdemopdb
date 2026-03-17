import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=747;

@RoutePage()
class MchtMgmtQuickInfoOverView extends ConsumerWidget {
  const MchtMgmtQuickInfoOverView(
      {super.key, @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    if (convStrNewOrNullToNull(mchtEttyId) == null) {
      return const Center(
          child: Column(
        children: [
          SelectableText('Not Found. Please return to Main Page'),
          AcxBackToList(listUrl: '/dashboard/home'),
        ],
      ));
    }

    return MchtMgmtQuickInfoForm(
        mchtEttyId: convStrNewOrNullToNull(mchtEttyId));
  }
}

class MchtMgmtQuickInfoForm extends ConsumerWidget {
  const MchtMgmtQuickInfoForm({super.key, this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    // final quickInfoMchtMgmtFormKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "StsDscp": null,
      "CmpyName": null,
      "AgrmtNo": null,
      "AgrmtDate": null,
      "RgstionName": null,
      "RgstionNo": null,
      "RgstionDate": null,
      "ApplSrc": null,
      "ApplRef": null,
      "SubmtDate": null,
      "AppvDate": null,
      "CrtionDate": null,
      "AcctMgrName": null,
      "AcctContactNo": null,
      "BusnUnitCnt": null,
      "LocCnt": null,
      "TadCnt": null,
      "MchtEttyId": mchtEttyId
    };

    final formData = ref.watch(ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtMchtOverview/queryasync',
        params: {"MchtEttyId": mchtEttyId},
        showMsg: false)));

    return AsyncValueWidget(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return Row(
            children: [
              Expanded(
                flex: 5,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        ListTile(
                          leading: const SelectableText('Merchant Name'),
                          title: SelectableText(formValue['CmpyName'] ?? ''),
                        ),
                        ListTile(
                          leading: const SelectableText('Current Status:'),
                          title: SelectableText(formValue['StsDscp'] ?? ''),
                        ),
                        ListTile(
                          leading: const SelectableText('Approval date:'),
                          title: SelectableText(DateFormat('yMMMEd')
                              .format(formValue['AppvDate']??'')),
                        ),
                        ListTile(
                          leading: const SelectableText('Account manager:'),
                          title: SelectableText(formValue['AcctMgrName'] ?? ''),
                        ),
                           ListTile(
                          leading: const SelectableText('Contact No:'),
                          title: SelectableText(formValue['AcctContactNo'] ?? ''),
                        ),
                        ListTile(
                          leading: const SelectableText('Creation Date:'),
                          title: SelectableText(DateFormat('yMMMEd')
                              .format(formValue['CrtionDate']??'')),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SelectableText("Customer's Hierachy consist of..."),
                    Wrap(runSpacing: 10, children: [
                      AcxNavButton(listOfContent: [
                        const SelectableText('Business Unit'),
                        SelectableText(formValue['BusnUnitCnt'].toString())
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>()
                                  .navigatePath('/mcmgmt/bu/$mchtEttyId/list');
                            },
                            icon: const Icon(Icons.add))
                      ]),
                      sbw10,
                      AcxNavButton(listOfContent: [
                        const SelectableText('Location'),
                        SelectableText(formValue['LocCnt'].toString())
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>().navigatePath(
                                  '/mcmgmt/loc/$mchtEttyId/list');
                            },
                            icon: const Icon(Icons.add))
                      ]),
                      sbw10,
                      AcxNavButton(listOfContent: [
                        const SelectableText('TAD'),
                        SelectableText(formValue['TadCnt'].toString())
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>().navigatePath(
                                  '/mcmgmt/tad/$mchtEttyId/list');
                            },
                            icon: const Icon(Icons.add))
                      ]),
                      sbw10,
                    ]),
                    div,
                    //const SelectableText("Merchant has signed up..."),
                    // Row(children: [
                    //   AcxNavButton(listOfContent: [
                    //     const SelectableText('Program'),
                    //     SelectableText(formValue['PrgCnt'])
                    //   ], listOfButton: [
                    //     IconButton(
                    //         onPressed: () {
                    //           // /MchtMgmt/cust/16/program/list
                    //           singleton<AppRouter>().navigatePath('/MchtMgmt/cust/$mchtEttyId/program/list');
                    //         },
                    //         icon: const Icon(Icons.add)),
                    //   ]),
                    // ]),
                    // div,
                  ],
                ),
              ),
              // SizedBox(
              //   height: 1280,
              //   child: buildOverViewForm(mchtEttyId.toString())),
              Expanded(
                flex: 1,
                child: ListView(
                  children: const [
                    Tooltip(message: "Message", child: Icon(Icons.message))
                  ],
                ),
              ),
            ],
          );
        });
  }

  // Widget buildOverViewForm(String mchtEttyId) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Expanded(
  //           flex: 5,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SizedBox(
  //                 height: 300,
  //                 child: ListView(children: const [ListTile(leading: SelectableText('Start'), title: SelectableText('title')), ListTile(leading: SelectableText('Start'), title: SelectableText('title')), ListTile(leading: SelectableText('Start'), title: SelectableText('title'))]),
  //               ),
  //               const Expanded(
  //                 child: SelectableText("Customer's Heachy consist of ..."),
  //               ),
  //               SizedBox(
  //                 height: 300,
  //                 child: ListView(
  //                   shrinkWrap: true,
  //                   scrollDirection: Axis.horizontal,
  //                   children: [
  //                     Container(
  //                       height: 30,
  //                       width: 30,
  //                       color: Colors.red,
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               const Expanded(child: SelectableText('Customer has signed up...'))
  //             ],
  //           )),
  //       const Expanded(flex: 1, child: Icon(Icons.abc))
  //     ],
  //   );
  // }
}
