import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridv2.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=225;

@RoutePage()
class MchtEnrollListScreen extends BaseScreen {
  const MchtEnrollListScreen({super.key})
      : super(
          includeMainDrawer: true,
        );

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(context, ref);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(context, ref);
  }

  @override
  Widget sideBar() {
    return provideSideBar("mcenroll/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("mcenroll");
  }
}

Widget buildView(BuildContext context, WidgetRef ref) {
      final listQuery = ReturndataProvider(querysql: '/sp/ApiEnrlMchtList/queryasync',
        params: const {},
        showMsg: false);
  return Scaffold(
    body: AcxTrinaGridv2(
      gridTitle: 'Merchant Enrolment',
      idField: 'MchtEttyId',
      query: listQuery,
      onRefresh: () {
        ref.invalidate(listQuery);
      },
      onNew: () {
                  if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                            Toast.message("Action Not Authorised");
                            return;
                          }
      singleton<AppRouter>().navigatePath('/mcenroll/pending/new');
      },
      onSelected: (TrinaRow val) {
                  final theTitle = getTitle(
          ref,
          {
            "MchtEttyId": val.cells["MchtEttyId"]!.value.toString(),
          },
          AppBarTitleType.enroll);
      theTitle.then((value) {
        singleton<AppRouter>().navigatePath(
            '/mcenroll/mcht/${val.cells['MchtEttyId']!.value}/quickinfo/overview');
        ref.read(appBarTitleProvider.notifier).state = value.toString();
        ref.read(menuSideTabSelectProvider.notifier).state = "Merchant";
      });
      },
    ),
    appBar: AppBar(
      title: SelectableText(S.of(context).lblPendingMchtEnrl),
      automaticallyImplyLeading: false, centerTitle: false,
    ),
  );
}
