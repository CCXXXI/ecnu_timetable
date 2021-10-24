import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

Color get _c => Get.theme.colorScheme.primary;

final _kits = [
  () => SpinKitChasingDots(color: _c),
  () => SpinKitCircle(color: _c),
  () => SpinKitCubeGrid(color: _c),
  () => SpinKitDancingSquare(color: _c),
  () => SpinKitDoubleBounce(color: _c),
  () => SpinKitDualRing(color: _c),
  () => SpinKitFadingCircle(color: _c),
  () => SpinKitFadingCube(color: _c),
  () => SpinKitFadingFour(color: _c),
  () => SpinKitFadingGrid(color: _c),
  () => SpinKitFoldingCube(color: _c),
  () => SpinKitHourGlass(color: _c),
  () => SpinKitPianoWave(color: _c),
  () => SpinKitPouringHourGlass(color: _c),
  () => SpinKitPouringHourGlassRefined(color: _c),
  () => SpinKitPulse(color: _c),
  () => SpinKitPumpingHeart(color: _c),
  () => SpinKitRing(color: _c),
  () => SpinKitRipple(color: _c),
  () => SpinKitRotatingCircle(color: _c),
  () => SpinKitRotatingPlain(color: _c),
  () => SpinKitSpinningCircle(color: _c),
  () => SpinKitSpinningLines(color: _c),
  () => SpinKitSquareCircle(color: _c),
  () => SpinKitThreeBounce(color: _c),
  () => SpinKitThreeInOut(color: _c),
  () => SpinKitWanderingCubes(color: _c),
  () => SpinKitWave(color: _c),
];

class Loading extends StatelessWidget {
  Loading({Key? key}) : super(key: key);

  final logic = Get.put(LoadingLogic());

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: logic.onPressed,
      icon: FittedBox(
        child: Obx(
          () => _kits[logic.i.value](),
        ),
      ),
    );
  }
}

class LoadingLogic extends GetxController {
  static final _r = Random();
  final i = _r.nextInt(_kits.length).obs;

  void onPressed() => i.value = _r.nextInt(_kits.length);
}
