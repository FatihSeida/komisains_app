import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreOrganizationScreen extends StatelessWidget {
  static const routeName = '/more-organization';
  const MoreOrganizationScreen({Key key}) : super(key: key);

  final String text =
      """Himpunan Mahasiswa Islam (HMI) adalah organisasi mahasiswa yang didirikan di Yogyakarta pada tanggal 14 Rabiul Awal 1366 H bertepatan dengan tanggal 5 Februari 1947, atas prakarsa Lafran Pane beserta 14 orang mahasiswa Sekolah Tinggi Islam (sekarang Universitas Islam Indonesia). HMI telah melewati banyak fase atau tahap dalam perkembangannya sehingga kini HMI tetap dan terus menjalankan syariat organisasinya yang nasionalis dan tetap bernuansa Islam, sehingga kader-kader HMI sekarang menjadi seorang muslim yang nasionalis, berintelektual yang sekaligus menjunjung tinggi asas-asas keIslaman di Indonesia agar membuat Negara ini bangkit dan terus maju dalam pembangunan baik dalam segala aspek manapun, dan untuk menunjukkan kepada Negara luar khususnya Negara non-muslim bahwa Indonesia sebagai Negara dengan umat muslim terbanyak di dunia bisa membuat rakyat dan negaranya maju dalam segala bidang dan tetap menjunjung tinggi asas-asas keislaman.""";
  final String text2 =
      """Sebagai mahasiswa atau kaum intelektual di masa sekarang, HMI dengan sifat keindependenan menuntut mahasiswa menjadi mitra yang siap mengambil sikap berani, kritis, adil, dan jujur serta selalu berpikir obyektif dan rasional. Kader HMI harus mampu mencari, memilih dan menempuh jalan atas dasar keyakinan dan kebenaran, maka kader-kader HMI secara konsekuensi harus berkualitas karena itu merupakan suatu modal untuk meningkatkan mutu dari kader HMI sehingga mampu berperan aktif pada masa sekarang dan mendatang. Dengan mengetahui sejarah terbentuknya organisasi ini pada masa lalu, kita dapat mengetahui semangat juang HMI. Merupakan sebuah tonggak bagi HMI untuk meneruskan perjuangan pencipta dan para pendahulu di HMI agar selalu terciptanya hari esok yang lebih baik. Tidak jauh berbeda dengan apa yang terjadi di dunia saat itu, umat Islam berada dalam cengkaraman nekolim barat. Penjajah memperlakukan umat Islam sebagai masyarakat kelas bawah dan diperlakukan tidak adil, serta hanya menguntungkan kelompok mereka sendiri atau rakyat yang sudah seideologi dengan mereka.""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              InkWell(
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: const Color(0xff3BBC86),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                text,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontFamily: 'SourceSansPro',
                  height: 1.5,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Image.asset('assets/images/logohmi.png'),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      text2.substring(0, 320),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontFamily: 'SourceSansPro',
                        height: 1.5,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text2.substring(320, 514),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontFamily: 'SourceSansPro',
                  height: 1.5,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('assets/images/hmiaksi.jpg'),
              ),
              Text(
                text2.substring(514, text2.length),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontFamily: 'SourceSansPro',
                  height: 1.5,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
