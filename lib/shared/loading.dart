import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF72BF44),
      child: Center(
          child: SpinKitFadingCube(
        color: Colors.white,
        size: 60,
      )),
    );
  }
}
