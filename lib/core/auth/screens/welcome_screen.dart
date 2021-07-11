import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komisains_app/core/auth/bloc/authentication/authentication_bloc.dart';
import 'package:komisains_app/core/auth/bloc/login/login_bloc.dart';
import 'package:komisains_app/core/auth/bloc/sign_up/sign_up_bloc.dart';
import 'package:komisains_app/core/auth/repositories/login_auth_repository.dart';
import 'package:komisains_app/core/auth/repositories/sign_up_repository.dart';
import 'package:komisains_app/modules/news/bloc/news_bloc.dart';
import 'package:komisains_app/modules/news/repositories/news_repository.dart';
import 'package:komisains_app/modules/news/screens/more_detail_news_screen.dart';
import 'package:komisains_app/core/auth/screens/widgets/about_organization.dart';
import 'package:komisains_app/core/auth/screens/widgets/auth_screen.dart';
import 'package:komisains_app/widgets/header_welcome.dart';
import 'package:komisains_app/modules/news/screens/widgets/news_card.dart';
import 'package:komisains_app/widgets/title_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome-screen';
  final String text =
      """Himpunan Mahasiswa Islam (HMI) adalah organisasi mahasiswa yang didirikan di Yogyakarta pada tanggal 14 Rabiul Awal 1366 H bertepatan dengan tanggal 5 Februari 1947, atas prakarsa Lafran Pane beserta 14 orang mahasiswa Sekolah Tinggi Islam (sekarang Universitas Islam Indonesia). HMI telah melewati banyak fase atau tahap dalam perkembangannya sehingga kini HMI tetap dan terus menjalankan syariat organisasinya yang nasionalis dan tetap bernuansa Islam, sehingga kader-kader HMI sekarang menjadi seorang muslim yang nasionalis, berintelektual yang sekaligus menjunjung tinggi asas-asas keIslaman di Indonesia agar membuat Negara ini bangkit dan terus maju dalam pembangunan baik dalam segala aspek manapun, dan untuk menunjukkan kepada Negara luar khususnya Negara non-muslim bahwa Indonesia sebagai Negara dengan umat muslim terbanyak di dunia bisa membuat rakyat dan negaranya maju dalam segala bidang dan tetap menjunjung tinggi asas-asas keislaman.""";

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        parallaxOffset: .5,
        maxHeight: deviceSize.height * 0.74,
        minHeight: deviceSize.height * 0.1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        color: const Color(0xff3BBC86),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderWelcome(),
                  TitleWidget(
                    'Tentang Komisariat Terkini',
                    'Lihat lainnya',
                    () {
                      Navigator.of(context)
                          .pushNamed(MoreDetailNewsScreen.routeName);
                    },
                  ),
                  BlocProvider<NewsBloc>(
                    create: (context) => NewsBloc(
                        newsRepository:
                            RepositoryProvider.of<NewsRepository>(context))
                      ..add(FetchNews()),
                    child: WelcomeSlidingCard(),
                  ),
                  AboutOrganization(text),
                ],
              ),
            ),
          ],
        ),
        panelBuilder: (sc) => MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(
                      authenticationBloc:
                          BlocProvider.of<AuthenticationBloc>(context),
                      loginLoginRepository:
                          RepositoryProvider.of<LoginAuthRepository>(context),
                    )),
            BlocProvider<SignUpBloc>(
                create: (context) => SignUpBloc(
                      signUpRepository:
                          RepositoryProvider.of<SignUpRepository>(context),
                    )),
          ],
          child: AuthCard(sc: sc),
        ),
      ),
    );
  }
}
