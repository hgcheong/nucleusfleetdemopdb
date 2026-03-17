import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/base_screen.dart';

@RoutePage()
class RouteListCollection extends BaseScreen {
  const RouteListCollection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text("Not Authorised"),);
    // final theroutes = singleton<AppRouter>().routes;

    // var toAdd = "";
    // for (var rr in theroutes) {
    //   var list2 = rr.children;
    //   if (list2 != null) {
    //     for (var rr2 in list2.routes) {
    //       var list3 = rr2.children;
    //       if (list3 != null) {
    //         for (var rr3 in list3.routes) {
    //           var list4 = rr3.children;
    //           if (list4 != null) {
    //             for (var rr4 in list4.routes) {
    //               var list5 = rr4.children;
    //               if (list5 != null) {
    //                 for (var rr5 in list5.routes) {
                    
    //                   toAdd += "5|${rr5.name},";
                  
    //                 }
    //               }
    //               toAdd += "4|${rr4.name},";
    //             }
    //           }
    //           toAdd += "3|${rr3.name},";
    //         }
    //       }

    //       toAdd +="2|${rr2.name},";
    //     }
    //   }

    //   toAdd += "1|${rr.name},";
    // }

    // // for (var rr in theroutes) {
    // //   var list2 = rr.children;
    // //   if (list2 != null) {
    // //     for (var rr2 in list2.routes) {
    // //       var list3 = rr2.children;
    // //       if (list3 != null) {
    // //         for (var rr3 in list3.routes) {
    // //           var list4 = rr3.children;
    // //           if (list4 != null) {
    // //             for (var rr4 in list4.routes) {
    // //               var list5 = rr4.children;
    // //               if (list5 != null) {
    // //                 for (var rr5 in list5.routes) {
    // //                   toAdd += '${rr5.path},${rr5.name}';
    // //                 }
    // //               }
    // //               toAdd += '${rr4.path},${rr4.name}';
    // //             }
    // //           }
    // //           toAdd += '${rr3.path},${rr3.name}';
    // //         }
    // //       }

    // //       toAdd += '${rr2.path},${rr2.name}';
    // //     }
    // //   }

    //   toAdd += '${rr.path},${rr.name}';
    // }
    // return Scaffold(
    //   body: ListView(
    //     children: [SelectableText(toAdd)],
    //   ),
    // );
  }
}
