import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/generated/l10n.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridwith_clm.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/feature/auth/components/register_form.dart';

import 'package:trina_grid/trina_grid.dart';

const int wid=133;
@RoutePage()
class PrgMgmtListScreen extends BaseScreen {
  const PrgMgmtListScreen({super.key})
      : super(
          includeMainDrawer: true,
        );

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    return buildView();
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return buildView();
  }

  @override
  Widget sideTab() {
    return provideSideTab("prgmgmt/main");
  }

  @override
  Widget sideBar() {
    return provideSideBar("prgmgmt/setup");
  }

  @override
  PreferredSizeWidget breadCrumb() {
    return provideBreadCrumb("prgmgmt/main");
  }
}

Widget buildView() {
   

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }

    return Scaffold(
      body: const SingleChildScrollView(
        child: SizedBox(
          height: 1024,
          child: Column(
            children: [
              Expanded(
                child: ListPluto(),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const SelectableText('Programs'),
        automaticallyImplyLeading: false, centerTitle: false,
      ),
    );
  
  // if (isAllowTabAccess(defaultTabAccess, wid)) {
  //   return Scaffold(
  //     body: const SingleChildScrollView(
  //       child: SizedBox(
  //         height: 1024,
  //         child: Column(
  //           children: [
  //             Expanded(
  //               child: ListPluto(),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //     appBar: AppBar(
  //       title: const SelectableText('Programs'),
  //       automaticallyImplyLeading: false, centerTitle: false,
  //     ),
  //   );
  // } else {
  //   return const NotAuthorised();
  // }
}

class ListPluto extends ConsumerWidget {
  const ListPluto({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AcxTrinaGridWithColumn(
      useNav: false,
      querysql: '/sp/ApiPrgList/queryasync',
      params: const {},
      idField: 'PrgEttyId',
      navPrefix: '/prgmgmt/setup',
      spName: 'ApiPrgList',
      onNew: () {
          if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                          Toast.message("Action Not Authorised");
                          return;
                        }
        singleton<AppRouter>().navigatePath("/prgmgmt/setup/new");
      },
      onSelectedTap: (TrinaRow val) {
        ref.read(menuSideTabSelectProvider.notifier).state =
            S.current.sbProgramGeneralSettings;
        ref.read(appBarTitleProvider.notifier).state =
            val.cells['PrgDscp']!.value.toString();
        singleton<AppRouter>().navigatePath(
            "/prgmgmt/setup/${val.cells['PrgEttyId']!.value}/pgeninfo");
      },
    );
  }
}

class BuildViewInfo extends HookWidget {
  const BuildViewInfo({
    super.key,
    required TabController tabC1,
    required this.isMobile,
  }) : _tabC1 = tabC1;

  final TabController _tabC1;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const SizedBox(
        //   width: 50,
        //   height: double.infinity,
        //   child: SideTab(),
        // ),
        Expanded(
            flex: 6,
            child: Container(
              color: secondaryColor,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.blue,
                    child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: Placeholder()),
                          Expanded(child: Placeholder()),
                          Expanded(child: Placeholder()),
                        ]),
                  )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 12,
                        child: Align(
                          //  alignment: Alignment.centerRight,
                          child: TabBar(
                            dividerColor: Colors.transparent,
                            isScrollable: true,
                            controller: _tabC1,
                            tabs: const [
                              Tab(icon: Icon(Icons.abc)),
                              Tab(icon: Icon(Icons.directions_transit)),
                              Tab(icon: Icon(Icons.directions_car)),
                              Tab(icon: Icon(Icons.abc)),
                              Tab(icon: Icon(Icons.directions_transit)),
                              Tab(icon: Icon(Icons.directions_car)),
                              Tab(icon: Icon(Icons.abc)),
                              Tab(icon: Icon(Icons.directions_transit)),
                              Tab(icon: Icon(Icons.directions_car)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: bgColor,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.save),
                            padding: const EdgeInsets.only(left: 2, right: 20),
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                    flex: 12,
                    child: SizedBox(
                      height: 1280,
                      child: TabBarView(
                        controller: _tabC1,
                        children: [
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                          mainInfo(isMobile, context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}

Widget mainInfo(bool isMobile, BuildContext context) {
  final tabCM = useTabController(initialLength: 3);
  return Column(
    children: [
      Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            dividerColor: Colors.transparent,
            isScrollable: true,
            controller: tabCM,
            tabs: const [
              Tab(icon: Icon(Icons.abc)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 10,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 1280,
            child: TabBarView(controller: tabCM, children: [
              columnInfo(isMobile),
              columnInfo(isMobile),
              columnInfo(isMobile)
            ]),
          ),
        ),
      ),
    ],
  );
}

Widget columnInfo(bool isMobile) {
  if (isMobile) {
    return const Form(
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Placeholder(),
            ),
          ),
          Expanded(
            child: Card(
              child: Placeholder(),
            ),
          )
        ],
      ),
    );
  }
  return Form(
    child: Column(
      children: [
        const Expanded(
          child: Card(
            child: TheSubMitForm(),
          ),
        ),
        Expanded(
          child: Card(child: RegisterForm()),
        )
      ],
    ),
  );
}

class TheSubMitForm extends HookConsumerWidget {
  const TheSubMitForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      child: Column(
        children: [
          const TextField(),
          const TextField(),
          ElevatedButton(
              onPressed: () async {
                //  final data = await CategoryService().listDynamic();
              },
              child: const SelectableText('ShowMe')),
        ],
      ),
    );
  }
}
