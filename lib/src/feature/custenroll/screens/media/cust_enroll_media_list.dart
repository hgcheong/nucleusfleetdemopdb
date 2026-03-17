import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custenroll/screens/media/cust_enroll_media_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=289;

@RoutePage()
class CustEnrollMediaList extends StatelessWidget {
  const CustEnrollMediaList(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return CustEnrollMediaListGrid(custEttyId: custEttyId);
  }
}

class CustEnrollMediaListGrid extends HookConsumerWidget {
  const CustEnrollMediaListGrid({
    super.key,
    this.custEttyId,
  });
  final String? custEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listQuery = ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiEnrlMediaList/queryasync',
        params: {
          "CustEttyId": custEttyId,
        },
        showMsg: false));
    final listData = ref.watch(listQuery);
    return AsyncValueWidget<Returndata>(
        value: listData,
        data: (dv) {
          return AcxTrinaGridExtDataCheckBox(
            idField: 'MediaEttyId',
            spName: 'ApiEnrlMediaList',
            extData: dv,
            isMultiSelect: false,
            onDelete: (Set<TrinaRow> rows) async {
                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
             bool confirmed = await ConfirmDialog.show(
              title: 'Are you sure you want to delete the record?');
          if (confirmed) {
            var futures = <Future>[];
            for (var i = 0; i < rows.length; i++) {
              final queryDel = QueryObject(
                  querysql: '/sp/ApiEnrlMediaDel/queryasync',
                  params: {
                    "CustEttyId": custEttyId,
                    "MediaEttyId": rows
                        .elementAt(i)
                        .cells["MediaEttyId"]!
                        .value
                        .toString(),
                         "PrgEttyId": rows
                        .elementAt(i)
                        .cells["PrgEttyId"]!
                        .value
                        .toString(),
                  },
                  showMsg: false);
              final resultDel =
                  ref.read(ReturndatafreezedProvider(queryDel).future);
              futures.add(resultDel);
            }
            await Future.wait(futures, eagerError: true).then((value) {
              //   ref.invalidate(listQuery);
              List<dynamic> rtt = value;
          
              for (var element in rtt) {
                if (!isSuccess(element.message)) {
                  Toast.showresult(element);
                }
              }
              ref.invalidate(listQuery);
            }).onError((error, stackTrace) {
              Toast.message(error.toString());
            });
          }
            },
            onNew: () {
                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                   ref.read(mediaMediaCategorySelectProvider.notifier).state = {
                    "MediaCtgry": null,
                    "Dscp":null
                  };
              singleton<AppRouter>()
                  .navigatePath('/custenroll/media/$custEttyId/selmedia');
            },
            onSelectedTap: (TrinaRow val) {
              ref.read(mediaMediaHolderNameProvider.notifier).state =
                  "${val.cells['MemberName']!.value} ${val.cells['VehicleNo']!.value ?? ''}";
              ref.read(mediaMediaCategorySelectProvider.notifier).state = {"MediaCtgry": val.cells['MediaCtgry']!.value.toString(),"Dscp":val.cells['MediaCategory']!.value.toString(),};
              singleton<AppRouter>().navigatePath(
                  '/custenroll/media/$custEttyId/detail/${val.cells['MediaCtgry']!.value.toString()}/${val.cells['PrgEttyId']!.value.toString()}/${val.cells['MbrEttyId']!.value.toString()}/${val.cells['MediaEttyId']!.value.toString()}');
            },
          );
        });
  }
}
