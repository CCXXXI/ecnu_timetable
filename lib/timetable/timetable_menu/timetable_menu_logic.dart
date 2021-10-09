import 'package:get/get.dart';

import '../../utils/gu.dart';
import '../ecnu/ecnu_view.dart';

class TimetableMenuLogic extends GetxController {
  void ecnuOnTap() => Get.to(() => EcnuPage());

  void htmlOnTap() => gu();
}
