import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';

const int wid=217;

@RoutePage()
class BulkMediaprodList extends BaseScreen {
  const BulkMediaprodList({super.key})
      : super(
          includeMainDrawer: true,
        );

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
    return provideSideBar("bulkmedia/main");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("bulkmedia/main");
  }
}

Widget buildView() {
  return Scaffold(
    body: ListView(
      children: const [
        AcxTrinaGridWithColumn(
          querysql: '/sp/ApiEnrlCustList/queryasync',
          spName: 'ApiEnrlCustList',
          params: {},
          idField: 'CustEttyId',
          navPrefix: '/custenroll/cust',
          useNav: true,
        ),
      ],
    ),
    appBar: AppBar(
      title: const SelectableText('Pending Bulk Order'),
      automaticallyImplyLeading: false, centerTitle: false,
    ),
  );
}
