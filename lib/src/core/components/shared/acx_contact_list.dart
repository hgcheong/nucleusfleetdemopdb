import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap_manual.dart';
import 'package:nucleusv2/src/core/core_imports.dart';



class AcxContactList extends StatelessWidget {
  const AcxContactList({
    super.key,
    required this.query,
    required this.returnSelectedRef,
    required this.deleteSelectedRef,
  });

  final QueryObject query;
  final Function returnSelectedRef;
  final Function deleteSelectedRef;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child: AcxListButtonNavWrapManual(
                keyField: 'ContactType',
                // querysql: '/sp/ApiEnrlAddrList/queryasync',
                query: query,
                displayfield: const [
                  'ContactTypeDscp',
                  'FullName',
                  'DsgntionDscp',
                  'ContactStsDscp'
                ],
                // deleteSelectedRef: (val) async {
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
                returnSelectedRef: returnSelectedRef))
      ],
    );
  }
}
