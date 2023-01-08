import 'package:degree_quiz/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage({Key? key}) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => const HomePage()),
            ),
          );
        },
        finishCallback: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => const HomePage()),
            ),
          );
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: const Color(0xFF0097A7),
        imageAssetPath: 'assets/images/image01.jpeg',
        title: 'Screen 1',
        body: 'Share your ideas with the team',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/images/image02.jpeg',
        title: 'Screen 2',
        body: 'See the increase in productivity & output',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/images/image03.jpeg',
        title: 'Screen 3',
        body: 'Connect with the people from different places',
        doAnimateImage: true),
    PageModel.withChild(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Image.asset('assets/images/image04.jpeg',
              width: 300.0, height: 300.0),
        ),
        color: const Color(0xFF5886d6),
        doAnimateChild: true)
  ];
}
