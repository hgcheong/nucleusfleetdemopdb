import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=627;

@RoutePage()
class CustMgmtMemberCtrlProd extends ConsumerWidget {
  const CustMgmtMemberCtrlProd({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('mbrEttyId') this.mbrEttyId,
    @PathParam('prgEttyId') this.prgEttyId,
  });

  final String? custEttyId;
  final String? mbrEttyId;
  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    Map<String, dynamic> formSwitchValue = {};
    final queryPrdList = QueryObject(
        querysql: '/sp/ApiMgmtMbrPrdAccpt/queryasync',
        params: {
          "PrgEttyId": prgEttyId,
          "CustEttyId": custEttyId,
          "MbrEttyId": mbrEttyId
        },
        showMsg: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            children: [
              const SelectableText(
                  'Product & Services Acceptance at Member level'),
              Expanded(
                  child: CustMgmtMbrCtrlTxnprdList(
                switchValue: formSwitchValue,
                query: queryPrdList,
              )),
            ],
          ),
        ),
        Expanded(
          child: Column(children: [
            ElevatedButton(
                onPressed: () {
                  saveProdList(
                      formSwitchValue,
                      ref,
                      prgEttyId.toString(),
                      mbrEttyId.toString(),
                      custEttyId.toString(),
                      queryPrdList);
                },
                child: const Icon(Icons.save)),
            sbh10,
            AcxBackToList(
                listUrl:
                    '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/prodaccpt'),
            AcxAuditLogReqBtn('ApiMgmtMbrPrdAccptSave', ettyId: '$custEttyId|$mbrEttyId|$prgEttyId'),
          ]),
        )
      ],
    );
  }
}

class CustMgmtMbrCtrlTxnprdList extends ConsumerWidget {
  const CustMgmtMbrCtrlTxnprdList(
      {super.key, this.switchValue, required this.query});

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
              switchValue![item['PrdCd']] = item['PrdSts'];
            }

            for (var item in toVV) {
              rowItems.add(Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FormBuilderSwitch(
                      initialValue: item['PrdSts'] == 'N' ? false : true,
                      name: item['PrdCd'],
                      title: SelectableText(item['PrdDscp']),
                      onChanged: (value) {
                        switchValue![item['PrdCd']] =
                            value == false ? 'N' : 'Y';
                      },
                      valueTransformer: (value) {
                        return value == false ? 'N' : 'Y';
                      },
                    ),
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

void saveProdList(Map<String, dynamic> src, WidgetRef ref, String prgEttyId,
    String mbrEttyId, String custEttyId, QueryObject query) async {
  var futures = <Future>[];

  for (var element in src.entries) {
    final queryDel = QueryObject(
        querysql: '/sp/ApiMgmtMbrPrdAccptSave/queryasync?logId=$custEttyId|$mbrEttyId|$prgEttyId',
        params: {
          "CustEttyId": custEttyId,
          "MbrEttyId": mbrEttyId,
          "PrgEttyId": prgEttyId,
          "PrdSts": element.value ?? 'N',
          "PrdCd": element.key
        },
        showMsg: false);
    final resultDel = ref.read(ReturndatafreezedProvider(queryDel).future);
    futures.add(resultDel);
  }

  await Future.wait(futures, eagerError: true).then((value) {
       Toast.success('Product Acceptance Updated');
    ref.invalidate(ReturndatafreezedProvider(query));
  }).onError((error, stackTrace) {
    Toast.message(error.toString());
  });
}
