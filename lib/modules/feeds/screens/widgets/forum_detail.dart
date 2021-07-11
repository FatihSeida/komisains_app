import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komisains_app/colors.dart';

class ForumDetailPage extends StatefulWidget {
  @override
  _ForumDetailPageState createState() => _ForumDetailPageState();
}

var forumPostArr = [
  ForumPostEntry("ILoveFlutter", "2 Days ago", 0, 0,
      "Hello,\n I am a fluttajsdkljakdsjalkdjsakldjsakljdaskljdaskljdasdaskljdaskljdaskldasjdaskljdaskljdaskdasjdaskljdaskldasjdaskljdaskldasjer developer Check out my profile to see some of my projects!"),
  ForumPostEntry("flutterDev2", "23 Hours ago", 1, 0,
      "There are lots of resources online! Check out pub.dev"),
  ForumPostEntry("iProgram", "2 Days ago", 5, 0, "Join forums to learn more"),
  ForumPostEntry("julie_codes", "2 Days ago", 0, 0,
      "Try to make a project. Hands on experience always helps me"),
];

class _ForumDetailPageState extends State<ForumDetailPage> {
  @override
  Widget build(BuildContext context) {
    var questionSection = Container(
      margin: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Container(
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/parallax.png',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: AutoSizeText(
                            'Agil N. S |',
                            maxLines: 1,
                            minFontSize: 15,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 10),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            color: AppColorsTheme.myTheme.primarySwatch,
                            child: Text(
                              'entry.title',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: AutoSizeText(
                        'Nulla accumsan urna vel quam ultricies gravida. Cras luctus, lectus in maximus placerat, tortor tortor sagittis ipsum, imperdiet imperdiet massa nisl eget libero. Donec vulputate vitae eros et convallis. Nullam tempus quam euismod orci pretium finibus. Mauris tempus, quam vitae porttitor pellentesque, ex nisl porta tortor, ac scelerisque nisl mauris a magna. Aenean non elit accumsan, consequat ante vel, congue magna. Mauris maximus dolor eget eleifend sagittis. Sed eu nulla a erat viverra dignissim. Vivamus volutpat pellentesque arcu non blandit. Phasellus suscipit venenatis augue a dictum. Cras vel lacus ac nulla pretium lobortis. ',
                        minFontSize: 12,
                        maxFontSize: 12,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 2),
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    '400',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 2),
                                  child: Icon(
                                    Icons.speaker_notes,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    '50',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: IconWithText(
                              Icons.check_circle,
                              "Answered",
                              iconColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    var responses = Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) =>
              ForumPost(forumPostArr[index]),
          itemCount: forumPostArr.length,
        ));

    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.015),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: Color(0xff3BBC86),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'HMI KOMISARIAT DAKWAH & KOMUNIKASI',
                        style: TextStyle(
                          color: AppColorsTheme.myTheme.primarySwatch,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            questionSection,
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: responses,
            ),
          ],
        ),
      ),
    );
  }
}

class ForumPostEntry {
  final String username;
  final String hours;
  final int likes;
  final int dislikes;
  final String text;

  ForumPostEntry(
      this.username, this.hours, this.likes, this.dislikes, this.text);
}

class ForumPost extends StatelessWidget {
  final ForumPostEntry entry;

  ForumPost(this.entry);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: CircleAvatar(
                      radius: 25,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/parallax.png',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(entry.username),
                          Text(entry.hours),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(Icons.thumb_up, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          entry.likes.toString(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(Icons.thumb_down, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 2.0),
                        child: Text(
                          entry.dislikes.toString(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                entry.text,
                maxLines: 10,
                minFontSize: 12,
                maxFontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color iconColor;

  IconWithText(this.iconData, this.text, {required this.iconColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            this.iconData,
            color: this.iconColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(this.text),
          ),
        ],
      ),
    );
  }
}
