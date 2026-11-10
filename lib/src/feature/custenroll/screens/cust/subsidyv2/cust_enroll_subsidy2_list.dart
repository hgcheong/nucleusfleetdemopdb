import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridv2.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/app_router.dart';


const int wid=463;

@RoutePage()
class CustEnrollSubsidy2List extends BaseScreen {
  const CustEnrollSubsidy2List({
    super.key
  });
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
      final listQuery = returndataProvider(querysql: '/sp/ApiMgmtCbpPrgList/queryasync',

        params: const {},
        showMsg: false);
  return Scaffold(
 appBar: AppBar(
  
      title: SelectableText(S.of(context).lblSubsidySetupEnrol),
      automaticallyImplyLeading: false, centerTitle: false,
    ),
    body: AcxTrinaGridv2(
      gridTitle: 'Subsidy/Rebate Program List',
    idField: 'CbId', query: listQuery,
         onRefresh: () {
          ref.invalidate(listQuery);
        },
      onSelected: (val) {
         singleton<AppRouter>().navigatePath(
               '/custenroll/subsidy2/cbp/${val.cells["CbPrgType"]!.value.toString()}/${val.cells["PrgEttyId"]!.value.toString()}/${val.cells["CbId"]!.value.toString()}/cbplist');
      },

    ),
  );
}
// class Subsidy2QuotaList extends HookConsumerWidget {
//   const Subsidy2QuotaList({
//     super.key,
//     this.custEttyId,
//   });
//   final String? custEttyId;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//     final query = QueryObject(
//         querysql: '/sp/ApiMgmtCbpPrgList/queryasync',
//         params: {},
//         showMsg: false);
//     final listData = ref.watch(ReturndatafreezedProvider(query));
//     return AsyncValueWidget<Returndata>(
//         value: listData,
//         data: (dv) {
//           return SingleChildScrollView(
//             child: SizedBox(
//               height: 1280,
//               child: AcxTrinaGridExtData(
//                 spName: 'ApiMgmtCbpPrgList',
//                 extData: dv,
//                 idField: 'CbId',
//                 useCheckBox: false,
//                 onNew: (){
//                   singleton<AppRouter>().navigatePath(
//                           '/custenroll/cust/$custEttyId/Subsidy2/quotadtl/new');
//                 },
//                          onDelete: (ValueNotifier<TrinaRow> val) {
                
                  
//               if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
//                             Toast.message("Action Not Authorised");
//                             return;
//                           }
//                             final queryDel = QueryObject(
//                 querysql: '/sp/ApiEnrlCmpySubsDel/queryasync',
//                 params: {
//                   "CustEttyId": custEttyId,
//                   "CmpyEttyId": null,
//                   "QuotaId": val.value.cells["QuotaId"]!.value.toString()
//                 },
//                 showMsg: false);
//                             final resultDel =
//                 ref.read(ReturndatafreezedProvider(queryDel).future);
//                             resultDel.then((value) {
//               ref.invalidate(ReturndatafreezedProvider(query));
//               Toast.showresult(value);
//                             });
//                             },
//                 onSelectedTap: (TrinaRow val) {
//                   singleton<AppRouter>().navigatePath(
//                       '/custenroll/cust/$custEttyId/Subsidy2/quotadtl/${val.cells["QuoId"]!.value}');
//                   //singleton<AppRouter>().navigatePath('/Subsidy2/detail/${val["SubId"].value}/prg');
//                 },
//               ),
//             ),
//           );
//         });
//   }
// }
