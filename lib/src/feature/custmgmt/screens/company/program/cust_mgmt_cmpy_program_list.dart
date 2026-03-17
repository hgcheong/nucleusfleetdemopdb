import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrapext.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/feature/custmgmt/custmgmt_controller.dart';

const int wid=564;

@RoutePage()
class CustMgmtCmpyProgramList extends ConsumerWidget {
  const CustMgmtCmpyProgramList(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('cmpyEttyId') this.cmpyEttyId});

  final String? custEttyId;
  final String? cmpyEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtCmpyPrgAccptList/queryasync',
        params: {"CustEttyId": custEttyId, "CmpyEttyId": cmpyEttyId},
        showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          return ListView(
            children: [
              const SelectableText(
                  'Company have accepted the following program'),
              AcxListButtonNavWrapExt(
                keyField: 'PrgEttyId',
                filterField: 'BillingType',
                filterValue: "!null",
                displayfield: const ['PrgDscp', 'BillingLevel', 'BillingType'],
                deleteSelectedRef: (val) async {
                  final theResult =
                      await ConfirmDialog.show(title: 'Remove program?');
                  theResult == true
                      ? updateData({
                          "CmpyEttyId": cmpyEttyId,
                          "CustEttyId": custEttyId,
                          "PrgEttyId": val['PrgEttyId']
                        }, custEttyId.toString(), cmpyEttyId.toString(), ref,
                          query)
                      : null;
                },
                returnSelectedRef: (val) async {
                  {
                    ref.read(custMgmtPrgSelectProvider.notifier).state = val;

                    singleton<AppRouter>().navigatePath(
                        '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/program/select/${val["PrgEttyId"]}/${val["AccptId"]}');
                  }
                },
                returnData: theData,
              ),
              sbh10,
              const SelectableText('Available program for sign up'),
              sbh10,
              AcxListButtonNavWrapExt(
                keyField: 'PrgEttyId',
                filterField: 'BillingType',
                filterValue: null,
                displayfield: const ['PrgDscp', 'BillingLevel', 'BillingType'],
                returnSelectedRef: (val) {
                  {
                    ref.read(custMgmtPrgSelectProvider.notifier).state = val;

                    singleton<AppRouter>().navigatePath(
                        '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/program/select/${val["PrgEttyId"]}/${val["AccptId"]}');
                  }
                },
                returnData: theData,
              ),
            ],
          );
        });
  }
}

void updateData(Map<String, dynamic> param, String custEttyId,
    String cmpyEttyId, WidgetRef ref, QueryObject queryList) {
  final querySave = QueryObject(
      querysql: '/sp/ApiMgmtCmpyPrgAccptDel/queryasync',
      params: param,
      showMsg: false);
  final results = ref.read(ReturndatafreezedProvider(querySave).future);
  results.then((value) {
    Toast.showresult(value);
    if (isSuccess(value.message)) {
      // singleton<AppRouter>().navigatePath('/custmgmt/cust/$custEttyId/program/list');
      ///custmgmt/cmpy/528/detail/529/program/list
      singleton<AppRouter>()
          .navigatePath(
              '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/program/list')
          .then((v) {
        ref.invalidate(ReturndatafreezedProvider(queryList));
      });
    }
  });
}
