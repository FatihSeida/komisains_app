import 'package:flutter/material.dart';
// import 'package:komisains_app/core/auth/models/auth.dart';
import 'package:komisains_app/widgets/header_app.dart';
import 'package:komisains_app/widgets/list_agenda.dart';
import 'package:komisains_app/widgets/profil_komisariat_button.dart';
import 'package:komisains_app/widgets/title_widget.dart';
import 'package:komisains_app/widgets/video_preview.dart';
import 'package:komisains_app/widgets/news_card.dart';
import 'package:provider/provider.dart';

import '../../agenda/screens/more_detail_agenda_screen.dart';
import '../../news/screens/more_detail_news_screen.dart';
import '../../youtube_channel/screens/more_detail_yt_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final name = Provider.of<Auth>(context).items!.name.split(" ");
    // final realName = name[0];
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderApp('assets/images/buku.png', 'Hai fatih,',
              'Selamat Datang di Komisariat'),
          TitleWidget(
            'Tentang Komisariat Terkini',
            'Lihat lainnya',
            () {
              Navigator.of(context).pushNamed(MoreDetailNewsScreen.routeName);
            },
          ),
          WelcomeSlidingCard(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Profil Kabinet',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xff3BBC86),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          ProfilKomisariatButton(),
          TitleWidget(
            'Agenda Komisariat',
            'Lihat lainnya',
            () {
              Navigator.of(context).pushNamed(MoreDetailAgendaScreen.routeName);
            },
          ),
          ListAgenda(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          TitleWidget(
            'Rekomendasi Video',
            'Lihat lainnya',
            () {
              Navigator.of(context).pushNamed(MoreDetailYTScreen.routeName);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          VideoPreview(),
        ],
      ),
    );
  }
}
