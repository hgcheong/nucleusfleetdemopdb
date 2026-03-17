import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridv2.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';

const int wid=220;

@RoutePage()
class CustEnrollListScreen extends BaseScreen {
  const CustEnrollListScreen({super.key})
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
    return provideSideBar("custenroll/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custenroll/main");
  }
}

Widget buildView(BuildContext context, WidgetRef ref) {
      final listQuery = ReturndataProvider(querysql: '/sp/ApiEnrlCustList/queryasync',

        params: const {},
        showMsg: false);
  return Scaffold(
 appBar: AppBar(
      title: SelectableText(S.of(context).lblPendingCustEnrolment),
      automaticallyImplyLeading: false, centerTitle: false,
    ),
    body: AcxTrinaGridv2(
   
      gridTitle: 'Customer Enrolment',
         onRefresh: () {
          ref.invalidate(listQuery);
        },
      onSelected: (val) {
        getTitle(
                ref,
                {
                  "CustEttyId": val.cells["CustEttyId"]!.value.toString(),
                },
                AppBarTitleType.enroll)
            .then((value) {
          singleton<AppRouter>().navigatePath(
              '/custenroll/cust/${val.cells["CustEttyId"]!.value.toString()}');
          ref.read(menuSideTabSelectProvider.notifier).state = "Customer";
          ref.read(appBarTitleProvider.notifier).state = value.toString();
        });
    
      },
      idField: 'CustEttyId', query: listQuery,
    ),
  );
}

