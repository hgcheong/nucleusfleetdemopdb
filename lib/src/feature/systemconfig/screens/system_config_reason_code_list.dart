import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=242;

@RoutePage()
class SystemConfigReasonCodeList extends BaseScreen {
  const SystemConfigReasonCodeList({super.key});

    @override
  Widget body(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    // return const Center(
    //   child: SizedBox(
    //     width: 360,
    //     child: CircularProgressIndicator(),
    //   ),
    // );

    return const Center(
      child: Text("Reason Code List"),
    );
  }
}
