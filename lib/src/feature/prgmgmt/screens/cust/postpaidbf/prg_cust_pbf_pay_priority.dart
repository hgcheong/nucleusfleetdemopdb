import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';

const int wid=773;

@RoutePage()
class PrgCustPbfPayPriority extends ConsumerWidget {
  const PrgCustPbfPayPriority(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 54),
          child: SelectableText(
              'System adopt FIFO priority for aging buckets knock off'),
        ),
        sbh10,
        const Padding(
          padding: EdgeInsets.only(left: 54),
          child: SelectableText('Transaction Category knock-off matrix'),
        ),
        sbh10,
        const Padding(
          padding: EdgeInsets.only(left: 54),
          child: SelectableText(
              'Knock-off priority for "Group" is in ascending order of the group number, in the group then follow by "Sequence" with smaller number first in the ascending order'),
        ),
        sbh10,
        AcxTrinaGridWithColumn(
          querysql: '/sp/ApiPrgCustPostpaidBFPymtPriority/queryasync',
          params: {'PrgEttyId': prgEttyId},
          idField: 'CtgryId',
          spName: 'ApiPrgCustPostpaidBFPymtPriority',
          useNav: false,
        ),
      ],
    );
  }
}
