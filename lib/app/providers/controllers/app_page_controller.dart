import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageController = Provider<PageController>((ref) {
  final controller = PageController();
  return controller;
});
