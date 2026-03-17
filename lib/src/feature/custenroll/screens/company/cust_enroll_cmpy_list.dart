import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=277;

@RoutePage()
class CustEnrollCompanyList extends ConsumerWidget {
  const CustEnrollCompanyList({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  });

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return ListView(children: [
      AcxTrinaGridWithColumn(
        querysql: '/sp/ApiEnrlCmpyList/queryasync',
        spName: 'ApiEnrlCmpyList',
        params: {"CustEttyId": custEttyId},
        idField: 'CmpyEttyId',
        navPrefix: '',
        onNew: () {
            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          singleton<AppRouter>().navigatePath(
              '/custenroll/cmpy/$custEttyId/detail/new/profile/geninfo');
              
        },
        onSelectedTap: (TrinaRow val) {
          final theTitle = getTitle(
              ref,
              {"CustEttyId": val.cells["CustEttyId"]!.value.toString()},
              AppBarTitleType.enroll);
          theTitle.then((valt) {
       
            if(valt!.startsWith("  ")){

            }else{
   ref.read(appBarTitleProvider.notifier).state = valt.toString();
            }
                 singleton<AppRouter>().navigatePath(
                '/custenroll/cmpy/$custEttyId/detail/${val.cells['CmpyEttyId']!.value.toString()}/profile/geninfo');
         
          });
        },
        useNav: false,
      ),
    ]);
  }
}
