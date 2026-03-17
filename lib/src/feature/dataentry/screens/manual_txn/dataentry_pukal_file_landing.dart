import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const mModuleName = 'pukal';

const int wid=351;

@RoutePage()
class DataEntryPukalFileLanding extends HookConsumerWidget {
  const DataEntryPukalFileLanding(
      {super.key, @PathParam('txnType') this.txnType});
  final String? txnType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Scaffold(
        appBar: AppBar(title: const SelectableText("Pukal Files"),centerTitle: false, ),
        body: Column(
          children: [
            Expanded(
              flex: 12,
              child: AcxTabView(align: Alignment.centerLeft, routes: [
                DataEntryPukalFileIn(),
                DataEntryPukalFileOut()
              ], tabs: const [
                (Tab(text: "Inbound")),
                (Tab(text: "Outbound"))
              ]),
            ),
          ],
        ));
  }
}
