import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const mModuleName = 'reimbursement';

const int wid=183;

@RoutePage()
class ReimbursementFileLanding extends HookConsumerWidget {
  const ReimbursementFileLanding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return  AcxTabView(
                  align: Alignment.centerLeft,
                  routes: [ReimbursementFileOut(),
                  ReimbursementFileOutEmail()
                  ,ReimbursementSignatory()],
                  tabs: const [
                    (Tab(text: "Outbound")),
                    (Tab(text: "Email")),
                    (Tab(text: "Signatory"))
                  ]);
  
  }
}
