import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/utils/acx_authaccess.dart';
import 'package:nucleusv2/src/utils/acx_notauthorised.dart';
import 'package:nucleusv2/src/utils/uihelpers.dart';


const int wid=185;

@RoutePage()
class ReimbuseManualTxnLanding extends BaseScreen {
  const ReimbuseManualTxnLanding({
    super.key,
  });
  
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(false, context);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(true, context);
  }
  

Widget buildView(bool isMobile, BuildContext context) {

   return SingleChildScrollView(
    child: SizedBox(
        height: 1280, child: const AutoRouter()),
  );  
  }

}


    // return Scaffold(
    //     appBar: AppBar(title: const SelectableText("Reimbursement Files"), centerTitle: false,),
    //     body: Column(
    //       children: [
    //         Expanded(
    //           flex: 12,
    //           child: AcxTabView(
    //               align: Alignment.centerLeft,
    //               routes: [ReimbursementFileOut()],
    //               tabs: const [(Tab(text: "Outbound"))]),
    //         ),
    //       ],
    //     ));