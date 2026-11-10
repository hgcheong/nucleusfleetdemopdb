import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';

class AcxAppBarTitle extends ConsumerWidget {
  const AcxAppBarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theTitle = ref.watch(appBarTitleProvider);
    return Text(
      theTitle.toString(),
      //   maxLines: 2,
      style: TextStyle(
          fontSize: defaultFontSize,
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary),
    );
  }
}
