import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';

import 'package:trina_grid/trina_grid.dart';

const int wid=766;

@RoutePage()
class PrgCustMediaNumRange extends ConsumerWidget {
  const PrgCustMediaNumRange(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Center(
        child: AcxTrinaGridWithColumn(
      querysql: '/sp/ApiPrgCustMediaRangeList/queryasync',
      params: {'PrgEttyId': prgEttyId},
      idField: 'RangeId',
      spName: 'ApiPrgCustMediaRangeList',
      useNav: false,
      onNew: () {
          if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Dialog(
                child: NumRangeForm(
              prgEttyId: prgEttyId,
              rangeId: null,
            ));
          },
        );
      },
      onSelectedTap: (TrinaRow val) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Dialog(
                child: NumRangeForm(
              prgEttyId: val.cells['PrgEttyId']!.value.toString(),
              rangeId: val.cells['RangeId']!.value.toString(),
            ));
          },
        );
      },
    ));
  }
}

class NumRangeForm extends ConsumerWidget {
  const NumRangeForm({
    super.key,
    required this.prgEttyId,
    this.rangeId,
  });
  final String? prgEttyId;
  final String? rangeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formValue = {
      'PrgEttyId': prgEttyId,
      'RangeId': rangeId,
      'LastAssignedMediaNo': "0"
    };
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustMediaRange/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "RangeId": convStrNewOrNullToNull(rangeId)
        },
        showMsg: false);
    final formData = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (data) {
          if (data.data != null) {
            formValue = convertFormValueToDisplay(
                data.data![0] as Map<String, dynamic>, data.columnInfo!);
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
                          name: 'RangeId'),
                      const Flexible(
                        flex: 2,
                        child: FbText(
                          name: 'FromMediaNo',
                          label:
                                'Starting Number (excluding check digit)',
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: false),
                      
                        ),
                      ),
                      const Flexible(
                        flex: 2,
                        child:  FbText(
                          name: 'ToMediaNo',
                               label: 'Ending Number (excluding check digit)',
                          keyboardType:  TextInputType.numberWithOptions(
                              decimal: false),
                        ),
                      ),
                      const Flexible(
                          child: FbText(
                        name: 'LastAssignedMediaNo',
                        label: 'Last assigned Number',
                        readOnly: true,
                      ))
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
                              Map<String, dynamic> toPost =
                                  Map.from(formKeyPlan.currentState!.value);

                              toPost.remove('LastAssignedMediaNo');
                              final querySave = QueryObject(
                                  querysql:
                                      '/sp/ApiPrgCustMediaRangeSave/queryasync',
                                  params: toPost,
                                  showMsg: true);
                              final listData = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              listData.then((value) {
                                //   Toast.message(value.toString());
                                if (context.mounted) {
                                  context.maybePop();
                                  singleton<AppRouter>()
                                      .navigatePath(
                                          '/prgmgmt/custsetup/$prgEttyId/pcmlanding')
                                      .then((val) {
                                    ref.invalidate(
                                        ReturndatafreezedProvider(query));
                                  });
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
