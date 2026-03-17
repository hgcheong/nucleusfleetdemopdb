import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/placeholder/placeholder_list.dart';
import 'package:nucleusv2/src/feature/placeholder/placeholder_provider.dart';
import 'package:nucleusv2/src/core/base_screen.dart';

const int wid=181;

@RoutePage()
class PlaceholderScreen extends BaseScreen {
  const PlaceholderScreen({super.key})
      : super(
          verticalPadding: 8.0,
          horizontalPadding: 8.0,
        );

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      centerTitle: false,
      title: const SelectableText("Placeholders"),
    );
  }

  @override
  FloatingActionButton? floatingActionButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    return FloatingActionButton(
      onPressed: ref.read(placeholderProvider.notifier).addItem,
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
     

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return const PlaceholderList();
  }
}
