import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dev/dev_view.dart';
import '../timetable/timetable_logic.dart';
import '../utils/database.dart';
import '../utils/log.dart';

class HomeLogic extends GetxController with L {
  final idx = misc.launchPage_.obs;
  final isAnimating = false.obs;

  late PageController _pageController;

  PageController get pageController {
    _pageController = PageController(initialPage: idx.value);
    return _pageController;
  }

  void _toPage(int idx_, bool animate) async {
    idx.value = idx_;

    if (animate) {
      l.debug('animateToPage $idx_ begin.');
      isAnimating.value = true;

      await _pageController.animateToPage(
        idx_,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );

      isAnimating.value = false;
      l.debug('animateToPage $idx_ end.');
    } else {
      _pageController.jumpToPage(idx_);
    }
  }

  void onDestinationSelected(int idx_) {
    var realIdx = idxMap[idx_];
    if (realIdx == 1 && idx.value == 1) TimetableLogic.openMenu();
    _toPage(realIdx, false);
  }

  void onItemSelected(int idx_) {
    if (isAnimating.isFalse) _toPage(idx_, true);
  }

  void onPageChanged(int idx_) {
    if (isAnimating.isFalse) idx.value = idx_;
  }

  final railExtended = false.obs;

  void ecnuLongPress() => Get.to(() => DevPage());

  void ecnuOnPressed() => railExtended.toggle();
}

// actual: Toolbox, Timetable, Settings
// NavigationRail: Timetable, Toolbox, Settings
final idxMap = [1, 0, 2];
