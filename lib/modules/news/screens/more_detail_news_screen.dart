import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:komisains_app/modules/news/bloc/news_bloc.dart';


class MoreDetailNewsScreen extends StatelessWidget {
  static const routeName = '/more-news';
  const MoreDetailNewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) { 
    ContainerTransitionType _transitionType = ContainerTransitionType.fade;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: const Color(0xff3BBC86)),
        elevation: 0,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsStateLoad) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewsStateLoaded) {
            return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
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
                            const SizedBox(
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
                              padding: const EdgeInsets.only(left: 15, top: 20),
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
                                        left: 15, right: 15, top: 5, bottom: 5),
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
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 1,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  child: Image.network(
                                    state.news[index].thumbnail,
                                    fit: BoxFit.contain,
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
                                                const EdgeInsets.only(left: 10),
                                            child: Chip(
                                              backgroundColor:
                                                  const Color(0xffB5EFD7),
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
                    return InkWell(
                      onTap: openContainer,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.16,
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 3.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  child: Image.network(
                                    state.news[index].thumbnail,
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.48,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        state.news[index].title,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      AutoSizeText(
                                        '${state.news[index].by} | ${DateFormat.yMMMd('en_US').add_jm().format(state.news[index].createdAt)}',
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: <Widget>[
                                          for (var item in state.news[index].tag
                                              .split(' '))
                                            InkWell(
                                              onTap: () {},
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1),
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            itemCount: state.news.length,
          );
          } else {
            return Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
