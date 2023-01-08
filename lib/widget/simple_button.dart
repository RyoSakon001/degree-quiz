import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    Key? key,
    required this.text,
    required this.borderColor,
    required Function() this.onPressed,
  }) : super(key: key);
  final String text;
  final Color borderColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.75,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            side: BorderSide(
              width: 4.0,
              color: borderColor,
            ),
            shape: const StadiumBorder(),
            elevation: 0,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
