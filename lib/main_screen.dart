import 'package:flutter/material.dart';
import 'package:komisains_app/screens/intro_screen.dart';
import 'package:komisains_app/screens/welcome_screen.dart';

import '../responsive.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It provide us the width and height
    Size _size = MediaQuery.of(context).size;
    print(_size.width);
    return Scaffold(
      body: Responsive(
        // Let's work on our mobile part
        mobile: Center(
          child: Container(
            color: Colors.grey,
            constraints: BoxConstraints(minWidth: 450, maxWidth: 550),
            child: WelcomeScreen(),
          ),
        ),
        tablet: Center(
          child: Container(
            color: Colors.grey,
            constraints: BoxConstraints(minWidth: 450, maxWidth: 550),
            child: WelcomeScreen(),
          ),
        ),
        desktop: Center(
          child: Container(
            color: Colors.grey,
            constraints: BoxConstraints(minWidth: 450, maxWidth: 550),
            child: WelcomeScreen(),
          ),
        ),
      ),
    );
  }
}
