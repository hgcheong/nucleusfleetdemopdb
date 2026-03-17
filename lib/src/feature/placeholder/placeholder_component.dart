import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/base_component.dart';
import 'package:nucleusv2/src/feature/placeholder/placeholder_model.dart';
import 'package:nucleusv2/src/feature/placeholder/placeholder_provider.dart';

class PlaceholderComponent extends BaseComponent {
  final PlaceholderModel item;
  const PlaceholderComponent({super.key, required this.item});

  void _handleTap(BuildContext context, WidgetRef ref) {
    ref.read(placeholderProvider.notifier).remove(item);
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        _handleTap(context, ref);
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: item.color,
        ),
        child: Center(
          child: SelectableText(item.id.toString()),
        ),
      ),
    );
  }
}
