import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/mockdata.dart';
import 'package:trina_grid/trina_grid.dart';

import 'package:nucleusv2/src/core/app_router.dart';

const int wid=254;

@RoutePage()
class UserMgmtNucleusUserAccessList extends HookConsumerWidget {
  const UserMgmtNucleusUserAccessList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SingleChildScrollView(
      child: SizedBox(
        height: 1280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sbh20,
            const SelectableText("Nucleus Access Rights"),
            sbh20,
            Expanded(
              child: AcxTrinaGridExtDataCheckBox(
                  extData: accessRightsNucleus,
                  spName: 'ApiEnrlCustList',
                  idField: 'UserId',
                  onNew: () {
                      if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                    ///usermgmt/nucleususer/accessrightslist/16
                    singleton<AppRouter>().navigatePath(
                        '/usermgmt/nucleususer/accessrightsadd/new');
                  },
                  onDelete: (val) {
                                if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                  },
                  onSelectedTap: (TrinaRow val) {
                    singleton<AppRouter>().navigatePath(
                        '/usermgmt/nucleususer/accessrights/${val.cells['UserId']!.value.toString()}');
                    //accessrights
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
