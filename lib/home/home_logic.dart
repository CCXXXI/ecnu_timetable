import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  final idx = 1.obs;
  final pageController = PageController(initialPage: 1);

  void _toPage(int idx_, bool animate) {
    idx.value = idx_;

    if (animate) {
      pageController.animateToPage(
        idx_,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      pageController.jumpToPage(idx_);
    }
  }

  void onItemSelected(int idx_) => _toPage(idx_, true);

  void onDestinationSelected(int idx_) => _toPage(idxMap[idx_], false);
}

// NavigationRail: Timetable, Toolbox, Settings
// actual: Toolbox, Timetable, Settings
final idxMap = [1, 0, 2];
