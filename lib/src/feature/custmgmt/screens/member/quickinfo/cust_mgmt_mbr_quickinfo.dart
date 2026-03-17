import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_navbuttontemplate.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

const int wid=639;

@RoutePage()
class CustMgmtMemberQuickInfo extends HookConsumerWidget {
  const CustMgmtMemberQuickInfo(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId});

  final String? custEttyId;
  final String? mbrEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Center(
      child: CustMgmtMemberInfoForm(
        custEttyId: custEttyId,
        mbrEttyId: mbrEttyId,
      ),
    );
  }
}

class CustMgmtMemberInfoForm extends ConsumerWidget {
  const CustMgmtMemberInfoForm({super.key, this.custEttyId, this.mbrEttyId});

  final String? custEttyId;
  final String? mbrEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final custMgmtCmpyFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "MbrEttyId": mbrEttyId,
      "CostCtr": null,
      "MbrCnt": 0,
      "MediaCnt": 0,
      "MbrRnk": null
    };

    final formData = ref.watch(ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtMbrOverview/queryasync',
        params: {
          "MbrEttyId": mbrEttyId == 'new' ? null : mbrEttyId,
          "CustEttyId": custEttyId
        },
        showMsg: false)));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: custMgmtCmpyFormKey,
            initialValue: formNewValue,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                          
                          children: [
                              const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SelectableText(
                            'Member Info',
                            //   style: hdrStyle,
                          ),
                        ),
                        ListTile(
                          leading: const SelectableText("Title"),
                          title: SelectableText(
                            formNewValue["Title"] ?? "",
                            textAlign: TextAlign.right,
                          ),
                        ),
                        ListTile(
                          leading: const SelectableText("Member Name"),
                          title: SelectableText(
                            formNewValue["MbrName"] ?? "",
                            textAlign: TextAlign.right,
                          ),
                        ),
                        // ListTile(
                        //   leading: const SelectableText("LastName"),
                        //   title: SelectableText(
                        //     formNewValue["LastName"] ?? "",
                        //     textAlign: TextAlign.right,
                        //   ),
                        // ),
                        ],),
                      ),
                 Wrap(runSpacing: 10, children: [
                        sbw10,
                        AcxNavButton(listOfContent: [
                          const SelectableText('Media'),
                          SelectableText(formNewValue['MediaCnt'].toString())
                        ], listOfButton: [
                          IconButton(
                              onPressed: () {
                                singleton<AppRouter>().navigatePath(
                                    '/custmgmt/media/$custEttyId/list');
                              },
                              icon: const Icon(Icons.add))
                        ]),
                      ])
                    
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Card(
                    child: ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SelectableText(
                            'Vehicle Info',
                            //     style: hdrStyle,
                          ),
                        ),
                        ListTile(
                          leading: const SelectableText("Vehicle Number"),
                          title: SelectableText(
                            formNewValue["VhcRgsNo"] ?? "",
                            textAlign: TextAlign.right,
                          ),
                        ),
                        ListTile(
                          leading: const SelectableText("Vehicle Type"),
                          title: SelectableText(
                            formNewValue["VhcTypeDscp"] ?? "",
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SelectableText(
                            'Company Info',
                            //    style: hdrStyle,
                          ),
                        ),
                        ListTile(
                          leading: const SelectableText("Company Name"),
                          title: SelectableText(
                            formNewValue["CmpyName"] ?? "",
                            textAlign: TextAlign.right,
                          ),
                        ),
                        ListTile(
                          leading: const SelectableText("Cost Control"),
                          title: SelectableText(
                            formNewValue["CostCtrDscp"] ?? "",
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //  const Spacer(flex: 5,)
              ],
            ));
      },
    );
  }
}
