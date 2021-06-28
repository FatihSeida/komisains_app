import 'package:flutter/material.dart';
import 'package:komisains_app/widgets/header_app.dart';
import 'package:komisains_app/widgets/info_training_widget.dart';

class InfoTrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          HeaderApp('assets/images/buku.png', 'Info Training',
              'Siapkan diri yang terbaik untuk menyambut masa depan'),
          InfoTraining(),
        ],
      ),
    );
  }
}
