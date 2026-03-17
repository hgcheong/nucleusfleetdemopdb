import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/base_screen.dart';

const int wid=880;

@RoutePage()
class CClickCmsLanding extends BaseScreen {
  const CClickCmsLanding({
    super.key,
  });

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {
    
   return  body(context, ref);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }

      return const AcxTabView(
      routes: [CClickCmsUpload(),  CClickCmsUploadCarousel()],
      tabs:[Tab(text: "Image"), Tab(text:"Carousel")],
    );
   
  }
}
