import 'package:flutter/material.dart';

class NotAuthorised extends StatelessWidget {
  const NotAuthorised({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Not Authorised',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
