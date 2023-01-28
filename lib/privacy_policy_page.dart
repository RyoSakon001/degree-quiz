import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('プライバシーポリシー')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text('プライバシーポリシー'),
      ),
    );
  }
}
