import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=177;

@RoutePage()
class MediarenewalLanding extends BaseScreen {
  const MediarenewalLanding({
    super.key,
  });

  // @override
  // Widget sideTab() {
  //   return const DataEntrySideTab();
  // }

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Card Reissue/Replacement/Renewal'), centerTitle: false,),
      body: AcxTabView(
        routes: [
          MediaReissueRplcList(),
          MediaRenewalList(), 
          MediaRenewalSearch()],
        tabs: [
              Tab(
            text: S.current.tabMediaReissue,
          ),
          Tab(
            text: S.current.tabMediaRenewal,
          ),
          Tab(
            text: S.current.tabMediaRenewSearch,
          ),
        ],
      ),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Card Reissue/Replacement/Renewal'), centerTitle: false,),
      body: AcxTabView(
        routes: [
          MediaReissueRplcList(),
          MediaRenewalList(), 
          MediaRenewalSearch()],
        tabs: [
              Tab(
            text: S.current.tabMediaReissue,
          ),
          Tab(
            text: S.current.tabMediaRenewal,
          ),
          Tab(
            text: S.current.tabMediaRenewSearch,
          ),
        ],
      ),
    );
  }
}
