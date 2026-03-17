import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

import 'package:trina_grid/trina_grid.dart';

const int wid=427;

@RoutePage()
class UserMgmtWebGroupList extends ConsumerWidget {
  const UserMgmtWebGroupList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return AcxTrinaGridWithColumn(
        querysql: '/sp/ApiSignInWebGroupList/queryasync',
        params: const {},
        showActions: true,
        spName: 'ApiSignInWebGroupList',
        idField: 'UserGrp',
        useNav: false,
        onNew: () {
            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          singleton<AppRouter>()
              .navigatePath('/usermgmt/webgroup/dtl/new/new');
        },
        onDelete: (TrinaRow val) {
                      if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
          final resultDel = ref.read(ReturndatafreezedProvider(QueryObject(
                  querysql: '/sp/ApiSignInWebGroupDel/queryasync',
                  params: {
                    "GrpId": val.cells["GrpId"]!.value.toString(),
                    "UserType": val.cells["UserType"]!.value.toString()
                  },
                  showMsg: true))
              .future);
          resultDel.then((Returndata value) {
            //   ref.invalidate(ReturndatafreezedProvider(query));
            Toast.showresult(value);
          });
        },
        onSelectedTap: (TrinaRow val) {
          singleton<AppRouter>().navigatePath(
              '/usermgmt/webgroup/dtl/${val.cells['UserGrp']!.value.toString()}/${val.cells['UserType']!.value.toString()}/${val.cells['GrpId']!.value.toString()}');
        });
  }
}

//:userGrp/:userType
