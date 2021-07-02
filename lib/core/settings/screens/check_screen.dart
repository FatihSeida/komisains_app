// import 'package:flutter/material.dart';
// import 'package:komisains_app/core/auth/models/auth.dart';
// import 'package:komisains_app/core/walk_through.dart/intro_screen.dart';
// import 'package:komisains_app/modules/dashboard/screens/tab_screen.dart';
// import 'package:komisains_app/core/auth/screens/welcome_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CheckScreen extends StatefulWidget {
//   static const routeName = '/splash';
//   final Auth auth;

//   const CheckScreen({required this.auth});

//   @override
//   _CheckScreen createState() => _CheckScreen();
// }

// class _CheckScreen extends State<CheckScreen> {
//   Future checkFirstSeen() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool _seen = (prefs.getBool('seen') ?? false);

//     if (_seen == false) {
//       await prefs.setBool('seen', true);
//       Navigator.pushNamed(context, IntroScreen.routeName);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.auth.isAuth != null && true
//         ? TabScreen()
//         : LayoutBuilder(
//             builder: (context, constraints) {
//               return OrientationBuilder(
//                 builder: (context, orientation) {
//                   return FutureBuilder(
//                     future: widget.auth.tryAutoLogin(),
//                     builder: (context, authResultSnapshot) => WelcomeScreen(),
//                     // authResultSnapshot.connectionState ==
//                     //         ConnectionState.waiting
//                     //     ? SplashScreen()
//                     //     : WelcomeScreen(),
//                   );
//                 },
//               );
//             },
//           );
//   }

//   @override
//   void initState() {
//     super.initState();
//     checkFirstSeen();
//   }
// }
