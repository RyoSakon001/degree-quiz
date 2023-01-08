import 'package:degree_quiz/widget/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _showTutorial(context));

    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 64,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'mol計算ゲーム',
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(height: 100),
                SimpleButton(
                  text: 'スタート！',
                  borderColor: Colors.green,
                  onPressed: () {},
                ),
                SizedBox(height: 100),
                SimpleButton(
                  text: 'チュートリアル',
                  borderColor: Colors.orange,
                  onPressed: () {
                    Navigator.pushNamed(context, '/tutorial');
                  },
                ),
              ],
            )),
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
