import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onclicked;
  final Color color;
  const ButtonWidget(
      {super.key,
      required this.text,
      required this.onclicked,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onclicked;
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
          ),
        ));
  }
}
