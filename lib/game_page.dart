import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage();

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text('戻る'),
                ),
                ElevatedButton(
                  onPressed: () => _showTerms(context),
                  child: Text('条件'),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/data');
                    },
                    child: Text('Firestoreのページへ'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    ));
  }
}

void _showTerms(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      String text = '';
      text += '・アボガドロ定数は\n';
      text += '6.0 ✖︎ 10 ^ 23とする。\n';
      text += '・気体は理想気体とする。\n';
      text += '・標準状態とする。\n';
      text += '・原子量は以下の通り。\n\n';
      text += 'H = 1\n';
      text += 'C = 12\n';
      text += 'N = 14\n';
      text += 'O = 16\n';
      text += 'Na = 23\n';
      text += 'Mg = 24\n';
      text += 'Al = 27\n';
      text += 'S = 32\n';
      text += 'Ca = 40\n';
      return AlertDialog(
        title: Text('＜条件＞'),
        content: Text(text),
        actions: [
          ElevatedButton(
            child: const Text('プレイ画面に戻る'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}
