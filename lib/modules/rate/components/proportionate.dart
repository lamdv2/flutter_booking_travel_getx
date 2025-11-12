import 'package:flutter/material.dart';

// Get the height, proportionally to screen height
double getScreenPropotionHeight(double actualHeight, Size size) {
  // 896 is the artboard height that designer use
  return (actualHeight / 896.0) * size.height;
}

// Get the width, proportionally to screen width
double getScreenPropotionWidth(double actualWidth, Size size) {
  // 414 is the artboard width that designer use
  return (actualWidth / 414.0) * size.width;
}