import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';

class NotAuthorised extends StatelessWidget {
  const NotAuthorised({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Not Authorised',
        style: TextStyle(color: DbColors.danger),
      ),
    );
  }
}
