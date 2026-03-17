import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=721;

@RoutePage()
class MchtMgmtLocationPofileLanding extends StatelessWidget {
  const MchtMgmtLocationPofileLanding({
    super.key,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
  });

  final String? mchtEttyId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Scaffold(
      body: AcxTabView(
        routes: [
          MchtMgmtLocationProfileGenInfo(),
          MchtMgmtLocationProfileContactList(),
          MchtMgmtLocationProfileAddressList(),
          MchtMgmtLocationProfileDirectorList(),
        ],
        tabs: [
          Tab(
            text: S.current.lblGeneralInfo,
          ),

          Tab(
            text: S.current.tabContact,
          ),
          Tab(
            text: S.current.tabAddress,
          ),
                      Tab(
            text: S.current.tabDirector,
          ),
        ],
      ),
    );
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: SizedBox(
    //       height: 1280,
    //       child: AcxTabView(
    //         routes: [MchtMgmtLocationProfileGenInfo(), MchtMgmtLocationProfileAddressList(), MchtMgmtLocationProfileContactList()],
    //         tabs: [
    //           Tab(
    //             text: S.current.lblGeneralInfo,
    //           ),
    //           Tab(
    //             text: S.current.tabAddress,
    //           ),
    //           Tab(
    //             text: S.current.tabContact,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
