import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';

class AcxCheckBoxList extends StatelessWidget {
  const AcxCheckBoxList({super.key, required this.listWidget});

  final List<Widget> listWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: secondaryColor,
      ),
      child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: listWidget),
    );
  }
}
