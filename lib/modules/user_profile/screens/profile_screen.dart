import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komisains_app/core/auth/bloc/authentication/authentication_bloc.dart';
import 'package:komisains_app/core/auth/repositories/login_auth_repository.dart';
import 'package:komisains_app/modules/user_profile/bloc/user_profile_bloc.dart';
import 'package:komisains_app/modules/user_profile/repositories/user_repository.dart';
import 'package:komisains_app/modules/user_profile/screens/widgets/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserProfileBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context)),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(
              loginAuthRepository:
                  RepositoryProvider.of<LoginAuthRepository>(context)),
        ),
      ],
      child: ProfileWidget(),
    );
  }
}
