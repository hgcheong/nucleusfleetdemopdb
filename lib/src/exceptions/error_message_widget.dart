import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.errorMessage, {super.key});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return SelectableText(
      errorMessage,
      style:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: DbColors.danger),
      //     overflow: TextOverflow.ellipsis,
    );
  }
}
