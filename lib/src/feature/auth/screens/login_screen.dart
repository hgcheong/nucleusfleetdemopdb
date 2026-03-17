import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/base_screen.dart';

const int wid=211;

@RoutePage()
class LoginScreen extends BaseScreen {
  const LoginScreen({super.key});

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: Container(),
      automaticallyImplyLeading: false, centerTitle: false,
      title: const SelectableText("Login"),
    );
  }

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
      child: CircularProgressIndicator(),
    );
  }
}
