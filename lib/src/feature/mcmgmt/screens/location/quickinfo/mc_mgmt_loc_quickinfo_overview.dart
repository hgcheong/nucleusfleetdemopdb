import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=727;

@RoutePage()
class MchtMgmtLocQuickInfoOverView extends StatelessWidget {
  const MchtMgmtLocQuickInfoOverView(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId});

  final String? mchtEttyId;
  final String? locEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return MchtMgmtQuickInfoForm(
      mchtEttyId: mchtEttyId,
      locEttyId: locEttyId,
    );
  }
}

class MchtMgmtQuickInfoForm extends ConsumerWidget {
  const MchtMgmtQuickInfoForm({
    super.key,
    this.mchtEttyId,
    this.locEttyId,
  });

  final String? mchtEttyId;
  final String? locEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
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
        querysql: '/sp/ApiMgmtLocOverview/queryasync',
        params: {"MchtEttyId": mchtEttyId, "LocEttyId": locEttyId},
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
                          leading: const SelectableText('Location Name:'),
                          title:
                              SelectableText(formValue['LocName'] ?? ''),
                        ),
                        ListTile(
                          leading: const SelectableText('Loccation No:'),
                          title: SelectableText(formValue['LocNo'] ?? ''),
                        ),
                        ListTile(
                          leading: const SelectableText('Current Status:'),
                          title:
                              SelectableText(formValue['StsDscp'] ?? ''),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SelectableText("Location's Hierachy consist of..."),
                    Wrap(runSpacing: 10, children: [
                      AcxNavButton(listOfContent: [
                        const SelectableText('TAD'),
                        SelectableText(formValue['TadCnt'] ?? '')
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>().navigatePath(
                                  '/mcmgmt/tad/$mchtEttyId/list');
                            },
                            icon: const Icon(Icons.add))
                      ]),
                    ]),
                    div,
                    const SelectableText("Location has signed up.."),
                    Wrap(runSpacing: 10, children: [
                      AcxNavButton(listOfContent: [
                        const SelectableText('Program'),
                        SelectableText(formValue['PrgCnt'] ?? '')
                      ], listOfButton: [
                        IconButton(
                            onPressed: () {
                              singleton<AppRouter>()
                                  .navigatePath('././program');

                              ///mcmgmt/loc/83/detail/86/program
                            },
                            icon: const Icon(Icons.add))
                      ]),
                    ]),
                    div,
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        ListTile(
                          leading: const SelectableText('Agreement No:'),
                          title:
                              SelectableText(formValue['AgrmtNo'] ?? ''),
                        ),
                        ListTile(
                          leading: const SelectableText('Agreement Date:'),
                          title: SelectableText(
                            formValue['AgrmtDate'] == null
                                ? ''
                                :
                            DateFormat('yMMMEd')
                              .format(formValue['AgrmtDate'])),
                        ),
                        ListTile(
                          leading: const SelectableText('Registration Name:'),
                          title: SelectableText(
                              formValue['RgstionName'] ?? ''),
                        ),
                        ListTile(
                          leading: const SelectableText('Registration No:'),
                          title:
                              SelectableText(formValue['RgstionNo'] ?? ''),
                        ),
                        ListTile(
                          leading: const SelectableText('Registration Date:'),
                          title:  SelectableText(formValue['RgstionDate'] == null?'': DateFormat('yMMMEd')
                              .format(formValue['RgstionDate'])),
                        ),
                        ListTile(
                          leading: const SelectableText('Creation Date:'),
                          title: SelectableText(formValue['CrtionDate'] == null ? '': DateFormat('yMMMEd')
                              .format(formValue['CrtionDate'])),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: const [
                   // Tooltip(message: "Message", child: Icon(Icons.message))
                  ],
                ),
              ),
            ],
          );
        });
  }
}
