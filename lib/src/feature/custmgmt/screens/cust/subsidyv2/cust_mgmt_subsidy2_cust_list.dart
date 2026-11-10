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
class CustmgmtSubsidy2CustList extends BaseScreen {
  const CustmgmtSubsidy2CustList({
    super.key,
     @PathParam('cbId') this.cbId,
     @PathParam('prgEttyId') this.prgEttyId,
     @PathParam('chargeType') this.chargeType
  });
  final String? cbId;
  final String? prgEttyId;
  final String? chargeType;
@override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
  
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(context, ref, chargeType, prgEttyId, cbId);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(context, ref, chargeType, prgEttyId, cbId);
  }

  @override
  Widget sideBar() {
    return provideSideBar("custmgmt/setup");
  }



  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custmgmt/main");
  }
}
//'cbplist/:chargeType/:prgEttyId/:cbId',
Widget buildView(BuildContext context, WidgetRef ref, String? chargeType, String? prgEttyId, String? cbId) {
      final listQuery = returndataProvider(querysql: '/sp/ApimgmtCbpList/queryasync',

        params:  {
    "CbPrgType":convStrNewOrNullToNull(chargeType),
     "CbId":convStrNewOrNullToNull(cbId),
     "PrgEttyId": convStrNewOrNullToNull(prgEttyId),
        },
        showMsg: false);
  return Scaffold(
 appBar: AppBar(
  
      title: SelectableText(S.of(context).lblSubsidySetup),
      automaticallyImplyLeading: false, centerTitle: false,
    ),
    body: AcxTrinaGridv2(
      gridTitle: 'Customer Subsidy',
    idField: 'CbId', query: listQuery,
         onRefresh: () {
          ref.invalidate(listQuery);
        },
      onNew: (){
          if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                    Toast.message("Action Not Authorised");
                                    return;
                                  }
            singleton<AppRouter>().navigatePath('/custmgmt/subsidy2/cbp/$chargeType/$prgEttyId/$cbId/cbpdtl/new/new/new');
      },
      onSelected: (val) {

        //cbpdtl/:prgEttyId/:cbId/:cbPrgEttyId/:ettyId/cbQuoId
        ///:prgEttyId/:cbId/:cbPrgEttyId/:ettyId/cbQuoId',
                 singleton<AppRouter>().navigatePath(
               '/custmgmt/subsidy2/cbp/$chargeType/$prgEttyId/$cbId/cbpdtl/${val.cells["CbPrgEttyId"]!.value.toString()}/${val.cells["EttyId"]!.value.toString()}/${val.cells["CbQuoId"]!.value.toString()}');
        // getTitle(
        //         ref,
        //         {
        //           "CustEttyId": val.cells["CustEttyId"]!.value.toString(),
        //         },
        //         AppBarTitleType.mgmt)
        //     .then((value) {
        //   singleton<AppRouter>().navigatePath(
        //       '/custmgmt/cust/${val.cells["CustEttyId"]!.value.toString()}');
        //   ref.read(menuSideTabSelectProvider.notifier).state = "Customer";
        //   ref.read(appBarTitleProvider.notifier).state = value.toString();
        // });
    
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
//                           '/custmgmt/cust/$custEttyId/Subsidy2/quotadtl/new');
//                 },
//                          onDelete: (ValueNotifier<TrinaRow> val) {
                
                  
//               if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
//                             Toast.message("Action Not Authorised");
//                             return;
//                           }
//                             final queryDel = QueryObject(
//                 querysql: '/sp/ApimgmtCmpySubsDel/queryasync',
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
//                       '/custmgmt/cust/$custEttyId/Subsidy2/quotadtl/${val.cells["QuoId"]!.value}');
//                   //singleton<AppRouter>().navigatePath('/Subsidy2/detail/${val["SubId"].value}/prg');
//                 },
//               ),
//             ),
//           );
//         });
//   }
// }
