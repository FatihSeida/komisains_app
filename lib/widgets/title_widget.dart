import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  final String text2;
  final Function function;

  TitleWidget(
    this.text,
    this.text2,
    this.function,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xff3BBC86),
              ),
            ),
          ),
          Container(
            child: TextButton(
              child: Text(
                text2,
                style: const TextStyle(
                  fontSize: 12,
                  color: const Color(0xff3BBC86),
                ),
              ),
              onPressed: function,
            ),
          ),
        ],
      ),
    );
  }
}
