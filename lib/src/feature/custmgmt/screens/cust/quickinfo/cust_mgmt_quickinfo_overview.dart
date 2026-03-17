import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';

const int wid=611;

@RoutePage()
class CustMgmtQuickInfoOverView extends StatelessWidget {
  const CustMgmtQuickInfoOverView(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return CustMgmtQuickInfoForm(
      custEttyId: custEttyId,
    );
  }
}

class CustMgmtQuickInfoForm extends ConsumerWidget {
  const CustMgmtQuickInfoForm({super.key, this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    // final quickInfoFormKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "StsDscp": null,
      "CmpyName": null,
      "RgstionName": null,
      "RgstionNo": null,
      "RgstionDate": null,
      "SubmtDate": null,
      "CrtionDate": null,
      "AcctMgrName": null,
      "AcctContactNo": null,
      "CmpyCnt": null,
      "CcCtr": null,
      "MbrCnt": null,
      "MediaCnt": null,
      "PrgCnt": null,
      "CustEttyId": custEttyId
    };

    final formData = ref.watch(ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtCustOverview/queryasync',
        params: {"CustEttyId": custEttyId},
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
                          leading: const SelectableText('Customer Number:'),
                          title: SelectableText(formValue['CustNo']),
                        ),
                        ListTile(
                          leading: const SelectableText('Current Status:'),
                          title: SelectableText(formValue['StsDscp']),
                        ),
                        // ListTile(
                        //   leading: const SelectableText('Account manager:'),
                        //   title: SelectableText(formValue['AcctMgrName']??''),
                        // ),
                        ListTile(
                          leading: const SelectableText('Approval Date:'),
                          title: SelectableText(DateFormat('yMMMEd')
                              .format(formValue['AppvDate'])),
                        ),
                        ListTile(
                          leading: const SelectableText('Creation Date:'),
                          title: SelectableText(DateFormat('yMMMEd')
                              .format(formValue['CrtionDate']??'')),
                        ),
                        //AppvDate
                      ],
                    ),
                    const Divider(),
                    const SelectableText("Customer's Hierachy consist of..."),
                    Wrap(runSpacing: 10, children: [
                      AcxNavButton(listOfContent: [
                        const SelectableText('Company'),
                        SelectableText(formValue['CmpyCnt'])
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>().navigatePath(
                                  '/custmgmt/cmpy/$custEttyId/list');
                            },
                            icon: const Icon(Icons.add))
                      ]),
                      sbw10,
                      AcxNavButton(listOfContent: [
                        const SelectableText('Cost Center'),
                        SelectableText(formValue['CcCtr'])
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>().navigatePath(
                                  '/custmgmt/costcen/$custEttyId/list');
                            },
                            icon: const Icon(Icons.add))
                      ]),
                      sbw10,
                      AcxNavButton(listOfContent: [
                        const SelectableText('Member'),
                        SelectableText(formValue['MbrCnt'])
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>().navigatePath(
                                  '/custmgmt/member/$custEttyId/list');
                            },
                            icon: const Icon(Icons.add))
                      ]),
                      sbw10,
                      AcxNavButton(listOfContent: [
                        const SelectableText('Media'),
                        SelectableText(formValue['MediaCnt'])
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>().navigatePath(
                                  '/custmgmt/media/$custEttyId/list');
                            },
                            icon: const Icon(Icons.add))
                      ]),
                    ]),
                    div,
                    const SelectableText("Customer has signed up..."),
                    Row(children: [
                      AcxNavButton(listOfContent: [
                        const SelectableText('Program'),
                        SelectableText(formValue['PrgCnt'])
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              // /custmgmt/cust/16/program/list
                              singleton<AppRouter>().navigatePath(
                                  '/custmgmt/cust/$custEttyId/program/list');
                            },
                            icon: const Icon(Icons.add)),
                      ]),
                    ]),
                    div,
                  ],
                ),
              ),
              // SizedBox(
              //   height: 1280,
              //   child: buildOverViewForm(custEttyId.toString())),
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
}
