import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/base_component.dart';
import 'package:nucleusv2/src/feature/track/models/track.dart';

class LikeButton extends BaseComponent {
  final Track track;

  const LikeButton({
    super.key,
    required this.track,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.favorite_outline),
    );
  }
}
