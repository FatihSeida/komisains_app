import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komisains_app/modules/ebook/screens/buku_saku_screen.dart';
import 'package:komisains_app/modules/dashboard/screens/dashboard_screen.dart';
import 'package:komisains_app/modules/feeds/screens/feeds_screen.dart';
import 'package:komisains_app/modules/info_training/screens/info_training_screen.dart';
import 'package:komisains_app/modules/user_profile/bloc/screens/profile_screen.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/tab-screen';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with AutomaticKeepAliveClientMixin<TabScreen> {
  int _currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              DashboardScreen(),
              BukuSakuScreen(),
              InfoTrainingScreen(),
              FeedsScreen(),
              ProfileScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        itemCornerRadius: 24,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.home),
            title: Text('Home'),
            activeColor: const Color(0xff3BBC86),
            textAlign: TextAlign.center,
            inactiveColor: const Color(0xffABC8BC),
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.book),
            title: Text('Buku Saku'),
            activeColor: const Color(0xff3BBC86),
            textAlign: TextAlign.center,
            inactiveColor: const Color(0xffABC8BC),
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.route),
            title: Text('Info Training'),
            activeColor: const Color(0xff3BBC86),
            textAlign: TextAlign.center,
            inactiveColor: const Color(0xffABC8BC),
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.comments),
            title: Text('Feed'),
            activeColor: const Color(0xff3BBC86),
            textAlign: TextAlign.center,
            inactiveColor: const Color(0xffABC8BC),
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.user),
            title: Text('Profile'),
            activeColor: const Color(0xff3BBC86),
            textAlign: TextAlign.center,
            inactiveColor: const Color(0xffABC8BC),
          ),
        ],
      ),
    );
  }
}
