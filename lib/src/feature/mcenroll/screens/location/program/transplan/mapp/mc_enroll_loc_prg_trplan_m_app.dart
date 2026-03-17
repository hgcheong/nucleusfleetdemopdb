import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/feature/mcenroll/screens/location/program/transplan/mcenroll_transplan_common.mock.dart';

const int wid=851;

@RoutePage()
class MchtEnrlLocPrgTranPlanMapp extends ConsumerWidget {
  const MchtEnrlLocPrgTranPlanMapp({
    super.key,
    this.prgEttyId,
    this.msgTypePlanId,
  });

  final String? prgEttyId;
  final String? msgTypePlanId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return McEnrollTransPlanCommonFormMock(
        prgEttyId: prgEttyId,
        poe: 'APP',
        title: 'APP Transaction Plan Setup at Program Level',
        msgTypePlanId: msgTypePlanId == 'new' || msgTypePlanId == 'null'
            ? null
            : msgTypePlanId);
  }
}
