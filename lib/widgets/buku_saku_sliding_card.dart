import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:komisains_app/providers/books.dart';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class BukuSakuView extends StatefulWidget {
  @override
  _BukuSakuViewState createState() => _BukuSakuViewState();
}

class _BukuSakuViewState extends State<BukuSakuView> {
  PageController pageController;
  double pageOffset = 0;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.44);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
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
      Provider.of<BooksProvider>(context).getPickup().then((_) {
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
    final booksData =
        Provider.of<BooksProvider>(context, listen: false).materiWajib;
    ContainerTransitionType _transitionType = ContainerTransitionType.fade;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PageView.builder(
              controller: pageController,
              itemBuilder: (BuildContext context, int index) {
                final sumOffset = pageOffset - index;
                return ChangeNotifierProvider.value(
                  value: booksData[index],
                  child: OpenContainer<bool>(
                    closedColor: Colors.transparent,
                    closedElevation: 0,
                    closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    transitionDuration: Duration(milliseconds: 400),
                    transitionType: _transitionType,
                    openBuilder: (context, openContainer) {
                      return Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          iconTheme: IconThemeData(color: Color(0xff3BBC86)),
                          elevation: 0,
                        ),
                        body: Container(
                            child: PDFViewerCachedFromUrl(
                                url: booksData[index].file)),
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
                                      booksData[index].thumbnail,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width *
                                          0.44,
                                      alignment: Alignment(-sumOffset.abs(), 0),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.44,
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
                                            child: Text(booksData[index].name,
                                                style: const TextStyle(
                                                  fontSize: 20,
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
              itemCount: booksData.length < 7 ? booksData.length : 6,
            ),
    );
  }
}

class PDFViewerCachedFromUrl extends StatefulWidget {
  const PDFViewerCachedFromUrl({Key key, @required this.url}) : super(key: key);

  final String url;

  @override
  _PDFViewerCachedFromUrlState createState() => _PDFViewerCachedFromUrlState();
}

class _PDFViewerCachedFromUrlState extends State<PDFViewerCachedFromUrl> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PDF(
          autoSpacing: true,
          swipeHorizontal: true,
          onError: (e) {
            print(e);
          },
          onRender: (_pages) {
            setState(() {
              _totalPages = _pages;
              pdfReady = true;
            });
          },
          onPageChanged: (int page, int total) {
            setState(() {
              _currentPage = page + 1;
              _totalPages = total;
            });
          },
          onViewCreated: (PDFViewController vc) {
            _pdfViewController = vc;
          },
        ).cachedFromUrl(
          widget.url,
          // placeholder: (double progress) => Center(child: Text('$progress %')),
          // errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ),
        !pdfReady
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Offstage(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1.0, color: const Color(0xff6EA88F)),
              ),
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.25,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Page : $_currentPage / $_totalPages',
                      style: const TextStyle(
                        color: const Color(0xff6EA88F),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
