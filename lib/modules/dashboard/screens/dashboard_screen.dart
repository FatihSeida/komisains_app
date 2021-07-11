import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komisains_app/core/auth/repositories/login_auth_repository.dart';
import 'package:komisains_app/modules/agenda/bloc/agenda_bloc.dart';
import 'package:komisains_app/modules/agenda/repositories/agenda_repository.dart';
import 'package:komisains_app/modules/news/bloc/news_bloc.dart';
import 'package:komisains_app/modules/news/repositories/news_repository.dart';
import 'package:komisains_app/modules/youtube_channel/bloc/youtube_channel_bloc.dart';
import 'package:komisains_app/modules/youtube_channel/repositories/youtube_repository.dart';
// import 'package:komisains_app/core/auth/models/auth.dart';
import 'package:komisains_app/widgets/header_app.dart';
import 'package:komisains_app/modules/agenda/screens/widgets/list_agenda.dart';
import 'package:komisains_app/widgets/profil_komisariat_button.dart';
import 'package:komisains_app/widgets/title_widget.dart';
import 'package:komisains_app/modules/youtube_channel/screens/widgets/video_preview.dart';
import 'package:komisains_app/modules/news/screens/widgets/news_card.dart';
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
          BlocProvider<NewsBloc>(
            create: (context) => NewsBloc(
                newsRepository: RepositoryProvider.of<NewsRepository>(context)),
            child: WelcomeSlidingCard(),
          ),
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
          BlocProvider<AgendaBloc>(
            create: (context) => AgendaBloc(
              agendaRepository:
                  RepositoryProvider.of<AgendaRepository>(context),
            ),
            child: ListAgenda(),
          ),
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
          BlocProvider<YoutubeChannelBloc>(
            create: (context) => YoutubeChannelBloc(
              youtubeRepository:
                  RepositoryProvider.of<YoutubeRepository>(context),
            ),
            child: VideoPreview(),
          ),
        ],
      ),
    );
  }
}
