import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/company/creditriskscoring/cust_mgmt_credit_scoring_wizard.dart';

const int wid=551;

@RoutePage()
class CustMgmtCmpyCtrlCrEvaDetail extends ConsumerWidget {
  const CustMgmtCmpyCtrlCrEvaDetail(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
      @PathParam('crscoreId') this.crscoreId});

  final String? custEttyId;
  final String? cmpyEttyId;
  final String? crscoreId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeyEva = GlobalKey<FormBuilderState>();
    final query = QueryObject(
        querysql: '/sp/ApiMgmtCrRisk/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "CmpyEttyId": cmpyEttyId,
          "CrScoreId": convStrNewOrNullToNull(crscoreId)
        },
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "CmpyEttyId": null,
      "CostGoodsSold": null,
      "CrdtrAmt": null,
      "CrScoreId": null,
      "CurrAsset": null,
      "CurrLiab": null,
      "CustEttyId": null,
      "DbtrAmt": null,
      "FinChrg": null,
      "FinMonth": null,
      "FinYear": null,
      "FixedAsset": null,
      "Invtry": null,
      "LongTermLiab": null,
      "MdfDate": null,
      "Note": null,
      "OrdinaryShares": null,
      "PaidUpCapital": null,
      "PLBeforeTax": null,
      "PrefDividend": null,
      "Purchase": null,
      "Revenue": null,
      "ShareshldrFund": null,
      "PrgEttyId": null
    };
    final formQuery = ReturndatafreezedProvider(query);
    final formData = ref.watch(formQuery);
    return AsyncValueWidget(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
              key: formKeyEva,
              initialValue: formNewValue,
              child: Row(children: [
                const FbHiddenText(name: 'CustEttyId'),
                const FbHiddenText(name: 'CmpyEttyId'),
                const FbHiddenText(name: 'CrScoreId'),
                const FbHiddenDateTime(name: 'Mdfdate'),
                // Column(
                //   children: [
                //     Expanded(
                //         flex: 1,
                //         child: Card(
                //             child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Column(
                //             children: [
                //               const SizedBox(width: 200, child: FbNumber(name: 'FinYear', label: 'Year')),
                //               SizedBox(
                //                   width: 200,
                //                   child: FbLibref(
                //                     name: 'FinMonth',
                //                     initialValue: formNewValue['Month'],
                //                     label: 'Month',
                //                     params: const {"RefType": "Month", "BitInd": null},
                //                   ))
                //             ],
                //           ),
                //         ))),

                //   ],
                // ),

                Expanded(
                    flex: 12,
                    child: SingleChildScrollView(
                      child: Card(
                        child: SizedBox(
                          height: 1280,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: FbLibView(
                                      name: 'PrgEttyId',
                                      querySql:
                                          '/sp/ApiMgmtCmpyPrgAccptList/queryasync',
                                      keyField: 'PrgEttyId',
                                      label: 'Program',
                                      searchText: 'PrgDscp',
                                      params: {
                                        "CmpyEttyId": cmpyEttyId.toString(),
                                        "CustEttyId": custEttyId.toString()
                                      },
                                    )),
                                    sbw20,
                                    const Expanded(
                                        child: FbNumber(
                                            name: 'FinYear', label: 'Year')),
                                    sbw20,
                                    Expanded(
                                      child: FbLibref(
                                        name: 'FinMonth',
                                        initialValue: formNewValue['Month'],
                                        label: 'Month',
                                        params: const {
                                          "RefType": "Month",
                                          "BitInd": null
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(
                                  flex: 1,
                                  child: FbText(
                                    label: 'Note',
                                    name: 'Note',
                                    maxLines: 10,
                                  )),
                              Expanded(
                                flex: 10,
                                child: CustMgmtCreditScoringWizard(
                                  custEttyId: custEttyId,
                                  cmpyEttyId: cmpyEttyId,
                                  crscoreId: convStrNewOrNullToNull(crscoreId),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              final step =
                                  ref.watch(custMgmtcreScoreWizardProvider);
                              return step == 0
                                  ? AcxSaveButtonManual(onSave: () {
                                      formKeyEva.currentState!.save();
                                      final toPost = convertFormValueToSave(
                                          formKeyEva.currentState!.value,
                                          theData.columnInfo);
                                      final querySave = QueryObject(
                                          querysql:
                                              '/sp/ApiMgmtCrRiskSave/queryasync?logId=${convStrNewOrNullToNull(cmpyEttyId) ?? 0}',
                                          params: toPost,
                                          showMsg: false);
                                      final resultSaveUpdate = ref.read(
                                          ReturndatafreezedProvider(querySave)
                                              .future);
                                      resultSaveUpdate.then((value) {
                                        Toast.showresult(value);
                                        if (isSuccess(value.message)) {
                                          if (context.mounted) {
                                            singleton<AppRouter>()
                                                .navigatePath(getAfterSavePath(
                                                    context,
                                                    value.output,
                                                    '@CrScoreId'))
                                                .then((val) {
                                              ref.invalidate(formQuery);
                                            });
                                          }
                                        }
                                      });
                                    })
                                  : Container();
                            },
                          ),
                          sbh10,
                          const AcxBackToList(listUrl: '././list'),
                          AcxAuditLogReqBtn('ApiMgmtCrRiskSave',ettyId: cmpyEttyId.toString(),)
                        ],
                      ),
                    ))
              ]));
          // return Row(
          //   children: [
          //     Expanded(child: buildGridView(dv, 1, null)),
          //     Expanded(child: ElevatedButton(child: const SelectableText('testm'),onPressed: (){},))
          //   ],
          // );
          // Map<String, dynamic> theData = dv.data![0];

          // List<Widget> toInsert = [
          //   ElevatedButton(
          //       onPressed: () {
          //
          //       },
          //       child: const SelectableText('Test me'))
          // ];
          // theData.forEach((key, value) {
          //   toInsert.add(SizedBox(
          //     width: 200,
          //     child: FbNumber(
          //       name: key,
          //       label: key,
          //       initialValue: value,
          //     ),
          //   ));
          // });

          // return SingleChildScrollView(
          //   child: SizedBox(
          //     height: 1280,
          //     child: FormBuilder(
          //       key: formKeyEva,
          //       initialValue: theData,
          //       onChanged: () {
          //         formKeyEva.currentState!.save();
          //       },
          //       child: Wrap(
          //         direction: Axis.vertical,
          //          runSpacing: 5.0,
          //   spacing: 5.0,
          //         children: toInsert,
          //       ),
          //     ),
          //   ),
          // );
        });
  }
}

Returndata creEvalYear = Returndata.fromJson({
  "data": [
    {
      "RefCd": "2023",
      "Dscp": "2023",
    },
    {
      "RefCd": "2024",
      "Dscp": "2024",
    },
    {
      "RefCd": "2025",
      "Dscp": "2025",
    },
  ]
});
