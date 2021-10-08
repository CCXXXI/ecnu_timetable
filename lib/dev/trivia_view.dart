import 'package:flutter/material.dart';

import '../settings/trivia.dart';

class TriviaPage extends StatelessWidget {
  const TriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: trivia,
        ).toList(),
      ),
    );
  }
}
