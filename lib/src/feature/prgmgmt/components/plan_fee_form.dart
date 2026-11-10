import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class PlanFeeForm extends ConsumerWidget {
  const PlanFeeForm(
      {super.key,
      required this.querySql,
      required this.saveSql,
      required this.prgEttyId,
      required this.feeId,
      required this.planId});
  final String prgEttyId;
  final String feeId;
  final String planId;
  final String querySql;
  final String saveSql;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKeyPlan = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formNewValue = {
      'FromDate': null,
      'ToDate': null,
      'MdfDate': null,
      'PrgEttyId': prgEttyId,
      'FeeId': feeId,
      'PlanId': convStrNewOrNullToNull(planId),
      'TxnPlan': null
    };

    final query = QueryObject(
        querysql: querySql,
        params: {
          "PrgEttyId": prgEttyId,
          "PlanId": convStrNewOrNullToNull(planId),
          "FeeId": feeId
        },
        showMsg: false);

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
            key: formKeyPlan,
            initialValue: formNewValue,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 10,
                    child: Column(children: [
                      const FbHiddenDateTime(name: 'MdfDate'),
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
                      Flexible(
                          flex: 2,
                          child: FbField(child: FormBuilderField(
                              name: 'TxnPlan',
                              builder: (field) {
                                return AcxSearchBoxMap(
                                    returnSelectedRef: (dynamic val) {
                                      field.didChange(val['TxnPlan']);
                                    },
                                    selectedRef: {
                                      'TxnPlan': formNewValue['TxnPlan']
                                    },
                                    inputText: 'Fee Plan',
                                    inputIcon: const Icon(Icons.search),
                                    querysql: '/view/async/VwTxnPlan',
                                    searchText: 'TxnPlanDscp',
                                    keyField: 'TxnPlan',
                                    params: const {});
                              }))),
                      const Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            Flexible(
                              child: FbDateTimePicker(
                                name: 'FromDate',
                                label: 'From Date',
                              ),
                            ),
                            fbFieldGap,
                            Flexible(
                              child: FbDateTimePicker(
                                name: 'ToDate',
                                label: 'To Date',
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
                          ElevatedButton(
                            onPressed: () async {
                              formKeyPlan.currentState!.save();
                              final planId =
                                  formKeyPlan.currentState!.value['PlanId'];
                              formKeyPlan.currentState!.patchValue(
                                  {'PlanId': planId == '' ? null : planId});
                              Map<String, dynamic> toPost =
                                  convertFormValueToSave(
                                      Map.from(formKeyPlan.currentState!.value),
                                      theData.columnInfo);

                              final querySave = QueryObject(
                                  querysql: saveSql,
                                  params: toPost,
                                  showMsg: false);
                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((value) {
                                Toast.showresult(value);
                                if (isSuccess(value.message)) {
                                  if (context.mounted) {
                                    context.maybePop();
                                  }
                                }
                              });
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
        });
  }
}
