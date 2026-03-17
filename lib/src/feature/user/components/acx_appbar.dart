import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AcxAppBar extends ConsumerWidget {
  final String title;
  const AcxAppBar({
    super.key,
    required this.title,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppBar? toReturn;
    toReturn = AppBar(
      centerTitle: false,
      backgroundColor: Colors.red,
      foregroundColor: Colors.blue,
      shadowColor: Colors.yellow,
      leading: IconButton(
        icon: const Icon(Icons.shopping_cart),
        tooltip: 'Open shopping cart',
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: SelectableText(title),
    );
    return toReturn;
  }
}
