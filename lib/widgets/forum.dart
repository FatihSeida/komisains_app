import 'package:flutter/material.dart';
import 'package:komisains_app/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ForumPage extends StatefulWidget {
  ForumPage({required this.title});

  final String title;

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  /// Top Icons

  static final listItemsData = [
    ListEntry("Chat", "Welcome to Flutter!",
        "I am a   Flutter developer. Any advice?", 204, 800, true),
    ListEntry(
        "Local Groups",
        "GDG Rochester",
        "Join us on June 1st for the International Flutter Hackathon!",
        154,
        400,
        false),
    ListEntry(
        "Local Groups",
        "GDG Rochester",
        "Join us on June 1st for the International Flutter Hackathon!",
        154,
        400,
        false),
    ListEntry(
        "Local Groups",
        "GDG Rochester",
        "Join us on June 1st for the International Flutter Hackathon!",
        154,
        400,
        false),
    ListEntry(
        "Local Groups",
        "GDG Rochester",
        "Join us on June 1st for the International Flutter Hackathon!",
        154,
        400,
        false),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: SizedBox(
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: 8.0,
                runSpacing: 4.0,
                children: <Widget>[
                  CategoryIcon(Icons.school, "Tutorials", true),
                  CategoryIcon(Icons.public, "Jobs", false),
                  CategoryIcon(Icons.speaker_notes, "Chat", false),
                  CategoryIcon(Icons.place, "Local groups", false),
                  CategoryIcon(Icons.build, "Projects", false),
                  CategoryIcon(Icons.question_answer, "Questions", false),
                  CategoryIcon(Icons.calendar_today, "Events", false),
                  CategoryIcon(Icons.person, "Profile", false),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) =>
                EntryItem(listItemsData[index]),
            itemCount: listItemsData.length,
            shrinkWrap: true,
          ),
        ],
        shrinkWrap: true,
      ),
    );
  }
}

class ListEntry {
  final String title;
  final String icon;
  final String description;
  final int views;
  final int responses;
  final bool answered;

  ListEntry(this.title, this.icon, this.description, this.views, this.responses,
      this.answered);
}

class CategoryIcon extends StatelessWidget {
  const CategoryIcon(this.icon, this.iconText, this.selected);

  final String iconText;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(icon),
            onPressed: () {},
            color: selected == true
                ? AppColorsTheme.myTheme.primarySwatch
                : Colors.grey,
          ),
          Text(
            iconText,
            style: TextStyle(
                color: selected == true
                    ? AppColorsTheme.myTheme.primarySwatch
                    : Colors.grey),
          )
        ],
      ),
    );
  }
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final ListEntry entry;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/forum/1');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.16,
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
                Flexible(
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
                                entry.title,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: AutoSizeText(
                            entry.description,
                            maxLines: 4,
                            minFontSize: 12,
                            maxFontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 60,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 2),
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      entry.views.toString(),
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 2),
                                    child: Icon(
                                      Icons.speaker_notes,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      entry.responses.toString(),
                                      style:
                                          const TextStyle(color: Colors.grey),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
