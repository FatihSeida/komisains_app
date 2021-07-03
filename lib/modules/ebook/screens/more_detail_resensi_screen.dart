import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:komisains_app/modules/ebook/bloc/ebook_bloc.dart';


class MoreDetailResensiScreen extends StatelessWidget {
  static const routeName = '/more-resensi';
  const MoreDetailResensiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    ContainerTransitionType _transitionType = ContainerTransitionType.fade;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: const Color(0xff3BBC86)),
        elevation: 0,
      ),
      body: BlocBuilder<EbookBloc, EbookState>(
        builder: (context, state) {
          if (state is EbookStateLoad) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EbookStateLoaded) {
            final resensiBuku = state.books
              .where((booksItem) => booksItem.category == 'Resensi')
              .toList();
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
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        iconTheme:
                            IconThemeData(color: const Color(0xff3BBC86)),
                        elevation: 0,
                      ),
                      body: Container(
                          child:
                              PDFViewerCachedFromUrl(url: resensiBuku[index].file)),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  child: Image.network(
                                    resensiBuku[index].thumbnail,
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      resensiBuku[index].name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff3BBC86),
                                      ),
                                    ),
                                    Text(
                                      resensiBuku[index].by,
                                      style: const TextStyle(
                                          color: const Color(0xff3BBC86)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            itemCount: resensiBuku.length,
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

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
