import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=355;

@RoutePage()
class MchtEnrlBillingList extends ConsumerWidget {
  const MchtEnrlBillingList(
      {super.key, @PathParam.inherit('mchtEttyId') this.mchtEttyId});

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final theTitle = getTitle(
        ref,
        {
          "MchtEttyId": mchtEttyId,
        },
        AppBarTitleType.enroll);
    theTitle.then((value) {
      ref.read(appBarTitleProvider.notifier).state = value.toString();
    });
    return SingleChildScrollView(
      child: SizedBox(
        height: 1280,
        child: AcxTrinaGridWithColumn(
          querysql: '/sp/ApiEnrlMchtLocAutoPymtList/queryasync',
          spName: 'ApiEnrlMchtLocAutoPymtList',
          params: {"MchtEttyId": mchtEttyId},
          idField: 'LocEttyId',
          navPrefix: '',
          useNav: false,
          onSelectedTap: (TrinaRow val) {
            singleton<AppRouter>().navigatePath(
                './autoPayment/${val.cells['PrgEttyId']!.value}/${val.cells['LocEttyId']!.value}/dtl');
          },
        ),
      ),
    );
  }
}
