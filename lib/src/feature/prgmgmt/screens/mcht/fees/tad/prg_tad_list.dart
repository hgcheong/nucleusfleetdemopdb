import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap.dart';

const int wid=132;

@RoutePage()
class PrgMgmtMchtFeesTadList extends ConsumerWidget {
  const PrgMgmtMchtFeesTadList(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});
  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final toNavdetail = '/prgmgmt/mchtsetup/$prgEttyId/feesl/pmfeetad';

    // if (isAllowTabAccess(defaultTabAccess, wid)) {
       if (1==1) {
      return SingleChildScrollView(
        child: Column(
          children: [
            AcxListButtonNavWrap(
                querysql: '/sp/ApiPrgMchtTadFeeList/queryasync',
                params: {
                  "PrgEttyId": prgEttyId,
                },
                addNew: () {
                  singleton<AppRouter>().navigatePath('$toNavdetail/new');
                },
                returnSelectedRef: (va) {
                  singleton<AppRouter>()
                      .navigatePath('$toNavdetail/${va['FeeId']}');
                },
                displayfield: const [
                  'TadTypeDscp',
                  'TadVendorDscp',
                  'TadFeeDscp'
                ],
                keyField: 'FeeId'),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text('Not Authorised'),
      );
    }
  }
}

// child: SizedBox(
//     height: 1280,
//     child: Column(
//       children: [
//         thePaht.endsWith('pmfeetadlist') || thePaht.endsWith('feesl')
//             ?  Container() : Expanded(child: AutoRouter(
//                 placeholder: (context) {
//                   return Container(
//                     color: Colors.blue,
//                   );
//                 },
//               ))
//            ,
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: AcxListButtonNav(
//                 querysql: '/sp/ApiPrgMchtTadFeeList/queryasync',
//                 params: {
//                   "PrgEttyId": prgEttyId,
//                 },
//                 addNew: () {
//                   Toast.message('Add New');
//                   singleton<AppRouter>().navigatePath('pmfeetad');
//                 },
//                 returnSelectedRef: (va) {
//                   Toast.message('Editing' + va.toString());
//                 },
//                 // deleteSelectedRef: (val) {
//                 //   Toast.message('Deleting ' + val.toString());
//                 // },
//                 displayfield: const [
//                   'TadTypeDscp',
//                   'TadVendorDscp',
//                   'TadFeeDscp'
//                 ],
//                 keyField: 'FeeId'),
//           ),
//         ),
//       ],
//     ),
//   ),
