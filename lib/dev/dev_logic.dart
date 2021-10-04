import 'package:get/get.dart';

import 'trivia_view.dart';

class DevLogic extends GetxController {
  void triviaOnTap() => Get.to(() => const TriviaPage());
}
