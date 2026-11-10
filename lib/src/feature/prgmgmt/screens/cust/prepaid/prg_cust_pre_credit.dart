import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/components/acx_searchbox.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/libref/libref.dart';

const int wid=780;

@RoutePage()
class PrgCustPrePaidCredit extends StatelessWidget {
  const PrgCustPrePaidCredit(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyid});

  final String? prgEttyid;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Center(
      child: Column(
        children: [
          PrgCustPreCreditForm(
            prgEttyId: prgEttyid,
          ),
        ],
      ),
    );
  }
}

class PrgCustPreCreditForm extends ConsumerWidget {
  const PrgCustPreCreditForm({
    super.key,
    required this.prgEttyId,
  });
  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiPrgCustPrepaidSetup/queryasync',
        params: {"PrgEttyId": prgEttyId},
        showMsg: false);

    Map<String, dynamic> formValue = {
      "Reloadable": null,
      "CrExpType": null,
      "CrExpUnit": null,
      "CrExpValue": null,
      "CrExpDate": null,
      "MaxCrBal": null,
      "PrgEttyId": prgEttyId,
      "SetupId": null
    };

    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          formValue =
              convertFormTrueFalseValue(formValue, ['Reloadable']);
        } else {
          return const Center(child: SelectableText('No Record Found'));
        }

        return FormBuilder(
          key: formKey,
          initialValue: formValue,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 5,
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
                        name: 'SetupId'),
                    FormBuilderField(
                        builder: (field) {
                          return Container();
                        },
                        name: 'CrExpDate'),
                    FbField(child: FormBuilderSwitch(
                      name: 'Reloadable',
                      title: const SelectableText('Reloadable'),
                      valueTransformer: (value) {
                        return value == false ? 'N' : 'Y';
                      },
                    )),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: SelectableText('Credit Balance')),
                    const FbText(
                      name: 'MaxCrBal',
                      label: 'Credit balance ceiling',
               
                    ),
                    FormBuilderField(
                        name: 'CrExpType',
                        builder: (FormFieldState<dynamic> field) {
                          return AcxSearchBox(
                              returnSelectedRef: (Libref? val) {
                                val != null
                                    ? field.didChange(val.refCd)
                                    : field.didChange(null);
                              },
                              selectedRef: Libref(
                                  refCd:
                                      formValue['CrExpType'].toString()),
                              inputText: 'eg. First Transaction Date',
                              querysql: '/sp/GetLibRef/queryasyncnouser',
                              params: const {
                                "RefType": "CrExpType",
                                "BitInd": null
                              });
                        }),
                    FormBuilderField(
                        name: 'CrExpUnit',
                        builder: (FormFieldState<dynamic> field) {
                          return AcxSearchBox(
                              returnSelectedRef: (Libref? val) {
                                val != null
                                    ? field.didChange(val.refCd)
                                    : field.didChange(null);
                              },
                              selectedRef: Libref(
                                  refCd:
                                      formValue['CrExpUnit'].toString()),
                              inputText: 'eg. Month',
                              querysql: '/sp/GetLibRef/queryasyncnouser',
                              params: const {
                                "RefType": "CrExpUnit",
                                "BitInd": null
                              });
                        }),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: SelectableText('Credit Expiry Period')),
                    const FbText(
                      name: 'CrExpValue',
                      label: 'eg. 24',
                    ),
                    const SelectableText('or'),
                    const Expanded(
                        child: FbDateTimePicker(
                      name: 'CrExpDate',
                      label: 'Credit Expiry Date',
                    )),
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
                            formKey.currentState!.save();
                            Map<String, dynamic> toPost =
                                convertFormValueToSave(
                                    formKey.currentState!.value,
                                    theData.columnInfo);
                            final querySave = QueryObject(
                                querysql:
                                    '/sp/ApiPrgCustPrepaidSetupSave/queryasync',
                                params: toPost,
                                showMsg: false);
                            final saveResult = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            saveResult.then((value) {
                              Toast.showresult(value);
                            });
                          },
                          child: const Icon(Icons.save),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
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
