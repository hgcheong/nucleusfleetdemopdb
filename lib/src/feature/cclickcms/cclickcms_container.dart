import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/core/base_component.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

//Wid Taken out to replace for Side Bar. Not Required for container
@RoutePage()
class CClickCmsContainer extends BaseComponent {
  const CClickCmsContainer({super.key});

  @override
  Widget body(BuildContext context, WidgetRef ref) {

    return const AutoRouter();
  }

  @override
  Widget desktopBody(BuildContext context, WidgetRef ref) {

    return body(context, ref);
  }
}
