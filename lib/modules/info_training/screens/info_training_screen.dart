import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komisains_app/modules/info_training/bloc/info_training_bloc.dart';
import 'package:komisains_app/modules/info_training/repositories/info_training_repository.dart';
import 'package:komisains_app/widgets/header_app.dart';
import 'package:komisains_app/modules/info_training/screens/widgets/info_training_widget.dart';

class InfoTrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: BlocProvider(
        create: (context) => InfoTrainingBloc(
            infoTrainingRepository:
                RepositoryProvider.of<InfoTrainingRepository>(context)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            HeaderApp('assets/images/buku.png', 'Info Training',
                'Siapkan diri yang terbaik untuk menyambut masa depan'),
            InfoTraining(),
          ],
        ),
      ),
    );
  }
}
