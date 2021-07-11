import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:komisains_app/core/auth/screens/more_organization.dart';

class AboutOrganization extends StatefulWidget {
  final String text;

  AboutOrganization(
    this.text,
  );

  @override
  _AboutOrganizationState createState() => _AboutOrganizationState();
}

class _AboutOrganizationState extends State<AboutOrganization> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: deviceSize.height * 0.3,
          width: deviceSize.width * 0.7,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: <Widget>[
                Text(
                  'Tentang Himpunan Mahasiswa Islam',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff3BBC86),
                  ),
                ),
                Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          widget.text.length > 300
                              ? TextSpan(
                                  text: widget.text.substring(0, 300),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              : TextSpan(
                                  text: widget.text,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                          TextSpan(
                            text: '... ReadMore',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamed(
                                    MoreOrganizationScreen.routeName);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            child: Image.asset(
              'assets/images/logohmi.png',
              fit: BoxFit.fitHeight,
              height: deviceSize.height * 0.2,
              width: deviceSize.width * 0.3,
            ),
          ),
        ),
      ],
    );
  }
}
