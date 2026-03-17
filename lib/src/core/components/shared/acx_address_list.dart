import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap_manual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

import 'acx_address_controller.dart';

class AcxAddressList extends ConsumerWidget {
  const AcxAddressList({
    super.key,
    required this.query,
    required this.returnSelectedRef,
    required this.deleteSelectedRef,
  });

  final QueryObject query;
  final Function  returnSelectedRef;
  final Function deleteSelectedRef;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child: AcxListButtonNavWrapManual(
                keyField: 'AddrType',
                // querysql: '/sp/ApiEnrlAddrList/queryasync',
                query: query,
                displayfield: const [
                  'AddrTypeDscp',
                  'Street1',
                  'Street2',
                  'Street3',
                  'PostCode'
                ],
                // deleteSelectedRef: (val) async {
                //       if (val['AddrId'] == null) {
                //     Toast.message('Done');
                //     return;
                //        }
                //   bool confirmed = await ConfirmDialog.show(
                //     title: "Delete?",
                //     body: "Are you sure you want to Delete?",
                //     destructive: true,
                //     confirmText: "Yes",
                //     cancelText: "Cancel",
                //   );

                //   if (!confirmed) {
                //     return;
                //   }
                //   deleteSelectedRef(val);
                // },
                returnSelectedRef: (val) {
                     ref.read(myStateCityProvider.notifier).state = "";
                
                  return returnSelectedRef(val);
                  // if (val['ContactId'] == null) {
                  //   Toast.message('You need to create a contact first');
                  // } else {
                  //   return returnSelectedRef(val);
                  // }
                }))
      ],
    );
  }
}
