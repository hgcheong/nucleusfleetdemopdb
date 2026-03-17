import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=681;

@RoutePage()
class MchtEnrlQuickInfoOverView extends StatelessWidget {
  const MchtEnrlQuickInfoOverView(
      {super.key, @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return MchtEnrlQuickInfoForm(
      mchtEttyId: mchtEttyId,
    );
  }
}

class MchtEnrlQuickInfoForm extends ConsumerWidget {
  const MchtEnrlQuickInfoForm({super.key, this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    // final quickInfoMchtEnrlFormKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "MchtName": null,
      "MchtStsDscp": null,
      "ApplSrcDscp": null,
      "AgrmtNo": null,
      "AgrmtDate": null,
      "SubmtDate": null,
      "RgstionNo": null,
      "RgstionDate": null,
      "CrtionDate": null,
      "CrtBy": null,
      "AcctMgrName": null,
      "AcctMgrContactNo": null,
      "MchtEttyId": convStrNewOrNullToNull(mchtEttyId),
      "BusnUnitCnt": null,
      "LocCnt": null,
      "TadCnt": null,
      "PrgCnt": null
    };

    final formData = ref.watch(ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiEnrlMchtOverview/queryasync',
        params: {"MchtEttyId": mchtEttyId},
        showMsg: false)));

    return AsyncValueWidget(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          } else {
            Toast.message("No data available");
            singleton<AppRouter>().navigatePath('/mcenroll/mcht');
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
                          leading: const SelectableText('Current Status:'),
                          title: SelectableText(formValue['MchtStsDscp']),
                        ),
                        ListTile(
                          leading: const SelectableText('Account manager:'),
                          title: SelectableText(formValue['AcctMgrName'] ?? ""),
                        ),
                        //   ListTile(
                        //   leading: const SelectableText('Contact No:'),
                        //   title: SelectableText(formValue['AcctMgrContactNo'] ?? ""),
                        // ),
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
                        SelectableText(formValue['BusnUnitCnt'])
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>().navigatePath(
                                  '/mcenroll/bu/$mchtEttyId/list');
                            },
                            icon: const Icon(Icons.add))
                      ]),
                      sbw10,
                      AcxNavButton(listOfContent: [
                        const SelectableText('Location'),
                        SelectableText(formValue['LocCnt'])
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>().navigatePath(
                                  '/mcenroll/loc/$mchtEttyId/list');
                            },
                            icon: const Icon(Icons.add))
                      ]),
                      sbw10,
                      AcxNavButton(listOfContent: [
                        const SelectableText('TAD'),
                        SelectableText(formValue['TadCnt'])
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>().navigatePath(
                                  '/mcenroll/tad/$mchtEttyId/list');
                            },
                            icon: const Icon(Icons.add))
                      ]),
                      sbw10,
                    ]),
                    div,
                    // const SelectableText("Merchant has signed up..."),
                    // Row(children: [
                    //   AcxNavButton(listOfContent: [
                    //     const SelectableText('Program'),
                    //     SelectableText(formValue['PrgCnt'])
                    //   ], listOfButton: [
                    //     IconButton(
                    //         onPressed: () {
                    //           // /MchtEnrl/cust/16/program/list
                    //           singleton<AppRouter>().navigatePath('/MchtEnrl/cust/$mchtEttyId/program/list');
                    //         },
                    //         icon: const Icon(Icons.add)),
                    //   ]),
                    // ]),
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

  Widget buildOverViewForm(String mchtEttyId) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  child: ListView(children: const [
                    ListTile(
                        leading: SelectableText('Start'),
                        title: SelectableText('title')),
                    ListTile(
                        leading: SelectableText('Start'),
                        title: SelectableText('title')),
                    ListTile(
                        leading: SelectableText('Start'),
                        title: SelectableText('title'))
                  ]),
                ),
                const Expanded(
                  child: SelectableText("Customer's Heachy consist of ..."),
                ),
                SizedBox(
                  height: 300,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                const Expanded(
                    child: SelectableText('Customer has signed up...'))
              ],
            )),
        const Expanded(flex: 1, child: Icon(Icons.abc))
      ],
    );
  }
}
