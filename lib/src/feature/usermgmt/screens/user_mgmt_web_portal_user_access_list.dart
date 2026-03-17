import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/mockdata.dart';
import 'package:trina_grid/trina_grid.dart';

import 'package:nucleusv2/src/core/app_router.dart';

const int wid=264;

@RoutePage()
class UserMgmtWebPortalUserAccessList extends BaseScreen {
  const UserMgmtWebPortalUserAccessList({super.key});

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView();
  }

  @override
  Widget sideTab() {
    return provideSideTab("");
  }

  @override
  Widget sideBar() {
   return provideSideBar("usermgmt/nucleususer");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("usermgmt/webportaluser");
  }

  Widget buildView() {
    return Scaffold(
      body: toReturn(),
      appBar: AppBar(
        centerTitle: false,
        title: const SelectableText('Web Portal Access Control'),
      ),
    );
  }

  Widget toReturn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbh20,
        const SelectableText("Web User Access Rights"),
        sbh20,
        Expanded(
          child: AcxTrinaGridExtDataCheckBox(
              extData: accessRights,
              spName: 'ApiEnrlCustList',
              idField: 'UserId',
              onNew: () {
                  if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                ///usermgmt/webportaluser/accessrightslist/16
                singleton<AppRouter>()
                    .navigatePath('/usermgmt/webportaluser/accessrightsadd/new');
              },
              onDelete: (val) {
                            if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
              },
              onSelectedTap: (TrinaRow val) {
                singleton<AppRouter>().navigatePath(
                    '/usermgmt/webportaluser/accessrights/${val.cells['UserId']!.value.toString()}');
                //accessrights
              }),
        ),
      ],
    );
  }
}
