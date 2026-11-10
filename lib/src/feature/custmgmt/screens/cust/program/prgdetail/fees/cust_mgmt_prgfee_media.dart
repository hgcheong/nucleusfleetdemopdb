import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:intl/intl.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';

const int wid=839;

@RoutePage()
class CustMgmtProgramFeeMedia extends StatelessWidget {
  const CustMgmtProgramFeeMedia(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam('mediaType') this.mediaType,
      @PathParam('billingEttyType') this.billingEttyType});
  final String? prgEttyId;
  final String? custEttyId;
  final String? mediaType;
  final String? billingEttyType;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return CustMgmtProgramFeeMediaForm(
        prgEttyId: prgEttyId,
        custEttyId: custEttyId,
        mediaType: convStrNewOrNullToNull(mediaType),
        billingEttyType: billingEttyType.toString());
  }
}

class CustMgmtProgramFeeMediaForm extends ConsumerWidget {
  const CustMgmtProgramFeeMediaForm(
      {super.key,
      this.custEttyId,
      this.prgEttyId,
      this.mediaType,
      required this.billingEttyType});
  final String? custEttyId;
  final String? prgEttyId;
  final String? mediaType;
  final String billingEttyType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    //  final formKey = GlobalKey<FormBuilderState>();
    //   final isLoaindg = ref.watch(loadingProvider);

    final query = QueryObject(
        querysql: '/sp/ApiMgmtCustMediaType/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "PrgEttyId": prgEttyId,
          "MediaType": mediaType
        },
        showMsg: false);

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data!.isNotEmpty) {
            List<dynamic>? mediaList = theData.data;
            List<Widget> toReturnWidget = [];

            for (var element in mediaList!.toList()) {
              var queryx = QueryObject(
                  querysql: '/sp/ApiMgmtCustMediaFeePlanList/queryasync',
                  params: {
                    "CustEttyId": custEttyId,
                    "PrgEttyId": prgEttyId,
                    "FeeId": element['FeeId'],
                    "FeeType": element['FeeType'].toString(),
                    "MediaType": element['MediaType'].toString()
                  },
                  showMsg: false);
              var resultSet = ref.watch(ReturndatafreezedProvider(queryx));
              resultSet.when(
                  data: (data) {
                    var initialVal = 'N';
                    if (data.data != null && data.data!.isNotEmpty) {
                      initialVal = data.data![0]['FeeInd'].toString();
                    }
                    if (mediaList.indexOf(element) == 0) {
                      toReturnWidget
                          .add(SelectableText('Media Fees for $mediaType'));

                      toReturnWidget.add(Row(crossAxisAlignment: CrossAxisAlignment.start, 
                        children: [
                          Expanded(
                              flex: 3,
                              child: FbSwitch(
                                name: 'handleMe',
                                initialValue: initialVal,
                                label: 'Handle Media Fees at Customer Level',
                                onChanged: (val) async {
                                  final queryDel = QueryObject(
                                      querysql:
                                          '/sp/ApiMgmtCustMediaFeeIndSave/queryasync',
                                      params: {
                                        "PrgEttyId": prgEttyId,
                                        "CustEttyId": custEttyId,
                                        "MediaType": mediaType,
                                        "FeeInd": val == true ? 'Y' : 'N'
                                      },
                                      showMsg: false);
                                  final resultDel = ref.read(
                                      ReturndatafreezedProvider(queryDel)
                                          .future);
                                  resultDel.then((value) {
                                    ref.invalidate(
                                        ReturndatafreezedProvider(query));
                                    Toast.showresult(value);
                                  });
                                },
                              )),
                          const Spacer(flex: 5),
                          Expanded(
                              flex: 1,
                              child: AcxBackToList(
                                  listUrl:
                                      '/custmgmt/custprg/$custEttyId/$prgEttyId/$billingEttyType/fees/media')),
                        ],
                      ));
                      toReturnWidget.add(const Divider());
                    }
                    toReturnWidget.add(SizedBox(
                      width: 250,
                      child: CustMgmtFeePlanList(
                        srcData: data,
                        custEttyId: custEttyId,
                        //Not Using FeeId because need to get from response
                        feeId: data.data![0]['FeeId'].toString(),
                        prgEttyId: prgEttyId,
                        mediaType: data.data![0]['MediaType'].toString(),
                        feeType: data.data![0]['FeeType'].toString(),
                        feeTypeDscp: element['FeeTypeDscp'].toString(),
                        query: queryx,
                      ),
                    ));
                  },
                  error: (error, stackTrace) {
                    Toast.error(error.toString());
                  },
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ));
            }

            // return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: toReturnWidget);

            return Wrap(direction: Axis.horizontal, children: toReturnWidget);
          }
          return const SelectableText('Nothing');
        });
  }
}

class CustMgmtFeePlanList extends ConsumerWidget {
  const CustMgmtFeePlanList(
      {super.key,
      required this.srcData,
      this.custEttyId,
      this.prgEttyId,
      this.mediaType,
      this.feeType,
      this.feeTypeDscp,
      this.feeId,
      required this.query});

  final Returndata srcData;
  final String? custEttyId;
  final String? prgEttyId;
  final String? mediaType;
  final String? feeType;
  final String? feeTypeDscp;
  final String? feeId;
  final QueryObject query;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final hdrText = SelectableText("$feeTypeDscp");
    if (srcData.data == null) {
      return const SizedBox(
          height: 300, child: Expanded(child: SelectableText('No Record ')));
    }
    if (srcData.data![0]['PlanId'] == null) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hdrText,
            ElevatedButton(
                onPressed: () async {
                  await showAcxDialog(
                      context,
                      PrgCustFeePlanListForm(
                          custEttyId: custEttyId,
                          prgEttyId: prgEttyId.toString(),
                          mediaType: mediaType,
                          feeId: convStrNewOrNullToNull(feeId),
                          feeType: feeType,
                          planId: null,
                          query: query));
                  //     ref.invalidate(ReturndatafreezedProvider(query));
                },
                child: const Icon(Icons.post_add)),
            SelectableText("No Txn Plan for $feeTypeDscp"),
            SizedBox(
                height: 100,
                child: ListView(
                  children: const [SelectableText('No Record')],
                ))
          ],
        ),
      );
    }

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hdrText,
          Flexible(
            flex: 1,
            child: ElevatedButton(
                onPressed: () async {
                  await showAcxDialog(
                      context,
                      PrgCustFeePlanListForm(
                          custEttyId: custEttyId,
                          feeId: convStrNewOrNullToNull(
                              srcData.data![0]['FeeId'].toString()),
                          prgEttyId: prgEttyId.toString(),
                          mediaType: mediaType,
                          feeType: feeType,
                          planId: null,
                          query: query));
                  //   ref.invalidate(ReturndatafreezedProvider(query));
                },
                child: const Icon(Icons.post_add)),
          ),
          // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
          SizedBox(
            height: 300,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: srcData.rowcount!,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                final currentData = srcData.data![index];
                return ListTile(
                    onTap: () async {
                      await showAcxDialog(
                          context,
                          PrgCustFeePlanListForm(
                            prgEttyId: prgEttyId,
                            custEttyId: custEttyId,
                            mediaType: mediaType,
                            txnPlan: currentData['TxnPlan'].toString(),
                            feeType: feeType,
                            feeId: convStrNewOrNullToNull(
                                currentData['FeeId'].toString()),
                            planId: currentData['PlanId'].toString(),
                            query: query,
                          ));
                    },
                    title: SelectableText(
                        '${currentData['TxnPlanDscp']} (${fmtDateStr(currentData['FromDate'].toString())} to ${fmtDateStr(currentData['ToDate'].toString())})'),
                    trailing: IconButton(
                        onPressed: () async {
                          bool confirmed = await ConfirmDialog.show(
                            title: "Delete?",
                            body: "Are you sure you want to Delete?",
                            destructive: true,
                            confirmText: "Yes",
                            cancelText: "Cancel",
                          );

                          if (!confirmed) {
                            return;
                          }

                          final queryDel = QueryObject(
                              querysql:
                                  '/sp/ApiMgmtCustMediaFeePlanDel/queryasync',
                              params: {
                                "PrgEttyId": currentData['PrgEttyId'],
                                "CustEttyId": currentData['CustEttyId'],
                                "FeeId": currentData['FeeId'],
                                "PlanId": currentData['PlanId'],
                                "TxnPlan": currentData['TxnPlan'],
                              },
                              showMsg: false);
                          final resultDel = ref
                              .read(ReturndatafreezedProvider(queryDel).future);
                          resultDel.then((value) {
                            ref.invalidate(ReturndatafreezedProvider(query));
                            Toast.showresult(value);
                          });
                        },
                        icon: const Icon(Icons.delete)));
              },
            ),
          ),
        ]);
  }
}

class PrgCustFeePlanListForm extends ConsumerWidget {
  const PrgCustFeePlanListForm(
      {super.key,
      this.custEttyId,
      required this.prgEttyId,
      this.feeId,
      this.txnPlan,
      this.feeType,
      this.mediaType,
      this.fromDate,
      this.toDate,
      this.planId,
      required this.query});

  final String? custEttyId;
  final String? prgEttyId;
  final String? feeId;
  final String? txnPlan;
  final String? feeType;
  final String? mediaType;
  final String? fromDate;
  final String? toDate;
  final String? planId;
  final QueryObject query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      "CustEttyId": custEttyId,
      "PrgEttyId": prgEttyId,
      "FeeId": feeId,
      "MediaType": mediaType,
      "FeeType": feeType,
      "TxnPlan": txnPlan,
      "PlanId": planId,
      "FromDate": fromDate,
      "ToDate": toDate,
    };

    final queryPlanListForm = QueryObject(
        querysql: '/sp/ApiMgmtCustMediaFeePlan/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "PrgEttyId": prgEttyId,
          "FeeId": feeId,
          "PlanId": planId,
          "MediaType": mediaType,
          "FeeType": feeType,
        },
        showMsg: false);

    final formDataPlanListForm =
        ref.watch(ReturndatafreezedProvider(queryPlanListForm));

    return AsyncValueWidget<Returndata>(
      value: formDataPlanListForm,
      data: (theData) {
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        } else {}

        return FormBuilder(
          key: formKeyPlan,
          initialValue: formValue,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 10,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const FbHiddenText(name: 'MdfDate'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'CustEttyId'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'PrgEttyId'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'FeeId'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'PlanId'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'FeeType'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'MediaType'),
                    Flexible(
                      flex: 2,
                      child: FbLibView(
                        name: 'TxnPlan',
                        label: 'Fee Plan',
                        querySql: '/sp/ApiPlanList/queryasync',
                        params: {"TxnType": feeType},
                        keyField: 'TxnPlan',
                        searchText: 'TxnPlanDscp',
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: FbField(child: FormBuilderDateTimePicker(
                              valueTransformer: (v) {
                                // return v!.toIso8601String();
                                return DateFormat('yMMMEd').format(v!);
                              },
                              name: 'FromDate',
                              format: DateFormat.yMMMEd(),
                              initialEntryMode: DatePickerEntryMode.calendar,
                              inputType: InputType.date,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'FromDate',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    // _formKey.currentState!
                                    //     .fields['FromDate']
                                    //     ?.didChange(null);
                                  },
                                ),
                              ),
                              initialTime: const TimeOfDay(hour: 8, minute: 0),
                              // locale: const Locale.fromSubtags(languageCode: 'fr'),
                            )),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: FbField(child: FormBuilderDateTimePicker(
                              valueTransformer: (v) {
                                // return v!.toIso8601String();
                                return DateFormat('yMMMEd').format(v!);
                              },
                              name: 'ToDate',
                              format: DateFormat.yMMMEd(),
                              initialEntryMode: DatePickerEntryMode.calendar,
                              inputType: InputType.date,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'To Date',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {},
                                ),
                              ),
                              initialTime: const TimeOfDay(hour: 8, minute: 0),
                              // locale: const Locale.fromSubtags(languageCode: 'fr'),
                            )),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (formKeyPlan.currentState != null) {
                              formKeyPlan.currentState!.save();
                              final planId =
                                  formKeyPlan.currentState!.value['PlanId'];
                              formKeyPlan.currentState!.patchValue(
                                  {'PlanId': planId == '' ? null : planId});

                              Map<String, dynamic> toPost =
                                  convertFormValueToSave(
                                      formKeyPlan.currentState!.value,
                                      theData.columnInfo);
                              final querySave = QueryObject(
                                  querysql:
                                      '/sp/ApiMgmtCustMediaFeePlanSave/queryasync',
                                  params: toPost,
                                  showMsg: true);
                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((value) {
                                Toast.showresult(value);
                                //singleton<AppRouter>().maybePop();
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                              });
                            }
                          },
                          child: const Icon(Icons.save),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.maybePop();
                          },
                          child: const RotationTransition(
                            turns: AlwaysStoppedAnimation(180 / 360),
                            child: Icon(
                              Icons.exit_to_app,
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
