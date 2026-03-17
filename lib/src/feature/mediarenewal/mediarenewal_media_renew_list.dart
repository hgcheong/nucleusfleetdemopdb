import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=178;

@RoutePage()
class MediaRenewalList extends ConsumerWidget {
  const MediaRenewalList(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    //  return const SelectableText('Cust Enroll Member List');

    return AcxTrinaGridWithColumn(
      querysql: '/sp/ApiMgmtMediaRenewList/queryasync',
      spName: 'ApiMgmtMediaRenewList',
      params: const {},
      idField: 'MediaId',
      navPrefix: '',
      onDelete: (TrinaRow val) async {
                   if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
        bool confirmed =
            await ConfirmDialog.show(title: 'Delete selected card renewal?');
        if (confirmed) {
          final currentRow = val;
          final queryDel = QueryObject(
              querysql: '/sp/ApiMgmtMediaRenewDel/queryasync',
              params: {
                "MediaEttyId": currentRow.cells['MediaEttyId'],
                "MediaNo": currentRow.cells['MediaNo'],
                "MediaId": currentRow.cells['MediaId'],
                "PrgEttyId": currentRow.cells['PrgEttyId'],
                "CustEttyId": currentRow.cells['CustEttyId'],
              },
              showMsg: false);
          await ref
              .read(ReturndatafreezedProvider(queryDel).future)
              .then((value) {
            if (isSuccess(value.message)) {
              // ref.invalidate(ReturndatafreezedProvider(QueryObject(querysql: '/sp/ApiPrgMchtTxnPlanList/queryasync', params: {'mchtEttyId': mchtEttyId, 'MsgTypePlanId': msgTypePlanId}, showMsg: false)));
            }
    
            return Toast.showresult(value);
          });
        }
      },
      onSelectedTap: (TrinaRow val) {
        //  getTitle(ref, {"CustEttyId": val.cells["CustEttyId"]!.value.toString()}, AppBarTitleType.enroll).then((value) {
        // ref.read(appBarTitleProvider.notifier).state = value.toString();
        //        ref.read(mbrCostCenterProvider.notifier).state = {"CustEttyId": val.cells["CustEttyId"]!.value.toString(), "CmpyEttyId": val.cells["CmpyEttyId"]!.value.toString()};
        // singleton<AppRouter>().navigatePath('/custenroll/member/$custEttyId/detail/${val.cells['MbrEttyId']!.value.toString()}/memberinfo/membership');
    
        // });
      },
      useNav: false,
    );
  }
}
