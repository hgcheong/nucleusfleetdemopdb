import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';

const int wid=774;

@RoutePage()
class PrgCustPbfPayPriorityList extends ConsumerWidget {
  const PrgCustPbfPayPriorityList(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Column(children: [
      const SelectableText(
          'System adopt FIFO priority for aging buckets knock off'),
      const SelectableText('Transaction Category knock-off matrix'),
      const SelectableText(
          'Knock-off priority for "Group" is in ascending order of the group number, in the group then follow by "Sequence" with smaller number first in the ascending order'),
      AcxTrinaGridWithColumn(
        querysql: '/sp/ApiPrgCustPostpaidBFPymtPriority/queryasync',
        params: {'PrgEttyId': prgEttyId},
        idField: 'CtgryId',
        spName: 'ApiPrgCustPostpaidBFPymtPriority',
      )
    ]);
  }
}
