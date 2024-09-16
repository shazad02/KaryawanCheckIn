// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';

class MultiBottom extends StatelessWidget {
  final Function onPressed;
  final String textButton;
  final Color buttomcolor;
  final Color textcolor;

  const MultiBottom(
      {super.key,
      required this.textButton,
      required this.onPressed,
      required this.buttomcolor,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 70 / 100,
      height: MediaQuery.of(context).size.height * 6 / 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: buttomcolor,
        ),
        onPressed: onPressed as void Function(),
        child: Text(
          textButton,
          style: TextStyle(
            fontSize: 18,
            color: textcolor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
