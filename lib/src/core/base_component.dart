import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/config/constants/breakpoints.dart';

abstract class BaseComponent extends HookConsumerWidget {
  const BaseComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BreakPoints.useMobileLayout(context)
        ? body(context, ref)
        : desktopBody(context, ref);
  }

  Widget body(BuildContext context, WidgetRef ref) {
    return Container();
  }

  Widget desktopBody(BuildContext context, WidgetRef ref) {
    // defaults to using standard body if not overridden
    return body(context, ref);
  }
}
