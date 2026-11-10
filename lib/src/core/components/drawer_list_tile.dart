import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';

import '../menu_controller.dart';

class DrawerListTile extends ConsumerWidget {
  const DrawerListTile(
      {super.key,
      // For selecting those three line once press "Command+D"
      required this.title,
      required this.wid,
      this.wPid,
      this.level,
      this.svgSrc,
      required this.press,
      this.theIcon,
      this.thecolor = DbColors.slate500});
  final String? title, svgSrc;
  final int wid;
  final int? wPid;
  final int? level;
  final VoidCallback press;
  final Color thecolor;
  final IconData? theIcon;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      waitDuration: const Duration(seconds: 1),
      message: title,
      child: ListTile(
        onTap: () {
          ref.read(appBarTitleProvider.notifier).state = "";
          press();
        },
        horizontalTitleGap: 0.0,
        // leading: theIcon == null? SvgPicture.asset(
        //   svgSrc!,
        //   colorFilter: ColorFilter.mode(thecolor, BlendMode.srcIn),
        //   height: 16,
        // ) : Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Icon(theIcon,color: thecolor),
        // ),
        title: Text(
          title.toString(),
          style: const TextStyle(
              //  color: thecolor,
              fontSize: defaultFontSize,
              fontFamily: defaultFontFamily),
        ),
      ),
    );

    // if (BreakPoints.useTabletLayout(context)) {

    //   return Tooltip(
    //     waitDuration: const Duration(seconds: 2),
    //     message: title,
    //     child: ListTile(
    //         onTap: (){
    //             ref.read(appBarTitleProvider.notifier).state = "";
    //           press();
    //         },
    //         horizontalTitleGap: 0.0,
    //         leading: theIcon == null? SvgPicture.asset(
    //         svgSrc!,
    //         colorFilter: ColorFilter.mode(thecolor, BlendMode.srcIn),
    //         height: 16,
    //       ) : Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Icon(theIcon),
    //       )
    //         ),
    //   );
    // } else {

    //   return Tooltip(
    //     waitDuration: const Duration(seconds: 2),
    //     message: title,
    //     child: ListTile(
    //       onTap: (){
    //  ref.read(appBarTitleProvider.notifier).state = "";
    //         press();
    //       },
    //       horizontalTitleGap: 0.0,
    //       leading: theIcon == null? SvgPicture.asset(
    //         svgSrc!,
    //         colorFilter: ColorFilter.mode(thecolor, BlendMode.srcIn),
    //         height: 16,
    //       ) : Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Icon(theIcon),
    //       ),
    //       title: Text(
    //         title.toString(),
    //         style: TextStyle(color: thecolor),
    //       ),
    //     ),
    //   );
    // }
  }
}

// class DrawerListTileSideTab extends StatelessWidget {
//   const DrawerListTileSideTab(
//       {Key? key,
//       // For selecting those three line once press "Command+D"
//       required this.title,
//       required this.svgSrc,
//       required this.press,
//       this.thecolor = Colors.white54,
//       this.hightlightColor = bgColor,
//       this.tooltipMessage})
//      ;

//   final String title, svgSrc;
//   final VoidCallback press;
//   final Color thecolor;
//   final Color hightlightColor;
//   final String? tooltipMessage;
//   @override
//   Widget build(BuildContext context) {
//     if (tooltipMessage != null) {
//       return Tooltip(
//         message: tooltipMessage,
//         child: Container(
//           width: 50,
//           color: hightlightColor,
//           child: ListTile(
//             onTap: press,
//             horizontalTitleGap: 0.0,
//             leading: SvgPicture.asset(
//               svgSrc,
//            colorFilter: ColorFilter.mode(thecolor, BlendMode.srcIn),
//               height: 16,
//             ),
//             title: Text(
//               title,
//               style: TextStyle(color: thecolor),
//             ),
//           ),
//         ),
//       );
//     } else {
//       return Container(
//         width: 50,
//         color: hightlightColor,
//         child: Tooltip(
//           message: title,
//           child: ListTile(
//             onTap: press,
//             horizontalTitleGap: 0.0,
//             leading: SvgPicture.asset(
//               svgSrc,
//               colorFilter: ColorFilter.mode(thecolor, BlendMode.srcIn),
//               height: 16,
//             ),
//             title: Text(
//               title,
//               style: TextStyle(color: thecolor),
//             ),
//           ),
//         ),
//       );
//     }
//   }
// }

class DrawerListTileSideTab extends ConsumerWidget {
  const DrawerListTileSideTab(
      {super.key,
      // For selecting those three line once press "Command+D"
      required this.title,
      required this.wid,
      this.wPid,
      this.level,
      required this.svgSrc,
      required this.press,
      this.titleType,
      this.titleParam,
      this.theIcon,
      this.thecolor = DbColors.slate500,
      this.hightlightColor = bgColor,
      this.tooltipMessage});

  final String title;
  final String? svgSrc;
    final int wid;
  final int? wPid;
  final int? level;
  final VoidCallback press;
  final Color thecolor;
  final Color hightlightColor;
  final String? tooltipMessage;
  final IconData? theIcon;
  final AppBarTitleType? titleType;
  final Map<String, dynamic>? titleParam;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tooltipMessage != null) {
      return Tooltip(
        waitDuration: const Duration(seconds: 1),
        message: tooltipMessage,
        child: IconButton(
            iconSize: 16,
            onPressed: () async {
              if (titleParam != null) {
                await getTitle(ref, titleParam!, titleType!).then((value) {
                  ref.read(appBarTitleProvider.notifier).state =
                      value.toString();
                });
              }
              press();
            },
            icon: theIcon == null
                ? svgSrc == ''
                    ? Container()
                    : SvgPicture.asset(
                        svgSrc.toString(),
                        colorFilter:
                            ColorFilter.mode(thecolor, BlendMode.srcIn),
                        height: 16,
                      )
                : Icon(
                    theIcon,
                    color: thecolor,
                  )),
      );
    } else {
      return Tooltip(
        waitDuration: const Duration(seconds: 2),
        message: title,
        child: IconButton(
            iconSize: 16,
            onPressed: () async {
              if (titleParam != null) {
                await getTitle(ref, titleParam!, titleType!).then((value) {
                  ref.read(appBarTitleProvider.notifier).state =
                      value.toString();
                });
              }
              press();
            },
            icon: theIcon == null
                ? svgSrc == ''
                    ? Container()
                    : SvgPicture.asset(
                        svgSrc.toString(),
                        colorFilter:
                            ColorFilter.mode(thecolor, BlendMode.srcIn),
                        height: 16,
                      )
                : Icon(
                    theIcon,
                    color: thecolor,
                  )),
      );
    }
  }
}
