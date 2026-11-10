import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=233;

@RoutePage()
class SubsidymgmtProgram extends StatelessWidget {
  const SubsidymgmtProgram(
      {super.key, @PathParam.inherit('subsId') this.subsId});

  final String? subsId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SusidyPrgMgmtForm(subsId: convStrNewOrNullToNull(subsId));
  }
}

class SusidyPrgMgmtForm extends ConsumerWidget {
  final String? subsId;

  const SusidyPrgMgmtForm({
    super.key,
    this.subsId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeySubsidyPrg = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiPrgSubs/queryasync',
        params: {"SubsId": subsId},
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "SubsId": subsId,
      "Dscp": null,
      "Sponsor": null,
      "BillingFreq": null,
      "SubsidyType": null,
      "ApplyOn": null
    };
    Map<String, dynamic> formSwitchValue = {};
    final formData = ref.watch(ReturndatafreezedProvider(query));
    final queryPrdList = QueryObject(
        querysql: '/sp/ApiPrgSubsPrdList/queryasync',
        params: {"SubsId": subsId},
        showMsg: false);
    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
              key: formKeySubsidyPrg,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                formKeySubsidyPrg.currentState!.save();
              },
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  const FbHiddenText(name: 'SubsId'),
                  const Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FbText(name: 'Dscp', label: 'Description'),
                          FbLibView(
                              name: 'Sponsor',
                              label: 'Program Sponsor',
                              params: {},
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/view/async/VwSponsor'),
                          FbLibView(
                              name: 'BillingFreq',
                              label: 'Billing Frequency',
                              params: {},
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/view/async/VwBillingFreq'),
                          // FbLibView(name: 'SubsidyType', label: 'Subsidy type', params: {}, keyField: 'SubsidyId', searchText: 'Dscp', querySql: '/view/async/VwSubsSubsidy'),
                          FbOption(
                            name: 'SubsidyType',
                            label: 'Type of Subsidy',
                            params: {},
                            querysql: '/view/async/VwSubsidyType',
                            orientation: OptionsOrientation.wrap,
                          ),
                          FbOption(
                            name: 'ApplyOn',
                            label: 'Subsidy apply on',
                            params: {},
                            querysql: '/view/async/VwApplyOn',
                            orientation: OptionsOrientation.wrap,
                          ),
                          FbLibView(
                              name: 'Sts',
                              label: 'Program Status',
                              params: {},
                              keyField: 'RefCd',
                              searchText: 'Dscp',
                              querySql: '/view/async/VwActvSuspSts'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Flexible(
                            flex: 1,
                            child: SelectableText(
                                'Apply settings to transactions from the following . If no product is selected the setting will apply to all products'),
                          ),
                          sbh10,
                          Flexible(
                            flex: 4,
                            child: SubsidyProgramSetupPrdList(
                              subsId: subsId,
                              switchValue: formSwitchValue,
                              query: queryPrdList,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      AcxSaveButtonManual(
                        onSave: () async {
                            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          formKeySubsidyPrg.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              formKeySubsidyPrg.currentState!.value,
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiPrgSubsSave/queryasync',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            saveProdList(formSwitchValue, ref,
                                subsId.toString(), queryPrdList);
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              final subsId =
                                  getOutputValue(value.output, '@SubsId');

                              singleton<AppRouter>().navigatePath(
                                '/subsidy/program/$subsId',
                              );
                              ref.invalidate(ReturndatafreezedProvider(query));
                            }
                          });
                        },
                      ),
                      const AcxBackToList(listUrl: '/subsidy/main'),
                      AcxAuditLogReqBtn('ApiPrgSubsSave',)
                    ]),
                  )
                ],
              ));
        });
  }
}

class SubsidyProgramSetupPrdList extends ConsumerWidget {
  const SubsidyProgramSetupPrdList({
    super.key,
    this.subsId,
    this.switchValue,
    required this.query,
  });

  final String? subsId;
  final Map<String, dynamic>? switchValue;
  final QueryObject query;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeySwitch = GlobalKey<FormBuilderState>();

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
        data: (rValue) {
          var data = rValue.data;

          Set<String> theValue = <String>{};
          data!.asMap().entries.forEach((ele) {
            theValue.add(ele.value['PrdDscp'].toString());
          });

          var identifier = {};
          for (var item in theValue) {
            List<dynamic> toAdd = [];
            data.asMap().entries.forEach((ele) {
              if (ele.value['PrdDscp'].toString() == item) {
                toAdd.add(ele.value);
              }
            });
            identifier[item] = toAdd;
          }
          List<Widget> categoryItem = [];

          for (var val in identifier.entries) {
            List<Widget> rowItems = [];

            List<dynamic> toVV = val.value;
            for (var item in toVV) {
              switchValue![item['PrdCd']] = {
                "PrdSts": item['PrdSts'],
                "Mdf": false
              };
            }

            for (var item in toVV) {
              rowItems.add(Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FbField(child: FormBuilderSwitch(
                      initialValue: item['PrdSts'] == 'N' ? false : true,
                      name: item['PrdCd'],
                      title: SelectableText(item['PrdDscp']),
                      onChanged: (value) {
                        switchValue![item['PrdCd']] = value == false
                            ? {"PrdSts": 'N', "Mdf": true}
                            : {"PrdSts": 'Y', "Mdf": true};
                      },
                      valueTransformer: (value) {
                        return value == false ? 'N' : 'Y';
                      },
                    )),
                  )
                ],
              ));
            }

            categoryItem.add(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [...rowItems],
            ));
          }

          ListView toReturn = ListView(
            children: categoryItem,
          );

          return FormBuilder(
            initialValue: switchValue!,
            key: formKeySwitch,
            child: toReturn,
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()),);
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

void saveProdList(Map<String, dynamic> src, WidgetRef ref, String subsId,
    QueryObject query) async {
  var futures = <Future>[];
  for (var element in src.entries) {
    if (element.value['Mdf']) {
      final curPrdSts = element.value['PrdSts'];
      final queryDel = QueryObject(
          querysql: '/sp/ApiPrgSubsPrdSave/queryasync',
          params: {"SubsId": subsId, "PrdSts": curPrdSts, "PrdCd": element.key},
          showMsg: false);
      final resultDel = ref.read(ReturndatafreezedProvider(queryDel).future);
      futures.add(resultDel);
    }
  }

  await Future.wait(futures).then((value) {
    ref.invalidate(ReturndatafreezedProvider(query));
  });
}
