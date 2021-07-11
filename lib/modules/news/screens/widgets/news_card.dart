import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:komisains_app/modules/news/bloc/news_bloc.dart';
import 'package:komisains_app/modules/news/repositories/news_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class WelcomeSlidingCard extends StatefulWidget {
  @override
  _WelcomeSlidingCardState createState() => _WelcomeSlidingCardState();
}

class _WelcomeSlidingCardState extends State<WelcomeSlidingCard> {
  late PageController pageController;
  double pageOffset = 0;
  late NewsBloc newsBloc;

  @override
  void initState() {
    newsBloc = context.read<NewsBloc>();
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
    newsBloc.add(FetchNews());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ContainerTransitionType _transitionType = ContainerTransitionType.fade;
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsStateLoad) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewsStateLoaded) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (BuildContext context, int index) {
                final sumOffset = pageOffset - index;
                return OpenContainer<bool>(
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
                                state.news[index].title,
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
                                      state.news[index].by,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 5),
                                  child: Text(
                                    DateFormat.yMMMd('en_US')
                                        .add_jm()
                                        .format(state.news[index].createdAt),
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
                                    state.news[index].thumbnail,
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
                                    data: state.news[index].description,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      for (var item
                                          in state.news[index].tag.split(' '))
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
                                    state.news[index].thumbnail,
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
                                              state.news[index].title,
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
                );
              },
              itemCount: state.news.length < 7 ? state.news.length : 6,
            ),
          );
        } else {
          return Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
