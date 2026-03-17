import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdata_creval.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatav2.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/mcmgmt/screens/billingacc/cclickmockdata.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

class CustMgmtCreditScoringWizard extends ConsumerWidget {
  const CustMgmtCreditScoringWizard({
    super.key,
    this.custEttyId,
    this.cmpyEttyId,
    this.crscoreId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;
  final String? crscoreId;
  static const noOfStps = 4;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = ref.watch(custMgmtcreScoreWizardProvider);

    return Stepper(
      controlsBuilder: (BuildContext context, ControlsDetails controls) {
        return Row(
          children: <Widget>[
            Container(),
          ],
        );
      },
      currentStep: step,
      onStepContinue: () {
        if (step < noOfStps) {
          ref.read(custMgmtcreScoreWizardProvider.notifier).state = step + 1;
        }
      },
      onStepCancel: () {
        if (step > noOfStps) {
          ref.read(custMgmtcreScoreWizardProvider.notifier).state = step - 1;
          // singleton<AppRouter>().back();
        }
      },
      onStepTapped: (value) {
        ref.read(custMgmtcreScoreWizardProvider.notifier).state = value;
      },
      type: StepperType.horizontal,
      steps: [
        const Step(
          title: Text('Credit Info Entry'),
          content: Card(
            child: Column(
              children: [
                FbNumber(name: 'Revenue', label: 'Revenue'),
                FbNumber(name: 'Purchase', label: 'Purchase'),
                FbNumber(name: 'CostGoodsSold', label: 'Cost Goods Sold'),
                FbNumber(name: 'PLBeforeTax', label: 'P/L Before Tax'),
                FbNumber(name: 'FinChrg', label: 'Financial Charge'),
                FbNumber(name: 'PrefDividend', label: 'Pref Dividend'),
                FbNumber(name: 'FixedAsset', label: 'Fixed Asset'),
                FbNumber(name: 'Invtry', label: 'Inventory'),
                FbNumber(name: 'DbtrAmt', label: 'Debtor Amt'),
                FbNumber(name: 'CurrAsset', label: 'Current Asset'),
                FbNumber(name: 'CrdtrAmt', label: 'Creditor Amt'),
                FbNumber(name: 'CurrLiab', label: 'Current Liability'),
                FbNumber(name: 'LongTermLiab', label: 'Long Term Liability'),
                FbNumber(name: 'PaidUpCapital', label: 'Paid Up Capital'),
                FbNumber(name: 'ShareshldrFund', label: 'Shares Holder Fund'),
                FbNumber(name: 'OrdinaryShares', label: 'Ordinary Shares'),
              ],
            ),
          ),
        ),
                const Step(
          title: Text('Bank Latest Statement Entry'),
          content: Card(
            child: Column(
              children: [
                FbNumber(name: 'YearIn', label: 'Year'),
                FbNumber(name: 'InFlow', label: 'Inflow'),
                FbNumber(name: 'OpnBal', label: 'OpenBalance'),
                SizedBox(height: 500, child: CreBankStatementForm())
              ],
            ),
          ),
        ),
        Step(
          title: const Text('Evaluate'),
          content: Card(
              child: CreScoreEvaluteForm(
            custEttyId: custEttyId,
            cmpyEttyId: cmpyEttyId,
            crscoreId: crscoreId,
          )),
        ),
        Step(
          title: const Text('Credit Score'),
          content: Card(
            child: CreEvaScoreCard(
              custEttyId: custEttyId,
              cmpyEttyId: cmpyEttyId,
              crscoreId: crscoreId,
            ),
          ),
        )
      ],
    );
  }
}

final custMgmtcreScoreWizardProvider = StateProvider<int>((ref) {
  return 0;
});

class CreBankStatementForm extends ConsumerWidget {
  const CreBankStatementForm({super.key});

  @override
  Widget build(Object context, WidgetRef ref) {
   
    return AcxTrinaGridExtv2(
      extData: toUseLast3MonthBank,
      idField: 'FinMonth',
      useCheckBox: true,
      onNew: (){
        Toast.message('New');
      },
      onDelete: (List<TrinaRow<dynamic>> rows){
         Toast.message('New');
        for (var element in rows) {
          Toast.message(element.toJson().toString());
        }
      },
      appButtons: [
              AppButtonWithFunction(
                              btn: const AppButton(                        
                                icon: Icons.file_copy,
                                label: "Show Source",
                              ),
                              func: (List<TrinaRow<dynamic>> rows) {
                          //      print(cur.cells["FinMonth"]!.value.toString());
                            for (var element in rows) {
                              
                              (element.toJson());
                            }
                             //Toast.message('hji');
                              }),
      ],
      onRefresh: (){
        toUseLast3MonthBank.data?.clear();
        Toast.message('ok');
      },
    );
  }

}

class CreScoreEvaluteForm extends ConsumerWidget {
  const CreScoreEvaluteForm({
    super.key,
    this.custEttyId,
    this.cmpyEttyId,
    this.crscoreId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;
  final String? crscoreId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toPassQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtCrRiskEvaluate/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "CmpyEttyId": cmpyEttyId,
          "CrScoreId": crscoreId,
        },
        showMsg: false));
    final queryRes = ref.watch(toPassQuery);
    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          if (theData.data != null) {
            return AcxTrinaGridExtDataCreEval(
              extData: theData,
              idField: 'Seq',
              keyinfo: const [],
              showColumn: const [
                'Reference',
                'Remark',
                'InputVal',
                'ScorePts',
                'TotalScore',
                'Weighted%'
              ],
              //Dscp InputVal CrScoreIdDscp ScorePts TotalScore Weighted%
              readOnlyColumn: const [
                'Reference',
                'Remark',
                'ScorePts',
                'TotalScore',
                'Weighted%'
              ],
              onChanged: (TrinaGridOnChangedEvent val) async {
                final currentData = val.row.cells;
                final queryUpdate = QueryObject(
                    querysql: '/sp/ApiMgmtCrRiskEvaluateSave/queryasync',
                    params: {
                      "CustEttyId": custEttyId,
                      "CmpyEttyId": cmpyEttyId,
                      "CrScoreId": crscoreId,
                      "RefCd": "${currentData['RefCd']!.value}",
                      "InputVal": "${currentData['InputVal']!.value}",
                      "Sts": "A",
                    },
                    showMsg: false);
                final resultUpdate =
                    ref.read(ReturndatafreezedProvider(queryUpdate).future);
                resultUpdate.then((value) {
                  ref.invalidate(toPassQuery);
                  //   Toast.showresult(value);
                });
              },
            );
          } else {
            return const SelectableText('No Data');
          }
        });
  }
}
//Sorting
//If RefCd = "SUBTOTAL" whole row change to

class CreEvaScoreCard extends ConsumerWidget {
  const CreEvaScoreCard(
      {super.key,
      this.custEttyId,
      this.cmpyEttyId,
      this.crscoreId,
      this.prgEttyId});

  final String? custEttyId;
  final String? cmpyEttyId;
  final String? crscoreId;
  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKeyCrRiskScore = GlobalKey<FormBuilderState>();
    final query = QueryObject(
        querysql: '/sp/ApiMgmtCrRiskScore/queryasync',
        params: {
          "CustEttyId": custEttyId,
          "CmpyEttyId": cmpyEttyId,
          "CrScoreId": crscoreId,
        },
        showMsg: false);
    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "CmpyEttyId": cmpyEttyId,
      "CrScoreId": crscoreId,
      "TotalWeighted": null,
      "MaxCrLimit": null,
      "Note": null,
      "PrgEttyId": null,
      "MdfDate": null,
      "Sts": null,
      "CollateralJsg": null,
      "CollateralCash": null,
      "CollateralBG": null,
      "CollateralFD": null,
      "ProposedCrLimit": null,
      "ReqCrLmit": null
    };

    final formQuery = ReturndatafreezedProvider(query);
    final queryRes = ref.watch(formQuery);
    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
              key: formKeyCrRiskScore,
              initialValue: formNewValue,
              child: SizedBox(
                height: 1280,
                child: ListView(children: [
                  const FbHiddenText(name: 'CustEttyId'),
                  const FbHiddenText(name: 'CmpyEttyId'),
                  const FbHiddenText(name: 'PrgEttyId'),
                  const FbHiddenText(name: 'CrScoreId'),
                  const FbHiddenText(name: 'Sts'),
                  const FbHiddenText(name: 'Note'),
                  const FbHiddenDateTime(name: 'MdfDate'),
                  const FbText(
                    name: 'CmpyType',
                    label: 'Company Type',
                    readOnly: true,
                  ),
                  sbh10,
                  const FbText(
                    name: 'TotalWeighted',
                    label: 'Weighted Score',
                    readOnly: true,
                  ),
                  sbh10,
                  const FbText(
                    name: 'ReqCrLimit',
                    label: 'Request Credit Limit',
                  ),
                  sbh10,
                  const FbText(
                    name: 'ProposedCrLimit',
                    label: 'Proposed Credit Limit',
                  ),
                  sbh10,
                  const FbText(
                      name: 'MaxCrLimit', label: 'Maximum Credit Limit'),
                  sbh10,
                  const FbText(
                    name: 'CrRiskCd',
                    label: 'Credit Risk Code',
                    readOnly: true,
                  ),
                  sbh10,
                  const FbText(
                    name: 'CrRiskCdDscp',
                    label: 'Credit Risk Description',
                    readOnly: true,
                  ),
                  sbh10,
                  const FbText(
                    name: 'CrCtgryCd',
                    label: 'Credit Category Code',
                    readOnly: true,
                  ),
                  sbh10,
                  const FbText(
                    name: 'CrCtgryCdDscp',
                    label: 'Credit Category Description',
                    readOnly: true,
                  ),
                  sbh10,

                  const FbText(
                    name: 'ActionDscp',
                    label: 'Action Description',
                    readOnly: true,
                  ),
                  sbh10,
                  const FbText(
                    name: 'CollateralFD',
                    label: 'Collateral FD',
                    readOnly: true,
                  ),
                  sbh10,
                  const FbText(
                    name: 'CollateralBG',
                    label: 'Collateral BG',
                    readOnly: true,
                  ),
                  sbh10,
                  const FbText(
                    name: 'CollateralCash',
                    label: 'Collateral Cash',
                    readOnly: true,
                  ),
                  sbh10,
                  const FbText(
                    name: 'CollateralJsg',
                    label: 'Collateral Jsg',
                    readOnly: true,
                  ),
                                   FbSwitch(name: 'LegalActCmpyInd', label: 'Legal Action Company',  initialValue: formNewValue['LegalActCmpyInd']),
                     FbSwitch(
                              name: 'LegalActDirInd',
                              label: 'Legal Action Director',
                              initialValue: formNewValue['LegalActDirInd'],
                            ),
                               FbSwitch(
                              name: 'LegalActTradeInd',
                              label: 'Legal Action Trader',
                              initialValue: formNewValue['LegalActTradInd'],
                            ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            formKeyCrRiskScore.currentState!.save();
                            final toPost = convertFormValueToSave(
                                formKeyCrRiskScore.currentState!.value,
                                theData.columnInfo);

                            toPost.remove('CmpyTypeDscp');
                            toPost.remove('CrRiskCdDscp');
                            toPost.remove('CrCtgryCdDscp');
                            toPost.remove('ActionDscp');
                            toPost.remove('WeightedScore');
                            toPost.remove('CrRiskCd');
                            toPost.remove('CrCtgryCd');
                            toPost.remove('TotalWeighted');
                            toPost.remove('CmpyType');
                            final querySave = QueryObject(
                                querysql:
                                    '/sp/ApiMgmtCrRiskScoreSave/queryasync',
                                params: toPost,
                                showMsg: false);
                            final resultSaveUpdate = ref.read(
                                ReturndatafreezedProvider(querySave).future);
                            resultSaveUpdate.then((value) {
                              Toast.showresult(value);
                              if (isSuccess(value.message)) {
                                ref.invalidate(formQuery);
                              }
                            });
                          },
                          child: const Text('Confirm Evaluation Score')),
                      IconButton(
                          onPressed: () {
                            ref.invalidate(formQuery);
                          },
                          icon: const Icon(Icons.refresh)),
                    ],
                  )

                  //       Row(
                  //         children: [
                  //           Expanded(child: FbText(name: 'Company Type', label: 'Company Type', readOnly: true,)),
                  //           Expanded(child: FbText(name: 'Weighted Score', label: 'Weighted Score', readOnly: true,)),
                  //                    Expanded(child: FbText(name: 'Credit Risk Code', label: 'Credit Risk Code', readOnly: true,)),
                  //                               Expanded(child: FbText(name: 'Credit Category Code', label: 'Credit Category Code', readOnly: true,)),

                  //         ],
                  //       ),
                  //         Row(
                  //         children: [
                  //      Expanded(child: FbText(name: 'Action Description', label: 'Action Description', readOnly: true,)),
                  //           Expanded(child: FbText(name: 'Credit Risk Description', label: 'Credit Risk Description', readOnly: true,)),

                  //         ],
                  //       ),
                  // Row(children: [

                  //           Expanded(child: FbText(name: 'Credit Category Description', label: 'Credit Category Description', readOnly: true,)),
                  // ],),

                  //            Row(
                  //         children: [
                  //           Expanded(child: FbText(name: 'Collateral FD', label: 'Collateral FD', readOnly: true,)),
                  //            Expanded(child: FbText(name: 'Collateral BG', label: 'Collateral BG', readOnly: true,)),
                  //           Expanded(child: FbText(name: 'Collateral Cash', label: 'Collateral Cash', readOnly: true,)),
                  //             Expanded(child: FbText(name: 'Collateral Jsg', label: 'Collateral Jsg', readOnly: true,)),
                  //         ],
                  //       ),
                  //            Row(
                  //         children: [
                  //           Expanded(child: FbText(name: 'Request Credit Limit', label: 'Request Credit Limit',)),
                  //           sbw20,
                  //            Expanded(child: FbText(name: 'Proposed Credit Limit', label: 'Proposed Credit Limit',)),
                  //            sbw20,
                  //           Expanded(child: FbText(name: 'Maximum Credit Limit', label: 'Maximum Credit Limit')),
                  //         ],
                  //       ),
                ]),
              ));
        });
  }
}
