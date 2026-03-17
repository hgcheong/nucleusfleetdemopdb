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

const int wid=605;

@RoutePage()
class CustMgmtProgramList extends ConsumerWidget {
  const CustMgmtProgramList({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  });

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final query = QueryObject(
        querysql: '/sp/ApiMgmtCustPrgList/queryasync',
        params: {"CustEttyId": custEttyId},
        showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          return ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SelectableText(
                  'Customer have signed up for the following program'),
              AcxListButtonNavWrapExt(
                keyField: 'PrgEttyId',
                filterField: 'StsDscp',
                filterValue: 'ACCEPTED',
                displayfield: const ['PrgDscp', 'BillingLevel', 'StsDscp'],
                deleteSelectedRef: (val) async {
                  final theResult =
                      await ConfirmDialog.show(title: 'Remove program?');
                  theResult == true
                      ? updateData({
                          "CustEttyId": custEttyId,
                          "PrgEttyId": val['PrgEttyId']
                        }, custEttyId.toString(), ref, query)
                      : null;
                },
                returnSelectedRef: (val) async {
                  {
                    ref.read(custMgmtPrgSelectProvider.notifier).state = val;
                    singleton<AppRouter>().navigatePath(
                        '/custmgmt/custprg/$custEttyId/${val["PrgEttyId"]}/${val["BillingEttyType"]}/${val["AccptId"]}/billing/billingentity');
                  }
                },
                returnData: theData,
              ),
              sbh10,
              const SelectableText('Available program for sign up'),
              sbh10,
              AcxListButtonNavWrapExt(
                keyField: 'PrgEttyId',
                filterField: 'StsDscp',
                filterValue: 'UNASSIGN',
                displayfield: const ['PrgDscp', 'BillingLevel', 'StsDscp'],
                returnSelectedRef: (val) {
                  {
                    ref.read(custMgmtPrgSelectProvider.notifier).state = val;

                    //'/custmgmt/cust/$custEttyId/program/select/${val["PrgEttyId"]}'
                    singleton<AppRouter>().navigatePath(
                        '/custmgmt/cust/$custEttyId/program/select/${val["PrgEttyId"]}');
                    // singleton<AppRouter>().navigatePath('/custmgmt/cust/$custEttyId/profile/address/adddtl/${val["AddrType"]}/${val["ContactId"]}');
                  }
                },
                returnData: theData,
              ),
            ],
          );
        });
  }
}

void updateData(Map<String, dynamic> param, String custEttyId, WidgetRef ref,
    QueryObject queryList) {
  final querySave = QueryObject(
      querysql: '/sp/ApiMgmtCustPrgDel/queryasync',
      params: param,
      showMsg: false);
  final results = ref.read(ReturndatafreezedProvider(querySave).future);
  results.then((value) {
    Toast.showresult(value);
    if (isSuccess(value.message)) {
      singleton<AppRouter>()
          .navigatePath('/custmgmt/cust/$custEttyId/program/list')
          .then((v) {
        ref.invalidate(ReturndatafreezedProvider(queryList));
      });
    }
  });
}
