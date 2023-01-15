import 'package:flutter/material.dart';

class DataPage extends StatelessWidget {
  const DataPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              print('aaa');
            },
            child: Text('data'),
          ),
        ),
      ),
    );
  }
}
