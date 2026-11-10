import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class AcxVwTxnPlanForm extends ConsumerWidget {
  const AcxVwTxnPlanForm(
      {super.key,
      required this.hiddenFields,
      required this.querySaveSql,
      required this.query,
      this.feeCtgry});

  final Map<String, dynamic> hiddenFields;
  final String querySaveSql;
  final QueryObject query;
  final String? feeCtgry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKeyPlan = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {};
    List<Widget> hiddenWidget = [];

    hiddenFields.forEach(
      (key, value) {
        hiddenWidget.add(FbHiddenText(name: key));
      },
    );

    final formDataPlanListForm = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
      value: formDataPlanListForm,
      data: (theData) {
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }

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
                    ...hiddenWidget,
                    feeCtgry == null
                        ? Flexible(
                            flex: 2,
                            child: FormBuilderField(
                                name: 'TxnPlan',
                                builder: (field) {
                                  return AcxSearchBoxMap(
                                      returnSelectedRef: (dynamic val) {
                                        field.didChange(val['TxnPlan']);
                                      },
                                      selectedRef: {
                                        'TxnPlan': formValue['TxnPlan']
                                            .toString()
                                      },
                                      inputText: 'Fee Plan',
                                      inputIcon: const Icon(Icons.search),
                                      querysql: '/view/async/VwTxnPlan',
                                      searchText: 'TxnPlanDscp',
                                      keyField: 'TxnPlan',
                                      params: const {});
                                }))
                        : FbLibView(
                            name: 'TxnPlan',
                            label: 'Fee Plan',
                            querySql: '/sp/ApiPlanList/queryasync',
                            params: {"TxnType": feeCtgry},
                            keyField: 'TxnPlan',
                            searchText: 'TxnPlanDscp',
                          ),
                    const Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                              child: FbDateTimePicker(
                                  name: 'FromDate', label: 'From Date')),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              child: FbDateTimePicker(
                                  name: 'ToDate', label: 'To Date'))
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
                        AcxSaveButtonManual(onSave: () {
                          formKeyPlan.currentState!.save();
                          final planId =
                              formKeyPlan.currentState!.value['PlanId'];
                          formKeyPlan.currentState!.patchValue(
                              {'PlanId': planId == '' ? null : planId});
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              formKeyPlan.currentState!.value,
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: querySaveSql,
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              // ref.invalidate(ReturndatafreezedProvider(query));
                            }
                          });
                        }),
                        AcxAuditLogReqBtn(querySaveSql,),
                        sbh10,
                        ElevatedButton(
                          onPressed: () {
                            context.maybePop();
                          },
                          child: const Icon(
                            Icons.exit_to_app,
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
