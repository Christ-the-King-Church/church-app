import 'package:flutter/material.dart';
import '../utils/color_scheme.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MAIN1,
        child: const Center(
          child: CircularProgressIndicator(
            color: SECOND1,
          ),
        ));
  }
}
