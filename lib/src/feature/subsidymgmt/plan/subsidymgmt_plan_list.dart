import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap_manual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=231;

@RoutePage()
class SubsidymgmtPlanList extends ConsumerWidget {
  const SubsidymgmtPlanList(
      {super.key, @PathParam.inherit('subsId') this.subsId});

  final String? subsId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final listQuery = QueryObject(
        querysql: '/sp/ApiPrgSubsLocateList/queryasync',
        params: {"SubsId": subsId},
        showMsg: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SelectableText('Define the Subsidy plan of this program'),
        AcxListButtonNavWrapManual(
            keyField: 'SubsLocateId',
            query: listQuery,
            displayfield: const ['SubsSchemeDscp', 'Dscp'],
            deleteSelectedRef: (val) {
              final queryDel = QueryObject(
                  querysql: '/sp/ApiPrgSubsLocateDel/queryasync',
                  params: {
                    "SubsId": val['SubsId'],
                    "SubsLocateId": val['SubsLocateId']
                  },
                  showMsg: false);
              final queryRes =
                  ref.read(ReturndatafreezedProvider(queryDel).future);
              queryRes.then((value) {
                Toast.showresult(value);
                if (isSuccess(value.message)) {
                  ref.invalidate(ReturndatafreezedProvider(listQuery));
                }
              });
            },
            addNew: () {
              singleton<AppRouter>().navigatePath('/subsidy/plan/$subsId/new');
            },
            returnSelectedRef: (val) {
              {
                singleton<AppRouter>().navigatePath(
                    '/subsidy/plan/$subsId/${val['SubsLocateId']}');
              }
            }),
      ],
    );
  }
}
