import 'package:degree_quiz/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        inactiveBulletColor: Colors.blue,
        skipCallback: () {
          _setTutorialDone();
          Navigator.pushNamed(context, '/');
        },
        finishCallback: () {
          _setTutorialDone();
          Navigator.pushNamed(context, '/');
        },
      ),
    );
  }

  final pages = [
    _SimplePageModel(
      title: 'このアプリの目的',
      body:
          '高校化学では、「物質量(mol)」について理解し、計算をスムーズにできるようにすることが、必須です。このアプリでは、物質量の計算をスキマ時間に行い、基礎力を高めることを目的としています。',
      backgroundColor: Colors.lime,
    ),
    _SimplePageModel(
      title: "Let's Start!",
      body: '１回につき１０問を出題します。全問正解できるように頑張ってください！',
      backgroundColor: Colors.amber,
    ),
  ];
}

class _SimplePageModel extends PageModel {
  _SimplePageModel({
    required String title,
    required String body,
    required Color backgroundColor,
  }) : super(
          color: backgroundColor,
          imageAssetPath: 'assets/images/frasco.png',
          title: title,
          titleColor: Colors.black,
          body: body,
          bodyColor: Colors.black,
          doAnimateImage: true,
        );
}

void _setTutorialDone() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isFirst', true);
}
