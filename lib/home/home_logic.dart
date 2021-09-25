import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  var idx = 0.obs;
  final pageController = PageController();

  void onPageChanged(int idx_) => idx.value = idx_;

  void onItemSelected(int idx_) {
    idx.value = idx_;
    pageController.jumpToPage(idx_);
  }
}
