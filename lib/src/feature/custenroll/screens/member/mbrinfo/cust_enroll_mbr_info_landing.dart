import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=522;

@RoutePage()
class CustEnrollMemberInfoLanding extends StatelessWidget {
  const CustEnrollMemberInfoLanding(
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
    final valMbr = convStrNewOrNullToNull(mbrEttyId);
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: AcxTabView(
          align: Alignment.centerLeft,
          routes: [
            CustEnrollMemberInfo(),
            CustEnrollMemberInfoPersonal(),
            CustEnrollMemberInfoVehicle(),
          ],
          tabs: [
            Tab(
              text: S.current.tabMembership,
            ),
            valMbr == null
                ? emptyTab
                : Tab(
                    text: S.current.tabPersonalInfo,
                  ),
            valMbr == null
                ? emptyTab
                : Tab(
                    text: S.current.tabVehicleInfo,
                  ),
          ],
        ),
      ),
    );
  }
}
