import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komisains_app/core/auth/bloc/login_auth/auth_bloc.dart';
import 'package:komisains_app/main_screen.dart';
import 'package:komisains_app/modules/agenda/models/agenda.dart';
import 'package:komisains_app/modules/ebook/models/books.dart';
import 'package:komisains_app/modules/news/models/news.dart';
import 'package:komisains_app/modules/structure/models/structures.dart';
import 'package:komisains_app/modules/youtube_channel/models/youtube_channel.dart';
import 'package:komisains_app/core/walk_through.dart/intro_screen.dart';
import 'package:komisains_app/modules/structure/screens/komisariat_personalia_screen.dart';
import 'package:komisains_app/modules/profile/screens/komisariat_profile_screen.dart';
import 'package:komisains_app/modules/agenda/screens/more_detail_agenda_screen.dart';
import 'package:komisains_app/modules/ebook/screens/more_detail_books_screen.dart';
import 'package:komisains_app/modules/news/screens/more_detail_news_screen.dart';
import 'package:komisains_app/modules/ebook/screens/more_detail_resensi_screen.dart';
import 'package:komisains_app/modules/youtube_channel/screens/more_detail_yt_screen.dart';
import 'package:komisains_app/core/auth/screens/more_organization.dart';
import 'package:komisains_app/modules/dashboard/screens/tab_screen.dart';
import 'package:komisains_app/core/auth/screens/welcome_screen.dart';
import 'package:komisains_app/widgets/edit_password.dart';
import 'package:komisains_app/widgets/forum.dart';
import 'package:komisains_app/widgets/forum_detail.dart';
import 'package:komisains_app/widgets/profile_edit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/auth/models/auth.dart';
import 'modules/profile/models/kom_profile.dart';
import 'modules/info_training/models/training_information_item.dart';

late bool seen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  seen = prefs.getBool("seen")!;
  await prefs.setBool("seen", true);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, BooksProvider>(
          create: (context) => BooksProvider.init(
            Provider.of<UserProvider>(context, listen: false),
          ),
          update: (ctx, auth, previousProducts) => BooksProvider(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, NewsProvider>(
          create: (context) => NewsProvider(),
          update: (ctx, auth, previousProducts) => NewsProvider(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, AgendaProvider>(
          create: null,
          update: (ctx, auth, previousProducts) => AgendaProvider(
            authToken: auth.token,
            userId: auth.userId,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, TrainingInfoProvider>(
          create: null,
          update: (ctx, auth, previousProducts) => TrainingInfoProvider(
            authToken: auth.token,
            userId: auth.userId,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, YTProvider>(
          create: null,
          update: (ctx, auth, previousProducts) => YTProvider(
            authToken: auth.token,
            userId: auth.userId,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, ProfileProvider>(
          create: null,
          update: (ctx, auth, previousProducts) => ProfileProvider(
            authToken: auth.token,
            userId: auth.userId,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, StructureProvider>(
          create: null,
          update: (ctx, auth, previousProducts) => StructureProvider(
            authToken: auth.token,
            userId: auth.userId,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Komisariat App',
          theme: ThemeData(
              fontFamily: 'SourceSansPro',
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              hintColor: Colors.white,
              indicatorColor: Colors.white,
              focusColor: Colors.white,
              highlightColor: Colors.white),
          home: seen == false ? IntroScreen() : CheckAuth(),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/forum': (BuildContext context) => ForumPage(
                  title: 'Forum',
                ),
            '/forum/1': (BuildContext context) => ForumDetailPage(),
            '/komprofile': (BuildContext context) => KomisariatProfileScreen(),
            '/more-news': (BuildContext context) => MoreDetailNewsScreen(),
            '/more-agenda': (BuildContext context) => MoreDetailAgendaScreen(),
            '/more-books': (BuildContext context) => MoreDetailBooksScreen(),
            '/more-resensi': (BuildContext context) =>
                MoreDetailResensiScreen(),
            '/more-yt': (BuildContext context) => MoreDetailYTScreen(),
            '/edit-profile': (BuildContext context) => EditProfileScreen(),
            '/edit-password': (BuildContext context) => EditPasswordScreen(),
            '/more-organization': (BuildContext context) =>
                MoreOrganizationScreen(),
            '/tab-screen': (BuildContext context) => TabScreen(),
            '/welcome-screen': (BuildContext context) => WelcomeScreen(),
            '/intro-screen': (BuildContext context) => IntroScreen(),
            '/personalia-screen': (BuildContext context) => PersonaliaScreen(),
          },
        ),
      ),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final profileId = ModalRoute.of(context)!.settings.arguments as String;
      if (profileId != null) {
        Provider.of<Auth>(context, listen: false).tryAutoLogin();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthStateAuthenticated) {
        return TabScreen();
      } else {
        return FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (ctx, authResultSnapshot) => MainScreen());
      }
    });
    return Consumer<Auth>(
        builder: (context, auth, _) => auth.isAuth != null && true
            ? TabScreen()
            : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (ctx, authResultSnapshot) => MainScreen()));
  }
}
