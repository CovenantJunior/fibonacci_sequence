import 'dart:math' as math;
import 'package:flutter/material.dart';

const Color primaryColor = Color.fromRGBO(51, 153, 255, 1.0);
// const TargetPlatform platform = TargetPlatform.android;

void main() {
  runApp(const FibonacciSequence());
}

class FibonacciSequence {
  static const seedRadius = 2.0; // Seeds
  static const scaleFactor = 4;  // Scale
  static const tau = math.pi * 2;  // Tau
}