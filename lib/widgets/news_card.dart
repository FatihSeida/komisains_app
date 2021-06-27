import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:komisains_app/providers/news.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class WelcomeSlidingCard extends StatefulWidget {
  @override
  _WelcomeSlidingCardState createState() => _WelcomeSlidingCardState();
}

class _WelcomeSlidingCardState extends State<WelcomeSlidingCard> {
  late PageController pageController;
  double pageOffset = 0;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.7);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page!);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<NewsProvider>(context).getPickup().then((_) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<NewsProvider>(context, listen: false);
    ContainerTransitionType _transitionType = ContainerTransitionType.fade;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
              controller: pageController,
              itemBuilder: (BuildContext context, int index) {
                final sumOffset = pageOffset - index;
                return ChangeNotifierProvider.value(
                  value: news.items[index],
                  child: OpenContainer<bool>(
                    closedColor: Colors.transparent,
                    closedElevation: 0,
                    closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    transitionDuration: Duration(milliseconds: 400),
                    transitionType: _transitionType,
                    openBuilder: (context, openContainer) {
                      return Scaffold(
                        body: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 60,
                              ),
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Icon(
                                    FontAwesomeIcons.arrowLeft,
                                    color: const Color(0xff3BBC86),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 20),
                                child: AutoSizeText(
                                  news.items[index].title,
                                  maxLines: 3,
                                  style: textTheme.headline5!.copyWith(
                                      color: const Color(0xff3BBC86),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: Text(
                                        news.items[index].by,
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
                                    child: Text(
                                      DateFormat.yMMMd('en_US')
                                          .add_jm()
                                          .format(news.items[index].createdAt),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: MediaQuery.of(context).size.width * 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Image.network(
                                      news.items[index].thumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Html(
                                      data: news.items[index].description,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        for (var item
                                            in news.items[index].tag.split(' '))
                                          InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Chip(
                                                backgroundColor:
                                                    Color(0xffB5EFD7),
                                                label: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      color: const Color(
                                                          0xff3BBC86)),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    closedBuilder: (context, openContainer) {
                      double gauss = math
                          .exp(-(math.pow((sumOffset.abs() - 0.5), 2) / 0.08));
                      return InkWell(
                        customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onTap: openContainer,
                        child: Transform.translate(
                          offset: Offset(-32 * gauss * sumOffset.sign, 0),
                          child: Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: Image.network(
                                      news.items[index].thumbnail,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      alignment: Alignment(-sumOffset.abs(), 0),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Transform.translate(
                                            offset: Offset(8 * sumOffset, 0),
                                            child: AutoSizeText(
                                                news.items[index].title,
                                                maxFontSize: 15,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0, 0),
                                                      blurRadius: 3.0,
                                                      color: Colors.grey,
                                                    ),
                                                    Shadow(
                                                      offset: Offset(0, 0),
                                                      blurRadius: 3.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              itemCount: news.items.length < 7 ? news.items.length : 6,
            ),
    );
  }
}
