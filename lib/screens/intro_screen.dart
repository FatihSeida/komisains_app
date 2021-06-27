import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:komisains_app/screens/welcome_screen.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro-screen';
  IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  late Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        maxLineTextDescription: 6,
        title: "Apa Itu HMI?",
        styleTitle: const TextStyle(
            color: const Color(0xff3BBC86),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSansPro'),
        description:
            "Himpunan Mahasiswa Islam (HMI) adalah organisasi mahasiswa yang didirikan di Yogyakarta pada tanggal 14 Rabiul Awal 1366 H bertepatan dengan tanggal 5 Februari 1947 karena hal itu, HMI Menjadi organisasi mahasiswa tertua di Indonesia",
        styleDescription: const TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'SourceSansPro'),
        pathImage: "assets/images/logohmi.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Apa saja kegiatan HMI?",
        styleTitle: const TextStyle(
            color: const Color(0xff3BBC86),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSansPro'),
        description:
            "Banyak macam variasi kegiatan HMI, dimulai dari diskusi tentang kekampusan, kedaerahan maupun kebangsaan. Selain itu juga ada acara sosial seperti bakti desa ataupun berbagi ke panti asuhan, dan masih banyak lagi",
        styleDescription: const TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'SourceSansPro'),
        pathImage: "assets/images/logo.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Mari Bergabung HMI",
        styleTitle: const TextStyle(
            color: const Color(0xff3BBC86),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSansPro'),
        description:
            "Mari bersama-sama mengembangkan diri untuk menjadi pribadi yang lebih baik lagi, mari bergabung HMI Komisariat Sains & Teknologi Cabang Kabupaten Bandung. Yakin Usaha Sampai",
        styleDescription: const TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'SourceSansPro'),
        pathImage: "assets/images/kolase.png",
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: const Color(0xff3BBC86),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: const Color(0xff3BBC86),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: const Color(0xff3BBC86),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: const EdgeInsets.only(top: 20.0),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Text(
                    currentSlide.description,
                    style: currentSlide.styleDescription,
                    textAlign: TextAlign.center,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  margin: const EdgeInsets.only(top: 20.0),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      // slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Colors.white,
      highlightColorSkipBtn: const Color(0xff3BBC86),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Colors.white,
      highlightColorDoneBtn: const Color(0xff3BBC86),

      // Dot indicator
      colorDot: const Color(0xff3BBC86),
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Behavior
      scrollPhysics: BouncingScrollPhysics(),
      hideStatusBar: true,
      

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
