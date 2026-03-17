import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/acx_searchboxmap.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=770;

@RoutePage()
class PrgCustPbfDelinqSts extends ConsumerWidget {
  const PrgCustPbfDelinqSts(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return PrgCustPbfDeliqStsForm(
      prgEttyId: prgEttyId,
    );
    // final query = QueryObject(
    //     querysql: '/sp/ApiPrgCustPostpaidBFDelqc/queryasync',
    //     params: {
    //       'PrgEttyId': prgEttyId,
    //     },
    //     showMsg: false);
    // final myData = ref.watch(ReturndatafreezedProvider(query));
    // return myData.when(
    //   data: (res) {
    //     final delqcId = res.data![0]['DelqcId'].toString();
    //     return ListView(
    //       children: [
    //         const SelectableText('Aging Bucket of the Transaction Category define below will be use to determine the delinquency status'),
    //         SizedBox(
    //           height: 500,
    //           child: PrgCustPbfDeliqTxnCtgryList(
    //             delqcId: delqcId,
    //             prgEttyId: prgEttyId,
    //           ),
    //         ),
    //         const SelectableText('Only the total overdue amount of an Aging Bucket is larger than the amount below will be take into account'),
    //       ],
    //     );
    //   },
    //   error: (error, stackTrace) {
    //     return Center(child: Text(error.toString()),);
    //   },
    //   loading: () => const Center(child: CircularProgressIndicator()),
    // );
  }
}

class PrgCustPbfDeliqStsForm extends ConsumerWidget {
  const PrgCustPbfDeliqStsForm({
    super.key,
    this.prgEttyId,
  });

  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formDeliqStsFormKey = GlobalKey<FormBuilderState>();
    final query = QueryObject(
        querysql: '/sp/ApiPrgCustPostpaidBFDelqc/queryasync',
        params: {
          'PrgEttyId': prgEttyId,
        },
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "PrgEttyId": prgEttyId,
      "DelqcId": null,
      "BillingType": null,
      "ExcptionalAmt": null
    };
    final formData = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);

            return FormBuilder(
                key: formDeliqStsFormKey,
                autovalidateMode: AutovalidateMode.always,
                initialValue: formNewValue,
                child: Row(
                  children: [
                    sbw54,
                    const Flexible(
                        child: Column(
                      children: [
                        SelectableText(
                            'Aging Bucket of the Transaction Category define below will be use to determine the delinquency status'),
                        sbh20,
                        SelectableText(
                            'Only the total overdue amount of an Aging Bucket is larger than the amount below will be take into account'),
                        FbHiddenText(name: 'PrgEttyId'),
                        FbHiddenText(name: 'DelqcId'),
                        FbHiddenText(name: 'BillingType'),
                        FbText(
                            name: 'ExcptionalAmt', label: 'Exceptional Amount')
                      ],
                    )),
                    sbw20,
                    Flexible(
                        child: PrgCustPbfDeliqTxnCtgryList(
                      prgEttyId: prgEttyId,
                      delqcId: formNewValue["DelqcId"],
                    )),
                    Flexible(
                      child: Column(children: [
                        AcxSaveButtonManual(onSave: () {
                            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                          formDeliqStsFormKey.currentState!.save();
                          Map<String, dynamic> toPost = convertFormValueToSave(
                              formDeliqStsFormKey.currentState!.value,
                              theData.columnInfo);
                          final querySave = QueryObject(
                              querysql:
                                  '/sp/ApiPrgCustPostpaidBFDelqcSave/queryasync?logId=${convStrNewOrNullToNull(prgEttyId) ?? 0}',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((Returndata value) {
                            Toast.showresult(value);
                            if (isSuccess(value.message)) {
                              ref.invalidate(ReturndatafreezedProvider(query));
                            }
                          });
                        }),
                        sbh10,
                        AcxAuditLogReqBtn('ApiPrgCustPostpaidBFDelqcSave',ettyId: prgEttyId.toString(),)
                      ]),
                    )
                  ],
                ));
          } else {
            return Container();
          }
        });
  }
}

class PrgCustPbfDeliqTxnCtgryList extends ConsumerWidget {
  const PrgCustPbfDeliqTxnCtgryList({
    super.key,
    this.delqcId,
    this.prgEttyId,
  });

  final String? delqcId;
  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    // final query = QueryObject(querysql: '/sp/ApiPrgCustPostpaidBFDelqcCtgryList/queryasync', params: {'PrgEttyId': prgEttyId, 'DelqcId': convStrNewOrNullToNull(delqcId)}, showMsg: false);

    final query = QueryObject(
        querysql: '/sp/ApiPrgCustPostpaidBFDelqcCtgryList/queryasync',
        params: {'PrgEttyId': prgEttyId, 'DelqcId': delqcId},
        showMsg: false);

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          return const SizedBox(
              height: 300,
              child: Expanded(child: SelectableText('No Record ')));
        }
        if (returnData.data![0]['DelqcId'] == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectableText('No Fee Plan'),
              Expanded(
                  child: ListView(
                children: const [SelectableText('No Record')],
              ))
            ],
          );
        }

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Flexible(flex: 1, child: SelectableText(theVal.state.toString())),
          const SelectableText(
              'Aging Bucket of the Transaction Category define below will be use to determine the delinquency status'),
          const Divider(),
          Row(
            children: [
              const SelectableText('Transaction Category'),
              ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                            child: PrgCustPbfDeliqTxnCtgryForm(
                          prgEttyId: prgEttyId.toString(),
                          delqcId: delqcId.toString(),
                        ));
                      },
                    );
                    ref.invalidate(ReturndatafreezedProvider(QueryObject(
                        querysql:
                            '/sp/ApiPrgCustPostpaidBFDelqcCtgryList/queryasync',
                        params: {
                          'PrgEttyId': prgEttyId,
                          'DelqcId': convStrNewOrNullToNull(delqcId)
                        },
                        showMsg: false)));
                  },
                  child: const Icon(Icons.post_add))
            ],
          ),
          returnData.data![0]["CtgryId"] == null
              ? const SelectableText('No Record')
              : Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: returnData.rowcount!,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      final currentData = returnData.data![index];
                      return ListTile(
                        title: SelectableText('${currentData['TxnCtgryDscp']}'),
                        //  leading: SelectableText('${currentData['SchdDscp']}'),
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

                              //                            "TxnCtgry":0,
                              // "PrgEttyId": 1,
                              // "DelqcId": null,
                              // "CtgryId": null

                              final queryDel = QueryObject(
                                  querysql:
                                      '/sp/ApiPrgCustPostpaidBFDelqcCtgryDel/queryasync',
                                  params: {
                                    "PrgEttyId": currentData['PrgEttyId'],
                                    "CtgryId": currentData['CtgryId'],
                                    "TxnCtgry": currentData['TxnCtgry'],
                                    "DelqcId": currentData['DelqcId'],
                                  },
                                  showMsg: false);
                              final resultDel = ref.read(
                                  ReturndatafreezedProvider(queryDel).future);
                              resultDel.then((value) {
                                ref.invalidate(
                                    ReturndatafreezedProvider(query));
                                Toast.showresult(value);
                              });
                            },
                            icon: const Icon(Icons.delete)),
                      ); // return const SelectableText('Test 123');
                    },
                  ),
                ),
        ]);
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()),);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class PrgCustPbfDeliqTxnCtgryForm extends ConsumerWidget {
  const PrgCustPbfDeliqTxnCtgryForm(
      {super.key,
      required this.prgEttyId,
      this.delqcId,
      this.ctgryId,
      this.txnCtgry});
  final String? prgEttyId;
  final String? delqcId;
  final String? ctgryId;
  final String? txnCtgry;

//  {

//       "TxnCtgry": 10,
//       "PrgEttyId": 1,
//       "DelqcId": 1,
//       "CtgryId": null
//     }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyPlan = GlobalKey<FormBuilderState>();
    final formValue = {
      'PrgEttyId': prgEttyId,
      'DelqcId': delqcId,
      'CtgryId': ctgryId,
      'TxnCtgry': txnCtgry
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
                const FbHiddenText(name: 'PrgEttyId'),
                const FbHiddenText(name: 'DelqcId'),
                const FbHiddenText(name: 'CtgryId'),
                Flexible(
                    flex: 2,
                    child: FormBuilderField(
                        name: 'TxnCtgry',
                        builder: (field) {
                          return AcxSearchBoxMap(
                              returnSelectedRef: (dynamic val) {
                                field.didChange(val['TxnCtgry']);
                              },
                              selectedRef: {'TxnCtgry': field},
                              inputText: 'Transaction Category',
                              inputIcon: const Icon(Icons.search),
                              querysql: '/view/async/VwLibTxnCtgry',
                              searchText: 'Dscp',
                              keyField: 'TxnCtgry',
                              params: const {});
                        })),
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
                        final querySave = QueryObject(
                            querysql:
                                '/sp/ApiPrgCustPostpaidBFDelqcCtgrySave/queryasync',
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
  }
}
