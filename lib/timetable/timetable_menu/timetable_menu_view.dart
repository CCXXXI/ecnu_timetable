import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../utils/database.dart';
import '../../utils/gu.dart';
import '../../utils/string.dart';
import '../../utils/web.dart';
import '../ecnu/ecnu_logic.dart';
import '../ecnu/ecnu_view.dart';
import 'timetable_menu_logic.dart';

class TimetableMenuPage extends StatelessWidget {
  TimetableMenuPage({Key? key}) : super(key: key);

  final logic = Get.put(TimetableMenuLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('课程表'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            children: [
              SettingsGroup(
                title: '导入自',
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      title: const Text('公共数据库'),
                      subtitle: const Text('推荐，输入学号密码即可'),
                      trailing: const ImageIcon(
                        ResizeImage(
                          AssetImage('assets/images/ecnu_c.png'),
                          width: 42,
                        ),
                      ),
                      onTap: GetPlatform.isWeb
                          ? () => Get.defaultDialog(
                                title: 'Web端功能受限'.s,
                                middleText: '因跨域资源共享（CORS）问题，无法连接公共数据库。',
                                textConfirm: '下载完整版',
                                textCancel: '返回',
                                onConfirm: Url.latest.launch,
                              )
                          : () => Get.to(() => EcnuPage()),
                    ),
                    ListTile(
                      title: Text('HTML文件'.s),
                      subtitle: const Text('离线可用，需手动下载保存课表网页'),
                      trailing: const FaIcon(FontAwesomeIcons.fileImport),
                      onTap: () => gu(),
                    ),
                  ],
                ).toList(),
              ),
              SettingsGroup(
                title: '修改',
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      title: const Text('周数'),
                      subtitle: Text('🕊' * 5),
                      trailing: const FaIcon(FontAwesomeIcons.dove),
                      onTap: gu,
                    ),
                    ListTile(
                      title: const Text('调休'),
                      subtitle: Text('🕊' * 5),
                      trailing: const FaIcon(FontAwesomeIcons.dove),
                      onTap: gu,
                    ),
                    ListTile(
                      title: const Text('原始数据'),
                      subtitle: Text('🕊' * 5),
                      trailing: const FaIcon(FontAwesomeIcons.dove),
                      onTap: gu,
                    ),
                  ],
                ).toList(),
              ),
              SettingsGroup(
                title: '导出',
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      title: Text('ICS文件'.s),
                      subtitle:
                          user.id == null ? const Text('需先登录公共数据库') : null,
                      enabled: user.id != null,
                      trailing: const FaIcon(FontAwesomeIcons.fileExport),
                      onTap: user.id == null
                          ? null
                          : Url.ics(
                              user.id!,
                              user.password!,
                              EcnuLogic.guessYear(DateTime.now()),
                              EcnuLogic.guessSemester(DateTime.now()),
                            ).launch,
                    ),
                    ListTile(
                      title: const Text('壁纸'),
                      subtitle: Text('🕊' * 5),
                      trailing: const FaIcon(FontAwesomeIcons.dove),
                      onTap: gu,
                    ),
                  ],
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
