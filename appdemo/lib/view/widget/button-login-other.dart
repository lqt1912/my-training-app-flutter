// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ButtonLink extends StatelessWidget {
  String url;
  Function onPressed;
  ButtonLink({Key? key, required this.url, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffF6F6F6),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 1, color: Color(0x60606078))),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Center(
          child: SizedBox(
            width: 29,
            height: 29,
            child: Image.asset(
              url,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
