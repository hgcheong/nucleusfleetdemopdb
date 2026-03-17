class DrawerItem {
  final String title;
  final String? svgSrc;
  final String? tooltipMessage;
  final String? route;
  DrawerItem({
    required this.title,
    this.svgSrc,
    this.tooltipMessage,
    required this.route,
  });
}
