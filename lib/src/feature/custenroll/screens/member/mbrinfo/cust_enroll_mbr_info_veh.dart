import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_dtp.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_hiddentext.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_libview.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_text.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

const int wid=524;

@RoutePage()
class CustEnrollMemberInfoVehicle extends StatelessWidget {
  const CustEnrollMemberInfoVehicle(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId});

  final String? custEttyId;
  final String? mbrEttyId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Center(
      child: CustEnrollMemberInfoVehicleForm(
        custEttyId: custEttyId,
        mbrEttyId: mbrEttyId,
      ),
    );
  }
}

class CustEnrollMemberInfoVehicleForm extends ConsumerWidget {
  const CustEnrollMemberInfoVehicleForm(
      {super.key, this.custEttyId, this.mbrEttyId});

  final String? custEttyId;
  final String? mbrEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final custEnrollVehFormKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "MbrEttyId": mbrEttyId,
      "Dscp": null,
      "CostCtr": null,
      "MbrCnt": 0,
      "MediaCnt": 0,
      "RoadTaxExpDate": null,
      "EngineCapacity": null,
      "VhcId": null
    };

    //  "MbrRnk": null,
    // "VipCd": 0,
    // "CmpyEttyId": 37,
    // "CostCtrEttyId": 40,
    final query = QueryObject(
        querysql: '/sp/ApiEnrlMbrVhc/queryasync',
        params: {
          "MbrEttyId": mbrEttyId == 'new' ? null : mbrEttyId,
          "CustEttyId": custEttyId,
        },
        showMsg: false);
    final formData = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget<Returndata>(
      value: formData,
      data: (theData) {
        if (theData.data != null) {
          formNewValue = convertFormValueToDisplay(
              theData.data![0] as Map<String, dynamic>, theData.columnInfo);
        }
        return FormBuilder(
            key: custEnrollVehFormKey,
            initialValue: formNewValue,
            child: Row(
              children: [
                //   "TaxCtgry": null,

                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FbHiddenText(name: 'CustEttyId'),
                        const FbHiddenText(name: 'MbrEttyId'),
                        const FbHiddenText(name: 'VhcId'),
                        SelectableText(S.of(context).lblVehicleDatails),
                        FbText(
                            name: 'VhcRgsNo',
                            label: S.of(context).lblVehicleRegNo),
                        FbText(
                            name: 'EngineCapacity',
                            label: S.of(context).lblEngineCapacity),
                        Row(
                          children: [
                            Flexible(
                              child: FbDateTimePicker(
                                  name: 'RgstionDate',
                                  label: S.of(context).lblVehRgsDate),
                            ),
                            Flexible(
                              child: FbDateTimePicker(
                                  name: 'RoadTaxExpDate',
                                  label: S.of(context).lblRoadTaxExp),
                            ),
                          ],
                        ),
                        FbLibView(
                            name: 'Brand',
                            label: S.of(context).lblVehBrandMake,
                            params: const {
                              "RefType": "VHCBRAND",
                              "BitInd": null
                            },
                            keyField: "RefCd",
                            searchText: "Dscp",
                            querySql: '/sp/GetLibRef/queryasyncnouser'),
                        FbLibView(
                            name: 'Model',
                            label: S.of(context).lblVehModel,
                            params: const {
                              "RefType": "VHCMODEL",
                              "BitInd": null
                            },
                            keyField: "RefCd",
                            searchText: "Dscp",
                            querySql: '/sp/GetLibRef/queryasyncnouser'),
                        FbLibView(
                            name: 'VhcType',
                            label: S.of(context).lblVehType,
                            params: const {
                              "RefType": "VHCTYPE",
                              "BitInd": null
                            },
                            keyField: "RefCd",
                            searchText: "Dscp",
                            querySql: '/sp/GetLibRef/queryasyncnouser'),
                        FbLibView(
                            name: 'VhcCtgry',
                            label: S.of(context).lblVehClass,
                            params: const {
                              "RefType": "VHCCTGRY",
                              "BitInd": null
                            },
                            keyField: "RefCd",
                            searchText: "Dscp",
                            querySql: '/sp/GetLibRef/queryasyncnouser'),
                      ],
                    ),
                  ),
                ),
                const Expanded(flex: 5, child: SelectableText('')),
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    ElevatedButton(
                        onPressed: () {
                          custEnrollVehFormKey.currentState!.save();

                          Map<String, dynamic> toPost = Map.from(
                              convertFormValueToSave(
                                  custEnrollVehFormKey.currentState!.value,
                                  theData.columnInfo));

                          final querySave = QueryObject(
                              querysql: '/sp/ApiEnrlMbrVhcSave/queryasync',
                              params: toPost,
                              showMsg: false);
                          final saveResult = ref.read(
                              ReturndatafreezedProvider(querySave).future);
                          saveResult.then((value) {
                            Toast.showresult(value);
                                 if (isSuccess(value.message)) {
                            ref.invalidate(ReturndatafreezedProvider(query));
                          }
                          });
                        },
                        child: const Icon(Icons.save)),
                             sbh10,
                    AcxAuditLogReqBtn('ApiEnrlMbrVhcSave',ettyId: convStrNewOrNullToNull(formNewValue["VhcId"]).toString(),)
                  ]),
                )
              ],
            ));
      },
    );
  }
}
