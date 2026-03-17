import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

const int wid=763;

@RoutePage()
class PrgCustMediaMType extends StatelessWidget {
  const PrgCustMediaMType(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam('mediaTypeId') this.mediaTypeId});

  final String? prgEttyId;
  final String? mediaTypeId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return PrgCustMediaMTypeForm(
      prgEttyId: prgEttyId,
      mediaTypeId: convStrNewOrNullToNull(mediaTypeId),
    );
  }
}

class PrgCustMediaMTypeForm extends ConsumerWidget {
  const PrgCustMediaMTypeForm({
    super.key,
    this.prgEttyId,
    this.mediaTypeId,
  });
  final String? prgEttyId;
  final String? mediaTypeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();
    //   final isLoaindg = ref.watch(loadingProvider);
    final listUrl = '/prgmgmt/custsetup/$prgEttyId/pcmlanding/pcmmtypelist';
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustMediaType/queryasync',
        params: {"PrgEttyId": prgEttyId, "MediaTypeId": mediaTypeId},
        showMsg: false);

    var formNewValue = {
      "PrgEttyId": prgEttyId,
      "MediaType": "",
      "ImprintFmt": "",
      "AutoRnwl": false,
      "RequireImprint": false,
      "RequireAtvtion": false,
      "RequireTac": false,
      "TacType": "",
      "MaxTxnPinAttempt": false,
      "ExpMth": "0",
      "RnwlMth": "0",
      "Track2ExpDatePos": "0",
      "MediaTypeId": mediaTypeId
    };
    //final formValue = useState<Map<String, dynamic>>(formNewValue);

    final formData = ref.watch(ReturndatafreezedProvider(query));
    final queryOptions = QueryObject(
        querysql: '/sp/GetLibRef/queryasyncnouser',
        params: {"RefType": "TACTYPE", "BitInd": null},
        showMsg: false);
    final queryOptionValue = ref.watch(ReturndatafreezedProvider(queryOptions));
    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
            formNewValue = convertFormTrueFalseValue(formNewValue, [
              'AutoRnwl',
              'RequireImprint',
              'RequireAtvtion',
              'RequireTac',
              'MaxTxnPinAttempt'
            ]);
          } else {}

          return queryOptionValue.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text(error.toString()),),
              data: (afterOptionData) {
                return FormBuilder(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.always,
                    initialValue: formNewValue,
                    onChanged: () {
                      formKey.currentState!.save();
                    },
                    child: Row(
                      children: [
                        FormBuilderField(
                          name: 'PrgEttyId',
                          builder: (FormFieldState f) {
                            return Container();
                          },
                        ),
                        FormBuilderField(
                          name: 'MediaTypeId',
                          builder: (FormFieldState f) {
                            return Container();
                          },
                        ),
                        FormBuilderField(
                          name: 'MaxTxnPinAttempt',
                          builder: (FormFieldState f) {
                            return Container();
                          },
                        ),
                        FormBuilderField(
                          name: 'Track2ExpDatePos',
                          builder: (FormFieldState f) {
                            return Container();
                          },
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FbLibView(
                                  name: 'MediaType',
                                  label: 'Supported Media Type',
                                  params: const {
                                    "RefType": "MediaType",
                                    "BitInd": null
                                  },
                                  keyField: 'RefCd',
                                  searchText: 'Dscp',
                                  querySql: '/sp/GetLibRef/queryasyncnouser',
                                  initialValue:
                                      formNewValue['MediaType'].toString(),
                                ),
                                FbLibView(
                                  name: 'ImprintFmt',
                                  label: 'Media Production Interface Format',
                                  params: const {
                                    "RefType": "IMPRTEXPFMT",
                                    "BitInd": null
                                  },
                                  keyField: 'RefCd',
                                  searchText: 'Dscp',
                                  querySql: '/sp/GetLibRef/queryasyncnouser',
                                  initialValue:
                                      formNewValue['ImprintFmt'].toString(),
                                ),
                                const FbText(
                                  name: 'ExpMth',
                                  label: 'Media Expiry Month',
                                ),
                                const FbText(
                                  name: 'RnwlMth',
                                  label: 'Card Renewal Pre-Issue Month',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SelectableText('Media Attributes'),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FormBuilderSwitch(
                                        name: 'RequireImprint',
                                        title: const SelectableText(
                                            'Card Imprint'),
                                        valueTransformer: (value) {
                                          return value == false ? 'N' : 'Y';
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: FormBuilderSwitch(
                                        name: 'RequireTac',
                                        title: const SelectableText(
                                            'Require Transaction TAC'),
                                        valueTransformer: (value) {
                                          return value == false ? 'N' : 'Y';
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FormBuilderSwitch(
                                        name: 'RequireAtvtion',
                                        title: const SelectableText(
                                            'Media Require Activation'),
                                        valueTransformer: (value) {
                                          return value == false ? 'N' : 'Y';
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: FormBuilderSwitch(
                                        name: 'AutoRnwl',
                                        title: const SelectableText(
                                            'Auto Renewal'),
                                        valueTransformer: (value) {
                                          return value == false ? 'N' : 'Y';
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: FormBuilderRadioGroup<dynamic>(
                                    decoration: const InputDecoration(
                                      labelText: 'Type of Transaction TAC',
                                    ),
                                    // initialValue: 'LASTDAY',
                                    name: 'TacType',
                                    activeColor: Colors.green,
                                    options: afterOptionData.data!
                                        .toList()
                                        .map((lang) => FormBuilderFieldOption(
                                              value: lang['RefCd'],
                                              child:
                                                  SelectableText(lang['Dscp']),
                                            ))
                                        .toList(growable: false),
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(children: [
                            AcxSaveButtonManual(onSave: () {
                                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                              formKey.currentState!.save();
                              Map<String, dynamic> toPost =
                                  convertFormValueToSave(
                                      formKey.currentState!.value,
                                      theData.columnInfo);
                              final querySave = QueryObject(
                                  querysql:
                                      '/sp/ApiPrgCustMediaTypeSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                                  params: toPost,
                                  showMsg: false);
                              final saveResult = ref.read(
                                  ReturndatafreezedProvider(querySave).future);
                              saveResult.then((Returndata value) {
                                Toast.showresult(value);
                                if (isSuccess(value.message)) {
                                  if (context.mounted) {
                                    singleton<AppRouter>()
                                        .navigatePath(getAfterSavePath(context,
                                            value.output, '@MediaTypeId'))
                                        .then((val) {
                                      ref.invalidate(
                                          ReturndatafreezedProvider(query));
                                    });
                                  }
                                }
                              });
                            }),
                            sbh10,
                            AcxBackToList(listUrl: listUrl),
                            sbh10,
                            AcxAuditLogReqBtn('ApiPrgCustMediaTypeSave',ettyId: prgEttyId.toString(),)
                          ]),
                        )
                      ],
                    ));
              });
        });
  }
}
