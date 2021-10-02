import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'settings_logic.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingsLogic());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        user(),
        const Divider(),
        const Placeholder(),
      ],
    );
  }

  Widget user() => logic.loggedIn
      ? ListTile(
          leading: const Icon(Icons.person),
          trailing: const Icon(Icons.logout),
          title: Text(logic.username!),
          subtitle: Text(logic.id!),
        )
      : ListTile(
          leading: const FaIcon(FontAwesomeIcons.userSecret),
          trailing: const Icon(Icons.login),
          title: const Text('无名者'),
          subtitle: const Text('点击以登录'),
          onTap: logic.login,
        );
}
