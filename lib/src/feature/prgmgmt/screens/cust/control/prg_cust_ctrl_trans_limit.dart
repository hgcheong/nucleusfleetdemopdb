import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=156;
@RoutePage()
class PrgCustCtrlTransLimit extends StatelessWidget {
  const PrgCustCtrlTransLimit(
      {super.key,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('limitId') this.limitId});

  final String? prgEttyId;
  final String? limitId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Center(
      child: PrgCustCtrlTxnLimitForm(
        prgEttyId: prgEttyId,
        limitId: convStrNewOrNullToNull(limitId),
      ),
    );
  }
}

class PrgCustCtrlTxnLimitForm extends ConsumerWidget {
  const PrgCustCtrlTxnLimitForm({
    super.key,
    this.prgEttyId,
    this.limitId,
  });
  final String? prgEttyId;
  final String? limitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKey = GlobalKey<FormBuilderState>();

    final query = QueryObject(
        querysql: '/sp/ApiPrgCustTxnLimit/queryasync',
        params: {"PrgEttyId": prgEttyId, "LimitId": limitId},
        showMsg: false);
    // final queryPrdList = QueryObject(
    //     querysql: '/sp/ApiPrgCustTxnLimitPrdList/queryasync',
    //     params: {"PrgEttyId": prgEttyId, "LimitId": limitId},
    //     showMsg: false);
    Map<String, dynamic> formNewValue = {
      "TxnCtgry": null,
      "LimitType": null,
      "Dscp": null,
      "LimitMsuremt": null,
      "MinThsld": null,
      "MaxThsld": null,
      "CntThsld": null,
      "Sts": null,
      "FromDate": null,
      "ToDate": null,
      "PrgEttyId": prgEttyId,
      "LimitId": limitId
    };
    // Map<String, dynamic> formSwitchValue = {};
    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                formKey.currentState!.save();
              },
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  const FbHiddenText(name: 'PrgEttyId'),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FbHiddenText(name: 'Sts'),
                          FbText(
                            name: 'Dscp',
                            label: S.of(context).lblDescription,
                          ),
                          FbLibView(
                            name: 'TxnCtgry',
                            initialValue: formNewValue["TxnCtgry"],
                            label: S.of(context).lblApplyTransCat,
                            params: const {},
                            keyField: 'TxnCtgry',
                            searchText: 'Dscp',
                            querySql: '/view/async/VwLibTxnCtgry',
                          ),
                          const FbLibView(
                              name: 'PrdCtgry',
                              label: 'Product Category',
                              params: {},
                              keyField: 'PrdCtgry',
                              searchText: 'Dscp',
                              querySql: '/view/async/VwPrdCtgry'),
                          const FbHiddenText(name: 'LimitId'),
                          FbLibView(
                            name: 'LimitType',
                            initialValue: formNewValue["RefCd"],
                            label: S.of(context).lblTypeOfLimit,
                            params: const {},
                            keyField: 'RefCd',
                            searchText: 'Dscp',
                            querySql: '/view/async/VwLimitType',
                          ),
                          FbOption(
                            querysql: '/view/async/VwApplyOn',
                            name: 'LimitMsuremt',
                            label: S.of(context).lblLimitMeaApplyTo,
                            params: const {},
                            orientation: OptionsOrientation.wrap,
                          ),
                          SelectableText(S.of(context).tabTransactionLimits),
                          Row(
                            children: [
                              Expanded(
                                child: FbText(
                                    name: 'MinThsld',
                                    label: S.of(context).lblMin),
                              ),
                              fbFieldGap, Expanded(
                                child: FbText(
                                    name: 'MaxThsld',
                                    label: S.of(context).lblMax),
                              )
                            ],
                          ),
                          Expanded(
                            child: FbText(
                                name: 'CntThsld',
                                label: S.of(context).lblCount),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Flexible(
                          //   flex: 1,
                          //   child: SelectableText(
                          //       'Apply settings to transactions from the following . If no product is selected the setting will apply to all products'),
                          // ),
                          // sbh10,
                          // Flexible(
                          //   flex: 4,
                          //   child: limitId == null
                          //       ? const SelectableText('No Record')
                          //       : PrgCustCtrlTxnprdList(
                          //           limitId: limitId,
                          //           prgEttyId: prgEttyId,
                          //           switchValue: formSwitchValue,
                          //           query: queryPrdList,
                          //         ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      ElevatedButton(
                        onPressed: () async {
                          formKey.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              formKey.currentState!.value, theData.columnInfo);
                          final querySave = QueryObject(
                              querysql: '/sp/ApiPrgCustTxnLimitSave/queryasync',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                            // if (isSuccess(value.message)) {
                            //   saveProdList(
                            //       formSwitchValue,
                            //       ref,
                            //       limitId.toString(),
                            //       prgEttyId.toString(),
                            //       queryPrdList);
                            //   singleton<AppRouter>().navigatePath(
                            //       getAfterSavePath(
                            //           context, value.output, '@LimitId'));
                            // }
                            if (context.mounted) {
                              singleton<AppRouter>()
                                  .navigatePath(getAfterSavePath(
                                      context, value.output, '@LimitId'))
                                  .then((val) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                              });
                            }
                          });
                        },
                        child: const Icon(Icons.save),
                      ),
                      sbh10,
                      AcxBackToList(
                        listUrl:
                            '/prgmgmt/custsetup/$prgEttyId/pctrllanding/pcctrltranslimitlist',
                      )
                    ]),
                  )
                ],
              ));
        });
  }
}

class PrgCustCtrlTxnprdList extends ConsumerWidget {
  const PrgCustCtrlTxnprdList(
      {super.key,
      this.custEttyId,
      this.prgEttyId,
      this.cmpyEttyId,
      this.limitId,
      this.switchValue,
      required this.query});

  final String? custEttyId;
  final String? prgEttyId;
  final String? cmpyEttyId;
  final String? limitId;
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
              switchValue![item['PrdCd']] = item['Sts'];
            }

            for (var item in toVV) {
              rowItems.add(Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FbField(child: FormBuilderSwitch(
                      initialValue: item['Sts'] == 'N' ? false : true,
                      name: item['PrdCd'],
                      title: SelectableText(item['PrdDscp']),
                      onChanged: (value) {
                        switchValue![item['PrdCd']] =
                            value == false ? 'N' : 'Y';
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

void saveProdList(Map<String, dynamic> src, WidgetRef ref, String limitId,
    String prgEttyId, QueryObject query) async {
  var futures = <Future>[];
  for (var element in src.entries) {
    if (element.value['Mdf']) {
      final curPrdSts = element.value['PrdSts'];
      final queryDel = QueryObject(
          querysql: '/sp/ApiPrgCustTxnLimitPrdSave/queryasync',
          params: {
            "PrgEttyId": prgEttyId,
            "LimitId": limitId,
            "PrdSts": curPrdSts,
            "PrdCd": element.key
          },
          showMsg: false);
      final resultDel = ref.read(ReturndatafreezedProvider(queryDel).future);
      futures.add(resultDel);
    }
  }

  await Future.wait(futures).then((value) {
    ref.invalidate(ReturndatafreezedProvider(query));
  });
}
