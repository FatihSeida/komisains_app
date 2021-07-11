import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komisains_app/modules/ebook/bloc/ebook_bloc.dart';
import 'package:komisains_app/modules/ebook/repository/ebook_repository.dart';
import 'package:komisains_app/modules/ebook/screens/widgets/buku_saku_sliding_card.dart';
import 'package:komisains_app/widgets/header_app.dart';
import 'package:komisains_app/modules/ebook/screens/widgets/resensi_sliding_card.dart';
import 'package:komisains_app/widgets/title_widget.dart';

import 'more_detail_books_screen.dart';
import 'more_detail_resensi_screen.dart';

class BukuSakuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: BlocProvider(
        create: (context) => EbookBloc(
            ebookRepository: RepositoryProvider.of<EbookRepository>(context)),
        child: Column(
          children: <Widget>[
            HeaderApp('assets/images/buku.png', 'Buku Saku',
                'Membaca adalah bermimpi dengan mata yang terbuka'),
            TitleWidget(
              'Bacaan Wajib',
              'Lihat bacaan wajib lainnya',
              () {
                Navigator.of(context)
                    .pushNamed(MoreDetailBooksScreen.routeName);
              },
            ),
            BukuSakuView(),
            TitleWidget(
              'Bacaan Lainnya',
              'Lihat bacaan lainnya',
              () {
                Navigator.of(context)
                    .pushNamed(MoreDetailResensiScreen.routeName);
              },
            ),
            ResensiBukuView(),
          ],
        ),
      ),
    );
  }
}
