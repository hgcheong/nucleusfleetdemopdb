import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_dtp.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'package:nucleusv2/src/utils/uihelpers.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_field.dart';

class PlanFeeLocForm extends ConsumerWidget {
  const PlanFeeLocForm(
      {super.key,
      required this.prgEttyId,
      required this.feeId,
      required this.planId,
      required this.locEttyId});
  final String prgEttyId;
  final String feeId;
  final String planId;
  final String? locEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKeyPlan = GlobalKey<FormBuilderState>();
    final formValue = {
      'FromDate"=': null,
      'ToDate': null,
      'PrgEttyId': prgEttyId,
      'FeeId': feeId,
      'PlanId': null,
      'TxnPlan': null,
      'LocEttyId': locEttyId
    };
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
              child: Column(children: [
                FormBuilderField(
                    builder: (field) {
                      return Container();
                    },
                    name: 'PrgEttyId'),
                FormBuilderField(
                    builder: (field) {
                      return Container();
                    },
                    name: 'LocEttyId'),
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
                              // selectedRef:  {'TxnPlan': txn},
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
                    AcxSaveButtonManual(
                      onSave: () async {
                        
                        formKeyPlan.currentState!.save();
                        final planId =
                            formKeyPlan.currentState!.value['PlanId'];
                        formKeyPlan.currentState!.patchValue(
                            {'PlanId': planId == '' ? null : planId});
                        final querySave = QueryObject(
                            querysql: '/sp/ApiEnrlLocTadFeePlanSave/queryasync?logId=${convStrNewOrNullToNull(locEttyId) ?? 0}',
                            params: formKeyPlan.currentState!.value,
                            showMsg: false);
                        final saveResult = ref
                            .read(ReturndatafreezedProvider(querySave).future);
                        saveResult.then((value) {
                          if (context.mounted) {
                            Toast.showresult(value);
                            context.maybePop();
                          }
                        });
                      },
                    ),
                    AcxAuditLogReqBtn('ApiEnrlLocTadFeePlanSave', ettyId: locEttyId.toString(),),
                    sbh10,
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
  }
}
