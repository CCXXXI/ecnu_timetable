import 'package:flutter/material.dart';

import '../toolbox/cheater.dart';

class CheaterPage extends StatelessWidget {
  const CheaterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: cheaters.map((e) => Text(e)),
        ).toList(),
      ),
    );
  }
}
