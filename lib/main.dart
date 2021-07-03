import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komisains_app/core/auth/bloc/authentication/authentication_bloc.dart';
import 'package:komisains_app/core/auth/repositories/login_auth_repository.dart';
import 'package:komisains_app/core/auth/repositories/sign_up_repository.dart';
import 'package:komisains_app/main_screen.dart';
import 'package:komisains_app/core/walk_through.dart/intro_screen.dart';
import 'package:komisains_app/modules/agenda/bloc/agenda_bloc.dart';
import 'package:komisains_app/modules/agenda/repositories/agenda_repository.dart';
import 'package:komisains_app/modules/ebook/bloc/ebook_bloc.dart';
import 'package:komisains_app/modules/ebook/repository/ebook_repository.dart';
import 'package:komisains_app/modules/info_training/repositories/info_training_repository.dart';
import 'package:komisains_app/modules/news/repositories/news_repository.dart';
import 'package:komisains_app/modules/profile/repositories/kom_profile_repository.dart';
import 'package:komisains_app/modules/structure/repositories/structure_repository.dart';
import 'package:komisains_app/modules/structure/screens/komisariat_personalia_screen.dart';
import 'package:komisains_app/modules/profile/screens/komisariat_profile_screen.dart';
import 'package:komisains_app/modules/agenda/screens/more_detail_agenda_screen.dart';
import 'package:komisains_app/modules/ebook/screens/more_detail_books_screen.dart';
import 'package:komisains_app/modules/news/screens/more_detail_news_screen.dart';
import 'package:komisains_app/modules/ebook/screens/more_detail_resensi_screen.dart';
import 'package:komisains_app/modules/user_profile/repositories/user_repository.dart';
import 'package:komisains_app/modules/youtube_channel/screens/more_detail_yt_screen.dart';
import 'package:komisains_app/core/auth/screens/more_organization.dart';
import 'package:komisains_app/modules/dashboard/screens/tab_screen.dart';
import 'package:komisains_app/core/auth/screens/welcome_screen.dart';
import 'package:komisains_app/widgets/edit_password.dart';
import 'package:komisains_app/widgets/forum.dart';
import 'package:komisains_app/widgets/forum_detail.dart';
import 'package:komisains_app/widgets/profile_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/auth/bloc/login/login_bloc.dart';
import 'core/auth/bloc/sign_up/sign_up_bloc.dart';
import 'modules/info_training/bloc/info_training_bloc.dart';
import 'modules/news/bloc/news_bloc.dart';
import 'modules/profile/bloc/kom_profile_bloc.dart';
import 'modules/structure/bloc/structure_bloc.dart';
import 'modules/user_profile/bloc/user_profile_bloc.dart';
import 'modules/youtube_channel/bloc/youtube_channel_bloc.dart';
import 'modules/youtube_channel/repositories/youtube_repository.dart';

late bool seen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  seen = prefs.getBool("seen")!;
  await prefs.setBool("seen", true);
  
  runApp(RepositoryProvider<LoginAuthRepository>(
    create: (context) {
      return LoginAuthRepository();
    },
    child: BlocProvider<AuthenticationBloc>(
      create: (context) {
        final authService = RepositoryProvider.of<LoginAuthRepository>(context);
        return AuthenticationBloc(loginAuthRepository: authService)
          ..add(AppLoaded());
      },
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LoginAuthRepository>(
          create: (_) => LoginAuthRepository(),
        ),
        RepositoryProvider<SignUpRepository>(
          create: (_) => SignUpRepository(),
        ),
        RepositoryProvider<AgendaRepository>(
          create: (_) => AgendaRepository(),
        ),
        RepositoryProvider<EbookRepository>(
          create: (_) => EbookRepository(),
        ),
        RepositoryProvider<InfoTrainingRepository>(
          create: (_) => InfoTrainingRepository(),
        ),
        RepositoryProvider<NewsRepository>(
          create: (_) => NewsRepository(),
        ),
        RepositoryProvider<KomProfileRepository>(
          create: (_) => KomProfileRepository(),
        ),
        RepositoryProvider<StructureRepository>(
          create: (_) => StructureRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(
                    authenticationBloc: AuthenticationBloc(
                        loginAuthRepository: LoginAuthRepository()),
                    loginLoginRepository: LoginAuthRepository(),
                  )),
          BlocProvider<SignUpBloc>(
              create: (context) => SignUpBloc(
                    signUpRepository:
                        RepositoryProvider.of<SignUpRepository>(context),
                  )),
          BlocProvider<AgendaBloc>(
              create: (context) => AgendaBloc(
                  agendaRepository:
                      RepositoryProvider.of<AgendaRepository>(context))
                ..add(FetchAgenda())),
          BlocProvider<EbookBloc>(
              create: (context) => EbookBloc(
                  ebookRepository:
                      RepositoryProvider.of<EbookRepository>(context))
                ..add(FetchEbooks())),
          BlocProvider<InfoTrainingBloc>(
              create: (context) => InfoTrainingBloc(
                  infoTrainingRepository:
                      RepositoryProvider.of<InfoTrainingRepository>(context))
                ..add(FetchInfoTraining())),
          BlocProvider<NewsBloc>(
              create: (context) => NewsBloc(
                  newsRepository:
                      RepositoryProvider.of<NewsRepository>(context))
                ..add(FetchNews())),
          BlocProvider<KomProfileBloc>(
              create: (context) => KomProfileBloc(
                  komProfileRepository:
                      RepositoryProvider.of<KomProfileRepository>(context))
                ..add(FetchKomProfile())),
          BlocProvider<StructureBloc>(
              create: (context) => StructureBloc(
                  structureRepository:
                      RepositoryProvider.of<StructureRepository>(context))
                ..add(FetchStructure())),
          BlocProvider<UserProfileBloc>(
              create: (context) => UserProfileBloc(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context))
                ..add(FetchUserProfile())),
          BlocProvider<YoutubeChannelBloc>(
              create: (context) => YoutubeChannelBloc(
                  youtubeRepository:
                      RepositoryProvider.of<YoutubeRepository>(context))
                ..add(FetchYoutubeVideo())),
        ],
        child: MaterialApp(
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
            // '/edit-profile': (BuildContext context) => EditProfileScreen(),
            // '/edit-password': (BuildContext context) => EditPasswordScreen(),
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationAuthenticated) {
        return TabScreen();
      } else {
        return MainScreen();
      }
    });
  }
}
