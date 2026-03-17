import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
                    // Add the line below
                    height: 30,
                    child: Image.asset('assets/images/logopdb.png',
                        fit: BoxFit.fill));
  }
}
