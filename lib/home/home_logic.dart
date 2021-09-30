import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/logger.dart';

class HomeLogic extends GetxController {
  final idx = 1.obs;
  final pageController = PageController(initialPage: 1);
  final isAnimating = false.obs;

  Future<void> _toPage(int idx_, bool animate) async {
    idx.value = idx_;

    if (animate) {
      logger.d('animateToPage $idx_ begin.');
      isAnimating.value = true;

      await pageController.animateToPage(
        idx_,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );

      isAnimating.value = false;
      logger.d('animateToPage $idx_ end.');
    } else {
      pageController.jumpToPage(idx_);
    }
  }

  void onDestinationSelected(int idx_) => _toPage(idxMap[idx_], false);

  void onItemSelected(int idx_) {
    if (isAnimating.isFalse) _toPage(idx_, true);
  }

  void onPageChanged(int idx_) {
    if (isAnimating.isFalse) idx.value = idx_;
  }
}

// NavigationRail: Timetable, Toolbox, Settings
// actual: Toolbox, Timetable, Settings
final idxMap = [1, 0, 2];
