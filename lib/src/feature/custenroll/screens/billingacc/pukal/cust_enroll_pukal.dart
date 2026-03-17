import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custenroll/screens/billingacc/cust_enroll_billing_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=535;

@RoutePage()
class CustEnrollPukal extends StatelessWidget {
  const CustEnrollPukal(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('ettyId') this.ettyId,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      //acctId
      @PathParam.inherit('acctId') this.acctId,
      @PathParam.inherit('acctType') this.acctType});

  final String? custEttyId;
  final String? ettyId;
  final String? prgEttyId;
  final String? acctId;
  final String? acctType;
  @override
  Widget build(BuildContext context) { 
//  var bb = singleton.get<AcxAuthAccess>();

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return MerchantMgmtPukalForm(
      custEttyId: custEttyId,
      ettyId: ettyId,
      prgEttyId: prgEttyId,
      acctId: acctId,
      acctType: acctType,
    );
  }
}

class MerchantMgmtPukalForm extends ConsumerWidget {
  const MerchantMgmtPukalForm(
      {super.key,
      this.custEttyId,
      this.ettyId,
      this.prgEttyId,
      this.acctId,
      this.acctType});

  final String? custEttyId;
  final String? ettyId;
  final String? prgEttyId;
  final String? acctId;
  final String? acctType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final cmgmPukalKey = GlobalKey<FormBuilderState>();
    final params = ref.watch(pukalCustEnrollAccDetailProvider);
    Map<String, dynamic> toQueryParam = Map.from(params);
    toQueryParam.remove('AcctNo');
    final query = QueryObject(
        querysql: '/sp/ApiEnrlCustBillingAcctPukal/queryasync',
        params: toQueryParam,
        showMsg: false);

    Map<String, dynamic> formNewValue = {
      "Acctble": null,
      "AcctId": acctId,
      "AcctOffcSad": null,
      "AgencyId": null,
      "BusnArea": null,
      "CustEttyId": custEttyId,
      "DeptGrpCd": null,
      "EttyId": ettyId,
      "MdfDate": null,
      "ObjCd": null,
      "PrgActvtyCd": null,
      "PrgEttyId": prgEttyId,
      "ProjCd": null,
      "PukalId": null,
      "SortKey": null,
      "TrustFund": null,
      "Vot": null
    };
    //final formValue = useState<Map<String, dynamic>>(formNewValue);

    final formData = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
        value: formData,
        data: (theData) {
          if (theData.data != null) {
            formNewValue = convertFormValueToDisplay(
                theData.data![0] as Map<String, dynamic>, theData.columnInfo);
          }
          return FormBuilder(
              key: cmgmPukalKey,
              autovalidateMode: AutovalidateMode.always,
              initialValue: formNewValue,
              onChanged: () {
                cmgmPukalKey.currentState!.save();
              },
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 1280,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 1280,
                              child: ListView(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText("Kod Agensi 200042", style: TextStyle(color: Colors.lightBlue),),
                                   const Row(
                                    children: [
                                      Expanded(
                                          child: FbLibView(
                                        params: {},
                                        name: 'BusnArea',
                                        label: 'Pejabat Perakaunan',
                                        keyField: 'RefCd',
                                        searchText: 'Dscp',
                                        querySql: '/view/async/VwPukalBusnArea',
                                      )),
                                    ],
                                  ),
                                        const FbText(
                                    name: 'DeptGrpCd',
                                    label: 'Kump.PTJ/PTJ Pembayar',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 1280,
                              child: ListView(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                         SelectableText("Butir-Butir Akaun Pukal", style: TextStyle(color: Colors.lightBlue),),
                                    // FbText(name: 'BusnArea',label:'Business Area',),
                                    //'BUSNAREAPUKAL'
                                    // Row(
                                    //   children: [
                                    //     Expanded(child: FbLibViewExt(
                                    //       showSearchBox: true,
                                    //       name: 'BusnArea', label: 'Business Area', keyField: 'BAC', searchText: 'Description', datasrc: toUseBusnArea)),
                                    //   ],
                                    // ),
                                    const FbHiddenText(name: 'SortKey'),
                                           const Row(
                                    children: [
                                      Expanded(
                                          child: FbLibView(
                                        params: {},
                                        name: 'AcctOffcSad',
                                        label: 'Kod Pejabat Perakaunan',
                                        keyField: 'RefCd',
                                        searchText: 'Dscp',
                                        querySql: '/view/async/VwPukalBusnArea',
                                      )),
                                    ],
                                  ),
                            

                                  const FbText(
                                      name: 'Acctble',
                                      label: 'Kump.PTJ/PTJ Dipertanggung'),
                                  // FbText(name: 'ObjCd', label:'Kod Akaun'),
                                  const FbHiddenText(name: 'ObjCd'),
                                  const FbHiddenText(name: 'ObjCd1'),
                          
                          
                                         const FbText(
                                      name: 'Vot',
                                      label: 'VOT',
                                    ),
                                    const FbText(
                                      name: 'PrgActvtyCd',
                                      label: 'Program/Activiti',
                                    ),
                                    const FbText(
                                      name: 'ProjCd',
                                      label: 'Projek',
                                    ),
                                            sbh10,
                                            FbSwitch(
                                      name: 'ObjCdInd',
                                      label: 'Kod Akaun (B0226201 PETROL)',
                                      initialValue: formNewValue['ObjCdInd']),

                                  sbh10,
                                  FbSwitch(
                                      name: 'ObjCd1Ind',
                                      label: 'Kod Akaun (B0226202 DIESEL)',
                                      initialValue: formNewValue['ObjCd1Ind']),
                                    const FbHiddenText(name: 'TrustFund'),
                                    const FbHiddenText(name: 'CustEttyId'),
                                    const FbHiddenText(name: 'AgencyId'),
                                    const FbHiddenText(name: 'AcctId'),
                                    const FbHiddenText(name: 'PukalId'),
                                    const FbHiddenText(name: 'EttyId'),
                                    const FbHiddenText(name: 'PrgEttyId'),
                                    const FbHiddenDateTime(name: 'MdfDate'),
                                    // FbText(name: 'BusnArea',label:'Business Area',),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1280,
                          child: ListView(children: [
                            AcxSaveButtonManual(
                              confirmSave: false,
                              onSave: () {  
                                 if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                                cmgmPukalKey.currentState!.save();
                                Map<String, dynamic> toPost =
                                    convertFormValueToSave(
                                        cmgmPukalKey.currentState!.value,
                                        theData.columnInfo);

                                final querySave = QueryObject(
                                    querysql:
                                        '/sp/ApiEnrlCustBillingAcctPukalSave/queryasync?logId=${convStrNewOrNullToNull(acctId) ?? 0}',
                                    params: toPost,
                                    showMsg: false);

                                final saveResult = ref.read(
                                    ReturndatafreezedProvider(querySave)
                                        .future);
                                saveResult.then((value) {
                                  Toast.showresult(value);
                                  if (isSuccess(value.message)) {
                                    //                      ref.read(pukalCustEnrollAccDetailProvider.notifier).state = {
                                    //   "CustEttyId": custEttyId,
                                    //   "PrgEttyId": params['PrgEttyId'],
                                    //   "EttyId": toPost['EttyId'],
                                    // };
                                    ref.invalidate(
                                        ReturndatafreezedProvider(query));
                                  }
                                });
                              },
                            ),
                            sbh10,
                            const AcxBackToList(
                              listUrl: './list',
                            ),
                                 sbh10,
                          AcxAuditLogReqBtn('ApiEnrlCustBillingAcctPukalSave', ettyId: formNewValue["AcctId"].toString(),),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        }
        // else {
        //   formNewValue = formNewValue;
        //   return Container();
        // }
        // },
        );
  }
}
