import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/app_theme.dart';

class BottomModalContainer extends StatelessWidget {
  final List<Widget> children;
  final String? title;
  final bool withDismiss;
  final Function()? handleMenuPressed;
  final Function()? onClose;
  const BottomModalContainer(
      {super.key,
      required this.children,
      this.title,
      this.withDismiss = true,
      this.handleMenuPressed,
      this.onClose});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.playerBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6.0),
          topRight: Radius.circular(6.0),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (onClose != null) {
                          onClose!();
                        }
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_drop_down),
                    ),
                    Flexible(
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        //     style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: handleMenuPressed,
                    ),
                  ],
                ),
              ...children
            ],
          ),
        ),
      ),
    );
  }
}
