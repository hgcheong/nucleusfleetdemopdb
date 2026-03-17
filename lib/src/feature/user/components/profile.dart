import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nucleusv2/src/core/base_component.dart';
import 'package:nucleusv2/src/feature/user/models/user.dart';

class Profile extends BaseComponent {
  final User user;

  const Profile({
    super.key,
    required this.user,
  });

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return SelectableText(user.name);
  }
}
