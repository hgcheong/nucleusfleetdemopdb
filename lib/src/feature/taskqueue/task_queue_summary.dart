import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap.dart';

const int wid=202;

@RoutePage()
class TaskQueueSummary extends BaseScreen {
  const TaskQueueSummary({super.key});

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
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("taskqueue/summary");
  }

  Widget buildView(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AcxListButtonNavWrap(
          addNew: (){
                         singleton<AppRouter>()
                  .navigatePath('/taskqueue/creditcollection');
          },
          querysql: 'ApiTaskQueSmryList',
          params: const {},
          returnSelectedRef: (val) {
            //  ref.read(dataentryTxnIdProvider.notifier).state = '';
            //main/:wfcd/:wfprcsid/:usrid
            if (val["WfCd"] == 'CRCOLLECT') {
              singleton<AppRouter>()
                  .navigatePath('/taskqueue/creditcollection');
            } else {
              singleton<AppRouter>().navigatePath(
                  '/taskqueue/main/${val["WfCd"]}/${val["WfPrcsId"]}/${val["WfGrpId"]}/list');
            }
          },
          displayfield: const ['WorkFlowDscp', 'TaskCount'],
          keyField: 'WfPrcsId',
        ),
      ),
      appBar: AppBar(
        title: const SelectableText('Task Queue Summary'),
        automaticallyImplyLeading: false, centerTitle: false,
      ),
    );
  }
}
