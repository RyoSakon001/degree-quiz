import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('利用規約')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text('利用規約'),
      ),
    );
  }
}
