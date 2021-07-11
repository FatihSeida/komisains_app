import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:komisains_app/modules/ebook/bloc/ebook_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ResensiBukuView extends StatefulWidget {
  @override
  _ResensiBukuViewState createState() => _ResensiBukuViewState();
}

class _ResensiBukuViewState extends State<ResensiBukuView> {
  late PageController pageController;
  double pageOffset = 0;
  late EbookBloc ebookBloc;

  @override
  void initState() {
    ebookBloc = context.read<EbookBloc>();
    
    super.initState();
    pageController = PageController(viewportFraction: 0.44);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page!);
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  void didChangeDependencies() {
    ebookBloc.add(FetchEbooks());
    super.didChangeDependencies();
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    ContainerTransitionType _transitionType = ContainerTransitionType.fade;

    return BlocBuilder<EbookBloc, EbookState>(
      builder: (context, state) {
        if (state is EbookStateLoad) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EbookStateLoaded) {
          final resensi = state.books
              .where((booksItem) => booksItem.category == 'Resensi')
              .toList();
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
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
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        iconTheme:
                            IconThemeData(color: const Color(0xff3BBC86)),
                        elevation: 0,
                      ),
                      body: Container(),
                      // child:
                      //     PDFViewerCachedFromUrl(url: resensi[index].file)),
                    );
                  },
                  closedBuilder: (context, openContainer) {
                    double gauss = math
                        .exp(-(math.pow((sumOffset.abs() - 0.5), 2) / 0.08));
                    return InkWell(
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onTap: () => _launchURL(resensi[index].file),
                      // openContainer,
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Image.network(
                                    resensi[index].thumbnail,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width: MediaQuery.of(context).size.width *
                                        0.44,
                                    alignment: Alignment(-sumOffset.abs(), 0),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.44,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Transform.translate(
                                          offset: Offset(8 * sumOffset, 0),
                                          child: Container(
                                            child: Text(resensi[index].name,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset:
                                                          const Offset(0, 0),
                                                      blurRadius: 3.0,
                                                      color: Colors.grey,
                                                    ),
                                                    Shadow(
                                                      offset:
                                                          const Offset(0, 0),
                                                      blurRadius: 3.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                )),
                                          ),
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
              itemCount: resensi.length < 7 ? resensi.length : 6,
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

// class PDFViewerCachedFromUrl extends StatefulWidget {
//   const PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);

//   final String url;

//   @override
//   _PDFViewerCachedFromUrlState createState() => _PDFViewerCachedFromUrlState();
// }

// class _PDFViewerCachedFromUrlState extends State<PDFViewerCachedFromUrl> {
//   int _totalPages = 0;
//   int _currentPage = 0;
//   bool pdfReady = false;
//   late PDFViewController _pdfViewController;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         PDF(
//           autoSpacing: true,
//           swipeHorizontal: true,
//           onError: (e) {
//             print(e);
//           },
//           onRender: (_pages) {
//             setState(() {
//               _totalPages = _pages!;
//               pdfReady = true;
//             });
//           },
//           onPageChanged: (int? page, int? total) {
//             setState(() {
//               _currentPage = (page! + 1);
//               _totalPages = total!;
//             });
//           },
//           onViewCreated: (PDFViewController vc) {
//             _pdfViewController = vc;
//           },
//         ).cachedFromUrl(
//           widget.url,
//           // placeholder: (double progress) => Center(child: Text('$progress %')),
//           // errorWidget: (dynamic error) => Center(child: Text(error.toString())),
//         ),
//         !pdfReady
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Offstage(),
//         Align(
//           alignment: Alignment.bottomRight,
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//                 border: Border.all(width: 1.0, color: const Color(0xff6EA88F)),
//               ),
//               height: MediaQuery.of(context).size.height * 0.04,
//               width: MediaQuery.of(context).size.width * 0.25,
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: Row(
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Page : $_currentPage / $_totalPages',
//                       style: const TextStyle(
//                         color: const Color(0xff6EA88F),
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
