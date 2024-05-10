import 'package:flutter/material.dart';

class Pixels {
  static height(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * height;
  }

  static width(BuildContext context, double width) {
    return MediaQuery.of(context).size.width * width;
  }
}
