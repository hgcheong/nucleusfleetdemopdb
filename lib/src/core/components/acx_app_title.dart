import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';

class AcxAppTitle extends StatelessWidget {
  const AcxAppTitle({super.key, this.pageTitle});

  final String? pageTitle;
  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: true,
      pageTitle.toString(),
      maxLines: 2,
      style: TextStyle(
          fontFamily: defaultFontFamily,
          fontSize: defaultFontSize,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary),
    );
  }
}
