// import 'package:auto_route/auto_route.dart';

// @AutoRouterConfig()
// class AppRouter extends RootStackRouter{

//   @override
//   late final List<AutoRouteGuard> guards = [
//     AutoRouteGuard.simple((resolver, router) {

//       print(router.currentUrl);
//       print(resolver.routeName);
//         // if(isAuthenticated || resolver.routeName == LoginRoute.name) {
//         //   // we continue navigation
//         //   resolver.next();
//         // } else {
//         //   // else we navigate to the Login page so we get authenticated

//         //   // tip: use resolver.redirect to have the redirected route
//         //   // automatically removed from the stack when the resolver is completed
//         //   resolver.redirect(LoginRoute(onResult: (didLogin) => resolver.next(didLogin)));
//         // }
//       },
//     ),
//     // add more guards here
//   ];

// // ..routes[]
// }
