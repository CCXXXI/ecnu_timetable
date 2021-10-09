import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/loading.dart';
import 'calendar_logic.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({Key? key}) : super(key: key);

  final logic = Get.put(CalendarLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('校历')),
      body: InteractiveViewer(
        child: Obx(
          () => Center(
            child: logic.imgUrl.isEmpty
                ? Loading()
                : CachedNetworkImage(
                    imageUrl: logic.imgUrl.value,
                    progressIndicatorBuilder: (_, __, downloadProgress) =>
                        CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                    errorWidget: (_, url, error) => Text('$url\n$error'),
                  ),
          ),
        ),
      ),
    );
  }
}
