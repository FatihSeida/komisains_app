import 'package:flutter/material.dart';
import 'package:komisains_app/widgets/buku_saku_sliding_card.dart';
import 'package:komisains_app/widgets/header_app.dart';
import 'package:komisains_app/widgets/resensi_sliding_card.dart';
import 'package:komisains_app/widgets/title_widget.dart';

import 'more_detail_books_screen.dart';
import 'more_detail_resensi_screen.dart';

class BukuSakuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          HeaderApp('assets/images/buku.png', 'Buku Saku',
              'Membaca adalah bermimpi dengan mata yang terbuka'),
          TitleWidget(
            'Bacaan Wajib',
            'Lihat bacaan wajib lainnya',
            () {
              Navigator.of(context).pushNamed(MoreDetailBooksScreen.routeName);
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
    );
  }
}
