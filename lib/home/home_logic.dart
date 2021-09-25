import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  final idx = 1.obs;
  final pageController = PageController(initialPage: 1);

  void _toPage(int idx_) {
    idx.value = idx_;
    pageController.animateToPage(
      idx_,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void onItemSelected(int idx_) => _toPage(idx_);

  void onDestinationSelected(int idx_) => _toPage(idxMap[idx_]);
}

// NavigationRail: Timetable, Toolbox, Settings
// actual: Toolbox, Timetable, Settings
final idxMap = [1, 0, 2];
