import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:intl/intl.dart';
import 'package:nucleusv2/src/core/app/api_acxdatatable.dart';
import 'package:nucleusv2/src/core/app/api_acxlangkeyval.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/alert_dialogs.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';

const int wid=130;

@RoutePage()
class PrgMgmtSetupGenInfo extends StatelessWidget {
  const PrgMgmtSetupGenInfo(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}

      return BuildMainFormNotStateFull(prgEttyId: prgEttyId);

    // if (isAllowTabAccess(defaultTabAccess, wid)) {
    //   return BuildMainFormNotStateFull(prgEttyId: prgEttyId);
    // } else {
    //   return const NotAuthorised();
    // }
  }
}

class TheSubMitForm extends HookConsumerWidget {
  const TheSubMitForm({super.key, this.prgEttyId});

  Future<Returndata> asdloadData(
    BuildContext context,
    WidgetRef ref,
    String querysql,
    Map<String, dynamic> params,
  ) async {
    try {
      return await ref
          .read(repoQueryProvider)
          .retrieveData(querysql, params)
          .onError((error, stackTrace) {
        if (context.mounted) {
          showAlertDialog(
              context: context, title: 'Error Loading', content: 'Failed');
        }

        return Returndata();
      });
    } catch (e) {
      showAlertDialog(
          context: context, title: 'Error Loading', content: e.toString());
      return Returndata();
    } finally {}
  }

  Future<List<Langkeypair>> loadColumnName(BuildContext context, WidgetRef ref,
      String querysql, Map<String, dynamic> params) async {
    try {
      return await ref
          .read(repoLangKeyValueProvider)
          .retrieveLangKey(querysql, params)
          .onError((error, stackTrace) {
        if (context.mounted) {
          showAlertDialog(
              context: context, title: 'Error Loading', content: 'Failed');
        }

        return [];
      });
    } catch (e) {
      showAlertDialog(
          context: context, title: 'Error Loading', content: e.toString());
      return [];
    } finally {}
  }

  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BuildMainFormNotStateFull(
      prgEttyId: prgEttyId,
    );
  }
}

class BuildMainFormNotStateFull extends HookConsumerWidget {
  BuildMainFormNotStateFull({
    super.key,
    this.prgEttyId,
  });
  final String? prgEttyId;
  final GlobalKey<FormBuilderState> _prgSetupFormKey =
      GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theClmName = useState<List<Langkeypair>>([]);
    final clmName = ref.watch(returnLangKeyProvider(QueryObject(
        querysql: '/sp/ApiConstructLblName/queryasync',
        params: {
          "UserType": "I",
          "ObjName": "ApiPrg",
          "ApplVer": null,
          // "SignIn": _sessionProvider.user!.name
        },
        showMsg: false)));
    final prgTypeData = ref.watch(ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/GetPrgType/queryasyncnouser',
        params: {},
        showMsg: false)));

    // final query = AcxReturnDataProvider(QueryObject(querysql: '/sp/ApiPrg/queryasync', params: {"PrgEttyId": prgEttyId == 'new' ? null : prgEttyId}, showMsg: false));
    final querySql = QueryObject(
        querysql: '/sp/ApiPrg/queryasync',
        params: {"PrgEttyId": prgEttyId == 'new' ? null : prgEttyId},
        showMsg: false);

    final query = ReturndatafreezedProvider(querySql);
    final formData = ref.watch(query);

    return clmName.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (x, e) => Center(child: Text(e.toString()),),
        data: (value) {
          theClmName.value = value;
          return prgTypeData.when(
              data: (prtyType) {
                return formData.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (x, e) => Center(child: Text(e.toString()),),
                    data: (b) {
                      Map<String, dynamic> formNewValue = {
                        "PrgEttyId": null,
                        "PrgName": null,
                        "Dscp": null,
                        "FromDate": null,
                        "Pic": 'ASSOC',
                        "ToDate": null,
                        "PrgType": null,
                        "MktSegmt": null,
                        "ImprintFmt": null
                      };
                      if (b.data != null) {
                        formNewValue = convertFormValueToDisplay(
                            b.data![0] as Map<String, dynamic>, b.columnInfo!);
                        _prgSetupFormKey.currentState?.patchValue(formNewValue);
                      } else {
                        formNewValue = formNewValue;
                      }
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: FormBuilder(
                            initialValue: formNewValue,
                            autovalidateMode: AutovalidateMode.disabled,
                            key: _prgSetupFormKey,
                            skipDisabled: true,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    children: [
                                      FormBuilderField(
                                        name: 'PrgEttyId',
                                        builder: (FormFieldState f) {
                                          return Container();
                                        },
                                      ),
                                      FormBuilderField(
                                        name: 'Pic',
                                        builder: (FormFieldState f) {
                                          return Container();
                                        },
                                      ),
                                     const FbText(
                                        name: 'PrgName',
                                        label: 'PrgName',
                                      ),
                                      const FbText(
                                        name: 'Dscp',
                                        label: 'Dscp'
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: FormBuilderDateTimePicker(
                                              valueTransformer: (v) {
                                                // return v!.toIso8601String();
                                                if (v == null) {
                                                  return null;
                                                  // return DateFormat('yMMMEd').format(DateTime.now());
                                                }
                                                return DateFormat('yMMMEd')
                                                    .format(v);
                                              },
                                              name: 'FromDate',
                                              format: DateFormat.yMMMEd(),
                                              initialEntryMode:
                                                  DatePickerEntryMode.calendar,
                                              inputType: InputType.date,
                                              decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                labelText: getlabelbykeyval(
                                                    theClmName.value,
                                                    'FromDate'),
                                                suffixIcon: IconButton(
                                                  icon: const Icon(Icons.close),
                                                  onPressed: () {
                                                    _prgSetupFormKey
                                                        .currentState!
                                                        .fields['FromDate']
                                                        ?.didChange(null);
                                                  },
                                                ),
                                              ),
                                              initialTime: const TimeOfDay(
                                                  hour: 8, minute: 0),

                                            ),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Expanded(
                                            child: FormBuilderDateTimePicker(
                                              valueTransformer: (v) {
                                                if (v == null) {
                                                  return null;

                                                }
                                                return DateFormat('yMMMEd')
                                                    .format(v);
                                              },
                                              name: 'ToDate',
                                              format: DateFormat.yMMMEd(),
                                              initialEntryMode:
                                                  DatePickerEntryMode.calendar,
                                              inputType: InputType.date,
                                              decoration: InputDecoration(
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                labelText: getlabelbykeyval(
                                                    theClmName.value, 'ToDate'),
                                                suffixIcon: IconButton(
                                                  icon: const Icon(Icons.close),
                                                  onPressed: () {
                                                    _prgSetupFormKey
                                                        .currentState!
                                                        .fields['ToDate']
                                                        ?.didChange(null);
                                                  },
                                                ),
                                              ),
                                              initialTime: const TimeOfDay(
                                                  hour: 8, minute: 0),
                                              // locale: const Locale.fromSubtags(languageCode: 'fr'),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: SelectableText(
                                              getlabelbykeyval(theClmName.value,
                                                  'PrgType'))),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      FormBuilderChoiceChips(
                                        name: 'PrgType',
                                        options: getChipOptions(
                                            prgTypeData.value!.data!,
                                            'PrgType',
                                            'Dscp'),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      FbLibView(
                                        querySql:
                                            '/sp/GetLibRef/queryasyncnouser',
                                        name: 'MktSegmt',
                                        label: 'Market Segment',
                                        params: const {
                                          "RefType": "MKTSEGMT",
                                          "BitInd": null
                                        },
                                        initialValue: formNewValue['MktSegmt'],
                                        keyField: 'RefCd',
                                        searchText: 'Dscp',
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      FbHiddenText(name: 'ImprintFmt')
                                      // FbLibView(
                                      //   querySql:
                                      //       '/sp/GetLibRef/queryasyncnouser',
                                      //   name: 'ImprintFmt',
                                      //   label: getlabelbykeyval(
                                      //       theClmName.value, 'ImprintFmt'),
                                      //   params: const {
                                      //     "RefType": "MediaPdctionFmt",
                                      //     "BitInd": null
                                      //   },
                                      //   initialValue:
                                      //       formNewValue['ImprintFmt'],
                                      //   keyField: 'RefCd',
                                      //   searchText: 'Dscp',
                                      // ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        AcxSaveButtonManual(
                                          confirmSave: false,
                                          onSave: () {
                                              if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                                            _prgSetupFormKey.currentState!
                                                .save();

                                            Map<String, dynamic> toPost =
                                                convertFormValueToSave(
                                                    _prgSetupFormKey
                                                        .currentState!.value,
                                                    b.columnInfo);
                                            final querySave = QueryObject(
                                                querysql:
                                                    '/sp/ApiPrgSave/queryasync',
                                                params: toPost,
                                                showMsg: false);
                                            final saveResult = ref.read(
                                                ReturndatafreezedProvider(
                                                        querySave)
                                                    .future);
                                            saveResult.then((value) {
                                              Toast.showresult(value);
                                              if (isSuccess(value.message)) {
                                                final thePrgId = getOutputValue(
                                                    value.output, '@PrgEttyId');
                                                singleton<AppRouter>()
                                                    .navigatePath(
                                                        '/prgmgmt/setup/$thePrgId')
                                                    .then(
                                                  (value) {
                                                    ref.invalidate(
                                                        ReturndatafreezedProvider(
                                                            querySql));
                                                  },
                                                );
                                              }
                                            });
                                          },
                                        ),
                                        AcxBackToList(
                                          fnBeforeNav: () {
                                            clearTitle(ref);
                                          },
                                          listUrl: './././main',
                                        ),
                    AcxAuditLogReqBtn('ApiPrgSave',)
                                      ],
                                    ))
                              ],
                            )),
                      );
                    });
              },
              error: (m, e) {
                return Center(child: Text(e.toString()),);
              },
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }
}
