import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/user_mgmt_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=260;

@RoutePage()
class UserMgmtWebPortalAccessControlList extends ConsumerWidget {
  const UserMgmtWebPortalAccessControlList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return AcxTrinaGridWithColumn(
        querysql: '/sp/ApiSignInList/queryasync',
        params: const {"UserType": "I"},
        showActions: true,
        spName: 'ApiSignInList',
        idField: 'UserId',
        useNav: false,
        onNew: (){
                   singleton<AppRouter>().navigatePath(
              '/usermgmt/nucleususer/dtl/new');
        },
        onSelectedTap: (TrinaRow val) {
          ref.read(userMgmtControllerProvider.notifier).state = val.toJson();
          //  Toast.message(val.toJson().toString());
          singleton<AppRouter>().navigatePath(
              '/usermgmt/nucleususer/dtl/${val.cells['UserId']!.value.toString()}');
        });
  }
}
