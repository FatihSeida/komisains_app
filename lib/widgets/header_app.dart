import 'package:flutter/material.dart';

class HeaderApp extends StatelessWidget {
  final String image;
  final String text;
  final String text2;

  HeaderApp(
    this.image,
    this.text,
    this.text2,
  );

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: deviceSize.height * 0.2,
            width: deviceSize.width * 0.6,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      text2,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              height: deviceSize.height * 0.2,
              width: deviceSize.width * 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
