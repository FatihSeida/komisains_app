import 'package:flutter/material.dart';
import 'package:komisains_app/screens/more_detail_news_screen.dart';
import 'package:komisains_app/widgets/about_organization.dart';
import 'package:komisains_app/widgets/auth_screen.dart';
import 'package:komisains_app/widgets/header_welcome.dart';
import 'package:komisains_app/widgets/news_card.dart';
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
                  WelcomeSlidingCard(),
                  AboutOrganization(text),
                ],
              ),
            ),
          ],
        ),
        panelBuilder: (sc) => AuthCard(sc: sc),
      ),
    );
  }
}
