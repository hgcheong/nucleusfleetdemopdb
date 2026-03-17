import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:intl/intl.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';

const int wid=756;

@RoutePage()
class PrgCustFeeMedia extends StatelessWidget {
  const PrgCustFeeMedia(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam('mediaType') this.mediaType});

  final String? prgEttyId;
  final String? mediaType;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return PrgCustFeeMediaForm(
      prgEttyId: prgEttyId,
      mediaType: convStrNewOrNullToNull(mediaType),
    );
  }
}

class PrgCustFeeMediaForm extends ConsumerWidget {
  const PrgCustFeeMediaForm({
    super.key,
    this.prgEttyId,
    this.mediaType,
  });
  final String? prgEttyId;
  final String? mediaType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustMediaFee/queryasync',
        params: {"PrgEttyId": prgEttyId, "MediaType": mediaType},
        showMsg: false);
    final listUrl = '/prgmgmt/custsetup/$prgEttyId/pcfeelanding/pcfeemlist';
    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data!.isNotEmpty) {
            List<dynamic>? mediaList = theData.data;
            List<Widget> toReturnWidget = [];
            toReturnWidget.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText('Media Fees for $mediaType'),
                AcxBackToList(listUrl: listUrl),
              ],
            ));
            toReturnWidget.add(const Divider());
            for (var element in mediaList!.toList()) {
              var queryx = QueryObject(
                  querysql: '/sp/ApiPrgCustMediaFeePlanList/queryasync',
                  params: {
                    "PrgEttyId": prgEttyId,
                    "FeeType": element['FeeType'].toString(),
                    "MediaType": element['MediaType'].toString()
                  },
                  showMsg: false);
              var resultSet = ref.watch(ReturndatafreezedProvider(queryx));
              resultSet.when(
                  data: (data) {
                    toReturnWidget.add(SizedBox(
                      width: 250,
                      child: PrgCustFeePlanList(
                          srcData: data,
                          prgEttyId: prgEttyId,
                          mediaType: element['MediaType'].toString(),
                          feeType: element['FeeType'].toString(),
                          query: queryx),
                    ));
                  },
                  error: (error, stackTrace) {
                    Toast.error(error.toString());
                  },
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ));
            }

            return Wrap(direction: Axis.horizontal, children: toReturnWidget);
          }
          return const SelectableText('Nothing');
        });
  }
}

class PrgCustFeePlanList extends ConsumerWidget {
  const PrgCustFeePlanList(
      {super.key,
      required this.srcData,
      this.prgEttyId,
      this.mediaType,
      this.feeType,
      required this.query});

  final Returndata srcData;
  final String? prgEttyId;
  final String? mediaType;
  final String? feeType;
  final QueryObject query;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final hdrText = SelectableText('$feeType');
    if (srcData.data == null) {
      return const SizedBox(
          height: 300, child: Expanded(child: SelectableText('No Record ')));
    }
    if (srcData.data![0]['PlanId'] == null) {
      return Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hdrText,
          ElevatedButton(
              onPressed: () async {
                await showAcxDialog(
                        context,
                        PrgCustFeePlanListForm(
                            prgEttyId: prgEttyId.toString(),
                            mediaType: mediaType,
                            feeType: feeType,
                            planId: null,
                            query: query))
                    .then((value) {
                  ref.invalidate(ReturndatafreezedProvider(query));
                });
                //
              },
              child: const Icon(Icons.post_add)),
          SelectableText('No Txn Plan for $feeType'),
          SizedBox(
              height: 100,
              child: ListView(
                children: const [SelectableText('No Record')],
              ))
        ],
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
                        query: query,
                        prgEttyId: prgEttyId.toString(),
                        mediaType: mediaType,
                        feeType: feeType,
                        planId: null,
                      ));
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
                            query: query,
                            prgEttyId: prgEttyId.toString(),
                            mediaType: mediaType,
                            feeType: feeType,
                            planId: currentData['PlanId'].toString(),
                          ));
                    },
                    title: SelectableText(
                        '${currentData['TxnPlanDscp'].toString()} to ${currentData['FeeType'].toString()} (${fmtDateStr(currentData['FromDate'].toString())} to ${fmtDateStr(currentData['ToDate'].toString())}'),
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
                                  '/sp/ApiPrgCustMediaFeePlanDel/queryasync',
                              params: {
                                "PrgEttyId": currentData['PrgEttyId'],
                                "MediaType": currentData['MediaType'],
                                "FeeType": currentData['FeeType'],
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
                        icon: const Icon(Icons
                            .delete))); // return const SelectableText('Test 123');
              },
            ),
          ),
        ]);
  }
}

class PrgCustFeePlanListForm extends ConsumerWidget {
  const PrgCustFeePlanListForm(
      {super.key,
      required this.prgEttyId,
      this.txnPlan,
      this.feeType,
      this.mediaType,
      this.fromDate,
      this.toDate,
      this.planId,
      required this.query});
  final String? prgEttyId;
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
    var formValue = {
      "PrgEttyId": prgEttyId,
      "MediaType": mediaType,
      "FeeType": feeType,
      "TxnPlan": 0,
      "FromDate": fromDate,
      "ToDate": toDate,
      "PlanId": planId
    };

    final queryPlanListForm = QueryObject(
        querysql: '/sp/ApiPrgCustMediaFeePlan/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "MediaType": mediaType,
          "FeeType": feeType,
          "PlanId": planId
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
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'PrgEttyId'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'MdfDate'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'FeeType'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'PlanId'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'MediaType'),
                    Flexible(
                        flex: 2,
                        child: FormBuilderField(
                            name: 'TxnPlan',
                            builder: (field) {
                              return AcxSearchBoxMap(
                                  returnSelectedRef: (dynamic val) {
                                    field.didChange(val['TxnPlan']);
                                  },
                                  selectedRef: {
                                    'TxnPlan':
                                        formValue['TxnPlan'].toString()
                                  },
                                  inputText: 'Fee Plan',
                                  inputIcon: const Icon(Icons.search),
                                  querysql: '/view/async/VwTxnPlan',
                                  searchText: 'TxnPlanDscp',
                                  keyField: 'TxnPlan',
                                  params: const {});
                            })),
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              valueTransformer: (v) {
                                // return v!.toIso8601String();
                                if (v != null) {
                                  return DateFormat('yMMMEd').format(v);
                                }
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
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              valueTransformer: (v) {
                                if (v != null) {
                                  return DateFormat('yMMMEd').format(v);
                                }
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
                                  onPressed: () {
                                    // _formKey.currentState!
                                    //     .fields['ToDate']
                                    //     ?.didChange(null);
                                  },
                                ),
                              ),
                              initialTime: const TimeOfDay(hour: 8, minute: 0),
                              // locale: const Locale.fromSubtags(languageCode: 'fr'),
                            ),
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
                        AcxSaveButtonManual(
                          onSave: () async {
                              if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                            formKeyPlan.currentState!.save();
                            Map<String, dynamic> toPost =
                                convertFormValueToSave(
                                    formKeyPlan.currentState!.value,
                                    theData.columnInfo);
                            final querySave = QueryObject(
                                querysql:
                                    '/sp/ApiPrgCustMediaFeePlanSave/queryasync',
                                params: toPost,
                                showMsg: false);

                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((value) {
                              Toast.showresult(value);
                              ref.invalidate(ReturndatafreezedProvider(query));
                              singleton<AppRouter>().navigatePath(
                                  '/prgmgmt/custsetup/$prgEttyId/pcfeelanding/pcfeemlist/pcfeem/$mediaType');
                            });
                          },
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
