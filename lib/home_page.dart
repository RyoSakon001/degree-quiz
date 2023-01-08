import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _showTutorial(context));

    return Scaffold(
      appBar: AppBar(title: Text("ホーム")),
      body: Center(
        child: Text("スタート"),
      ),
    );
  }
}

void _showTutorial(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('isFirst') != true) {
    // 警告が出ているが一旦無視でOK
    Navigator.pushNamed(context, '/tutorial');
  }
}
