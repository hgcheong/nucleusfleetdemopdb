import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_component.dart';
import 'package:nucleusv2/src/feature/user/models/user.dart';

class UserCard extends BaseComponent {
  final User user;
  const UserCard(this.user, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        onTap: () {
          singleton<AppRouter>().push(ProfileRoute(uuid: user.uuid));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectableText(user.username) 
        ),
      ),
    );
  }
}
