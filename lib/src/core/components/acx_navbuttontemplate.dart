import 'package:flutter/material.dart';

class AcxNavButton extends StatelessWidget {
  const AcxNavButton({
    super.key,
    required this.listOfContent,
    required this.listOfButton,
    this.theheight = 100,
    this.thewidth = 120,
  });

  final List<Widget> listOfContent;
  final List<Widget>? listOfButton;
  final double? theheight;
  final double? thewidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: theheight,
      width: thewidth,
      child: Card(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ...listOfContent,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
           //      color: secondarylightColor,
            ),
            child: listOfButton == null
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [...listOfButton!],
                  ),
          )
        ]),
      ),
    );
  }
}
