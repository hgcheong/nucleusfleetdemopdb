import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/base_component.dart';
import 'package:nucleusv2/src/feature/track/models/track.dart';

class BookmarkButton extends BaseComponent {
  final Track track;

  const BookmarkButton({
    super.key,
    required this.track,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.bookmark_outline),
    );
  }
}
