import 'package:flutter/material.dart';
import 'package:nucleusv2/src/utils/appbartitle.dart';

class DrawerItem {
  DrawerItem({
    required this.title,
    required this.wid,
    this.wPid,
    this.level,
    this.svgSrc,
    this.theIcon,
    this.tooltipMessage,
    this.titleType,
    this.titleParam,
    required this.route,
  });
  final String title;
  final int wid;
  final int? wPid;
  final int? level;
  final String? svgSrc;
  final String? tooltipMessage;
  final String? route;
  final IconData? theIcon;
  final AppBarTitleType? titleType;
  final Map<String, dynamic>? titleParam;
}
