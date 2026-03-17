import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/session_provider.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_screen.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/components/centered_loader.dart';
import 'package:nucleusv2/src/feature/brand/components/brand_logo.dart';

// this does not actually need to be a stateful widget but including it this way for reference.
const int wid=209;

@RoutePage()
class AuthLandingScreen extends BaseStatefulScreen {
  const AuthLandingScreen({super.key});

  @override
  AuthLandingScreenState createState() => AuthLandingScreenState();
}

class AuthLandingScreenState extends BaseScreenState<AuthLandingScreen> {
  bool _loading = true;

  @override
  AppBar? appBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const SelectableText("Welcome"),
    );
  }

  void _handleSession(SessionModel session) {
    if (session.ready) {
      setState(() {
        _loading = false;
      });
    }

    if (session.isAuthenticated) {
      if (singleton<AppRouter>().current.path == '/') {
        singleton<AppRouter>().push(const DashboardContainer());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _handleSession(ref.read(sessionStateNotifierProvider));
  }

  @override
  Widget body(BuildContext context) {
    ref.listen<SessionModel>(sessionStateNotifierProvider, (prev, next) {
      _handleSession(next);
    });

    if (_loading) {
      return const CenteredLoader();
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BrandLogo(
              // maxWidth: 300,
              ),
              sbh20,
               const Text('Thank you for using Nucleus'),
          const SizedBox(
            height: 80,
          ),
      
          AppButton(
            onPressed: () {
              singleton<AppRouter>().replace(const LoginRoute());
            },
           processing:false,
            label: "Login",
          ),


        ],
      ),
    );
  }
}
