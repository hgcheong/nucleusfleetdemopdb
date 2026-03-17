import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=281;

@RoutePage()
class CustEnrollCustScreen extends BaseScreen {
  const CustEnrollCustScreen(
      {super.key, @PathParam('custEttyId') this.custEttyId})
      : super(
          includeMainDrawer: true,
        );
  final String? custEttyId;
  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView2(false);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return buildView(true, context);
  }

  @override
  Widget sideBar() {
    return provideSideBar("custenroll/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("custenroll/main");
  }

  @override
  Widget sideTab() {
    return provideSideTab("custenroll", id: custEttyId.toString());
  }
}

Widget buildView2(bool isMobile) {
  return Scaffold(
    body: AcxTabView(
      routes: [
        CustEnrollQuickInfoLanding(),
        CustEnrollProfileLanding(),
        const CustEnrollProgramLanding(),
            CustEnrollSubsidyLanding(),
        CustEnrollDocLanding()
      ],
      tabs: [
        Tab(
          text: S.current.tabQuickInfo,
        ),
        Tab(
          text: S.current.tabProfile,
        ),
        Tab(
          text: S.current.tabProgramSetting,
        ),
                      Tab(text: S.current.tabSubsidyQuota),
        Tab(
          text: S.current.tabDocuments,
        ),
      ],
    ),
  );
}

Widget buildView(bool isMobile, BuildContext context) {
  return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1280,
          child: AcxTabView(
            routes: [
              CustEnrollQuickInfoLanding(),
              CustEnrollProfileLanding(),
              const CustEnrollProgramLanding(),
              CustEnrollSubsidyLanding(),
              CustEnrollDocLanding()
            ],
            tabs: [
              Tab(
                text: S.current.tabQuickInfo,
              ),
              Tab(
                text: S.current.tabProfile,
              ),
              Tab(
                text: S.current.tabProgramSetting,
              ),
              Tab(text: S.current.tabSubsidyQuota),
              Tab(
                text: S.current.tabDocuments,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false, centerTitle: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // singleton<AppRouter>().navigatePath('/prgmgmt/main');
        //     singleton<AppRouter>().navigateBack();
        //   },
        // ),
        //  title: const TheTitle()),
      ));
  // return AcxTabView(
  //   // headerBarWidget: const [Placeholder()],
  //   routes:  [
  //     CustEnrollQuickInfoLanding(),
  //     CustEnrollProfileLanding(),
  //   ],
  //   tabs: [
  //     Tab(
  //       text: S.current.tabQuickInfo,
  //     ),
  //     Tab(
  //       text: S.current.tabProfile,
  //     ),
  //   ],
  // );
}

// class BuildMainTab extends HookWidget {
//   const BuildMainTab({
//     super.key,
//     required this.isMobile,
//   });

//   final bool isMobile;

//   @override
//   Widget build(BuildContext context) {
//     final tabcM = useTabController(initialLength: 8);
//     return Row(
//       children: [
//         Expanded(
//             flex: 6,
//             child: Container(
//               color: secondaryColor,
//               child: Column(
//                 children: [
//                   Expanded(
//                       flex: 1,
//                       child: Container(
//                         color: Colors.blue,
//                         child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Expanded(child: SelectableText(S.of(context).lblProgram)),
//                               const Expanded(flex: 6, child: Placeholder()),
//                             ]),
//                       )),
//                   Expanded(
//                       flex: 1,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Expanded(
//                             flex: 12,
//                             child: Align(
//                               alignment: Alignment.centerRight,
//                               child: TabBar(
//                                 isScrollable: true,
//                                 controller: tabcM,
//                                 tabs: [
//                                   Tab(text: S.of(context).tabProgramSetting),
//                                   Tab(text: S.of(context).tabOnlineAccess),
//                                   Tab(text: S.of(context).tabProgramSetting),
//                                   Tab(text: S.of(context).tabOnlineAccess),
//                                   Tab(text: S.of(context).tabProgramSetting),
//                                   Tab(text: S.of(context).tabOnlineAccess),
//                                   Tab(text: S.of(context).tabProgramSetting),
//                                   Tab(text: S.of(context).tabOnlineAccess),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Container(
//                               color: bgColor,
//                               child: IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(Icons.save),
//                                 padding:
//                                     const EdgeInsets.only(left: 2, right: 20),
//                                 constraints: const BoxConstraints(),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )),
//                   const Expanded(flex: 10, child: AutoRouter())
//                 ],
//               ),
//             ))
//       ],
//     );
//   }
// }

// Widget buildOnlineAccess() {
//   return const Center(
//     child: SelectableText('Build Online Access'),
//   );
// }

// Widget buildSubTabGeneralInfo(bool isMobile, BuildContext context) {
//   final tabCM = useTabController(initialLength: 3);
//   return Column(
//     children: [
//       Expanded(
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: TabBar(
//             isScrollable: true,
//             controller: tabCM,
//             tabs: const [
//               Tab(icon: Icon(Icons.abc)),
//               Tab(icon: Icon(Icons.directions_transit)),
//               Tab(icon: Icon(Icons.directions_car)),
//             ],
//           ),
//         ),
//       ),
//       Expanded(
//         flex: 10,
//         child: SingleChildScrollView(
//           child: SizedBox(
//             height: 1280,
//             child: TabBarView(controller: tabCM, children: [
//               columnInfo(isMobile),
//               columnInfo(isMobile),
//               columnInfo(isMobile)
//             ]),
//           ),
//         ),
//       ),
//     ],
//   );
// }

// Widget columnInfo(bool isMobile) {
//   if (isMobile) {
//     return const Form(
//       child: Row(
//         children: [
//           Expanded(
//             child: Card(
//               child: Placeholder(),
//             ),
//           ),
//           Expanded(
//             child: Card(
//               child: Placeholder(),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//   return Form(
//     child: Column(
//       children: [
//         const Expanded(
//           child: Card(
//             child: TheSubMitForm(),
//           ),
//         ),
//         Expanded(
//           child: Card(child: RegisterForm()),
//         )
//       ],
//     ),
//   );
// }

// class TheSubMitForm extends HookConsumerWidget {
//   const TheSubMitForm({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Form(
//       child: Column(
//         children: [
//           const TextField(),
//           const TextField(),
//           ElevatedButton(
//               onPressed: () async {
//                 //  final data = await CategoryService().listDynamic();
//               },
//               child: const SelectableText('ShowMe')),
//         ],
//       ),
//     );
//   }
// }
